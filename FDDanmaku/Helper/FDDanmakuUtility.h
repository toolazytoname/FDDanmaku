//
//  FDDanmakuUtility.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FDDanmakuConstant.h"

@interface FDDanmakuUtility : NSObject

+ (void)pauseLayer:(CALayer *)layer;
+ (void)resumeLayer:(CALayer *)layer;

+ (NSInteger)rowNumberWithFrameType:(FDDanmakuFrameType)frameType;

+ (CGFloat)rowHeightWithFrameType:(FDDanmakuFrameType)frameType
                       viewHeight:(CGFloat)viewHeight;

+ (CGFloat)fontSizeWithFrameType:(FDDanmakuFrameType)frameType
                      viewHeight:(CGFloat)viewHeight
                    fontSizeType:(FDDanmakuFontSizeType)fontSizeType;

/**
 *  封装完成以后的弹幕数据是一个大字典，key是时间，value是一个弹幕数组
 *
 */
+ (NSMutableDictionary *)packDanmakuDic:(NSArray *)danmakuArray;

@end
