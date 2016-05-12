//
//  OrkinQuoteVC.h
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface OrkinQuoteVC : UIViewController<NIDropDownDelegate> {
    BOOL isScreenLoaded;
    NIDropDown *dropDown;
    __weak IBOutlet UILabel *optionLbl;
}
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;

@end
