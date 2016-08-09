//
//  FDDanmakuView.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDanmakuModel.h"
#import "FDDanmakuConstant.h"

@interface FDDanmakuView : UIView
- (void)updateWithModel:(FDDanmakuModel *)danmakuModel
              FrameType:(FDDanmakuFrameType)frameType
             viewHeight:(CGFloat)viewHeight;
@end
