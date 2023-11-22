# Script to be used as entrypoint in android container to build apks
no | npm run generate &&
npx cap sync android &&
cd android &&  

./gradlew --no-build-cache --no-configuration-cache --stacktrace --continue assembleDebug && 

cp app/build/outputs/apk/debug/app-debug.apk ../apks/app-debug.apk && 

exit 0