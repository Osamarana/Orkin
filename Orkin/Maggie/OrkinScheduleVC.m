//
//  OrkinScheduleVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinScheduleVC.h"
#import "Constants.h"
#import "CustomLoading.h"
#import "OrkinScheduleVC2.h"

@interface OrkinScheduleVC ()

@end

@implementation OrkinScheduleVC
@synthesize location;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    _email.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    _name.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    _phone.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone_no"];
    
    
    mainScroler.contentSize = CGSizeMake(320, 550);
    
//    if(![location isEqualToString:@"Home"]) {
//        mainScroler.contentSize = CGSizeMake(320, 700);
//        [self adjustViews];
//    }
//    else{
//        mainScroler.contentSize = CGSizeMake(320, 800);
//    }
    
}

- (void)adjustViews {
    _selectorBtn.hidden = true;
    _selectorImg.hidden = true;
    _secondOptionLbl.hidden = true;
    for (UIView *subview in mainScroler.subviews)
    {
        if(subview.tag > 0 && subview.tag < 17) {
            CGRect frame = subview.frame;
            frame.origin.y = frame.origin.y - 64;
            
            subview.frame = frame;
        }
    }
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)firstOptionPressed:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Home", @"Company", @"Office",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
    if(dropDown == nil) {
        CGFloat f = 186;
        if(IS_IPAD) {
            f = 280;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down":false];
        dropDown.delegate = self;
        dropDown.tag = 1;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)secondOptionPressed:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Pest Control", @"Bed Bug Control", @"Bird Control",@"Mosquito Control",@"Termite Control",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
    if(dropDown == nil) {
        CGFloat f = 310;
        if(IS_IPAD) {
            f = 280;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down":false];
        dropDown.delegate = self;
        dropDown.tag = 2;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)thirdOptionPressed:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Home", @"Company", @"Office",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
    if(dropDown == nil) {
        CGFloat f = 186;
        if(IS_IPAD) {
            f = 280;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down":false];
        dropDown.delegate = self;
        dropDown.tag = 3;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)scheduleNowPressed:(id)sender {
    if(_name.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Name cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_email.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Email cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_phone.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Number cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self validateEmailWithString:_email.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Email is not in valid format." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        //[self sendRequest];
        _sModel = [[ScheduleModel alloc] init];
        _sModel.name = _name.text;
        _sModel.email = _email.text;
        _sModel.phone = _phone.text;
        _sModel.specificProb = _cityTxt.text;
        _sModel.details = txtView.text;
        _sModel.type = location;
        
        if(IS_IPAD) {
            OrkinScheduleVC2 *childrenSUVC = [[OrkinScheduleVC2 alloc] initWithNibName:@"OrkinScheduleVC2" bundle:nil];
            childrenSUVC.sModel = _sModel;
            [self.navigationController pushViewController:childrenSUVC animated:YES];
            [self.navigationController setNavigationBarHidden:YES];
        }
        else {
            OrkinScheduleVC2 *childrenSUVC = [[OrkinScheduleVC2 alloc] initWithNibName:@"OrkinScheduleVC2" bundle:nil];
            childrenSUVC.sModel = _sModel;
            [self.navigationController pushViewController:childrenSUVC animated:YES];
            [self.navigationController setNavigationBarHidden:YES];
        }
    }
}



- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    if(sender.tag == 1) {
        if(sender.selectedIndex == 0) {
            _firstOptionLbl.text = @"Home";
        }
        else if(sender.selectedIndex == 1) {
            _firstOptionLbl.text = @"Company";
        }
        else if(sender.selectedIndex == 2) {
            _firstOptionLbl.text = @"Office";
        }
    }
    else if(sender.tag == 2) {
        if(sender.selectedIndex == 0) {
            _secondOptionLbl.text = @"Pest Control";
        }
        else if(sender.selectedIndex == 1) {
            _secondOptionLbl.text = @"Bed Bug Control";
        }
        else if(sender.selectedIndex == 2) {
            _secondOptionLbl.text = @"Bird Control";
        }
        else if(sender.selectedIndex == 3) {
            _secondOptionLbl.text = @"Mosquito Control";
        }
        else if(sender.selectedIndex == 4) {
            _secondOptionLbl.text = @"Termite Control";
        }
    }
    else {
        if(sender.selectedIndex == 0) {
            _secondOptionLbl.text = @"Home";
        }
        else if(sender.selectedIndex == 1) {
            _secondOptionLbl.text = @"Company";
        }
        else if(sender.selectedIndex == 2) {
            _secondOptionLbl.text = @"Office";
        }
    }
    
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 5:
            firstImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 7:
            secondImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 9:
            thirdImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 11:
            fourthImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 13:
            fifthImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 15:
            sixthImg.image = [UIImage imageNamed:@"commentselected.png"];
            break;
            
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 5:
            firstImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 7:
            secondImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 9:
            thirdImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 11:
            fourthImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 13:
            fifthImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 15:
            sixthImg.image = [UIImage imageNamed:@"dialogbg.png"];
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"More Details..."]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
    sixthImg.image = [UIImage imageNamed:@"commentselected.png"];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"More Details...";
    }
    
    sixthImg.image = [UIImage imageNamed:@"dialogbg.png"];
}


@end
