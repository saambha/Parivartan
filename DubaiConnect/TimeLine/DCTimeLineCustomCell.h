//
//  DCTimeLineCustomCell.h
//  DubaiConnect
//
//  Created by Anoop on 8/28/15.
//  Copyright © 2015 Anoop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTimeLineCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *timelineCellImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLinePlacePrimaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLineSecLabel;
@end
