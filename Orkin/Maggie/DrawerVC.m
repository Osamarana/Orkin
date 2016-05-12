//
//  DrawerVC.m
//  HydePark
//
//  Created by Mr on 22/04/2015.
//  Copyright (c) 2015 TxLabz. All rights reserved.
//

#import "DrawerVC.h"
#import "Constants.h"
#import "NavigationHandler.h"
@interface DrawerVC ()

@end

static DrawerVC *DrawerVC_Instance= NULL;

@implementation DrawerVC

@synthesize _currentState,tag;
float _yLocation;

+(DrawerVC *)getInstance{
    
    if(DrawerVC_Instance == NULL)
    {
        if(IS_IPAD) {
            DrawerVC_Instance = [[DrawerVC alloc] initWithNibName:@"DrawerVC_iPad" bundle:nil];
        }
        else {
            DrawerVC_Instance = [[DrawerVC alloc] initWithNibName:@"DrawerVC" bundle:nil];
        }
        
        _yLocation = 0.0f;
    }
    return DrawerVC_Instance;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _currentState = OFF_HIDDEN;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (IS_IPHONE_6) {
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 667);
    }else if (IS_IPHONE_6Plus){
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 736);
    }
    
    DrawerVC_Instance = self;
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void)AddInView:(UIView *)_parentView{
    parentView = _parentView;
    if(_currentState == OFF_HIDDEN)
        //        [self.view setFrame:CGRectMake(parentView.frame.size.width, _yLocation, self.view.frame.size.width, self.view.frame.size.height)];
        if (IS_IPAD) {
            [self.view setFrame:CGRectMake(-424, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
        }else{
            
            [self.view setFrame:CGRectMake(-280, _yLocation, self.view.frame.size.width, self.view.frame.size.height)];
            if (IS_IPHONE_6) {
                [self.view setFrame:CGRectMake(-285, _yLocation, self.view.frame.size.width, self.view.frame.size.height)];
            }
        }
    [_parentView addSubview:self.view];
    
}
-(void)ShowInView{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    /*if(_currentState == OFF_HIDDEN)
    {
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            // final view elements attributes goes here
            // [self.view setFrame:CGRectMake(parentView.frame.size.width - self.view.frame.size.width, _yLocation, self.view.frame.size.width, parentView.frame.size.height-_yLocation)];
            [self.view setFrame:CGRectMake(0, _yLocation, screenWidth, parentView.frame.size.height-_yLocation)];
            
            [parentView bringSubviewToFront:self.view];
            
            
        } completion:^(BOOL done){
            dimmer.hidden = false;
        }];
    }
    
    else if(_currentState == ON_SCREEN)
    {
        [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            _currentState = OFF_HIDDEN;
            if (IS_IPAD) {
                [self.view setFrame:CGRectMake(-screenWidth, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
            }else{
                [self.view setFrame:CGRectMake(-screenWidth, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
                if (IS_IPHONE_6) {
                    [self.view setFrame:CGRectMake(-screenWidth , _yLocation, self.view.frame.size.width, self.view.frame.size.height)];
                }
            }
            dimmer.hidden = true;
            
        } completion:nil];
    }*/
    if(_currentState == OFF_HIDDEN)
    {
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            _currentState = ON_SCREEN;
            
            // final view elements attributes goes here
            [self.view setFrame:CGRectMake(0, _yLocation, screenWidth, parentView.frame.size.height-_yLocation)];
            [parentView bringSubviewToFront:self.view];
            
            
        }completion:^(BOOL done){
            dimmer.hidden = false;
        }];
    }
    
    else if(_currentState == ON_SCREEN)
    {
        [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            _currentState = OFF_HIDDEN;
            dimmer.hidden = true;
            //[[parentView viewWithTag:HIDE_TAG] removeFromSuperview];
            
            // final view elements attributes goes here
            // [self.view setFrame:CGRectMake(parentView.frame.size.width, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
            if (IS_IPAD) {
                [self.view setFrame:CGRectMake(-screenWidth, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
            }else{
                [self.view setFrame:CGRectMake(-screenWidth, _yLocation, self.view.frame.size.width, parentView.frame.size.height -_yLocation)];
                if (IS_IPHONE_6) {
                    [self.view setFrame:CGRectMake(-screenWidth , _yLocation, self.view.frame.size.width, self.view.frame.size.height)];
                }
            }
            
        } completion:^(BOOL done){
            
        }];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)generalAction:(id)sender{
    
    [self ShowInView];
}

- (IBAction)logTicketPressed:(id)sender {
    
    //[[NavigationHandler getInstance] NavigateToHomeScreen];
    [self ShowInView];
}

- (IBAction)appSettngs:(id)sender {
    //[[NavigationHandler getInstance] NavigateToLoginScreen];
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    [self ShowInView];
}
- (IBAction)editProfilePressed:(id)sender {
    [[NavigationHandler getInstance] MoveToEditProfile];
}

- (IBAction)historyPressed:(id)sender {
    [[NavigationHandler getInstance] MoveToHistory];
}
- (IBAction)orkinPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.orkinlebanon.com/"]];

}
- (IBAction)facebookPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/OrkinLB/"]];
}
- (IBAction)gamePressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/bn/app/bug-battle/id410912970?mt=8"]];
}

@end
