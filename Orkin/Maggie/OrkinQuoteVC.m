//
//  OrkinQuoteVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 10/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinQuoteVC.h"
#import "OrkinScheduleVC.h"
#import "Constants.h"

@interface OrkinQuoteVC ()
@end

@implementation OrkinQuoteVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)optionPressed:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Residential", @"Commercial",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@""], [UIImage imageNamed:@""], nil];
    if(dropDown == nil) {
        CGFloat f = 186;
        if(IS_IPAD) {
            f = 280;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down":false];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    if(sender.selectedIndex == 0) {
      optionLbl.text = @"Residential";
    }
    else if(sender.selectedIndex == 1) {
        optionLbl.text = @"Commercial";
    }
    [self rel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)nextPressed:(id)sender {
    if(IS_IPAD) {
        OrkinScheduleVC *childrenSUVC = [[OrkinScheduleVC alloc] initWithNibName:@"OrkinScheduleVC_iPad" bundle:nil];
        childrenSUVC.location = optionLbl.text;
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    else {
        OrkinScheduleVC *childrenSUVC = [[OrkinScheduleVC alloc] initWithNibName:@"OrkinScheduleVC" bundle:nil];
        childrenSUVC.location = optionLbl.text;
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
