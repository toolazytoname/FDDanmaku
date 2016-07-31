//
//  NSMutableArray+FDHelper.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "NSMutableArray+FDHelper.h"

@implementation NSMutableArray (FDHelper)
- (void)fd_addObjectOrNil:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

@end
