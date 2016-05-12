//
//  ChatThreadsVCViewController.m
//  Maggie
//
//  Created by Apple on 04/05/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "ChatThreadsVCViewController.h"
#import "ChatThreads.h"
#import "Constants.h"
#import "CustomLoading.h"
@interface ChatThreadsVCViewController ()

@end

@implementation ChatThreadsVCViewController
@synthesize messages,status,messageId;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (_tableView.contentSize.height > _tableView.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, _tableView.contentSize.height -  _tableView.frame.size.height);
//        [_tableView setContentOffset:offset animated:NO];
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getChatByMessageId];
    _statuslbl.text = status;
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 320, 60)];
    delegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    chatsAray = [[NSArray alloc] init];
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 60)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    textView.returnKeyType = UIReturnKeyDone; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"Message...";
    
    // textView.text = @"test\n\ntest";
    // textView.animateHeightChange = NO; //turns off animation
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardaa)];
    [self.view addGestureRecognizer:tap];
   // [self.view addSubview:containerView];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, 248, 60);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    //[containerView addSubview:imageView];
    //[containerView addSubview:textView];
    //[containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [chatview addSubview:doneBtn];
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}
- (IBAction)optionPressed:(id)sender {
    statusView.hidden = NO;
}
- (IBAction)openPressed:(id)sender {
    statusView.hidden = YES;
    statusString = @"OPEN";
    [self setStatus];
}
- (IBAction)closePressed:(id)sender {
    statusView.hidden = YES;
    statusString = @"CLOSE";
    [self setStatus];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)setStatus{
    [CustomLoading showAlertMessage];
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:@"updateRequestStatus" forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:messageId forKey:@"message_id"];
    [postParams setObject:statusString forKey:@"status"];
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
                _statuslbl.text =  statusString;
                
            }
        }
        else{
            NSLog(@"Error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Conection Error" message:@"Please retry after some time" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

}
-(void)getChatByMessageId{
    [CustomLoading showAlertMessage];
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:@"getChatByMessageId" forKey:@"method"];
    [postParams setObject:messageId forKey:@"message_id"];
    NSData *postData = [self encodeDictionary:postParams];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData  *data, NSError *error) {
        [CustomLoading DismissAlertMessage];
        if ( [(NSHTTPURLResponse *)response statusCode] == 200 )
        {
            messages = [[NSMutableArray alloc] init];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            int flag = [[result objectForKey:@"flag"] intValue];
            if(flag == 1) {
                chatsAray = (NSArray*)[result objectForKey:@"chat_messages"];
                for(int i=0; i<chatsAray.count; i++) {
                    NSDictionary *tempDict = (NSDictionary*)[chatsAray objectAtIndex:i];
                    ChatThreads *threads = [[ChatThreads alloc] init];
                    threads.message_text  = [tempDict objectForKey:@"message_text"];
                    threads.date_time     = [tempDict objectForKey:@"date_time"];
                    threads.sent_by       = [tempDict objectForKey:@"sent_by"];
                    [messages addObject:threads];
                }
                [_tableView reloadData];
                if (_tableView.contentSize.height > _tableView.frame.size.height)
                {
                    CGPoint offset = CGPointMake(0, _tableView.contentSize.height -  _tableView.frame.size.height);
                    [_tableView setContentOffset:offset animated:NO];
                }
            }
        }
        else{
            NSLog(@"Error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Conection Error" message:@"Please retry after some time" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
}
-(void)dismissKeyboardaa
{
    [statusView setHidden:YES];
    [textView resignFirstResponder];
}
-(void)sendMessage
{
     [_chattext resignFirstResponder];
    [CustomLoading showAlertMessage];
    NSString *textToSend = _chattext.text;
    _chattext.text = @"";
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_SEND_CHAT_MESSAGE forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:messageId forKey:@"message_id"];
    [postParams setObject:textToSend forKey:@"message_text"];
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
                ChatThreads *threads = [[ChatThreads alloc] init];
                threads.message_text = textToSend;
                threads.sent_by = @"USER";
                [messages addObject:threads];
                [_tableView reloadData];
                if (_tableView.contentSize.height > _tableView.frame.size.height)
                {
                    CGPoint offset = CGPointMake(0, _tableView.contentSize.height -  _tableView.frame.size.height);
                    [_tableView setContentOffset:offset animated:YES];
                }
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
//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = chatview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    chatview.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = chatview.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    chatview.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)drawerPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    
    PTSMessagingCell * cell = (PTSMessagingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatThreads *threads = [messages objectAtIndex:indexPath.row];
    CGSize messageSize = [PTSMessagingCell messageSize:threads.message_text];
    return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f;
}

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    ChatThreads *threads = [messages objectAtIndex:indexPath.row];
    if ([threads.sent_by isEqualToString:@"USER"]) {
        ccell.sent = YES;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person1"];
        ccell.messageLabel.textColor = [UIColor blackColor];
    } else {
        ccell.messageLabel.textColor = [UIColor whiteColor];
        ccell.sent = NO;
        ccell.avatarImageView.image = [UIImage imageNamed:@"person2"];
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *myString = threads.date_time;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *yourDate = [dateFormatter dateFromString:myString];
    dateFormatter.dateFormat = @"HH:mm a";
    ccell.messageLabel.text = threads.message_text;
    if([dateFormatter stringFromDate:yourDate])
        ccell.timeLabel.text = [NSString stringWithFormat:@"Sent %@",[dateFormatter stringFromDate:yourDate]];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
