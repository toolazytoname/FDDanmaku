//
//  FDVideoPlayer.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/8/9.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDVideoPlayer.h"

@interface FDVideoPlayer()
/**
 *  当前播放位置，单位（ms）
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FDVideoPlayer


+ (FDVideoPlayer *)sharedPlayer {
    static FDVideoPlayer *videoPlayer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoPlayer = [[FDVideoPlayer alloc] init];
        [videoPlayer timer];
    });
    return videoPlayer;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

- (void)tick {
    self.playPostion++;
}

@end
