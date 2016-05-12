//
//  NavigationHandler.m
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "NavigationHandler.h"
#import "ViewController.h"
#import "OrkinRegionVC.h"
#import "Constants.h"
#import "OrkinHistoryVC.h"
#import "EditProfileVC.h"
#import "ChatThreadsVCViewController.h"
@implementation NavigationHandler

- (id)initWithMainWindow:(UIWindow *)_tempWindow{
    
    if(self = [super init])
    {
        _window = _tempWindow;
    }
    instance = self;
    return self;
}

static NavigationHandler *instance= NULL;

+(NavigationHandler *)getInstance
{
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    
    return instance;
}

-(void)loadFirstVC{
    
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"])
    {
        [self NavigateToHomeScreen];
        
    }
    else{
        
        OrkinRegionVC *_mainVC = [[OrkinRegionVC alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:_mainVC];
        _window.rootViewController = navController;
        [navController setNavigationBarHidden:YES];
    }
}
-(void)loadFirstVCNotifications:(NSString *)messageId{
    navController = nil;
    if (IS_IPAD) {
        
        ViewController *homeVC1 = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:homeVC1];
    }
    
    else{
        
        ViewController *homeVC2 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:homeVC2];
    }
    _window.rootViewController = navController;
    [navController setNavigationBarHidden:YES];
    [self MoveToMessages:messageId];
}
-(void)NavigateToHomeScreen{
    navController = nil;
    if (IS_IPAD) {
        
        ViewController *homeVC1 = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:homeVC1];
    }
    
    else{
        
        ViewController *homeVC2 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:homeVC2];
    }
    _window.rootViewController = navController;
    [navController setNavigationBarHidden:YES];
    
}

-(void)MoveToHistory{
    
    [navController popToRootViewControllerAnimated:NO];
    
    if (IS_IPAD)
    {
        
        OrkinHistoryVC *topic = [[OrkinHistoryVC alloc] initWithNibName:@"OrkinHistoryVC_iPad" bundle:nil];
        [navController pushViewController:topic animated:YES];
    }
    
    else
    {
        
        OrkinHistoryVC *topic1 = [[OrkinHistoryVC alloc] initWithNibName:@"OrkinHistoryVC" bundle:nil];
        [navController pushViewController:topic1 animated:YES];
        
    }
    
}

-(void)MoveToEditProfile{
    
    [navController popToRootViewControllerAnimated:NO];
    
    if (IS_IPAD)
    {
        
        EditProfileVC *topic = [[EditProfileVC alloc] initWithNibName:@"EditProfileVC_iPad" bundle:nil];
        [navController pushViewController:topic animated:YES];
    }
    
    else
    {
        
        EditProfileVC *topic1 = [[EditProfileVC alloc] initWithNibName:@"EditProfileVC" bundle:nil];
        [navController pushViewController:topic1 animated:YES];
        
    }
    
}
-(void)MoveToMessages:(NSString *)messageId{
    
    if (IS_IPAD)
    {
        ChatThreadsVCViewController *topic = [[ChatThreadsVCViewController alloc] initWithNibName:@"ChatThreadsVCViewController" bundle:nil];
        topic.messageId = messageId;
        [navController pushViewController:topic animated:YES];
    }
    else
    {
        ChatThreadsVCViewController *topic1 = [[ChatThreadsVCViewController alloc] initWithNibName:@"ChatThreadsVCViewController" bundle:nil];
        topic1.messageId = messageId;
        [navController pushViewController:topic1 animated:YES];
    }
}
@end
