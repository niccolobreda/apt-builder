FROM ubuntu:latest

#Ubuntu variables
ARG DEBIAN_FRONTEND=noninteractive

# Nuxt variables
ENV APP_VERSION 2.3.$COMMIT_HASH
ENV HOST 0.0.0.0
ENV PORT 8060
ENV TZ=Europe/Rome
ENV BACKEND_URL=http://server:80
ENV PREFIX_API=/
ENV SUFFIX_URL=/
ENV CHOKIDAR_USEPOLLING=true

# Docker variables
ENV BUILDKIT_PROGRESS=plain
ENV PROGRESS_NO_TRUNC=1

# Android variables
ENV ANDROID_SDK_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK=/opt/android-sdk-linux
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV ANDROID_EMULATOR_HOME=$ANDROID_HOME

# System update
RUN apt-get -y update

# Instal required ubuntu packages
RUN apt-get -y install \
  curl \
  build-essential\
  openjdk-11-jdk \
  unzip \
  wget \
  && apt-get clean

# Install Node v16 and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# Install Android sdk 
RUN mkdir -p /opt/android-sdk-linux/cmdline-tools \
  && wget 'https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip' -P /tmp \
  && unzip -d /opt/android-sdk-linux/cmdline-tools /tmp/commandlinetools-linux-9477386_latest.zip \
  && rm -rf /opt/android-sdk-linux/.android/cache

# Export Android main variables
RUN export JAVA_HOME ANDROID_SDK_HOME ANDROID_SDK_ROOT ANDROID_HOME ANDROID_SDK

# Install Android extensions
WORKDIR $ANDROID_HOME/cmdline-tools/cmdline-tools/bin
RUN ./sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "build-tools;33.0.3" "platforms;android-33" "emulator"
RUN yes | ./sdkmanager --licenses

# Copy app code and install dependencies
WORKDIR /usr/src/app
COPY . .
RUN npm -g config set user node
RUN npm install

# Set permissions for the entrypoint scripts
RUN chmod -R 777 ./debug.build.sh && chmod -R 777 ./bundle.release.sh && chmod -R 777 ./bundle.build.sh

# Execute the apk generation script
CMD ./${CMD_SCRIPT}