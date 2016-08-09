//
//  FDVideoPlayer.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/8/9.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDVideoPlayer : NSObject
@property (nonatomic, assign) NSTimeInterval playPostion;

+ (FDVideoPlayer *)sharedPlayer;
@end
