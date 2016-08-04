//
//  FDDanmakuViewController.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuViewController.h"
#import "FDDanmakuConstant.h"
#import "FDDanmakuONScreen.h"
#import "FDDanmakuRow.h"
#import "FDDanmakuView.h"
#import "UIView+FDHelper.h"

@interface FDDanmakuViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) FDDanmakuONScreen *danmakuONScreen;
@property (nonatomic, assign) BOOL isDanmakuON;
@property (nonatomic, strong) NSMutableArray *requestedTimeRange;
@property (nonatomic, assign) BOOL isPaused;



@end

@implementation FDDanmakuViewController
#pragma mark - life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
    }
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor clearColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithFrame:(CGRect)frame frameType:(FDDanmakuFrameType)frameType {
    CGFloat deltaHeight = CGRectGetHeight(frame) - self.view.height;
    self.view.frame = frame;
    if (FDDanmakuFrameTypePhoneInline == frameType) {
        self.isDanmakuON = NO;
        return;
    }
    [self.danmakuONScreen updateCurrentRowsWithFrameType:frameType];
    [self.danmakuONScreen.rowsFlyFromRight enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FDDanmakuRow *danmakuRow = (FDDanmakuRow *)obj;
        [danmakuRow.danmakuViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDDanmakuView *danmakuView = (FDDanmakuView *)obj;
            danmakuView.top = danmakuView.top + deltaHeight;
        }];
    }];
    
    [self.danmakuONScreen.rowsFlyFromBottom enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FDDanmakuRow *danmakuRow = (FDDanmakuRow *)obj;
        [danmakuRow.danmakuViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDDanmakuView *danmakuView = (FDDanmakuView *)obj;
            if(danmakuView.bottom > CGRectGetHeight(frame)){
                danmakuView.alpha = 0;
            }
        }];
    }];
}

- (void)invalidateTimer {
    [self.displayLink invalidate];
}

- (void)setIsDanmakuON:(BOOL)isDanmakuON {
    _isDanmakuON = isDanmakuON;
    [self invalidateTimer];
    if (isDanmakuON) {
        
        
    }
}

- (void)setIsPaused:(BOOL)isPaused {
    _isPaused = isPaused;
    if (isPaused) {
        [self.danmakuONScreen pause];
    }
    else {
        [self.danmakuONScreen resume];
    }
}

- (void)checkDanmaku {
    //TODO:外部设置一个定时器，模拟播放器播放进度的变化，这里可以用一个单例，获取播放器的值。
    NSTimeInterval currentPlaybackTime;
    NSRange requestRange = NSMakeRange(currentPlaybackTime, FDRequestTimeInterval);
    if(![self rangeHasLoaded:requestRange]) {
//        [self requestedTimeRange:requestRange];
    }
    

}


//TODO:觉得这个方法太不合理，只判断了NSEqualRanges一模一样的情况，应该判断：当前请求的时间段，与，已请求的时间段，比较，前者是否是后者的一个子集。而不能用全等来判断
//并且，一请求的时间段，最好是一个大的整体，尽量不要用数组来表示， 不知道NSRange能不能存储不连续的值。
- (BOOL)rangeHasLoaded:(NSRange)range
{
    for (NSValue *rangeValue in self.requestedTimeRange)
    {
        NSRange timeRange = [rangeValue rangeValue];
        if(NSEqualRanges(range, timeRange)) {
            return YES;
        }
    }
    return NO;
}


- (void)removeAllDanmakus {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.danmakuONScreen removeAllRows];
    [self.requestedTimeRange removeAllObjects];
}

- (void)requestWithRange:(NSRange)timeRange {
    [self.requestedTimeRange addObject:[NSValue valueWithRange:timeRange]];
}
#pragma mark - lazy Load
- (FDDanmakuONScreen *)danmakuONScreen {
    if (!_danmakuONScreen) {
        _danmakuONScreen = [[FDDanmakuONScreen alloc] init];
    }
    return _danmakuONScreen;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(checkDanmaku)];
        [_displayLink setFrameInterval:60];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

- (NSMutableArray *)requestedTimeRange {
    if (!_requestedTimeRange) {
        _requestedTimeRange = [[NSMutableArray alloc] init];
    }
    return _requestedTimeRange;
}
@end