//
//  AppDelegate+Termination.m
//  
//
//  Created by Alexander Kozin on 19.06.15.
//
//

#import "AppDelegate_Private.h"

@implementation AppDelegate (Termination)

- (void)someAppDidTerminate:(NSNotification *)n
{
    NSDictionary *userInfo = n.userInfo;
    if ([userInfo[kApplicationBundleIdentifier] isEqualToString:kXcodeBundleIdentifier]) {
        BOOL allXcodesAreTerminated = [self isAllXcodesAreTerminated];
        if (allXcodesAreTerminated) {
            [self restartAllTerminatedXcodes];
            [self showSuccessAlertWithAlcatrazListChangedText:YES];
        }
    }
}

- (BOOL)isAllXcodesAreTerminated
{
    BOOL isAllXcodesAreTerminated;
    NSArray *runningXcodes = [self runningXcodes];
    isAllXcodesAreTerminated = !runningXcodes.count;

    return isAllXcodesAreTerminated;
}

- (void)restartAllTerminatedXcodes
{
    for (NSURL *executableURL in self.xcodesToRestart) {
        [[NSWorkspace sharedWorkspace] launchApplicationAtURL:executableURL
                                                      options:NSWorkspaceLaunchDefault
                                                configuration:nil
                                                        error:nil];
    }
}

- (void)subscribeToTerminationNotifications
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                                                           selector:@selector(someAppDidTerminate:)
                                                               name:NSWorkspaceDidTerminateApplicationNotification
                                                             object:nil];
}

- (void)terminate
{
    [[NSApplication sharedApplication] terminate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}

@end
