//
//  FDDanmakuLabel.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuLabel.h"
#import "FDDanmakuUtility.h"
#import "UIColor+FDHelper.h"

@implementation FDDanmakuLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

//- (void)drawTextInRect:(CGRect)rect {
//    CGSize shadowOffset = self.shadowOffset;
//    UIColor *textColor = self.textColor;
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    
//    CGContextSetTextDrawingMode(context, kCGTextStroke);
////    self.textColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
//    [super drawTextInRect:rect];
//    
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    self.shadowOffset = CGSizeMake(0, 0);
//    [super drawTextInRect:rect];
//}


- (void)updateWithModel:(FDDanmakuModel *)danmakuModel
              FrameType:(FDDanmakuFrameType)frameType
             viewHeight:(CGFloat)viewHeight {
    if (!danmakuModel) {
        return;
    }
    //color
    UIColor *color = [UIColor fd_colorWithHexString:danmakuModel.color];
    if(!color) {
        color = [UIColor whiteColor];
    }
    [self setTextColor:color];
    //font size
    CGFloat fontSzie =[FDDanmakuUtility fontSizeWithFrameType:frameType viewHeight:viewHeight fontSizeType:danmakuModel.fontSizeType];
    [self setFont:[UIFont systemFontOfSize:fontSzie]];
    
    //text and border
    switch (danmakuModel.danmakuType) {
        case FDDanmakuTypeSendByMyself:{
            [self.layer setBorderColor:[UIColor colorWithWhite:1 alpha:0.8].CGColor];
            [self.layer setBorderWidth:([UIScreen mainScreen].scale < 2) ? 1 : 0.5];
            [self setText:danmakuModel.content];
            break;
        }
        case FDDanmakuTypeStar: {
//            [self setText:[NSString stringWithFormat:@"%@：%@",danmakuModel.nickName,danmakuModel.content]];
            break;
        }
        default: {
            [self setText:danmakuModel.content];
            break;
        }
    }
    [self sizeToFit];
}

@end
