//
//  EditProfileVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 11/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "EditProfileVC.h"
#import "CustomLoading.h"
#import "Constants.h"
@interface EditProfileVC ()

@end

@implementation EditProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    _email.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    _name.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    _familyName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"family_name"];
    _number.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone_no"];
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
        [self sendEditProfileCall];
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
            firstImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 2:
            secondImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 3:
            thirdImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
            break;
        case 4:
            fourthImg.image = [UIImage imageNamed:@"qtextboxbg.png"];
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
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - server communication methods
- (void) sendEditProfileCall{
    [CustomLoading showAlertMessage];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_EDIT_PROFILE forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:_name.text forKey:@"name"];
    [postParams setObject:_email.text forKey:@"email"];
    [postParams setObject:_number.text forKey:@"phone_no"];
    [postParams setObject:_familyName.text forKey:@"family_name"];
    
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
            int flag = [[result objectForKey:@"success"] intValue];
            
            if(flag == 1) {
                
                [[NSUserDefaults standardUserDefaults] setObject:_email.text forKey:@"email"];
                [[NSUserDefaults standardUserDefaults] setObject:_familyName.text forKey:@"family_name"];
                [[NSUserDefaults standardUserDefaults] setObject:_name.text forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] setObject:_number.text forKey:@"phone_no"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.navigationController popViewControllerAnimated:true];
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
