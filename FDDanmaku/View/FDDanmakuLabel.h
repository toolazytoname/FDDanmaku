//
//  FDDanmakuLabel.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDanmakuConstant.h"
#import "FDDanmakuModel.h"

@interface FDDanmakuLabel : UILabel
- (void)updateWithModel:(FDDanmakuModel *)danmakuModel
              FrameType:(FDDanmakuFrameType)frameType
             viewHeight:(CGFloat)viewHeight;
@end
