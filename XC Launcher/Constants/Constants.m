//
//  Constants.m
//
//  Created by Alexander Kozin on 2/2/12.
//  Copyright (c) 2012 Siberian.pro. All rights reserved.
//

#import "Constants.h"

NSString
#if TEST_ON_NOTES_APP
    *const kXcodeBundleIdentifier = @"com.apple.Notes",
#else
    *const kXcodeBundleIdentifier = @"com.apple.dt.Xcode",
#endif

*const kAlcatrazPath = @"Library/Application Support/Developer/Shared/Xcode/Plug-ins/Alcatraz.xcplugin/Contents/Info.plist",
*const kApplicationInfoPathFormat = @"/Applications/%@/Contents/Info.plist",
*const kCompatibilityUUID_S_Key = @"DVTPlugInCompatibilityUUIDs",
*const kCompatibilityUUIDKey = @"DVTPlugInCompatibilityUUID",
*const kApplicationBundleIdentifier = @"NSApplicationBundleIdentifier";
