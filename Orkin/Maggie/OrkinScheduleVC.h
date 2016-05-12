//
//  OrkinScheduleVC.h
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "ScheduleModel.h"
@interface OrkinScheduleVC : UIViewController <NIDropDownDelegate,UITextFieldDelegate,UITextViewDelegate> {
    NIDropDown *dropDown;
    __weak IBOutlet UIScrollView *mainScroler;
    UIGestureRecognizer *tapper;
    
    __weak IBOutlet UIImageView *firstImg;
    __weak IBOutlet UIImageView *secondImg;
    __weak IBOutlet UIImageView *thirdImg;
    __weak IBOutlet UIImageView *fourthImg;
    __weak IBOutlet UIImageView *fifthImg;
    __weak IBOutlet UIImageView *sixthImg;
    __weak IBOutlet UITextView *txtView;
    
}
@property (strong, nonatomic) ScheduleModel *sModel;
@property (weak, nonatomic) IBOutlet UIImageView *selectorImg;
@property (weak, nonatomic) IBOutlet UIButton *selectorBtn;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *moreDetails;
@property (weak, nonatomic) IBOutlet UITextField *cityTxt;

@property (weak, nonatomic) NSString *location;
@property (weak, nonatomic) IBOutlet UILabel *firstOptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *secondOptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *thirdOptionLbl;

- (IBAction)firstOptionPressed:(id)sender;
- (IBAction)secondOptionPressed:(id)sender;
- (IBAction)thirdOptionPressed:(id)sender;
- (IBAction)scheduleNowPressed:(id)sender;
- (IBAction)successOkPressed:(id)sender;
@end
