//
//  ViewController.m
//  Maggie
//
//  Created by Hannan Khan on 12/9/15.
//  Copyright © 2015 Hannan Khan. All rights reserved.
//

#import "ViewController.h"
#import "DrawerVC.h"
#import "OrkinQuoteVC.h"
#import "Constants.h"
#import "CustomLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"name"];
    NSString *nameUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    lblName.text = [NSString stringWithFormat:@"Hi %@",nameUser];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Swipe Left");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [[DrawerVC getInstance] AddInView:self.view];
        [[DrawerVC getInstance] ShowInView];
        NSLog(@"Swipe Right");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Swipe Up");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe Down");
    }
}

- (void)changeImage
{
    static int counter = 1;
    if([_images count] == counter)
    {
        counter = 0;
    }
    UIImage * toImage = [UIImage imageNamed:[_images objectAtIndex:counter]];
    
    [UIView transitionWithView:self.imgView
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.imgView.image = toImage;
                    } completion:nil];
    
    counter++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSms:(id)sender {
//    if(![MFMessageComposeViewController canSendText]) {
//        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [warningAlert show];
//        return;
//    }
//    
//    NSArray *recipents = @[@"+18667139979"];
//    NSString *message = [NSString stringWithFormat:@"Tweety.Technology is a client-centric, quality-focused, fast-paced IT Services and products based company."];
//    
//    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//    messageController.messageComposeDelegate = self;
//    [messageController setRecipients:recipents];
//    [messageController setBody:message];
//    
//    // Present message view controller on screen
//    [self presentViewController:messageController animated:YES completion:nil];
    txtView.text = @"Add Details...";
    emailView.hidden = false;
}

- (IBAction)sendEmail:(id)sender {
//    NSString *emailTitle = @"Tweety.Technology";
//    // Email Content
//    NSString *messageBody = @"Tweety.Technology is a client-centric, quality-focused, fast-paced IT Services and products based company.";
//    // To address
//    NSArray *toRecipents = [NSArray arrayWithObject:@"support@tweetytechnology.com"];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    if ([MFMailComposeViewController canSendMail]) {
//        mc.mailComposeDelegate = self;
//        [mc setSubject:emailTitle];
//        [mc setMessageBody:messageBody isHTML:NO];
//        [mc setToRecipients:toRecipents];
//        
//        // Present mail view controller on screen
//        [self presentViewController:mc animated:YES completion:NULL];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Configuration Error" message:@"Please configure email in your device settings" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    //2016-03-28 09:37:09
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_SUBMIT_ACTION forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:@"CALL" forKey:@"action_name"];
    [postParams setObject:formattedDate forKey:@"action_date_time"];
    
    NSData *postData = [self encodeDictionary:postParams];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData  *data, NSError *error) {
        
        if ( [(NSHTTPURLResponse *)response statusCode] == 200 )
        {
            
        }
        else{
        }
    }];
    
    NSString *phNo = @"+96176763252";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (IBAction)call:(id)sender {
    
}

- (IBAction)quotePressed:(id)sender {
    if(IS_IPAD) {
        OrkinQuoteVC *childrenSUVC = [[OrkinQuoteVC alloc] initWithNibName:@"OrkinQuoteVC_iPad" bundle:nil];
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    else {
        OrkinQuoteVC *childrenSUVC = [[OrkinQuoteVC alloc] initWithNibName:@"OrkinQuoteVC" bundle:nil];
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}

- (IBAction)emailSubmitPressed:(id)sender {
  
    [self.view endEditing:YES];
    
    if([txtView.text isEqualToString:@"Add Details..."] || txtView.text.length<1) {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"INVALID INPUT" message:@"Please enter details." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    else {
        [CustomLoading showAlertMessage];
        
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
        [postParams setObject:METHOD_SUBMIT_MESSAGE forKey:@"method"];
        [postParams setObject:user_id forKey:@"user_id"];
        [postParams setObject:txtView.text forKey:@"message_text"];
        
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Message sent successfully" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    emailView.hidden = true;
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Occured" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
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
}

- (IBAction)emailBackPressed:(id)sender {
    emailView.hidden = true;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)webPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.orkinlebanon.com/"]];
}

- (IBAction)ShowDrawer:(id)sender {
    [[DrawerVC getInstance] AddInView:self.view];
    [[DrawerVC getInstance] ShowInView];
}

#pragma mark - Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:nil up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:nil up:NO];
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Add Details..."]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
    _sixthImg.image = [UIImage imageNamed:@"commentselected.png"];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add Details...";
    }
    
    _sixthImg.image = [UIImage imageNamed:@"dialogbg.png"];
}
@end
