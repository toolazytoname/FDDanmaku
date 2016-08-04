//
//  NSArray+FDHelper.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FDHelper)
- (id)fd_objectOrNilAtIndex:(NSUInteger)index;

- (BOOL)fd_containsIndex:(NSUInteger)index;
@end
