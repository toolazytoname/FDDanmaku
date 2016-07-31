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

@interface FDDanmakuViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) FDDanmakuONScreen *danmakuONScreen;
@property (nonatomic, assign) BOOL isDanmakuON;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithFrame:(CGRect)frame frameType:(FDDanmakuFrameType)frameType {
    self.view.frame = frame;
    if (FDDanmakuFrameTypePhoneInline == frameType) {
        self.isDanmakuON = NO;
    }
}

#pragma mark - lazy Load
- (void)invalidateTimer {
    [self.displayLink invalidate];
}

- (FDDanmakuONScreen *)danmakuONScreen {
    if (_danmakuONScreen) {
        _danmakuONScreen = [[FDDanmakuONScreen alloc] init];
    }
    return _danmakuONScreen;
}

@end
