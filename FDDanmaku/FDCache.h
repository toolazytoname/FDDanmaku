//
//  FileDiskCache.h
//  VideoPlayer
//
//  Created by weichao on 16/7/15.
//
//

#import <Foundation/Foundation.h>

typedef void(^cacheQueryCompletedBlock)(NSArray *dataArray);
typedef void(^cacheIsExitCompletedBlock)(BOOL isExist);
typedef void(^cacheNoParamsBlock)();

/**
 A simle cache manager class:reference to the SDImageCache in SDWebImage.
 Basing on the file system, my class reads and writes into cache data through the key corresponding to the file.The problems lay in inconvenient extension, lacking of metadata, unavailiableness of the elimination algorithm, slowness to statistics.
 */
@interface FDCache : NSObject

+ (FDCache *)sharedCache;

/**
 *  init a FileDiskCache instance
 *
 *  @param folderName the foldname under cache folder in sandbox
 *
 *  @return a FileDiskCache instance
 */
- (FDCache *)initWithFolderName:(NSString *)folderName;

/**
 *  store asynchronically
 *
 *  @param arrayToStore array
 *  @param key          key to the content
 *  @param completion   callback block from the main thread
 */
- (void)storeAsyncToDiskWithArray:(NSArray *)arrayToStore forKey:(NSString *)key withCompletion:(cacheNoParamsBlock)completion;

/**
 *  remove asynchronically
 *
 *  @param key        key to the content
 *  @param completion callback block from the main thread
 */
- (void)removeForKey:(NSString *)key withCompletion:(cacheNoParamsBlock)completion;

/**
 *  clear all cached files under the specified folder
 *
 *  @param completion callback block from the main thread
 */
- (void)clearDiskOnCompletion:(cacheNoParamsBlock)completion;

/**
 *  query asynchronically
 *
 *  @param key        key to the content
 *  @param completion callback block from the main thread
 */
- (void)queryAsyncforKey:(NSString *)key withCompletion:(cacheQueryCompletedBlock)completion;

/**
 *  query synchronically
 *
 *  @param key key to the content
 *
 *  @return the array result
 */
- (NSArray *)querySyncforKey:(NSString *)key;

/**
 *  check asynchronically whether the file to the key exists
 *
 *  @param key        key to query
 *  @param completion callback block from the main thread
 */
- (void)isExistForKey:(NSString *)key withCompletion:(cacheIsExitCompletedBlock)completion;

/**
 *  check synchronically whether the file to the key exists
 *
 *  @param key key to query
 *
 *  @return the result whether the file to the key exists
 */
- (BOOL)isExistSyncforKey:(NSString *)key;

@end
