//
//  FDDanmakuModel.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDDanmakuConstant.h"

@interface FDDanmakuModel : NSObject

@property (nonatomic, assign) BOOL sentByMyself;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger showTime;
@property (nonatomic, assign) FDDanmakuFontSizeType fontSize;
@property (nonatomic, assign) FDDanmakuType danmakuType;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *nickName;
@property (nonatomic, copy)   NSString *color;
@property (nonatomic, copy)   NSString *headPicture;   //明星弹幕头像



@end
