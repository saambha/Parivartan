//
//  DCTimeLineCustomCell.m
//  DubaiConnect
//
//  Created by Anoop on 8/28/15.
//  Copyright © 2015 Anoop. All rights reserved.
//

#import "DCTimeLineCustomCell.h"

@implementation DCTimeLineCustomCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setupCellView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setupCellView{
    
  _timeLinePlacePrimaryLabel.text = @"Burj khalifa";
    _timeLineSecLabel.text = @"3000 miles or 200 AED";
}
@end
