//
//  QuadCurveMenuItem.h
//  AwesomeMenu
//
//  Created by Levey on 8/28/15.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuadCurveMenuItemDelegate;

@interface QuadCurveMenuItem : UIImageView
{
    UIImageView *_contentImageView;
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGPoint _nearPoint; // near
    CGPoint _farPoint; // far
    
    id<QuadCurveMenuItemDelegate> _delegate;
}

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;

@property (nonatomic, assign) id<QuadCurveMenuItemDelegate> delegate;

- (id)initWithImage:(UIImage *)img 
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg;


@end

@protocol QuadCurveMenuItemDelegate <NSObject>
- (void)quadCurveMenuItemTouchesBegan:(QuadCurveMenuItem *)item;
- (void)quadCurveMenuItemTouchesEnd:(QuadCurveMenuItem *)item;
@end