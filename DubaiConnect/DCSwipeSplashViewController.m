//
//  DCSwipeSplashViewController.m
//  DubaiConnect
//
//  Created by Anoop on 8/26/15.
//  Copyright © 2015 Anoop. All rights reserved.
//

#import "DCSwipeSplashViewController.h"
#import "DraggableViewBackground.h"

@interface DCSwipeSplashViewController ()

@end

@implementation DCSwipeSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
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

@end
