//
//  OrkinScheduleVC2.m
//  Maggie
//
//  Created by Ahmed Sadiq on 25/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinScheduleVC2.h"
#import "Constants.h"
#import "CustomLoading.h"
#import "ViewController.h"
@interface OrkinScheduleVC2 ()

@end

@implementation OrkinScheduleVC2
@synthesize sModel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    _mainScroller.contentSize = CGSizeMake(320, 650);
    
    
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

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)premisesPressed:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    if([sModel.type isEqualToString:@"Residential"]) {
        arr = [NSArray arrayWithObjects:@"Villa", @"Apartment", @"Duplex",@"Triplex",@"Chalet",nil];
        
        NSArray * arrImage = [[NSArray alloc] init];
        arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
        if(dropDown == nil) {
            CGFloat f = 310;
            if(IS_IPAD) {
                f = 310;
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
    else{
        
        arr = [NSArray arrayWithObjects:@"Restaurant", @"Hotel", @"Office",@"Hospital",@"Clinic",@"School",@"Shop",@"Other",nil];
        
        NSArray * arrImage = [[NSArray alloc] init];
        arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
        if(dropDown == nil) {
            CGFloat f = 496;
            if(IS_IPAD) {
                f = 496;
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
    
    
}

- (IBAction)submitPressed:(id)sender {
    if(_addressTxt.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Address cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_areaTxt.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Area cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_cityTxt.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"City cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(!isPremises) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Please select any valid premises" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_surfaceTxt.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Surface Area cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        sModel.address = _addressTxt.text;
        sModel.area = _areaTxt.text;
        sModel.city = _cityTxt.text;
        sModel.premises = _firstOptionLbl.text;
        sModel.surfaceArea = _surfaceTxt.text;
        [self sendRequest];
        
    }
}

#pragma mark - Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 10:
            firstImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 11:
            secondImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 12:
            thirdImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 13:
            fourthImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
            
        default:
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 10:
            firstImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 11:
            secondImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 12:
            thirdImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 13:
            fourthImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    isPremises = true;
    if([sModel.type isEqualToString:@"Residential"]) {
        if(sender.selectedIndex == 0) {
            _firstOptionLbl.text = @"Villa";
        }
        else if(sender.selectedIndex == 1) {
            _firstOptionLbl.text = @"Apartment";
        }
        else if(sender.selectedIndex == 2) {
            _firstOptionLbl.text = @"Duplex";
        }
        else if(sender.selectedIndex == 3) {
            _firstOptionLbl.text = @"Triplex";
        }
        else if(sender.selectedIndex == 4) {
            _firstOptionLbl.text = @"Chalet";
        }
    }
    else{
        
        if(sender.selectedIndex == 0) {
            _firstOptionLbl.text = @"Restaurant";
        }
        else if(sender.selectedIndex == 1) {
            _firstOptionLbl.text = @"Hotel";
        }
        else if(sender.selectedIndex == 2) {
            _firstOptionLbl.text = @"Office";
        }
        else if(sender.selectedIndex == 3) {
            _firstOptionLbl.text = @"Hospital";
        }
        else if(sender.selectedIndex == 4) {
            _firstOptionLbl.text = @"Clinic";
        }
        else if(sender.selectedIndex == 5) {
            _firstOptionLbl.text = @"School";
        }
        else if(sender.selectedIndex == 6) {
            _firstOptionLbl.text = @"Shop";
        }
        else if(sender.selectedIndex == 7) {
            _firstOptionLbl.text = @"Other";
        }
    }
    
    [self rel];
}

#pragma mark - server communication methods
- (void) sendRequest{
    [CustomLoading showAlertMessage];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_SUBMIT forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:sModel.type forKey:@"service_location"];
    [postParams setObject:sModel.name forKey:@"customer_name"];
    [postParams setObject:sModel.email forKey:@"email"];
    [postParams setObject:sModel.phone forKey:@"phone_no"];
    [postParams setObject:sModel.address forKey:@"address"];
    [postParams setObject:sModel.area forKey:@"area"];
    [postParams setObject:sModel.city forKey:@"city"];
    [postParams setObject:sModel.premises forKey:@"premises_type"];
    [postParams setObject:sModel.surfaceArea forKey:@"surface_area"];
    [postParams setObject:sModel.details forKey:@"more_detail"];
    [postParams setObject:sModel.specificProb forKey:@"specific_problem"];
    
    NSData *postData = [self encodeDictionary:postParams];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData  *data, NSError *error) {
        
        [CustomLoading DismissAlertMessage];
        if ( [(NSHTTPURLResponse *)response statusCode] == 200 )
        {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            int flag = [[result objectForKey:@"flag"] intValue];
            
            if(flag == 1) {
                
                //[self.navigationController popViewControllerAnimated:true];
                _successView.hidden = false;
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verification Error" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
            NSLog(@"Error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Conection Error" message:@"Please retry after some time" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

#pragma mark - Server Communication Helpher Method

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)successOkPressed:(id)sender {
    _successView.hidden = true;
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[ViewController class]])
        {
            //Do not forget to import AnOldViewController.h
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
    
}
@end
