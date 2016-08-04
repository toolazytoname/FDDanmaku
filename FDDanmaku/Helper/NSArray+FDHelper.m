//
//  NSArray+FDHelper.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "NSArray+FDHelper.h"

@implementation NSArray (FDHelper)
- (id)fd_objectOrNilAtIndex:(NSUInteger)index {
    return [self fd_containsIndex:index] ? [self objectAtIndex:index] : nil;
}

- (BOOL)fd_containsIndex:(NSUInteger)index {
    return index < self.count;
}


@end
