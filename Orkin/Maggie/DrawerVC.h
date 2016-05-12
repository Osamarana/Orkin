//
//  DrawerVC.h
//  HydePark
//
//  Created by Mr on 22/04/2015.
//  Copyright (c) 2015 TxLabz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

enum {
    
    OFF_HIDDEN = 0,
    ON_SCREEN = 1,
    
};
typedef NSUInteger CurrentState;


@interface DrawerVC : UIViewController{
    UIView *parentView;
    CurrentState _currentState;

    AppDelegate *appDelegate;
    
    __weak IBOutlet UIImageView *profileImg;
    __weak IBOutlet UILabel *usernameLbl;
    __weak IBOutlet UILabel *usernameIdLbl;
    __weak IBOutlet UILabel *userBalLbl;
    
    
    __weak IBOutlet UIImageView *dimmer;
    
}
@property int tag;
@property CurrentState _currentState;

@property ( strong , nonatomic ) UINavigationController *navigationController;

+(DrawerVC *)getInstance;
-(void)AddInView:(UIView *)parentView;
-(void)ShowInView;

-(IBAction)generalAction:(id)sender;
- (IBAction)logTicketPressed:(id)sender;
- (IBAction)appSettngs:(id)sender;

- (IBAction)homePressed:(id)sender;

- (IBAction)logOutPressed:(id)sender;

- (IBAction)shopPressed:(id)sender;
- (IBAction)sliderPressed:(id)sender;

@end
