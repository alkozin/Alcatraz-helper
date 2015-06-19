//
//  AppDelegate_Private.h
//  
//
//  Created by Alexander Kozin on 16.06.15.
//
//

#import "AppDelegate.h"

#import "Constants.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSArray *xcodesToRestart;
@property (weak, nonatomic) NSAlert *waitingForTerminationAlert;

/**
 *  Returns an array of all running Xcodes
 *
 *  @return All running Xcodes applications
 */
- (NSArray *)runningXcodes;

@end

@interface AppDelegate (Alerts)

- (NSModalResponse)showWaitingForTerminationAlert;
- (void)showSuccessAlertWithAlcatrazListChangedText:(BOOL)listChanged;

@end

@interface AppDelegate (Termination)

/**
 *  Terminates app
 */
- (void)terminate;

/**
 *  Add app termination handler
 */
- (void)subscribeToTerminationNotifications;

@end

@interface AppDelegate (UUIDs)

/**
 *  Adds UUIDs for all Xcode instances installed to /Applications folder
 *  To Alcatraz compatibility list
 *
 *  @return YES if Alcatraz compatibility list is changed
 */
- (BOOL)addAllXcodesUUIDsToAlcatraz;

@end
