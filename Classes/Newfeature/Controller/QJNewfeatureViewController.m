//
//  QJNewfeatureViewController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/1.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJNewfeatureViewController.h"
#import "QJTabBarViewController.h"

#define QJNewfeatureImageCount 4

@interface QJNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation QJNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加scrollView
    [self setupScrollView];
    
    // 添加pageControl
    [self setupPageControl];
    
    self.view.backgroundColor = QJColor(246, 246, 246);
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    
    CGFloat imageW = screenW;
    CGFloat imageH = screenH;
    CGFloat imageY = 0;
    for (int i = 0; i < QJNewfeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [scrollView addSubview:imageView];
        CGFloat imageX = i * imageW;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        if (screenH > 480) {
            imageName = [imageName stringByAppendingString:@"-568h"];
        }
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        // 最后一张添加按钮
        if (i == QJNewfeatureImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    // 设置scrollView属性
    scrollView.contentSize = CGSizeMake(imageW * QJNewfeatureImageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setupPageControl {
    // 创建pageControl
    self.pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:self.pageControl];
    // 设置pageControl属性
    self.pageControl.numberOfPages = QJNewfeatureImageCount;
    self.pageControl.centerX = screenW * 0.5;
    self.pageControl.centerY = screenH - 30;
    self.pageControl.currentPageIndicatorTintColor = QJColor(253, 98, 42);
    self.pageControl.pageIndicatorTintColor = QJColor(189, 189, 189);
}
/**
 *  设置最后一张图片
 */
- (void)setupLastImageView:(UIImageView *)imageView {
    // 添加开始按钮
    [self setupStartButton:imageView];
    
    // 添加分享按钮
    [self setupShareButton:imageView];
}
/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView {
    // 创建开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:startBtn];
    // 设置按钮属性
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    startBtn.width = startBtn.currentBackgroundImage.size.width;
    startBtn.height = startBtn.currentBackgroundImage.size.height;
    startBtn.centerX = screenW * 0.5;
    startBtn.centerY = screenH * 0.8;
}
/**
 *  添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView {
    // 创建分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:shareBtn];
    // 设置分享按钮属性
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.size = CGSizeMake(150, 35);
    shareBtn.centerX = screenW * 0.5;
    shareBtn.centerY = screenH * 0.7;
                          
}
/**
 *  点击开始微博按钮
 */
- (void)startBtnClicked {
    QJTabBarViewController *tvc = [[QJTabBarViewController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tvc;
}
/**
 *  点击分享按钮
 */
- (void)shareBtnClicked:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.selected;
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / screenW + 0.5;
}

@end
