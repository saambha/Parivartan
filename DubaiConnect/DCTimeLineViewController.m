//
//  DCTimeLineViewController.m
//  DubaiConnect
//
//  Created by Anoop on 8/22/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//


#import "DCTimeLineViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DCTimeLineDetailViewController.h"


CGFloat kSizeZero = 0;
CGFloat kHeaderHeightBuffer = 170;

@interface DCTimeLineViewController () {
    UITableView *tableView;
    UIImageView *imageView;
    UIView *scrollPanel;
    float defaultY;
    CGSize defaultSize;
    CGFloat defaultHeight;
    CGFloat prePointY;
    CGRect mainViewFrame;
}

@end

@implementation DCTimeLineViewController

-(void)fetchedFaceBookData {
    
    NSLog(@"Called");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DCFacebookManager getSharedInstance] getFBData];
    [DCFacebookManager getSharedInstance].fbDelegate = self;

    
    mainViewFrame = self.view.bounds;
    tableView = [[UITableView alloc] initWithFrame:mainViewFrame];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIImage *image = [UIImage imageNamed:@"HomePlaceHolder"];
    
//    UIGraphicsBeginImageContext(CGSizeMake(mainViewFrame.size.width, mainViewFrame.size.height));
//    [image drawInRect:CGRectMake(kSizeZero, kSizeZero, mainViewFrame.size.width, mainViewFrame.size.height)];
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    imageView = [[UIImageView alloc] initWithImage:image];
    CGRect frame = imageView.frame;
    frame.origin.y -= 130;
    defaultY = frame.origin.y;
    imageView.frame = frame;
    
    tableView.backgroundColor = [UIColor clearColor];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(kSizeZero, kSizeZero, mainViewFrame.size.width, kHeaderHeightBuffer)];
    header.backgroundColor = [UIColor clearColor];
    
    tableView.tableHeaderView = header;
    
    [self.view addSubview:imageView];
    [self.view addSubview:tableView];
    
    defaultSize = CGSizeMake(50, 20);
    scrollPanel = [[UIView alloc] initWithFrame:CGRectMake(-defaultSize.width, kSizeZero, defaultSize.width, defaultSize.height)];
    scrollPanel.backgroundColor = [UIColor blackColor];
    scrollPanel.alpha = 0.45;
    
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem5 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem6 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, nil];

    
    
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:CGRectMake(0, 200, 200, 200) menus:menus];
    menu.delegate = self;
    [self.view addSubview:menu];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIView *view = [cell viewWithTag:1];
    UITextView *textView = (UITextView *)[cell viewWithTag:2];
    
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(kSizeZero, kSizeZero, mainViewFrame.size.width, 50)];
        view.tag = 1;
        [cell addSubview:view];
    }
    
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:CGRectMake(kSizeZero, kSizeZero, 100, 20)];
        textView.tag = 2;
        [cell addSubview:textView];
    }
    
    textView.text = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
    view.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DCTimeLineDetailViewController *tlDetailVC = [[DCTimeLineDetailViewController alloc] initWithNibName:@"DCTimeLineDetailViewController" bundle:nil];
    [self presentViewController:tlDetailVC animated:YES completion:NULL];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 30;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}


#pragma Mark ScrollView Delegates
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float offsetY = scrollView.contentOffset.y;
    
    CGRect frame = imageView.frame;
    
    if (offsetY < kSizeZero) {
        frame.origin.y = defaultY - offsetY * 0.7;
    } else {
        frame.origin.y = defaultY - offsetY;
    }
    imageView.frame = frame;
    
    UIView *scrollIndicator = scrollView.subviews.lastObject;
    
    if (scrollIndicator.frame.size.height < defaultHeight) {
        
        CGRect panelFrame = scrollPanel.frame;
        
        if (scrollIndicator.frame.origin.y > kSizeZero) {
            panelFrame.origin.y = prePointY - (defaultHeight - scrollIndicator.frame.size.height);
        } else {
            panelFrame.origin.y = prePointY;
        }
        
        scrollPanel.frame = panelFrame;
    } else {
        prePointY = scrollPanel.frame.origin.y;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    if (!scrollPanel.superview) {
//        
//        UIView *scrollIndicator = [scrollView.subviews lastObject];
//        defaultHeight = scrollIndicator.frame.size.height;
//        
//        [scrollIndicator.layer addSublayer:scrollPanel.layer];
//        
//        CGRect panelFrame = scrollPanel.frame;
//        panelFrame.size = defaultSize;
//        panelFrame.origin.y = (scrollIndicator.frame.size.height - scrollPanel.frame.size.height) / 2.0;
//        scrollPanel.frame = panelFrame;
//    }
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [scrollView removeFromSuperview];
}

#pragma mark -

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %ld",(long)idx);
}
@end
