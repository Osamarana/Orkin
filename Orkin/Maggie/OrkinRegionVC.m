//
//  OrkinRegionVC.m
//  Maggie
//
//  Created by Ahmed Sadiq on 08/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import "OrkinRegionVC.h"
#import "IGLDemoCustomView.h"
#import "IGLDropDownMenu.h"
#import "OrkinSignUpVC.h"

@interface OrkinRegionVC () <IGLDropDownMenuDelegate>

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, assign) IGLDropDownMenuDirection direction;

@property (nonatomic, strong) IGLDropDownMenu *defaultDropDownMenu;
@property (nonatomic, strong) IGLDropDownMenu *customeViewDropDownMenu;

@end

@implementation OrkinRegionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.direction = IGLDropDownMenuDirectionDown;
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    if (!isScreenLoaded) {
//        isScreenLoaded = true;
//        self.dataArray = @[@{@"image":[UIImage imageNamed:@"flag.png"],@"title":@"Lebanon"},
//                           @{@"image":[UIImage imageNamed:@"qatar.png"],@"title":@"Qatar"},
//                           @{@"image":[UIImage imageNamed:@"iraq.png"],@"title":@"Iraq"}];
//        
//        [self initDefaultMenu];
//        [self initCustomViewMenu];
//        
//        self.customeViewDropDownMenu.hidden = YES;
//        self.dropDownMenu = self.defaultDropDownMenu;
//        
//        [self setUpParamsForDemo1];
//        
//        [self.dropDownMenu reloadView];
//    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)setUpParamsForDemo1
{
    self.dropDownMenu.type = IGLDropDownMenuTypeNormal;
    self.dropDownMenu.gutterY = 5;
}

- (void)initDefaultMenu
{
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary *dict = self.dataArray[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:dict[@"image"]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    self.defaultDropDownMenu = [[IGLDropDownMenu alloc] init];
    
    
    self.defaultDropDownMenu.menuIconImage = [UIImage imageNamed:@"flag.png"];
    
    self.defaultDropDownMenu.menuText = @"Lebanon";
    self.defaultDropDownMenu.dropDownItems = dropdownItems;
    self.defaultDropDownMenu.paddingLeft = 15;
    [self.defaultDropDownMenu setFrame:_regionBtn.frame];
    self.defaultDropDownMenu.delegate = self;
    
    [self.view addSubview:self.defaultDropDownMenu];
    [self.defaultDropDownMenu reloadView];
}

- (void)initCustomViewMenu
{
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i++) {
        NSDictionary *dict = self.dataArray[i];
        
        IGLDemoCustomView *customView = [[IGLDemoCustomView alloc] init];
        customView.image = dict[@"image"];
        customView.title = dict[@"title"];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] initWithCustomView:customView];
        [dropdownItems addObject:item];
    }
    
    IGLDemoCustomView *customView = [[IGLDemoCustomView alloc] init];
    
    self.customeViewDropDownMenu = [[IGLDropDownMenu alloc] initWithMenuButtonCustomView:customView];
    self.customeViewDropDownMenu.dropDownItems = dropdownItems;
    [self.customeViewDropDownMenu setFrame:CGRectMake(135, 140, 50, 50)];
    self.customeViewDropDownMenu.delegate = self;
    
    [self.view addSubview:self.customeViewDropDownMenu];
    
    [self.customeViewDropDownMenu reloadView];
    
    __weak typeof(self) weakSelf = self;
    [self.customeViewDropDownMenu addSelectedItemChangeBlock:^(NSInteger selectedIndex) {
        __strong typeof(self) strongSelf = weakSelf;
        IGLDropDownItem *item = strongSelf.dropDownMenu.dropDownItems[selectedIndex];
        IGLDemoCustomView *selectedView = (IGLDemoCustomView*)item.customView;
        IGLDropDownItem *menuButton = strongSelf.dropDownMenu.menuButton;
        IGLDemoCustomView *buttonView = (IGLDemoCustomView*)menuButton.customView;
        buttonView.image = selectedView.image;
        strongSelf.textLabel.text = [NSString stringWithFormat:@"Selected: %@", selectedView.title];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IGLDropDownMenuDelegate

- (void)dropDownMenu:(IGLDropDownMenu *)dropDownMenu selectedItemAtIndex:(NSInteger)index
{
    if (self.dropDownMenu == self.defaultDropDownMenu) {
        IGLDropDownItem *item = dropDownMenu.dropDownItems[index];
        self.textLabel.text = [NSString stringWithFormat:@"Selected: %@", item.text];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"Selected: %@", item.text] forKey:@"country_flag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        OrkinSignUpVC *childrenSUVC = [[OrkinSignUpVC alloc] initWithNibName:@"OrkinSignUpVC" bundle:nil];
        [self.navigationController pushViewController:childrenSUVC animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}

- (void)dropDownMenu:(IGLDropDownMenu *)dropDownMenu expandingChanged:(BOOL)isExpending
{
    NSLog(@"Expending changed to: %@", isExpending? @"expand" : @"fold");
}


- (IBAction)lebonanPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"Lebonan"] forKey:@"country_flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    OrkinSignUpVC *childrenSUVC = [[OrkinSignUpVC alloc] initWithNibName:@"OrkinSignUpVC" bundle:nil];
    [self.navigationController pushViewController:childrenSUVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)qatarPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"Qatar"] forKey:@"country_flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    OrkinSignUpVC *childrenSUVC = [[OrkinSignUpVC alloc] initWithNibName:@"OrkinSignUpVC" bundle:nil];
    [self.navigationController pushViewController:childrenSUVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)iraqPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"Iraq"] forKey:@"country_flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    OrkinSignUpVC *childrenSUVC = [[OrkinSignUpVC alloc] initWithNibName:@"OrkinSignUpVC" bundle:nil];
    [self.navigationController pushViewController:childrenSUVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
@end
