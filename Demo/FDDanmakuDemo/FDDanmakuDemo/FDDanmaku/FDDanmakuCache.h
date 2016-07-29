//
//  FDDanmakuCache.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDCache.h"

@interface FDDanmakuCache : NSObject

+ (FDDanmakuCache *)sharedDanmakuCache;

- (void)storeDanmakuToDisk:(NSArray *)DanmakuData key:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion;

- (NSArray *)querySyncForKey:(NSString *)key;
- (void)queryAsyncForKey:(NSString *)key  withCompletion:(cacheQueryCompletedBlock)completion ;

- (BOOL)isExistDanmakuForKey:(NSString *)key;
- (void)isExistDanmakuForKey:(NSString *)key  withCompletion:(cacheIsExitCompletedBlock)completion;

- (void)removeDanmakuForKey:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion;
- (void)clearDiskOnCompletion:(cacheNoParamsBlock)completion;

@end
