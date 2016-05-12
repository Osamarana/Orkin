//
//  OrkinRegionVC.h
//  Maggie
//
//  Created by Ahmed Sadiq on 08/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrkinRegionVC : UIViewController {
    BOOL isScreenLoaded;
}
- (IBAction)lebonanPressed:(id)sender;
- (IBAction)qatarPressed:(id)sender;
- (IBAction)iraqPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *regionBtn;

@end
