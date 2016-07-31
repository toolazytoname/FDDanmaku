//
//  FDDanmakuUtility.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuUtility.h"


@implementation FDDanmakuUtility
+ (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

+ (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

+ (CGFloat)fontSizeWithFrameType:(FDDanmakuFrameType)frameType
                      viewHeight:(CGFloat)viewHeight
                         fontSizeType:(FDDanmakuFontSizeType)fontSizeType {
    CGFloat rowHeight = [self rowHeightWithFrameType:frameType viewHeight:viewHeight];
    CGSize size = CGSizeZero;
    NSInteger i ,fontSize = 0;
    //TODO:逻辑比较怪，稍后完善
    for (i = 10; i < 50; i++) {
        size = [@"Barrage" sizeWithAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:i] }];
        if(size.height > rowHeight)
            break;
    }
    i--;
    switch (fontSize) {
        case FDDanmakuFontSizeTypeLarge: {
            fontSize = i;
            break;
        }
        case FDDanmakuFontSizeTypeMiddle:{
            fontSize = (i>30)?i * 13/15:i * 8/9;
            break;
        }
        case FDDanmakuFontSizeTypeSmall:{
            fontSize = (i>30)?i * 4/5:i * 5/6;
            break;
        }
        default:
            break;
    }
    return fontSize;
}

+ (CGFloat)rowHeightWithFrameType:(FDDanmakuFrameType)frameType
                       viewHeight:(CGFloat)viewHeight {
    CGFloat rowHeight = 0.0f;
    NSInteger rowNum = [self rowNumberWithFrameType:frameType];
    if(rowNum > 0) {
        rowHeight = viewHeight / rowNum;
    }
    return rowHeight;
}

+ (NSInteger)rowNumberWithFrameType:(FDDanmakuFrameType)frameType {
    NSInteger rowNumber = 0;
    switch (frameType) {
        case FDDanmakuFrameTypePhoneFullScreen:
        case FDDanmakuFrameTypePadInline:
            rowNumber = 14;
            break;
        case FDDanmakuFrameTypePadFullScreen:
            rowNumber = 19;
        default:
            break;
    }
    return rowNumber;
}

+ (NSString *)shadowColorHexWithshadowColorType:(FDDanmakuShadowColorType)danmakuShadowColorType {
    NSString *shadowColorHex = @"#E64E5D";
    switch (danmakuShadowColorType) {
        case FDDanmakuShadowColorTypeGray:
            shadowColorHex = @"#1D1D1E";
            break;
        case FDDanmakuShadowColorTypePurple:
            shadowColorHex = @"#9074D6";
            break;
        case FDDanmakuShadowColorTypeRed:
            shadowColorHex = @"#E64E5D";
            break;
        case FDDanmakuShadowColorTypeYellow:
            shadowColorHex = @"#E6B03C";
            break;
        case FDDanmakuShadowColorTypeBlue:
            shadowColorHex = @"#3BB0DC";
            break;
        case FDDanmakuShadowColorTypeGreen:
            shadowColorHex = @"#35BC9B";
            break;
        default:
            break;
    }
    return shadowColorHex;
}

@end
