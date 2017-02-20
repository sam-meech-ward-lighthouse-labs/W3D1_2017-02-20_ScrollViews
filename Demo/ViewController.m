//
//  ViewController.m
//  Demo
//
//  Created by Sam Meech-Ward on 2017-02-20.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) UIImageView *airpods;
@property (strong, nonatomic) UIImageView *blackPhoneImageView;

@property (strong, nonatomic, readonly) NSArray<UIImage *> *iPhoneImages;

@property (nonatomic, assign) BOOL scrollViewSetup;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.scrollViewSetup == NO) {
        self.scrollViewSetup = YES;
        [self setupScrollViewForPaging];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll View Logic 📜

- (void)setupImageForZooming {
    UIImage *airPodsImage = [UIImage imageNamed:@"airpods"];
    self.airpods = [[UIImageView alloc] initWithImage:airPodsImage];
    [self.imageScrollView addSubview:self.airpods];
    
    self.imageScrollView.maximumZoomScale = 2.0;
    self.imageScrollView.minimumZoomScale = 0.5;
}


- (void)setupScrollViewForPaging {
    CGFloat scrollViewWidth = CGRectGetWidth(self.imageScrollView.frame);
    CGFloat scrollViewHeight = CGRectGetHeight(self.imageScrollView.frame);
    
    [self.iPhoneImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:image];
        
        phoneImageView.frame = CGRectMake(scrollViewWidth*idx, 0, scrollViewWidth, scrollViewHeight);
        
        phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.imageScrollView addSubview:phoneImageView];
    }];
    
    self.imageScrollView.contentSize = CGSizeMake(self.iPhoneImages.count*scrollViewWidth, scrollViewHeight);
    
    self.imageScrollView.pagingEnabled = YES;
}


#pragma mark - Readonly Properties 👓

- (NSArray<UIImage *> *)iPhoneImages {
    return @[
             [UIImage imageNamed:@"black"],
             [UIImage imageNamed:@"gold"],
             [UIImage imageNamed:@"silver"],
             [UIImage imageNamed:@"black"],
             [UIImage imageNamed:@"gold"],
             [UIImage imageNamed:@"silver"],
             [UIImage imageNamed:@"rosegold"],
             [UIImage imageNamed:@"jetblack"],
             ];
}

#pragma mark - UIScrollViewDelegate 😎

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
////    return self.blackPhoneImageView;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Offset: %@", NSStringFromCGPoint(scrollView.contentOffset));
}

@end


