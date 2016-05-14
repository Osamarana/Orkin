//
//  ChatThreadsVCViewController.h
//  Maggie
//
//  Created by Apple on 04/05/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "ViewController.h"
#import "PTSMessagingCell.h"
#import "HPGrowingTextView.h"
#import "AppDelegate.h"
#import "NIDropDown.h"
@interface ChatThreadsVCViewController : UIViewController<HPGrowingTextViewDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
    AppDelegate *delegate;
    NSArray *chatsAray;
    NIDropDown *dropDown;
    IBOutlet UIView *statusView;
    NSString *statusString;
    IBOutlet UIView *chatview;
    __weak IBOutlet UIImageView *firstImg;
}

@property (strong, nonatomic) NSMutableArray *messages;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *messageId;
@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (weak,   nonatomic) IBOutlet UILabel     *statuslbl;
@property (weak,   nonatomic) IBOutlet UIButton    *optionsBtn;
@property (weak,   nonatomic) IBOutlet UITextField *chattext;
@end