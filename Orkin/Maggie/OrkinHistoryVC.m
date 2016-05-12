//
//  OrkinHistoryVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinHistoryVC.h"
#import "OrkinHistoryCell.h"
#import "DrawerVC.h"
#import "Constants.h"
#import "CustomLoading.h"
#import "HistoryModel.h"
#import "MessageHistory.h"
#import "ChatThreads.h"
#import "OrkinMessageCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatThreadsVCViewController.h"
@interface OrkinHistoryVC ()

@end

@implementation OrkinHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _outerView.layer.cornerRadius = 15;
    _outerView.layer.masksToBounds = YES;
    
    _hDetailScroll.contentSize = CGSizeMake(320, 500);
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor redColor];
    [_tblView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(getLatest)
                  forControlEvents:UIControlEventValueChanged];
    [self getHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getLatest{
    [self getHistory];
}
- (IBAction)historyDetailBackPressed:(id)sender {
    _historyDetailView.hidden = true;
}

- (IBAction)drawerPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)webPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.orkinlebanon.com/"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isMessage) {
        return _messageArray.count;
    }
    else {
        return _historyArray.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isMessage) {
        MessageHistory *hModel = (MessageHistory*)[_messageArray objectAtIndex:indexPath.row];
        
        OrkinMessageCell * cell = (OrkinMessageCell *)[_tblView dequeueReusableCellWithIdentifier:@""];
        if(IS_IPAD) {
            if (cell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrkinMessageCell_iPad" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
        }
        else {
            if (cell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrkinMessageCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *myString = hModel.schedule_datetime;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:myString];
        dateFormatter.dateFormat = @"dd/MM/yyyy (HH:mm a)";
        
        //3/2/2016 (7:00PM)
        //
        cell.title.text = hModel.message_text;
        cell.status.text = hModel.status;
        cell.timeLbl.text = [dateFormatter stringFromDate:yourDate];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else {
        HistoryModel *hModel = (HistoryModel*)[_historyArray objectAtIndex:indexPath.row];
        
        OrkinHistoryCell * cell = (OrkinHistoryCell *)[_tblView dequeueReusableCellWithIdentifier:@""];
        if(IS_IPAD) {
            if (cell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrkinHistoryCell_iPad" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
        }
        else {
            if (cell == nil) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrkinHistoryCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *myString = hModel.schedule_datetime;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:myString];
        dateFormatter.dateFormat = @"dd/MM/yyyy (HH:mm a)";
        
        
        cell.title.text = hModel.premises_type;
        cell.location.text = [NSString stringWithFormat:@"Location: %@",hModel.service_location];
        cell.tme.text = [dateFormatter stringFromDate:yourDate];
        cell.status.text = hModel.status;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(IS_IPAD) {
        return 100;
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(isMessage) {
        MessageHistory *hModel = (MessageHistory*)[_messageArray objectAtIndex:indexPath.row];
//        _msgDetailView.hidden = false;
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        
//        NSString *myString = hModel.schedule_datetime;
//        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        NSDate *yourDate = [dateFormatter dateFromString:myString];
//        dateFormatter.dateFormat = @"dd/MM/yyyy (HH:mm a)";
//        _timeLbl.text = [dateFormatter stringFromDate:yourDate];
//        _statusLbl.text = hModel.status;
        
        ChatThreadsVCViewController *childrenSUVC = [[ChatThreadsVCViewController alloc] initWithNibName:@"ChatThreadsVCViewController" bundle:nil];
        childrenSUVC.messages = nil;
        childrenSUVC.status   = hModel.status;
        childrenSUVC.messageId = hModel.message_id;
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    else {
        HistoryModel *hModel = (HistoryModel*)[_historyArray objectAtIndex:indexPath.row];
        _historyDetailView.hidden = false;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *myString = hModel.schedule_datetime;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:myString];
        dateFormatter.dateFormat = @"dd/MM/yyyy (HH:mm a)";
        _historyTimeLbl.text = [dateFormatter stringFromDate:yourDate];
        _hName_lbl.text = hModel.customer_name;
        _hEmailLbl.text = hModel.email;
        _hPhoneLbl.text = hModel.phone_no;
        _hLocTxt.text = hModel.service_location;
        _hSurfaceLbl.text = hModel.surface_area;
        _hPremisesTypeLbl.text = hModel.premises_type;
        _hMoreDetailLbl.text = hModel.more_detail;
        
    }
}

#pragma mark - server communication methods
- (void) getHistory{
    [CustomLoading showAlertMessage];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    [postParams setObject:METHOD_HISTORY forKey:@"method"];
    [postParams setObject:user_id forKey:@"user_id"];
    [postParams setObject:@"1" forKey:@"fetch_all"];
    
    NSData *postData = [self encodeDictionary:postParams];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData  *data, NSError *error) {
        
        [CustomLoading DismissAlertMessage];
        [self.refreshControl endRefreshing];
        if ( [(NSHTTPURLResponse *)response statusCode] == 200 )
        {
            
            _historyArray = [[NSMutableArray alloc] init];
            _messageArray = [[NSMutableArray alloc] init];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            int flag = [[result objectForKey:@"flag"] intValue];
            
            if(flag == 1) {
                
                NSArray *data = (NSArray*)[result objectForKey:@"requests"];
                NSArray *messagesData = (NSArray*)[result objectForKey:@"messages"];
                for(int i=0; i<data.count; i++) {
                    
                    NSDictionary *tempDict = (NSDictionary*)[data objectAtIndex:i];
                    HistoryModel *hModel = [[HistoryModel alloc] init];
                    hModel.address = [tempDict objectForKey:@"address"];
                    hModel.area = [tempDict objectForKey:@"area"];
                    hModel.city = [tempDict objectForKey:@"city"];
                    hModel.customer_name = [tempDict objectForKey:@"customer_name"];
                    hModel.email = [tempDict objectForKey:@"email"];
                    hModel.more_detail = [tempDict objectForKey:@"more_detail"];
                    hModel.phone_no = [tempDict objectForKey:@"phone_no"];
                    hModel.premises_type = [tempDict objectForKey:@"premises_type"];
                    hModel.schedule_datetime = [tempDict objectForKey:@"schedule_datetime"];
                    hModel.schedule_id = [tempDict objectForKey:@"schedule_id"];
                    hModel.schedule_type = [tempDict objectForKey:@"schedule_type"];
                    hModel.service_location = [tempDict objectForKey:@"service_location"];
                    hModel.specific_problem = [tempDict objectForKey:@"specific_problem"];
                    hModel.status = [tempDict objectForKey:@"status"];
                    hModel.surface_area = [tempDict objectForKey:@"surface_area"];
                    hModel.user_id = [tempDict objectForKey:@"user_id"];
                    [_historyArray addObject:hModel];
                   
                }
                for(int i=0; i<messagesData.count; i++)
                {
                    NSDictionary *tempDict = (NSDictionary*)[messagesData objectAtIndex:i];
                    MessageHistory *mModel = [[MessageHistory alloc] init];
                    mModel.message_id = [tempDict objectForKey:@"message_id"];
                    mModel.message_text = [tempDict objectForKey:@"message_text"];
                    mModel.status = [tempDict objectForKey:@"status"];
                    mModel.schedule_datetime = [tempDict objectForKey:@"schedule_datetime"];
                    NSArray *messageThreads = (NSArray*)[tempDict objectForKey:@"chat_messages"];
                     mModel.chat_messages = [[NSMutableArray alloc] init];
                    for(int i=0; i<messageThreads.count; i++)
                    {
                       
                        NSDictionary *chatDict = (NSDictionary*)[messageThreads objectAtIndex:i];
                        ChatThreads *tempChat = [[ChatThreads alloc] init];
                        tempChat.message_text = [chatDict objectForKey:@"message_text"];
                        tempChat.sent_by      = [chatDict objectForKey:@"sent_by"];
                        tempChat.date_time    = [chatDict objectForKey:@"date_time"];
                        [mModel.chat_messages addObject:tempChat];
                    }
                    [_messageArray addObject:mModel];
                }
                if(isMessage) {
                    if(_messageArray.count == 0) {
                        _noRecordLbl.hidden = false;
                    }
                    else {
                        _noRecordLbl.hidden = true;
                        [_tblView reloadData];
                    }
                }
                else{
                    if(_historyArray.count == 0) {
                        _noRecordLbl.hidden = false;
                    }
                    else {
                        _noRecordLbl.hidden = true;
                        [_tblView reloadData];
                    }
                }
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
- (IBAction)historyPressed:(id)sender {
    isMessage = false;
    _messageBar.hidden = true;
    _msgLbl.textColor = [UIColor blackColor];
    
    _historyBar.hidden = false;
    _historyLbl.textColor = [UIColor colorWithRed:0.717 green:0 blue:0 alpha:1.0];
    
    if(_historyArray.count == 0) {
        _noRecordLbl.hidden = false;
        _tblView.hidden = true;
    }
    else {
        _noRecordLbl.hidden = true;
        _tblView.hidden = false;
        [_tblView reloadData];
    }
    
}
- (IBAction)messagePressed:(id)sender {
    isMessage = true;
    _historyBar.hidden = true;
    _historyLbl.textColor = [UIColor blackColor];
    
    _messageBar.hidden = false;
    _msgLbl.textColor = [UIColor colorWithRed:0.717 green:0 blue:0 alpha:1.0];
    
    if(_messageArray.count == 0) {
        _tblView.hidden = true;
        _noRecordLbl.hidden = false;
    }
    else {
        _tblView.hidden = false;
        _noRecordLbl.hidden = true;
        [_tblView reloadData];
    }
}
- (IBAction)closeBtnPressed:(id)sender {
    _msgDetailView.hidden = true;
}
@end
