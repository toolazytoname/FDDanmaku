//
//  ViewController.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "ViewController.h"
#import "FDDanmakuHeaders.h"
//大体思路，先跑起来，然后逐步优化，通用，简单，合理
//1.导出弹幕数据
//2.外部加一个timer定时器
//3.完成展示逻辑
@interface ViewController ()

@property (nonatomic,strong) FDDanmakuViewController *danmakuViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientaionChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self addDanmaku];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateDanmaku {
    
    
//    NSLog(@"frame:%@",NSStringFromCGRect(danmakuFrame));
    
}

- (void)orientaionChange:(NSNotification *)notification {
    CGFloat longSide = MAX(CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame));
    CGFloat shortSide = MIN(CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame));
    CGFloat width;
    CGFloat height;
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    switch (orientation) {
        case UIDeviceOrientationPortrait: {
            width = shortSide;
            height = longSide;
            break;
        }
        case UIDeviceOrientationLandscapeLeft: {
            width = longSide;
            height = shortSide;
            break;
        }
        case UIDeviceOrientationLandscapeRight: {
            width = longSide;
            height = shortSide;
            break;
        }
        case UIDeviceOrientationPortraitUpsideDown:{
            width = shortSide;
            height = longSide;
            break;
        }
        default:
            return;
            break;
    }
    CGRect danmakuFrame = CGRectMake(0, 0,width,height);
    NSLog(@"orientation:%i;width:%f;height:%f;",(int)orientation,width,height);
    [self.danmakuViewController updateWithFrame:danmakuFrame frameType:FDDanmakuFrameTypePadFullScreen];
}

- (void)addDanmaku {
    [self addChildViewController:self.danmakuViewController];
    [self.view addSubview:self.danmakuViewController.view];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}


#pragma mark - lazy load
- (FDDanmakuViewController *)danmakuViewController {
    if (!_danmakuViewController) {
        _danmakuViewController = [[FDDanmakuViewController alloc] init];
        _danmakuViewController.view.frame = self.view.frame;
    }
    return _danmakuViewController;
}
@end
