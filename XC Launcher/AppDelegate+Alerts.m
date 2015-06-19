//
//  AppDelegate+Alerts.m
//  
//
//  Created by Alexander Kozin on 19.06.15.
//
//

#import "AppDelegate_Private.h"

@implementation AppDelegate (Alerts)

- (NSModalResponse)showWaitingForTerminationAlert
{
    NSModalResponse responce;

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Xcode should be restarted after enabling Alcatraz."];
    [alert setInformativeText:@"Alcatraz UUIDs list is updated. \n Waiting for closing all Xcode instances."];
    [alert addButtonWithTitle:@"Force terminate"];
    [alert addButtonWithTitle:@"Don't need"];
    [alert setAlertStyle:NSWarningAlertStyle];
    [self setWaitingForTerminationAlert:alert];

    responce = [alert runModal];

    return responce;
}

- (void)showSuccessAlertWithAlcatrazListChangedText:(BOOL)listChanged
{
    // Show app alert even if Xcode is just launched
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

    // Close previous alert
    [self.waitingForTerminationAlert.window close];

    // And show success alert
    NSString *alertText = listChanged ? @"Alcatraz UUIDs list is successfully updated." :
    @"Don't need to update Alcatraz UUIDs list, all is already OK.";

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Work is done"];
    [alert setInformativeText:alertText];
    [alert addButtonWithTitle:@"Got it!"];
    [alert setAlertStyle:NSInformationalAlertStyle];

    [alert runModal];
    [self terminate];
}


@end
