//
//  DCLoginViewController.m
//  DubaiConnect
//
//  Created by Krishna on 8/23/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "DCLoginViewController.h"
#import "DCTimeLineViewController.h"

@interface DCLoginViewController ()

@property (nonatomic , strong)  DCFacebookManager *objFBManager;


@end

@implementation DCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        
        //DCTimeLineViewController *dctimeLineVC =[[DCTimeLineViewController alloc] initWithNibName:@"DCTimeLineViewController" bundle:nil];
        //[self presentViewController:dctimeLineVC animated:YES completion:NULL];
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
