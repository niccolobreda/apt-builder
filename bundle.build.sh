no | npm run generate &&
npx cap sync android &&
cd android && 

./gradlew --no-build-cache --no-configuration-cache assembleRelease && 

cp app/build/outputs/bundle/release/app-release.apk ../apks/app-release.apk && 

exit 0