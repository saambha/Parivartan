//
//  SquareCashStyleBar.m
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import "SquareCashStyleBar.h"

@implementation SquareCashStyleBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self configureBar];
    }
    
    return self;
}

- (void)configureBar
{
    // Configure bar appearence
    //self.maximumBarHeight = 240.0;
    self.maximumBarHeight = 180;

    self.minimumBarHeight = 65.0;
    self.backgroundColor = [UIColor colorWithRed:0.84 green:0.10 blue:0.12 alpha:1];
    
    
     // Add and configure name label
     _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
     _nameLabel.font = [UIFont systemFontOfSize:22.0];
    [_nameLabel setFont:[UIFont fontWithName:@"Emirates SB" size:15.0f]];
     _nameLabel.textColor = [UIColor whiteColor];
     _nameLabel.text = @"   9 Hours Transit   ";
    
     BLKFlexibleHeightBarSubviewLayoutAttributes *initialNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialNameLabelLayoutAttributes.size = [_nameLabel sizeThatFits:CGSizeZero];
    initialNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight-50.0);
    [_nameLabel addLayoutAttributes:initialNameLabelLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialNameLabelLayoutAttributes];
    midwayNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.4+self.minimumBarHeight-50.0);
    [_nameLabel addLayoutAttributes:midwayNameLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayNameLabelLayoutAttributes];
    finalNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.minimumBarHeight-25.0);
    [_nameLabel addLayoutAttributes:finalNameLabelLayoutAttributes forProgress:1.0];
    
    [self addSubview:_nameLabel];
    
    
    // Add and configure profile image
    _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProfilePhoto"]];
    _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    _profileImageView.clipsToBounds = YES;
    _profileImageView.layer.cornerRadius = 35.0;
    _profileImageView.layer.borderWidth = 2.0;
    _profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialProfileImageViewLayoutAttributes.size = CGSizeMake(70.0, 70.0);
    initialProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight-110.0);
    [_profileImageView addLayoutAttributes:initialProfileImageViewLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialProfileImageViewLayoutAttributes];
    midwayProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.8+self.minimumBarHeight-110.0);
    [_profileImageView addLayoutAttributes:midwayProfileImageViewLayoutAttributes forProgress:0.2];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayProfileImageViewLayoutAttributes];
    finalProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.64+self.minimumBarHeight-110.0);
    finalProfileImageViewLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalProfileImageViewLayoutAttributes.alpha = 0.0;
    [_profileImageView addLayoutAttributes:finalProfileImageViewLayoutAttributes forProgress:0.5];
    
    [self addSubview:_profileImageView];
    
    
//    _btn_Fb = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btn_Fb.frame = CGRectMake(250, 120.0, 30.0, 30.0);
//    _btn_Fb.tintColor = [UIColor whiteColor];
//    [_btn_Fb setImage:[UIImage imageNamed:@"BookNow"] forState:UIControlStateNormal];
//    [_btn_Fb addTarget:self action:@selector(fbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    BLKFlexibleHeightBarSubviewLayoutAttributes *initial_btn_FbLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
//    initial_btn_FbLayoutAttributes.size = CGSizeMake(30.0, 30.0);
//    initial_btn_FbLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight-20.0);
//    [_btn_Fb addLayoutAttributes:initialProfileImageViewLayoutAttributes forProgress:0.0];
//    
//    BLKFlexibleHeightBarSubviewLayoutAttributes *midway_btn_FbLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialProfileImageViewLayoutAttributes];
//    midway_btn_FbLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.8+self.minimumBarHeight-110.0);
//    [_btn_Fb addLayoutAttributes:midwayProfileImageViewLayoutAttributes forProgress:0.2];
//    
//    BLKFlexibleHeightBarSubviewLayoutAttributes *final_btn_FbLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayProfileImageViewLayoutAttributes];
//    final_btn_FbLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.64+self.minimumBarHeight-110.0);
//    final_btn_FbLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    final_btn_FbLayoutAttributes.alpha = 0.0;
//    [_btn_Fb addLayoutAttributes:finalProfileImageViewLayoutAttributes forProgress:0.0];
////

    
    
    [self addSubview:_btn_Fb];

    
    
}

@end
