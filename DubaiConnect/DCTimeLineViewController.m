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
#import "MapViewController.h"
#import "DCBookingViewController.h"
#import "DCTimeLine.h"
#import "MPNavigationController.h"
#import "DCTimeLineCustomCell.h"

#import <MediaPlayer/MediaPlayer.h>




CGFloat kSizeZero = 0;
CGFloat kHeaderHeightBuffer = 170;

const int kHeaderBtn_X                  = 150;


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

@property (nonatomic , strong)  MPMoviePlayerController *moviePlayer;

@property (nonatomic , strong) UILabel *lblHours;

@property (nonatomic , assign) int hours;

@property (nonatomic , strong) UIView *error_notificationView;

@property (nonatomic , strong) UIView *error_notificationView_Alert;




@end

@implementation DCTimeLineViewController

-(void)fetchedFaceBookData {
    
    NSLog(@"Called");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    _hours = 9;
    
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

    self.myCustomBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"burj-al-arab-dubai-960x640.jpg"]];
    
       // self.myCustomBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage animatedImageNamed:@"dayNight.gif" duration:30.0]];
    
//    _bgView.animationImages = [NSArray arrayWithObjects:
//                               [UIImage imageNamed:@"dubai11.tiff"],
//                               [UIImage imageNamed:@"dubai12.tiff"],
//                               [UIImage imageNamed:@"dubai13.tiff"],
//                               [UIImage imageNamed:@"dubai14.tiff"], nil];;
//    
//    [_bgView startAnimating];

    ;
    
//    // Setup the table view
  //  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 0.0, 0.0);
   // self.tableView.contentInset = UIEdgeInsetsMake(40, 0.0, 0.0, 0.0);

//
   
    // Add close button - it's pinned to the top right corner, so it doesn't need to respond to bar height changes
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    minusButton.frame = CGRectMake(40.0, 25.0, 30.0, 30.0);
    minusButton.tintColor = [UIColor whiteColor];
    [minusButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [minusButton addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:minusButton];
    minusButton.backgroundColor = [UIColor clearColor];
    
    
    
//     _lblHours = [[UILabel alloc] init];
//    _lblHours.frame = CGRectMake(self.myCustomBar.frame.size.width-48.0, 25.0, 18.0, 30.0);
//    _lblHours.text = [NSString stringWithFormat:@"%i",_hours];
//    _lblHours.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
//    _lblHours.backgroundColor = [UIColor clearColor];
//    _lblHours.textColor = [UIColor whiteColor];
//    [self.myCustomBar addSubview:_lblHours];


    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(self.myCustomBar.frame.size.width-2*40.0, 25.0, 30.0, 30.0);
    plusButton.tintColor = [UIColor whiteColor];
    [plusButton setImage:[UIImage imageNamed:@"plus1"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCustomBar addSubview:plusButton];
    plusButton.backgroundColor = [UIColor clearColor];

    

    
    

    [self creatHeader];
    
    //[self showNotification:@"Test"];
}

-(void)creatHeader {
    UIView *header =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    header.backgroundColor = [UIColor colorWithRed:231/255.0 green:228/255.0 blue:223/255.0 alpha:1.0];//231 228 223 //[UIColor colorWithRed:0.84 green:0.10 blue:0.12 alpha:1];
    
    
    UIButton *lnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lnButton.frame = CGRectMake(20, 8, 25.0, 25.0);
    lnButton.tintColor = [UIColor whiteColor];
    [lnButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [lnButton addTarget:self action:@selector(lnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:lnButton];
    
    UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fbButton.frame = CGRectMake(kHeaderBtn_X+47, 8, 25.0, 25.0);
    fbButton.tintColor = [UIColor whiteColor];
    [fbButton setImage:[UIImage imageNamed:@"popular.png"] forState:UIControlStateNormal];
    [fbButton addTarget:self action:@selector(fbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:fbButton];
    
    UILabel *popularity =[[UILabel alloc] initWithFrame:CGRectMake(kHeaderBtn_X+80, 8, 25.0, 25.0)];
    popularity.text = @"400";
    [popularity setFont:[UIFont fontWithName:@"Emirates SB" size:14.0f]];
    popularity.textColor = [UIColor colorWithRed:49 green:65 blue:132 alpha:1];
    [header addSubview:popularity];
    
    
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterButton.frame = CGRectMake(kHeaderBtn_X+140, 8, 25.0, 25.0);
    twitterButton.tintColor = [UIColor whiteColor];
    [twitterButton setImage:[UIImage imageNamed:@"facebook_Friends"] forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(twitterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:twitterButton];
    
    UILabel *fbFriends =[[UILabel alloc] initWithFrame:CGRectMake(kHeaderBtn_X+167, 8, 25.0, 25.0)];
    fbFriends.text = @"400";
    [fbFriends setFont:[UIFont fontWithName:@"Emirates SB" size:14.0f]];
    fbFriends.textColor = [UIColor colorWithRed:49 green:65 blue:132 alpha:1];
    [header addSubview:fbFriends];
    
    self.tableView.tableHeaderView = header;


    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    DCTimeLineCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
//        cell = [[DCTimeLineCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DCTimeLineCustomCell" owner:self options:nil];//
        cell = [topLevelObjects objectAtIndex:0];
    }

    
    UIImageView *imgView_Place = (UIImageView *)[cell.contentView viewWithTag:11];
    imgView_Place.image = [UIImage imageNamed:@"dubai_icon"];
    imgView_Place.contentMode = UIViewContentModeScaleAspectFill;
    imgView_Place.clipsToBounds = YES;
    imgView_Place.layer.cornerRadius = 25.0;
    imgView_Place.layer.borderWidth = 1.0;
    imgView_Place.layer.borderColor = [UIColor whiteColor].CGColor;
    imgView_Place.backgroundColor = [UIColor clearColor];
    
     UILabel *primaryLabel = (UILabel *)[cell.contentView viewWithTag:1];
     UILabel *secondaryLabel = (UILabel *)[cell.contentView viewWithTag:5];
    UILabel *durationLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:6];
    
    [primaryLabel setFont:[UIFont fontWithName:@"Emirates SB" size:12.0f]];
    [secondaryLabel setFont:[UIFont fontWithName:@"Emirates SL" size:12.0f]];
    [durationLabel setFont:[UIFont fontWithName:@"Emirates SL" size:10.0f]];
    [distanceLabel setFont:[UIFont fontWithName:@"Emirates SL" size:10.0f]];
    

        [primaryLabel setTextAlignment:NSTextAlignmentLeft];
     [secondaryLabel setTextAlignment:NSTextAlignmentLeft];
     [durationLabel setTextAlignment:NSTextAlignmentRight];
     [distanceLabel setTextAlignment:NSTextAlignmentRight];
    
    if (indexPath.row == 0) {
        UIImageView *imgView_Location = (UIImageView *)[cell.contentView viewWithTag:13];
        
        imgView_Location.animationImages = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"loc1.jpeg"], [UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc1.jpeg"],[UIImage imageNamed:@"loc2.png"],[UIImage imageNamed:@"loc2.png"],[UIImage imageNamed:@"loc2.png"],[UIImage imageNamed:@"loc2.png"],[UIImage imageNamed:@"loc2.png"],[UIImage imageNamed:@"loc2.png"],nil];
        [imgView_Location startAnimating];
    }
    
    
    
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
        imgView_line.backgroundColor = [UIColor colorWithRed:231/255.0 green:228/255.0 blue:223/255.0 alpha:1.0];//231 228 223
        
        imgView_line.clipsToBounds = YES;
        imgView_line.layer.cornerRadius = 2;
        imgView_line.layer.borderWidth = 5;
        imgView_line.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:49 green:65 blue:132 alpha:1]);
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
- (IBAction)minusButtonAction:(id)sender
{
//    [self presentViewController:dcBookingVC animated:YES completion:nil];
    
//    UIStoryboard *storyboard = self.storyboard;
//    DCBookingViewController *dcBookingVC = [storyboard instantiateViewControllerWithIdentifier:@"DCTimeLineDetailViewController"];
//    dcBookingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    
//    // Configure the new view controller here.
//    
//    [self presentViewController:dcBookingVC animated:YES completion:nil];
    _hours = _hours- 2;
    _lblHours.text = [NSString stringWithFormat:@"%i",_hours];
    
    if (_hours < 9) {
        [self showErrorNotification:@"Do you want In"];

    }
    
    [self setLimeLineObjects1];
    [self.tableView reloadData];
}

- (IBAction)plusButtonAction:(id)sender
{
    
//    self.myCustomBar.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dubai.jpg"]];
//    [self setLimeLineObjects];

        _hours = _hours + 2;
        self.myCustomBar.nameLabel.text = [NSString stringWithFormat:@"%i Hours",_hours];
    
        [self.tableView reloadData];
    
    //[self playVideo:@"https://www.youtube.com/watch?v=5kdcROjK3Us&spfreload=10"];
    
    
}

-(void)showNotification:(NSString *)Text {
    
    
    UIView *notificationView;
    UILabel *notificationLbl;
    
    
    notificationView =[[UIView alloc] initWithFrame:CGRectMake(0, -50, 400, 100)];
    //notificationView =[[UIView alloc] init];

    notificationLbl =[[UILabel alloc] initWithFrame:CGRectMake(50, 20,300,30)];
    [notificationView addSubview:notificationLbl];
    
    notificationLbl.text = [NSString stringWithFormat:@"%@",Text];
    notificationLbl.backgroundColor = [UIColor clearColor];
    notificationLbl.textColor = [UIColor whiteColor];
    
    notificationView.backgroundColor = [UIColor colorWithRed:42/255.0 green:96/255.0 blue:152/255.0 alpha:1.0];//231 228 223 //[UIColor colorWithRed:0.84 green:
    
    notificationView.hidden = NO;
//    _notificationView.alpha = 1.0f;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromTop
                     animations:^
     {
         notificationView.frame = CGRectMake(0, 0, 400, 100);
         [self.view addSubview:notificationView];
     }
                     completion:nil];

    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^
     {

         notificationView.frame = CGRectMake(0, -50, 400, 100);
         //notificationView.alpha = 0.0f;

         [self.view addSubview:notificationView];
     }
                     completion:^(BOOL finished) {
                         // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
                         notificationView.hidden = YES;
                     }];

    
}



- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %ld",(long)idx);
    UIStoryboard *storyboard = self.storyboard;
    MPNavigationController *visaViewController;
    switch (idx) {
        case 0:{
            
                MapViewController *map = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
                map.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
                // Configure the new view controller here.
            
                [self presentViewController:map animated:YES completion:nil];
        }
            break;
        case 1:
            
            //UIStoryboard *storyboard = self.storyboard;
            visaViewController = [storyboard instantiateViewControllerWithIdentifier:@"MPNavigationController"];

//            visaViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            // Configure the new view controller here.
            [self presentViewController:visaViewController animated:YES completion:nil];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
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

-(void)fbButtonAction:(id)sender {
    
}

-(void)lnButtonAction:(id)sender {
    
}


-(void)twitterButtonAction:(id)sender {
    
}


-(void)playVideo:(NSString *)movieUrl {
    
    NSURL *fileURL = [NSURL URLWithString:movieUrl];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    self.moviePlayer .contentURL = fileURL;
    [self.moviePlayer  prepareToPlay];
    //[moviePlayer.view setFrame:CGRectMake(itemImageView.frame.origin.x,itemImageView.frame.origin.y,itemImageView.frame.size.width,(itemImageView.frame.size.height))];
    //[popView addSubview:[moviePlayer view]];
    
    self.moviePlayer .controlStyle = MPMovieControlStyleEmbedded;
    self.moviePlayer .scalingMode = MPMovieScalingModeAspectFit;
    self.moviePlayer .view.frame = self.view.frame;
    //[popView addSubview:[mPlayer view]];
    if (self.moviePlayer)
    {
        [self.moviePlayer setShouldAutoplay:YES];
        [self.moviePlayer play];
    }
    [self.view addSubview:self.moviePlayer.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerPlaybackWillExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerPlaybackWillEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerLoadStateChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerPlaybackStateChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
}

//------------------------------------------------------------------------------------------
//	Function Name	:   videoPlayerPlaybackFinished
//	Description		:   stop playback state finshed handler
//  params        :       none
//	return			:       void
//  author         :        Jeetendra
//------------------------------------------------------------------------------------------
-(void)videoPlayerPlaybackFinished:(NSNotification*)notification
{
    [self stopPlaying];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)stopPlaying
{
    if ([self.moviePlayer isPreparedToPlay])
    {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //[self performSelector:@selector(removePopOver) withObject:nil afterDelay:0.0];
       // [self removePopOver];
        //  [self.iceBaseVC updateView:[[UIApplication sharedApplication] statusBarOrientation]];
        [UIView commitAnimations];
    }
    //[self removeNotification];
    
//    if (_urlRequest) {
//        _urlRequest= nil;
//    }
//    if (_urlConnection) {
//        [_urlConnection cancel];
//        _urlConnection = nil;
//    }
}

//------------------------------------------------------------------------------------------
//	Function Name	:   videoPlayerPlaybackWillExitFullscreen
//	Description		:   exit full screen handler
//  params        :       none
//	return			:       void
//  author         :        Jeetendra
//------------------------------------------------------------------------------------------
-(void)videoPlayerPlaybackWillExitFullscreen:(NSNotification*)notification
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    //[UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // [self.iceBaseVC updateView:[[UIApplication sharedApplication] statusBarOrientation]];
    // moviePlayer.fullscreen = NO
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
    {
        [self.moviePlayer pause];
    }
    else if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer play];
    }
    else if (self.moviePlayer.playbackState == MPMoviePlaybackStateStopped)
    {
        [self.moviePlayer stop];
    }
    
    [UIView commitAnimations];
}



-(void)videoPlayerLoadStateChanged:(NSNotification *)notification
{
    //[self removeActivitySpinner];
    if (self.moviePlayer.loadState == MPMovieLoadStatePlayable) {
        if ([self.moviePlayer isPreparedToPlay]) {
            [self.moviePlayer setShouldAutoplay:YES];
            [self.moviePlayer prepareToPlay];
            [self.moviePlayer play];
        }
    }
}

-(void)videoPlayerPlaybackStateChanged:(NSNotification *)notification
{
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
    {
        [self.moviePlayer pause];
    }
    else if (self.moviePlayer.playbackState == MPMoviePlaybackStateStopped)
    {
        [self.moviePlayer stop];
    }
    else if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self.moviePlayer play];
    }
    
}


-(void)showErrorNotification:(NSString *)Text {
    
    
    _error_notificationView =[[UIView alloc] initWithFrame:CGRectMake(0, 700, 400, 80)];
    //notificationView =[[UIView alloc] init];
    
//    notificationLbl =[[UILabel alloc] initWithFrame:CGRectMake(50, 20,300,30)];
//    [_error_notificationView addSubview:notificationLbl];
//    
//    notificationLbl.text = [NSString stringWithFormat:@"%@",Text];
//    notificationLbl.backgroundColor = [UIColor clearColor];
 //   notificationLbl.textColor = [UIColor whiteColor];
    
    //_error_notificationView.backgroundColor = [UIColor colorWithRed:231/255.0 green:228/255.0 blue:223/255.0 alpha:1.0];
    _error_notificationView.backgroundColor = [UIColor lightTextColor];

    
    UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yesButton.frame = CGRectMake(280, 23,50,33);
    //yesButton.titleLabel.text = @"YES";
    //yesButton.tintColor = [UIColor whiteColor];
    [yesButton setImage:[UIImage imageNamed:@"RedAlert.jpeg"] forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(RedAlertButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_error_notificationView addSubview:yesButton];
    yesButton.backgroundColor = [UIColor redColor];
    

    
    
    _error_notificationView.hidden = NO;
    //    _notificationView.alpha = 1.0f;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom//UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^
     {
         _error_notificationView.frame = CGRectMake(0, 475, 400, 70);
         [self.view addSubview:_error_notificationView];
     }
                     completion:nil];
    
    
    
//    [UIView animateWithDuration:0.5
//                          delay:1.0
//                        options:UIViewAnimationOptionTransitionFlipFromTop
//                     animations:^
//     {
//         
//         notificationView.frame = CGRectMake(0, 700, 400, 100);
//         //notificationView.alpha = 0.0f;
//         
//         [self.view addSubview:notificationView];
//     }
//                     completion:^(BOOL finished) {
//                         // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
//                         notificationView.hidden = YES;
//                     }];
    
    
}

-(void)RedAlertButtonAction:(id)sender {
    [_error_notificationView removeFromSuperview];
    [self show_error_notificationViewAlert:@"Do you want to continue"];

}

-(void)show_error_notificationViewAlert:(NSString *)text {
    
    _error_notificationView_Alert =[[UIView alloc] initWithFrame:CGRectMake(0, 700, 400, 100)];
    
        UILabel *notificationLbl =[[UILabel alloc] initWithFrame:CGRectMake(50, 10,300,30)];
        [_error_notificationView_Alert addSubview:notificationLbl];
    
        notificationLbl.text = [NSString stringWithFormat:@"%@",text];
        notificationLbl.backgroundColor = [UIColor clearColor];
       notificationLbl.textColor = [UIColor whiteColor];
    
    _error_notificationView_Alert.backgroundColor = [UIColor colorWithRed:42/255.0 green:96/255.0 blue:152/255.0 alpha:1.0];
    //_error_notificationView_Alert.backgroundColor = [UIColor lightTextColor];
    
    
    UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yesButton.frame = CGRectMake(120, 40,50,33);
    
    [yesButton setTitle:@"YES" forState:UIControlStateNormal];


    [yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [yesButton addTarget:self action:@selector(yesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_error_notificationView_Alert addSubview:yesButton];
    
    
    
    UIButton *noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    noButton.frame = CGRectMake(160, 40,50,33);
    
    [noButton setTitle:@"NO" forState:UIControlStateNormal];
    [noButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    
    [noButton addTarget:self action:@selector(yesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_error_notificationView_Alert addSubview:noButton];
    
    

    
    
    _error_notificationView_Alert.hidden = NO;
    //    _notificationView.alpha = 1.0f;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom//UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^
     {
         _error_notificationView_Alert.frame = CGRectMake(0, 475, 400, 100);
         [self.view addSubview:_error_notificationView_Alert];
     }
                     completion:nil];

}

-(void)yesBtnAction:(id)sender {
    
    [_error_notificationView_Alert removeFromSuperview];
    
    _hours = 9;
    _lblHours.text = @"9";
    [_tableView reloadData];
    
}

@end
