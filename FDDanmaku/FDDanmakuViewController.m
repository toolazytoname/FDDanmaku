//
//  FDDanmakuViewController.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuViewController.h"

@interface FDDanmakuViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;
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

#pragma mark - lazy Load
- (void)invalidateTimer {
    [self.displayLink invalidate];
}

@end
