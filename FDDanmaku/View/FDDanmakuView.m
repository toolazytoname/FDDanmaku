//
//  FDDanmakuView.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuView.h"
#import "FDDanmakuLabel.h"


@interface FDDanmakuView()
//@property (nonatomic, retain) FDDanmakuLabel *itemLabel;
@end

@implementation FDDanmakuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)updateWithModel:(FDDanmakuModel *)danmakuModel
              FrameType:(FDDanmakuFrameType)frameType
             viewHeight:(CGFloat)viewHeight {
    if (!danmakuModel) {
        return;
    }
    FDDanmakuLabel *label = [[FDDanmakuLabel alloc] initWithFrame:CGRectZero];
    [label updateWithModel:danmakuModel FrameType:frameType viewHeight:viewHeight];
    self.frame = label.frame;
    [self addSubview:label];
}
@end
