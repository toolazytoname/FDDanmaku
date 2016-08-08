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

@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double showTime;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) FDDanmakuFontSizeType fontSizeType;
@property (nonatomic, assign) FDDanmakuDirectionType directionType;


@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) FDDanmakuType danmakuType;

- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
