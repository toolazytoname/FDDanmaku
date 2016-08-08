//
//  FDDanmakuViewController.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDanmakuConstant.h"

@interface FDDanmakuViewController : UIViewController

@property (nonatomic, strong) NSMutableDictionary *danmakuDic;



- (void)updateWithFrame:(CGRect)frame frameType:(FDDanmakuFrameType)frameType;

@end
