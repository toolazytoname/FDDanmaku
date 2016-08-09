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
    [self request];
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


- (void)request {
    NSURL *url = [NSURL URLWithString:@"http://api.danmu.tv.sohu.com/danmu?act=dmlist&vid=3186419&pct=2&aid=9076230&request_from=sohu_vrs_player&num=10000"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        NSArray *comments = [dic valueForKeyPath:@"info.comments"];
        NSDictionary *dfopt = [dic valueForKeyPath:@"info.dfopt"];
        __block NSMutableArray *danmakuArray = [[NSMutableArray alloc] init];
        [comments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *comment = [NSMutableDictionary dictionaryWithDictionary:obj];
            NSDictionary *option = [comment objectForKey:@"t"];
            if (!option || ![option isKindOfClass:[NSDictionary class]]) {
                if (dfopt) {
                    [comment setObject:dfopt forKey:@"t"];
                }
            }
            FDDanmakuModel *danmakuModel = [[FDDanmakuModel alloc] initWithDictionary:comment];
            
            [danmakuArray addObject:danmakuModel];
        }];
//        NSLog(@"danmakuArray:%@",danmakuArray);
        self.danmakuViewController.danmakuDic = [FDDanmakuUtility packDanmakuDic:danmakuArray];
        [self.danmakuViewController displayLink];
    }];
    [task resume];
}

//- (void)addTimer {
//    NSTimer *
//}

#pragma mark - lazy load
- (FDDanmakuViewController *)danmakuViewController {
    if (!_danmakuViewController) {
        _danmakuViewController = [[FDDanmakuViewController alloc] init];
        _danmakuViewController.view.frame = self.view.frame;
    }
    return _danmakuViewController;
}
@end
