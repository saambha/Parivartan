//
//  DCLoginViewController.m
//  DubaiConnect
//
//  Created by Krishna on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "DCLoginViewController.h"
#import "DCTimeLineViewController.h"
#import "MapViewController.h"

#import "DCSwipeSplashViewController.h"


@interface DCLoginViewController ()

@property (nonatomic , strong)  DCFacebookManager *objFBManager;



@end

@implementation DCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _bgView.animationImages = [NSArray arrayWithObjects:
//                               [UIImage imageNamed:@"dubai11.tiff"],
//                               [UIImage imageNamed:@"dubai12.tiff"],
//                               [UIImage imageNamed:@"dubai13.tiff"],
//                               [UIImage imageNamed:@"dubai14.tiff"], nil];;
//    
//    [_bgView startAnimating];
    _bgView.image = [UIImage imageNamed:@"Default.jpg"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btn_FacebookAction:(id)sender {
    
    _objFBManager =[DCFacebookManager getSharedInstance];
    _objFBManager.fbDelegate = self;
    [_objFBManager fbLogin];
}

-(void)facebookLoginResult:(BOOL)success {
    
    if (success) {
        
//        DCTimeLineViewController *dctimeLineVC =[[DCTimeLineViewController alloc] initWithNibName:@"DCTimeLineViewController" bundle:nil];
//        [self presentViewController:dctimeLineVC animated:YES completion:NULL];//
        
//        DCSwipeSplashViewController *dctimeLineVC =[[DCSwipeSplashViewController alloc] initWithNibName:@"DCSwipeSplashViewController" bundle:nil];
//        [self presentViewController:dctimeLineVC animated:YES completion:NULL];//DCSwipeSplashViewController
//
    }
}

-(IBAction)btn_SkipAction:(id)sender {
    //DCTimeLineViewController *dctimeLineVC =[[DCTimeLineViewController alloc] initWithNibName:@"DCTimeLineViewController" bundle:nil];
    //[self presentViewController:dctimeLineVC animated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
