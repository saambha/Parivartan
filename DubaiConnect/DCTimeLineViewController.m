//
//  DCTimeLineViewController.m
//  DubaiConnect
//
//  Created by Anoop on 8/22/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//


#import "DCTimeLineViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "DCTimeLineDetailViewController.h"


#import "SquareCashStyleBar.h"
#import "DCSquareCashStyleBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"

#import "DCBookingViewController.h"
#import "DCTimeLine.h"

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

@property (nonatomic , strong) NSMutableArray *arr_timelineObjs;

@end

@implementation DCTimeLineViewController

-(void)fetchedFaceBookData {
    
    NSLog(@"Called");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self setLimeLineObjects];
    //Setup FaceBook
    [[DCFacebookManager getSharedInstance] getFBData];
    [DCFacebookManager getSharedInstance].fbDelegate = self;

    mainViewFrame = self.view.frame;
    self.tableView.frame = mainViewFrame;
    
    //self.tableView.frame = CGRectMake(0, mainViewFrame.origin.y+20, mainViewFrame.size.width, mainViewFrame.size.height);
    
    self.tableView.allowsSelection = NO;
    
    /*
    UIScrollView *scrl =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:scrl];
    scrl.backgroundColor =[UIColor greenColor];
    scrl.delegate = self;
    //scrl.delegate = (id<UIScrollViewDelegate>)self.delegateSplitter;
    scrl.contentSize = CGSizeMake(320*3, 400);
    
    [self.view addSubview:scrl];

    for (int i= 0; i<= 1; i++ ) {
        
        UITableView *tblView =[[UITableView alloc] initWithFrame:CGRectMake(i*320, 100, 300, 400)];
        tblView.delegate = self;//(id<UITableViewDelegate>)self.delegateSplitter;
        tblView.dataSource = self;
        tblView.backgroundColor = [UIColor whiteColor];
        tblView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
        
        [scrl addSubview:tblView];
    }
    */
//    
//    defaultSize = CGSizeMake(50, 20);
//    scrollPanel = [[UIView alloc] initWithFrame:CGRectMake(-defaultSize.width, kSizeZero, defaultSize.width, defaultSize.height)];
//    scrollPanel.backgroundColor = [UIColor blackColor];
//    scrollPanel.alpha = 0.45;
    
    [self.view addSubview:[self setUpQuadMenu]];

    
    // Setup the bar
    self.myCustomBar = [[SquareCashStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSString *ImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[FBSDKAccessToken currentAccessToken].userID];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.myCustomBar.profileImageView.image = [UIImage imageWithData:imageData];
        

    }
    
    DCSquareCashStyleBehaviorDefiner *behaviorDefiner = [[DCSquareCashStyleBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.elasticMaximumHeightAtTop = YES;
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    
    // Configure a separate UITableViewDelegate and UIScrollViewDelegate (optional)
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    self.tableView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    self.tableView.separatorColor =[UIColor clearColor];
    
    //self.tableView.tableHeaderView = self.myCustomBar;
    [self.view addSubview:self.myCustomBar];

    self.myCustomBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dubai.jpg"]];
    
//    // Setup the table view
  //  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 0.0, 0.0);
   // self.tableView.contentInset = UIEdgeInsetsMake(40, 0.0, 0.0, 0.0);

//
    
    // Add close button - it's pinned to the top right corner, so it doesn't need to respond to bar height changes
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(self.myCustomBar.frame.size.width-40.0, 25.0, 30.0, 30.0);
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"BookNow"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:closeButton];
    
    
    
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(self.myCustomBar.frame.size.width-80.0, 25.0, 30.0, 30.0);
    plusButton.tintColor = [UIColor whiteColor];
    [plusButton setImage:[UIImage imageNamed:@"BookNow"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:plusButton];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DCTimeLineCustomCell" owner:self options:nil];//
        cell = [topLevelObjects objectAtIndex:0];
    }

    
    UIImageView *imgView_Place = (UIImageView *)[cell.contentView viewWithTag:11];
    imgView_Place.image = [UIImage imageNamed:@"khalifa.jpg"];
    imgView_Place.contentMode = UIViewContentModeScaleAspectFill;
    imgView_Place.clipsToBounds = YES;
    imgView_Place.layer.cornerRadius = 25.0;
    imgView_Place.layer.borderWidth = 1.0;
    imgView_Place.layer.borderColor = [UIColor whiteColor].CGColor;
    
    DCTimeLine *obj = [self.arr_timelineObjs objectAtIndex:indexPath.row];
    CGRect frame2;


    UIImageView *imgView_Line1 = (UIImageView *)[cell.contentView viewWithTag:12];
    CGRect frame = imgView_Line1.frame;

    
    imgView_Line1.hidden = YES;

    if ([obj.distanceFromAirport integerValue] == 2) {
        frame2 = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    }
    else if ([obj.distanceFromAirport integerValue] == 3) {
        frame2 = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+22);
        //return 94+22;
    }
    else if ([obj.distanceFromAirport integerValue] == 4) {
        frame2 = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+22*2);
    }
    else if ([obj.distanceFromAirport integerValue] == 5) {
        frame2 = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+22*3);
    }
    else {
        frame2 = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+22*4);

    }
    if (!(indexPath.row == 0)) {
        
    }
    if (!([self.arr_timelineObjs count]-1 == indexPath.row)) {
        UIImageView *imgView_line =[[UIImageView alloc] initWithFrame:frame2];
        imgView_line.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:imgView_line];

    }
    
    

    
    //return 94+22*4;
    
    /*
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
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.tableView.sectionIndexColor = [UIColor clearColor];
    
//    DCTimeLineDetailViewController *tlDetailVC = [[DCTimeLineDetailViewController alloc] initWithNibName:@"DCTimeLineDetailViewController" bundle:nil];
//    [self presentViewController:tlDetailVC animated:YES completion:NULL];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arr_timelineObjs count];
}

//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
//    return 30;
//}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCTimeLine *obj = [self.arr_timelineObjs objectAtIndex:indexPath.row];
    
    
    if ([obj.distanceFromAirport integerValue] == 2) {
        return 94;
    }
    if ([obj.distanceFromAirport integerValue] == 3) {
        return 94+22;
    }
    if ([obj.distanceFromAirport integerValue] == 4) {
        return 94+22*2;
    }
    if ([obj.distanceFromAirport integerValue] == 5) {
        return 94+22*3;
    }
    return 94+22*4;

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


//-(void)scrollViewDidScroll:(UIScrollView*)scrollView {
//    
////        self.myCustomBar.frame.size = scrollView.contentOffset.y;
////        yourHeaderView.frame = initialFrame;
//        
//        CGRect frame = self.tableView.tableHeaderView.frame;
//        frame.size.height -= scrollView.contentOffset.y;
//        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 320, 0);
//}
- (IBAction)closeViewController:(id)sender
{
//    [self presentViewController:dcBookingVC animated:YES completion:nil];
    
//    UIStoryboard *storyboard = self.storyboard;
//    DCBookingViewController *dcBookingVC = [storyboard instantiateViewControllerWithIdentifier:@"DCTimeLineDetailViewController"];
//    dcBookingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    
//    // Configure the new view controller here.
//    
//    [self presentViewController:dcBookingVC animated:YES completion:nil];
    
    self.myCustomBar.backgroundColor =[UIColor redColor];
    [self setLimeLineObjects1];
    [self.tableView reloadData];
}

- (IBAction)plusButtonAction:(id)sender
{
    //    [self presentViewController:dcBookingVC animated:YES completion:nil];
    
    //    UIStoryboard *storyboard = self.storyboard;
    //    DCBookingViewController *dcBookingVC = [storyboard instantiateViewControllerWithIdentifier:@"DCTimeLineDetailViewController"];
    //    dcBookingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //
    //    // Configure the new view controller here.
    //
    //    [self presentViewController:dcBookingVC animated:YES completion:nil];
    
    self.myCustomBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dubai.jpg"]];
    [self setLimeLineObjects];
    [self.tableView reloadData];
}



- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %ld",(long)idx);
}
-(void)setLimeLineObjects {
    
    if (self.arr_timelineObjs) {
        self.arr_timelineObjs = nil;
    }
    self.arr_timelineObjs =[[NSMutableArray alloc]init];
    for (int i =0; i< 2; i++) {
        
        DCTimeLine *obj_TimeLine =[[DCTimeLine alloc] init];
        obj_TimeLine.placeName = @"Burj Khalifa";
        obj_TimeLine.placeDescription = @"description";
        obj_TimeLine.taxiTime = @"3 hr";
        obj_TimeLine.distanceFromAirport = @"2";
        obj_TimeLine.weatherInfo =@"30";

        [self.arr_timelineObjs addObject:obj_TimeLine];
    }
    
    DCTimeLine *obj_TimeLine1 =[[DCTimeLine alloc] init];
    obj_TimeLine1.placeName = @"Burj Khalifa";
    obj_TimeLine1.placeDescription = @"description";
    obj_TimeLine1.taxiTime = @"3 hr";
    obj_TimeLine1.distanceFromAirport = @"3";
    obj_TimeLine1.weatherInfo =@"30";
    
    DCTimeLine *obj_TimeLine2 =[[DCTimeLine alloc] init];
    obj_TimeLine2.placeName = @"Burj Khalifa";
    obj_TimeLine2.placeDescription = @"description";
    obj_TimeLine2.taxiTime = @"3 hr";
    obj_TimeLine2.distanceFromAirport = @"4";
    obj_TimeLine2.weatherInfo =@"30";
    
    DCTimeLine *obj_TimeLine3 =[[DCTimeLine alloc] init];
    obj_TimeLine3.placeName = @"Burj Khalifa";
    obj_TimeLine3.placeDescription = @"description";
    obj_TimeLine3.taxiTime = @"3 hr";
    obj_TimeLine3.distanceFromAirport = @"5";
    obj_TimeLine3.weatherInfo =@"30";
    
    [self.arr_timelineObjs addObject:obj_TimeLine1];
    [self.arr_timelineObjs addObject:obj_TimeLine2];
    [self.arr_timelineObjs addObject:obj_TimeLine3];
    
}

-(void)setLimeLineObjects1 {
    
    if (self.arr_timelineObjs) {
        self.arr_timelineObjs = nil;
    }
    self.arr_timelineObjs =[[NSMutableArray alloc]init];
//    for (int i =0; i< 2; i++) {
//        
//        DCTimeLine *obj_TimeLine =[[DCTimeLine alloc] init];
//        obj_TimeLine.placeName = @"Burj Khalifa";
//        obj_TimeLine.placeDescription = @"description";
//        obj_TimeLine.taxiTime = @"3 hr";
//        obj_TimeLine.distanceFromAirport = @"2";
//        obj_TimeLine.weatherInfo =@"30";
//        
//        [self.arr_timelineObjs addObject:obj_TimeLine];
//    }
    
    DCTimeLine *obj_TimeLine1 =[[DCTimeLine alloc] init];
    obj_TimeLine1.placeName = @"Burj Khalifa";
    obj_TimeLine1.placeDescription = @"description";
    obj_TimeLine1.taxiTime = @"3 hr";
    obj_TimeLine1.distanceFromAirport = @"3";
    obj_TimeLine1.weatherInfo =@"30";
    
    DCTimeLine *obj_TimeLine2 =[[DCTimeLine alloc] init];
    obj_TimeLine2.placeName = @"Burj Khalifa";
    obj_TimeLine2.placeDescription = @"description";
    obj_TimeLine2.taxiTime = @"3 hr";
    obj_TimeLine2.distanceFromAirport = @"4";
    obj_TimeLine2.weatherInfo =@"30";
    
    DCTimeLine *obj_TimeLine3 =[[DCTimeLine alloc] init];
    obj_TimeLine3.placeName = @"Burj Khalifa";
    obj_TimeLine3.placeDescription = @"description";
    obj_TimeLine3.taxiTime = @"3 hr";
    obj_TimeLine3.distanceFromAirport = @"5";
    obj_TimeLine3.weatherInfo =@"30";
    
    [self.arr_timelineObjs addObject:obj_TimeLine1];
    [self.arr_timelineObjs addObject:obj_TimeLine2];
    [self.arr_timelineObjs addObject:obj_TimeLine3];
    
}


@end
