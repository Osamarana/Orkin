//
//  OrkinSignUpVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 09/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinSignUpVC.h"
#import "ViewController.h"
#import "NavigationHandler.h"
#import "CustomLoading.h"
#import "Constants.h"
#import "AppDelegate.h"
@interface OrkinSignUpVC ()

@end

@implementation OrkinSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
   
    NSString *countryCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"country_flag"];
    if([countryCode isEqualToString:@"Lebanon"]){
        _number.text = @"+961";
    }
    else if ([countryCode isEqualToString:@"Qatar"]) {
        _number.text = @"+974";
    }
    else if ( [countryCode isEqualToString:@"Iraq"]) {
        _number.text = @"+964";
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

- (IBAction)welcomePressed:(id)sender {
    
    if(_name.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Name cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_familyName.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Family name cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_email.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Email cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_number.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Number cannot be Empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self validateEmailWithString:_email.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Email is not in valid format." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [self sendSignUpCall];
    }
    
    
}

#pragma mark - Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            firstImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 2:
            secondImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 3:
            thirdImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
        case 4:
            fourthImg.image = [UIImage imageNamed:@"textboxselected.png"];
            break;
            
        default:
            break;
    }
    if(textField.tag > 2 ) {
        [self animateTextField:nil up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            firstImg.image = [UIImage imageNamed:@"textboxbg.png"];
            break;
        case 2:
            secondImg.image = [UIImage imageNamed:@"textboxbg.png"];
            break;
        case 3:
            thirdImg.image = [UIImage imageNamed:@"textboxbg.png"];
            break;
        case 4:
            fourthImg.image = [UIImage imageNamed:@"textboxbg.png"];
            break;
            
        default:
            break;
    }
    
    if(textField.tag > 2) {
        [self animateTextField:nil up:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 165; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - server communication methods
- (void) sendSignUpCall{
    [CustomLoading showAlertMessage];
    
    NSString *country_flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"country_flag"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_SIGN_UP forKey:@"method"];
    [postParams setObject:_name.text forKey:@"name"];
    [postParams setObject:_email.text forKey:@"email"];
    [postParams setObject:_number.text forKey:@"phone_no"];
    [postParams setObject:_familyName.text forKey:@"family_name"];
    [postParams setObject:country_flag forKey:@"country_flag"];
    
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
                
                NSDictionary *data = (NSDictionary*)[result objectForKey:@"user_data"];
                
                NSString *emailStr = [data objectForKey:@"email"];
                NSString *familyName = [data objectForKey:@"family_name"];
                NSString *nameStr = [data objectForKey:@"name"];
                NSString *phone_no = [data objectForKey:@"phone_no"];
                NSString *user_id = [data objectForKey:@"user_id"];
                
                [[NSUserDefaults standardUserDefaults] setObject:emailStr forKey:@"email"];
                [[NSUserDefaults standardUserDefaults] setObject:familyName forKey:@"family_name"];
                [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] setObject:phone_no forKey:@"phone_no"];
                [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
                
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"logged_in"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self sendNotificationKey];
                [[NavigationHandler getInstance] NavigateToHomeScreen];
                
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
-(void) sendNotificationKey{
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *token = [AppDelegate getDeviceToken];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_ADDNOTIFICATION_KEY forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:@"IOS" forKey:@"device_type"];
    if(token)
        [postParams setObject:token forKey:@"device_id"];
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
@end
