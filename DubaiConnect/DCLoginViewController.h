//
//  DCLoginViewController.h
//  DubaiConnect
//
//  Created by Krishna on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCFacebookManager.h"

@interface DCLoginViewController : UIViewController <FbManagerDelegate>

@property (nonatomic , weak) IBOutlet UIImageView *bgView;


@end
