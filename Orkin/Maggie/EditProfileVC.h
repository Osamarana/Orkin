//
//  EditProfileVC.h
//  Maggie
//
//  Created by Ahmed Sadiq on 11/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileVC : UIViewController <UITextFieldDelegate> {
    UIGestureRecognizer *tapper;
    
    __weak IBOutlet UIImageView *firstImg;
    __weak IBOutlet UIImageView *secondImg;
    __weak IBOutlet UIImageView *thirdImg;
    __weak IBOutlet UIImageView *fourthImg;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *familyName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *number;

- (IBAction)welcomePressed:(id)sender;

@end
