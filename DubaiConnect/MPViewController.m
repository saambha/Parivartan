//
//  MPViewController.m
//  MPSkewed
//
//  Created by Alex Manzella on 23/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"
#import "DCBarCodeVC.h"

static NSString *kCellId = @"cellId";

@interface MPViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)  DCBarCodeVC *barCodeVC;

@end

@implementation MPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    MPSkewedParallaxLayout *layout = [[MPSkewedParallaxLayout alloc] init];
    layout.lineSpacing = 2;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCellId];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
}

- (NSString *)titleForIndex:(NSInteger)index {
    NSString *text = nil;
    switch (index - 1) {
        case 0:
            text = @"Scan for\n BOARDING PASS";
            break;
        case 1:
            text = @"Scan\n ETICKET";
            break;
        case 2:
            text = @"Skywards\n LOGIN";
            break;
        case 3:
            text = @"Skywards\n SIGN UP";
            break;

            break;
        default:
            break;
    }
    
    return text;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4; // random
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % 5 + 1;
    MPSkewedCell* cell = (MPSkewedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    switch (index - 1) {
        case 0:
            cell.image = [UIImage imageNamed:@"bg"];
            break;
        case 1:
            cell.image = [UIImage imageNamed:@"bg"];
            break;
        case 2:
            cell.image = [UIImage imageNamed:@"bg"];
            break;
        case 3:
            cell.image = [UIImage imageNamed:@"bg"];
            break;
            
            break;
        default:
            break;
    }
    
    cell.text = [self titleForIndex:index];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@ %zd", NSStringFromSelector(_cmd), indexPath.item);
    
//    if(_barCodeVC){
//        return;
//    }

    UIStoryboard *storyboard = self.storyboard;
     _barCodeVC = [storyboard instantiateViewControllerWithIdentifier:@"DCBarCodeVC"];
//    barCodeVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    
    
    [self setPresentationStyleForSelfController:self presentingController:_barCodeVC];
    
//    switch (indexPath.item - 1) {
//        case 0:
//            [self.navigationController.view addSubview:_barCodeVC.view];
//////            _barCodeVC.view.backgroundColor = [UIColor clearColor];
////            self.modalPresentationStyle = UIModalPresentationCurrentContext;
////            [self :_barCodeVC animated:YES completion:NULL];
//            break;
//        case 1:
////            _barCodeVC.view.backgroundColor = [UIColor clearColor];
//            self.modalPresentationStyle = UIModalPresentationCurrentContext;
//            [self presentViewController:_barCodeVC animated:YES completion:NULL];
//            break;
//        case 2:
////            _barCodeVC.view.backgroundColor = [UIColor clearColor];
//            self.modalPresentationStyle = UIModalPresentationCurrentContext;
//            [self presentViewController:_barCodeVC animated:YES completion:NULL];
//            break;
//        case 3:
//            _barCodeVC.view.backgroundColor = [UIColor clearColor];
//            self.modalPresentationStyle = UIModalPresentationCurrentContext;
//            [self presentViewController:_barCodeVC animated:YES completion:NULL];
//            break;
//            
//            break;
//        default:
////            _barCodeVC.view.backgroundColor = [UIColor clearColor];
//            self.modalPresentationStyle = UIModalPresentationCurrentContext;
//            [self presentViewController:_barCodeVC animated:YES completion:NULL];
//            break;
//    }

}



- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}
- (IBAction)submitVISA:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) loadViewAsPopupwindow{
    
}

@end
