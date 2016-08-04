//
//  FDDanmakuCache.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDCache.h"

/**
 *  If you have some customized strategy,you can inherit this clsss and override corresponding method.
 */
@interface FDDanmakuCache : NSObject

+ (FDDanmakuCache *)sharedDanmakuCache;

/**
 *  store asynchronically
 *
 *  @param DanmakuData data to store
 *  @param key         key to the content
 *  @param completion  callback block from the main thread
 */
- (void)storeDanmakuToDisk:(NSArray *)DanmakuData key:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion;

/**
 *  query synchronically
 *
 *  @param key key to the content
 *
 *  @return array result
 */
- (NSArray *)querySyncForKey:(NSString *)key;

/**
 *  query asynchronically
 *
 *  @param key        key to the content
 *  @param completion callback block from the main thread
 */
- (void)queryAsyncForKey:(NSString *)key  withCompletion:(cacheQueryCompletedBlock)completion ;

/**
 *  check synchronically whether the file to the key exists
 *
 *  @param key key to query
 *
 *  @return the result whether the file to the key exists
 */
- (BOOL)isExistDanmakuForKey:(NSString *)key;

/**
 *  check asynchronically whether the file to the key exists
 *
 *  @param key        key to query
 *  @param completion callback block from the main thread
 */
- (void)isExistDanmakuForKey:(NSString *)key  withCompletion:(cacheIsExitCompletedBlock)completion;

/**
 *  remove asynchronically
 *
 *  @param key        key to the content
 *  @param completion callback block from the main thread
 */
- (void)removeDanmakuForKey:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion;

/**
 *  clear all cached files under the specified folder
 *
 *  @param completion callback block from the main thread
 */
- (void)clearDiskOnCompletion:(cacheNoParamsBlock)completion;

@end
