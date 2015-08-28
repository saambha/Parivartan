//
//  DCSwipeSplashViewController.m
//  DubaiConnect
//
//  Created by Anoop on 8/26/15.
//  Copyright © 2015 Anoop. All rights reserved.
//

#import "DCSwipeSplashViewController.h"
#import "DCTimeLineViewController.h"

@interface DCSwipeSplashViewController (){

    CGFloat progress;
}
@end

@implementation DCSwipeSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Set your preferences";
    // Do any additional setup after loading the view.
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    draggableBackground.delegateCardOver = self;
    [self.view addSubview:draggableBackground];
    
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

-(void)didCardLoadingOver{
    UIStoryboard *storyboard = self.storyboard;
    DCTimeLineViewController *dcBookingVC = [storyboard instantiateViewControllerWithIdentifier:@"DCTimeLineViewController"];
    //dcBookingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Configure the new view controller here.
    dcBookingVC.delegate = self;
    [self presentViewController:dcBookingVC animated:YES completion:nil];

    
}
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    
    
}


@end
