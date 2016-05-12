//
//  AppDelegate.m
//  Maggie
//
//  Created by Hannan Khan on 12/9/15.
//  Copyright © 2015 Hannan Khan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "OrkinRegionVC.h"
#import "NavigationHandler.h"
#import "ChatThreadsVCViewController.h"
static NSString *_deviceToken = NULL;

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize viewController, navigationController,dToken,messageid;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    NavigationHandler *navHandler = [[NavigationHandler alloc] initWithMainWindow:self.window];
    [navHandler loadFirstVC];
    
    [self.window makeKeyAndVisible];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    NSDictionary *userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSString *messageID = [userInfo objectForKey:@"thread_id"];
    if (userInfo && application.applicationState != UIApplicationStateActive) {
        [[NavigationHandler getInstance] MoveToMessages:messageID];
    }
    return YES;
}
+(NSString *)getDeviceToken{
    
    return _deviceToken;
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
    NSLog(@"didRegisterUser");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceToken1 = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken1 = [deviceToken1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    _deviceToken = deviceToken1;
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Push received: %@", userInfo);
    messageid = [userInfo objectForKey:@"thread_id"];
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateBackground) {
        // go to screen relevant to Notification content
               [[NavigationHandler getInstance] MoveToMessages:messageid];
    }
    else{
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Message" message:@"New message from Admin" delegate:self cancelButtonTitle:@"Show" otherButtonTitles:@"Cancel", nil];
        alert.tag = 1;
        [alert show];
        // App is in UIApplicationStateActive (running in foreground)
        // perhaps show an UIAlertView
//        _notiThread = [[ChatThreads alloc] init];
//        _notiThread.message_text =   [userInfo objectForKey:@"message_text"];
//        _notiThread.sent_by      =   [userInfo objectForKey:@"sent_by"];
//        _notiThread.date_time    =   [userInfo objectForKey:@"date_time"];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1 && buttonIndex == 0)
    {
        //Do something
         [[NavigationHandler getInstance] MoveToMessages:messageid];
    }
    else if(alertView.tag == 1 && buttonIndex == 1)
    {
        //Do something else
        [alertView dismissWithClickedButtonIndex:1 animated:TRUE];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
