//
//  AppDelegate.m
//  XC Launcher
//
//  Created by Alexander Kozin on 15.06.15.
//  Copyright © 2015 Siberian.pro. All rights reserved.
//

#import "AppDelegate_Private.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    BOOL uuidsListCahnged = [self addAllXcodesUUIDsToAlcatraz];
    if (uuidsListCahnged) {
        [self restartRunningXcodes];
    } else {
        [self showSuccessAlertWithAlcatrazListChangedText:NO];
    }
}

- (void)restartRunningXcodes
{
    NSArray *runningXcodes = [self runningXcodes];
    if (runningXcodes.count > 0) {
        // executableURL is nil if isTerminated == YES
        [self setXcodesToRestart:[runningXcodes valueForKeyPath:@"@unionOfObjects.executableURL"]];

        [self subscribeToTerminationNotifications];

        // Try to terminate all running Xcode instances
        for (NSRunningApplication *app in runningXcodes) {
            [app terminate];
        }

        NSModalResponse responce = [self showWaitingForTerminationAlert];
        if (responce == NSAlertFirstButtonReturn) {
            for (NSRunningApplication *app in runningXcodes) {
                [app forceTerminate];
            }
        } else {
            [self terminate];
        }
    } else {
        [self showSuccessAlertWithAlcatrazListChangedText:YES];
    }
}

- (NSArray *)runningXcodes
{
    NSArray *runningXcodes = [NSRunningApplication runningApplicationsWithBundleIdentifier:kXcodeBundleIdentifier];
    return runningXcodes;
}

@end
