//
//  FDDanmakuRow.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuRow.h"

@implementation FDDanmakuRow

- (NSMutableArray *)danmakuViewsArray {
    if (_danmakuViewsArray) {
        _danmakuViewsArray = [[NSMutableArray alloc] init];
    }
    return _danmakuViewsArray;
}
@end
