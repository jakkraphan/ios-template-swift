#!/bin/sh
# xcodebuild -workspace iOS-Template.xcworkspace -scheme Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | xcpretty -c && exit ${PIPESTATUS[0]}

xctool -workspace iOS-Template.xcworkspace -scheme 'Production' -configuration Release -sdk iphoneos7.1 CONFIGURATION_BUILD_DIR='~/build/' build
