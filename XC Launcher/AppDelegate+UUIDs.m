//
//  AppDelegate+UUIDs.m
//  
//
//  Created by Alexander Kozin on 16.06.15.
//
//

#import "AppDelegate_Private.h"

@implementation AppDelegate (UUIDs)

- (BOOL)addAllXcodesUUIDsToAlcatraz
{
    NSDictionary *allXcodesUUIDs = [self allXcodesUUIDs];
    return [self addUUIDsToAlcatraz:allXcodesUUIDs];
}

/**
 *  Returns UUIDs for all Xcode instances installed to /Applications folder
 *
 *  @return An dictionary where keys is UUIDs and values is Xcode app name
 */
- (NSDictionary *)allXcodesUUIDs
{
    NSMutableDictionary *allXcodesUUIDs;

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSLocalDomainMask, YES);
    NSString *applicationsPath = [searchPaths firstObject];

    NSArray *applications = [fileManager contentsOfDirectoryAtPath:applicationsPath error:nil];

    allXcodesUUIDs = [NSMutableDictionary dictionary];
    for (NSString *app in applications) {
        if ([app hasPrefix:@"Xcode"] && [app hasSuffix:@".app"]) {
            NSString *uuid = [self uuidForXcodeWithAppName:app];
            allXcodesUUIDs[uuid] = app;
        }
    }

    return allXcodesUUIDs;
}

/**
 *  Adds UUIDs from argument to Alcatraz compatibility list
 *
 *  @param allXcodesUUIDs An dictionary where keys is UUIDs and values is Xcode app name
 *
 *  @return YES if Alcatraz compatibility list is changed
 */
- (BOOL)addUUIDsToAlcatraz:(NSDictionary *)allXcodesUUIDs
{
    NSString *alcatrazInfoPath = [NSHomeDirectory() stringByAppendingPathComponent:kAlcatrazPath];
    NSMutableDictionary *alcatrazInfo = [NSMutableDictionary dictionaryWithContentsOfFile:alcatrazInfoPath];
    NSArray *uuidss = alcatrazInfo[kCompatibilityUUID_S_Key];

    BOOL uuidsChanged = NO;

    if (uuidss) {
        NSMutableArray *mutableUUIDs = [uuidss mutableCopy];
        for (NSString *uuid in allXcodesUUIDs) {
            if (![uuidss containsObject:uuid]) {
                [mutableUUIDs addObject:uuid];
                uuidsChanged = YES;

                NSLog(@"Add %@ uuid for %@", uuid, allXcodesUUIDs[uuid]);
            }
        }
        uuidss = mutableUUIDs;
    } else {
        uuidss = [allXcodesUUIDs allKeys];
        uuidsChanged = YES;
    }

    if (uuidsChanged) {
        alcatrazInfo[kCompatibilityUUID_S_Key] = uuidss;

        #if !DISABLE_ALCATRZ_INFO_SAVING
            [alcatrazInfo writeToFile:alcatrazInfoPath atomically:YES];
            NSLog(@"UUIDs are added to list: \n %@", allXcodesUUIDs);
        #endif
    } else {
        NSLog(@"Nothing to add. \n All UUIDs are in list: \n %@", allXcodesUUIDs);
    }

    return uuidsChanged;
}

- (NSString *)uuidForXcodeWithAppName:(NSString *)name
{
    NSString *uuid;

    NSString *path = [NSString stringWithFormat:kApplicationInfoPathFormat, name];

    NSDictionary *xcodeInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    uuid = xcodeInfo[kCompatibilityUUIDKey];

    return uuid;
}

@end
