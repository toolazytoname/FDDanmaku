//
//  FDDanmakuONScreen.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDDanmakuConstant.h"

@interface FDDanmakuONScreen : NSObject
@property (nonatomic, strong) NSMutableArray *rowsFlyFromRight;
@property (nonatomic, strong) NSMutableArray *rowsFlyFromBottom;

- (void)updateCurrentRowsWithFrameType:(FDDanmakuFrameType)frameType;
- (void)removeAllRows;

- (void)pause;
- (void)resume;
@end
