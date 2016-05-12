//
//  ViewController.h
//  Maggie
//
//  Created by Hannan Khan on 12/9/15.
//  Copyright © 2015 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate> {
    NSArray *_images;
    NSTimer *myTimer;
    int imageCount;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UITextField *textToEmail;
    __weak IBOutlet UIView *emailView;
    __weak IBOutlet UITextView *txtView;
    UIGestureRecognizer *tapper;
}
@property (weak, nonatomic) IBOutlet UIImageView *sixthImg;
- (IBAction)sendSms:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)quotePressed:(id)sender;
- (IBAction)emailSubmitPressed:(id)sender;
- (IBAction)emailBackPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

