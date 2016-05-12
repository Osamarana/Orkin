//
//  NavigationHandler.h
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface NavigationHandler : NSObject{
    
    UINavigationController *navController;
    UIWindow *_window;
    
    AppDelegate *appDelegate;
}

-(id)initWithMainWindow:(UIWindow *)_tempWindow;
-(void)loadFirstVC;

+(NavigationHandler *)getInstance;
-(void)NavigateToHomeScreen;
-(void)MoveToHistory;
-(void)MoveToEditProfile;
-(void)MoveToMessages:(NSString *)messageId;
-(void)loadFirstVCNotifications:(NSString *)messageId;
@end
