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

+ (CGFloat)fontSizeWithFrameType:(FDDanmakuFrameType)frameType
                      viewHeight:(CGFloat)viewHeight
                    fontSizeType:(FDDanmakuFontSizeType)fontSizeType;
@end
