//
//  OrkinHistoryVC.h
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrkinHistoryVC : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    BOOL isMessage;
}
@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIView *msgDetailView;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
- (IBAction)closeBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *historyLbl;
- (IBAction)historyPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *historyBar;
- (IBAction)messagePressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *messageBar;
@property (weak, nonatomic) IBOutlet UITextView *msgTxtDetail;

@property (weak, nonatomic) IBOutlet UILabel *msgLbl;

@property (strong, nonatomic) NSMutableArray *historyArray;
@property (strong, nonatomic) NSMutableArray *messageArray;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *noRecordLbl;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UIView *historyDetailView;
@property (weak, nonatomic) IBOutlet UILabel *historyTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *hLocTxt;
@property (weak, nonatomic) IBOutlet UILabel *hNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *hEmailLbl;
@property (weak, nonatomic) IBOutlet UILabel *hPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *hName_lbl;
@property (weak, nonatomic) IBOutlet UILabel *hPremisesTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *hSurfaceLbl;
@property (weak, nonatomic) IBOutlet UILabel *hMoreDetailLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *hDetailScroll;

- (IBAction)historyDetailBackPressed:(id)sender;

- (IBAction)drawerPressed:(id)sender;
- (IBAction)webPressed:(id)sender;

@end
