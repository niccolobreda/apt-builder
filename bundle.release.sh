
no | npm run generate &&
npx capacitor-assets generate --android &&
npx cap sync android &&  

cd android &&  

./gradlew --no-build-cache --no-configuration-cache bundleRelease &&
cp app/build/outputs/bundle/release/app-release.aab ../apks/app-release.aab && 

exit 0