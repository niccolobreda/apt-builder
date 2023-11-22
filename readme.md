In my current job I'm in charge of mantainig a Capacitor mobile app (only Android) written in Nuxt 2, which interacts with a Laravel 8 backend. The system involves a Nuxt 2 web app too and everything is developed and deployed with Docker using gitlab's CI/CD. When I started the previous developer who worked on it left absolutely zero documentation regarding the build process and, in general, regarding the whole app.
As I'm pretty new to native apps development, I didn't want to install Android Studio on my working machine so I thought it would be nice to build both the mobile app's debug and production bundles using Docker. I found a way to achieve this and the resulting files are grouped in this repository.

At the current state this can serve only as an example and need to be adapted to specific needs, if different from my environment.
The dockerfile builds an image with all the tools needed to build an Android 13 bundle: "openjdk-11-jdk", "build-tools;33.0.3" and "platforms;android-33".

I found this pretty useful, so I'll invest my spare time to make it more general and reusable.

### Usage

Build the image

```bash
docker build -t <image-name> -f ./dockerfiles/android.Dockerfile .
```

The command must be lounched on the root of you Capacitor app and assumes a folder /dockerfiles.
Then run it providing the path to a shell script containing the Capacitor commands to build the app.

```bash
docker run --env CMD_SCRIPT=<path-to-your-build-script> <image-name>
```
