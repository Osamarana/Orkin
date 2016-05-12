//
//  OrkinMessageCell.h
//  Maggie
//
//  Created by Ahmed Sadiq on 30/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrkinMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
