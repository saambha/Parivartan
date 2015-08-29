//
//  DCTimeLineViewController.h
//  DubaiConnect
//
//  Created by Anoop on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuadCurveMenu.h"
#import  "DCFacebookManager.h"
#import "DCSwipeSplashViewController.h"


@interface DCTimeLineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,QuadCurveMenuDelegate , FbManagerDelegate , UIActionSheetDelegate>{




}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id delegate;

@end

