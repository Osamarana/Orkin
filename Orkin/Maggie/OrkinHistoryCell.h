//
//  OrkinHistoryCell.h
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrkinHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *tme;
@property (weak, nonatomic) IBOutlet UILabel *scheduled;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
