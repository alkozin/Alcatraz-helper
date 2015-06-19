//
//  Constants.h
//
//  Created by Alexander Kozin on 2/2/12.
//  Copyright (c) 2012 Siberian.pro. All rights reserved.

@import AppKit;

#define TEST_BUILD                          0
#if TEST_BUILD
    #define TEST_ON_NOTES_APP               1
    #define DISABLE_ALCATRZ_INFO_SAVING     0
#endif

FOUNDATION_EXPORT NSString *const kXcodeBundleIdentifier,
*const kAlcatrazPath,
*const kApplicationInfoPathFormat,
*const kCompatibilityUUID_S_Key,
*const kCompatibilityUUIDKey,
*const kApplicationBundleIdentifier;
