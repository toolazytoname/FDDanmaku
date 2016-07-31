//
//  FileDiskCache.m
//  VideoPlayer
//
//  Created by weichao on 16/7/15.
//
//


#import "FDCache.h"
#import <CommonCrypto/CommonDigest.h>
/*** MD5 ***/
#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */

static char *ioQueuelabel = "com.FDCache";
static NSString *defaultFolderName = @"FDCache";

@interface FDCache()

@property (strong, nonatomic) NSString *diskCachePath;
@property (strong, nonatomic) NSString *folderName;
@property (strong, nonatomic) dispatch_queue_t ioQueue;
@property (strong, nonatomic) NSFileManager *fileManager;

@end

@implementation FDCache

+ (FDCache *)sharedCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (FDCache *)init {
    self = [self initWithFolderName:defaultFolderName];
    return self;
}


- (FDCache *)initWithFolderName:(NSString *)folderName {
    self = [super init];
    if (self) {
        if (folderName && folderName.length > 0) {
            self.folderName = folderName;
        }
    }
    return self;
}

#pragma mark - store
- (void)storeAsyncToDiskWithArray:(NSArray *)arrayToStore forKey:(NSString *)key withCompletion:(cacheNoParamsBlock)completion {
    if (!key || !(key.length > 0)) {
        NSLog(@"[FileDiskCache] input key is invalid");
        return;
    }
    if (!arrayToStore || !(arrayToStore.count > 0)) {
        NSLog(@"[FileDiskCache] arrayToStore input is invalid");
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(weakSelf.ioQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf storeSyncToDiskWithArray:arrayToStore forKey:key];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

- (void)storeSyncToDiskWithArray:(NSArray *)arrayToStore forKey:(NSString *)key {
    if (!arrayToStore || !(arrayToStore.count > 0)) {
        return;
    }
    if (!key || !(key.length > 0)) {
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrayToStore];
    [self storeSyncToDiskWithData:data forKey:key];
}

- (void)storeSyncToDiskWithData:(NSData *)dataToStore forKey:(NSString *)key {
    if (!dataToStore) {
        return;
    }
    if (!key || !(key.length > 0)) {
        return;
    }
    if (![self.fileManager fileExistsAtPath:self.diskCachePath]) {
        [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    NSString *cacheFilePath = [self cacheFilePathforKey:key];
    [self.fileManager createFileAtPath:cacheFilePath contents:dataToStore attributes:nil];
}

#pragma mark - remove
- (void)removeForKey:(NSString *)key withCompletion:(cacheNoParamsBlock)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *cacheFilePath = [strongSelf cacheFilePathforKey:key];
        [strongSelf.fileManager removeItemAtPath:cacheFilePath error:nil];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}


#pragma mark - clear
- (void)clearDiskOnCompletion:(cacheNoParamsBlock)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.fileManager removeItemAtPath:strongSelf.diskCachePath error:nil];
        [strongSelf.fileManager createDirectoryAtPath:strongSelf.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:nil];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

#pragma mark - query
- (void)queryAsyncforKey:(NSString *)key withCompletion:(cacheQueryCompletedBlock)completion {
    if (!key || !(key.length > 0)) {
        completion(nil);
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSArray *queryResultArray = [strongSelf querySyncforKey:key];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(queryResultArray);
            });
        }
    });
}

- (NSArray *)querySyncforKey:(NSString *)key {
    if (!key || !(key.length > 0)) {
        return nil;
    }
    NSString *cacheFilePath = [self cacheFilePathforKey:key];
    NSArray *dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFilePath];
    return dataArray;
}

#pragma mark - exist
- (void)isExistForKey:(NSString *)key withCompletion:(cacheIsExitCompletedBlock)completion {
    if (!completion) {
        NSLog(@"[FileDiskCache] input completion is invalid");
    }
    if (!key || !(key.length > 0) ) {
        NSLog(@"[FileDiskCache] input key is invalid");
        if (completion) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.ioQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL exist = [strongSelf isExistSyncforKey:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(exist);
        });
    });
    
}

- (BOOL)isExistSyncforKey:(NSString *)key {
    if (!key || !(key.length > 0)) {
        return NO;
    }
    BOOL isExist = NO;
    NSString *cacheFilePath = [self cacheFilePathforKey:key];
    isExist = [self.fileManager fileExistsAtPath:cacheFilePath];
    return isExist;
}

#pragma mark - private
- (NSString *)cacheFilePathforKey:(NSString *)key {
    NSString *fileName = [self cacheFileNameForKey:key];
    return [self.diskCachePath stringByAppendingPathComponent:fileName];
}

- (NSString *)cacheFileNameForKey:(NSString *)key {
    if (!key || !(key.length > 0)) {
        return nil;
    }
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

#pragma mark - lazyloader
- (dispatch_queue_t)ioQueue {
    if (!_ioQueue) {
        _ioQueue = dispatch_queue_create(ioQueuelabel, DISPATCH_QUEUE_SERIAL);
    }
    return _ioQueue;
}

- (NSString *)diskCachePath {
    if (!_diskCachePath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:self.folderName];
    }
    return _diskCachePath;
}

- (NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [NSFileManager new];
    }
    return _fileManager;
}

- (NSString *)folderName {
    if ((!_folderName)) {
        _folderName = [[NSString alloc] initWithString:defaultFolderName];
    }
    return _folderName;
}
@end
