//
//  AppDelegate.h
//  Maggie
//
//  Created by Hannan Khan on 12/9/15.
//  Copyright © 2015 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatThreads.h"
@class ViewController;
@class OrkinRegionVC;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ( strong , nonatomic ) UINavigationController *navigationController;
@property ( strong , nonatomic ) UIViewController *viewController;
@property (strong, nonatomic) NSString *dToken;
@property (strong, nonatomic) ChatThreads *notiThread;
@property (strong, nonatomic) NSString *messageid;
+(NSString *)getDeviceToken;
@end

