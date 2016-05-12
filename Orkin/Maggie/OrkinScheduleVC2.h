//
//  OrkinScheduleVC2.h
//  Maggie
//
//  Created by Ahmed Sadiq on 25/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "ScheduleModel.h"
@interface OrkinScheduleVC2 : UIViewController <NIDropDownDelegate,UITextFieldDelegate>{
    __weak IBOutlet UIImageView *firstImg;
    __weak IBOutlet UIImageView *secondImg;
    __weak IBOutlet UIImageView *thirdImg;
    __weak IBOutlet UIImageView *fourthImg;
    
    NIDropDown *dropDown;
    UIGestureRecognizer *tapper;
    BOOL isPremises;
}

@property (strong, nonatomic) ScheduleModel *sModel;
@property (weak, nonatomic) IBOutlet UILabel *firstOptionLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (weak, nonatomic) IBOutlet UITextField *addressTxt;
@property (weak, nonatomic) IBOutlet UITextField *areaTxt;
@property (weak, nonatomic) IBOutlet UITextField *cityTxt;
@property (weak, nonatomic) IBOutlet UITextField *surfaceTxt;
@property (weak, nonatomic) IBOutlet UIView *successView;
- (IBAction)successOkPressed:(id)sender;

- (IBAction)backPressed:(id)sender;
- (IBAction)premisesPressed:(id)sender;
- (IBAction)submitPressed:(id)sender;
@end
