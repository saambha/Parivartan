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


#import "SquareCashStyleBar.h"
#import "DCSquareCashStyleBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"

#import "DCBookingViewController.h"

CGFloat kSizeZero = 0;
CGFloat kHeaderHeightBuffer = 170;

@interface DCTimeLineViewController () {
    UIImageView *imageView;
    UIView *scrollPanel;
    float defaultY;
    CGSize defaultSize;
    CGFloat defaultHeight;
    CGFloat prePointY;
    CGRect mainViewFrame;

}
@property (nonatomic) SquareCashStyleBar *myCustomBar;

@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@property (weak, nonatomic) IBOutlet UIButton *bookNowBtn;

@end

@implementation DCTimeLineViewController

-(void)fetchedFaceBookData {
    
    NSLog(@"Called");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Setup FaceBook
    [[DCFacebookManager getSharedInstance] getFBData];
    [DCFacebookManager getSharedInstance].fbDelegate = self;

    mainViewFrame = self.view.frame;
    self.tableView.frame = mainViewFrame;
//    
//    defaultSize = CGSizeMake(50, 20);
//    scrollPanel = [[UIView alloc] initWithFrame:CGRectMake(-defaultSize.width, kSizeZero, defaultSize.width, defaultSize.height)];
//    scrollPanel.backgroundColor = [UIColor blackColor];
//    scrollPanel.alpha = 0.45;
    
    [self.view addSubview:[self setUpQuadMenu]];

    
    // Setup the bar
    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    
    DCSquareCashStyleBehaviorDefiner *behaviorDefiner = [[DCSquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    
    // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    self.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    
    [self.view addSubview:self.myCustomBar];
    
//    // Setup the table view
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 0.0, 0.0);
//
    
    // Add close button - it's pinned to the top right corner, so it doesn't need to respond to bar height changes
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(self.myCustomBar.frame.size.width-40.0, 25.0, 30.0, 30.0);
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"BookNow"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:closeButton];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    
    //self.tableView.sectionIndexColor = [UIColor clearColor];
    
//    DCTimeLineDetailViewController *tlDetailVC = [[DCTimeLineDetailViewController alloc] initWithNibName:@"DCTimeLineDetailViewController" bundle:nil];
//    [self presentViewController:tlDetailVC animated:YES completion:NULL];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
//    return 30;
//}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20;
//}



#pragma Mark ScrollView Delegates


#pragma mark -

-(QuadCurveMenu*) setUpQuadMenu{
    
    
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
    
    
    
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:CGRectMake(0 , 200, 40, 40) menus:menus];
    menu.delegate = self;
    
    return menu;
}


- (IBAction)closeViewController:(id)sender
{
    DCBookingViewController *dcBookingVC = [[DCBookingViewController alloc] initWithNibName:@"DCBookingViewController" bundle:nil];
    
    //dcBookingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:dcBookingVC animated:YES completion:nil];
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %ld",(long)idx);
}
@end
