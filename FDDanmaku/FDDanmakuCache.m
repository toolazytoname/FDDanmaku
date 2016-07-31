//
//  FDDanmakuCache.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuCache.h"


static NSString *cacheFolderName = @"DanmakuCache";

@interface FDDanmakuCache()

@property (strong, nonatomic) FDCache *cache;

@end

@implementation FDDanmakuCache

#pragma mark - life cycle
- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - public method
+ (FDDanmakuCache *)sharedDanmakuCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)storeDanmakuToDisk:(NSArray *)DanmakuData key:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion {
    if (!(key) || !(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] key input is invalid");
        return;
    }
    if (!DanmakuData || !(DanmakuData.count > 0)) {
        NSLog(@"[FDDanmakuCache] DanmakuData input is invalid");
        return;
    }
    [self.cache storeAsyncToDiskWithArray:DanmakuData forKey:key withCompletion:^{
        if (completion) {
            completion();
        }
        
    }];
}
#pragma mark - store public end

- (NSArray *)querySyncForKey:(NSString *)key  {
    if (!key || !(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] key input is invalid");
        return nil;
    }
    return [self.cache querySyncforKey:key];
}


- (void)queryAsyncForKey:(NSString *)key  withCompletion:(cacheQueryCompletedBlock)completion {
    if (!key ||!(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] input key is invalid");
        return;
    }
    [self.cache queryAsyncforKey:key withCompletion:completion];
}

- (BOOL)isExistDanmakuForKey:(NSString *)key  {
    if (!key || !(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] input danmakuID is invalid");
        return NO;
    }
    return [self.cache isExistSyncforKey:key];
}

- (void)isExistDanmakuForKey:(NSString *)key  withCompletion:(cacheIsExitCompletedBlock)completion {
    if (!key || !(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] input danmakuID is invalid");
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO);
        });
        return ;
    }
    [self.cache isExistForKey:key withCompletion:completion];
}

- (void)removeDanmakuForKey:(NSString *)key  withCompletion:(cacheNoParamsBlock)completion {
    if (!key|| !(key.length > 0)) {
        NSLog(@"[FDDanmakuCache] input danmakuID is invalid");
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO);
        });
        return ;
    }
    [self.cache removeForKey:key withCompletion:completion];
}

- (void)clearDiskOnCompletion:(cacheNoParamsBlock)completion {
    [self.cache clearDiskOnCompletion:completion];
}


#pragma mark - lazyloader
- (FDCache *)cache {
    if (!_cache) {
        _cache = [[FDCache alloc] initWithFolderName:cacheFolderName];
    }
    return _cache;
}

@end
