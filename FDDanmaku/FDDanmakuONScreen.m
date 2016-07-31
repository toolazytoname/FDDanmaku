//
//  FDDanmakuONScreen.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FDDanmakuONScreen.h"
#import "FDDanmakuConstant.h"
#import "FDDanmakuUtility.h"
#import "FDDanmakuView.h"
#import "FDDanmakuRow.h"
#import "NSArray+FDHelper.h"
#import "NSMutableArray+FDHelper.h"


@interface FDDanmakuONScreen()
/**
*  equals @[self.rowsFlyFromRight,self.rowsFlyFromBottom,self.rowsFlyFromBottom]
*/
@property (nonatomic, strong) NSMutableArray *allDiretionsArray;
@property (nonatomic, strong) NSMutableArray *rowsFlyFromRight;
@property (nonatomic, strong) NSMutableArray *rowsFlyFromBottom;
@property (nonatomic, strong) NSMutableArray *rowsFlyFromTop;

@end

@implementation FDDanmakuONScreen

- (void)addDanmakuView:(FDDanmakuView *)danmakuView row:(NSInteger)row type:(FDDanmakuDirectionType)directionType {
    NSMutableArray *directionArray = [self directionArrayForType:directionType];
    FDDanmakuRow *anmakuRow = [directionArray fd_objectOrNilAtIndex:row];
    [anmakuRow.danmakuViewsArray fd_addObjectOrNil:danmakuView];
}

- (void)removeDanmakuView:(FDDanmakuView *)danmakuView type:(FDDanmakuDirectionType)directionType {
    NSMutableArray *directionArray = [self directionArrayForType:directionType];
    [directionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FDDanmakuRow *danmakuRow = (FDDanmakuRow *)obj;
        if ([danmakuRow.danmakuViewsArray containsObject:danmakuView]) {
            [danmakuRow.danmakuViewsArray removeObject:danmakuView];
        }
    }];
}

- (void)updateCurrentRowsWithFrameType:(FDDanmakuFrameType)frameType {
    NSInteger rowNumber = [FDDanmakuUtility rowNumberWithFrameType:frameType];
    [self updateCurrentRowsToNumber:rowNumber];
}

- (void)removeAllRows {
    [self updateCurrentRowsToNumber:0];
}

- (void)updateCurrentRowsToNumber:(NSInteger)destinationRowNumber {
    [self.allDiretionsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *directionArray = (NSMutableArray *)obj;
        NSInteger currentRowNumber = directionArray.count;
        /**
         *  如果当前存储的rows有多余的，则删除
         */
        if (currentRowNumber > destinationRowNumber) {
            [directionArray removeObjectsInRange:NSMakeRange(destinationRowNumber, currentRowNumber - destinationRowNumber)];
        }
    }];
}

- (void)pause {
//TODO:
    /**
     *  这里能不能直接在最外层的大view，通过遍历子 view，做一次，pause 和resume？不用通过这种方式，获取每一个danmakuView
     *
     */
    [self.allDiretionsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *directionArray = (NSMutableArray *)obj;
        [directionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDDanmakuRow *danmakuRow = (FDDanmakuRow *)obj;
            [danmakuRow.danmakuViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FDDanmakuView *danmakuView = (FDDanmakuView *)obj;
                [FDDanmakuUtility pauseLayer:danmakuView.layer];
            }];
        }];
    }];
}

- (void)resume {
    [self.allDiretionsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *directionArray = (NSMutableArray *)obj;
        [directionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FDDanmakuRow *danmakuRow = (FDDanmakuRow *)obj;
            [danmakuRow.danmakuViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FDDanmakuView *danmakuView = (FDDanmakuView *)obj;
                [FDDanmakuUtility resumeLayer:danmakuView.layer];
            }];
        }];
    }];
}



- (NSMutableArray *)directionArrayForType:(FDDanmakuDirectionType)directionType {
    NSMutableArray *directionArray = nil;
    switch (directionType) {
        case FDDanmakuDirectionTypeRight:
            directionArray = self.rowsFlyFromRight;
            break;
        case FDDanmakuDirectionTypeBottom:
            directionArray = self.rowsFlyFromBottom;
            break;
        case FDDanmakuDirectionTypeTop:
            directionArray = self.rowsFlyFromTop;
            break;
        default:
            break;
    }
    return directionArray;
}


#pragma  mark - lazy load
- (NSMutableArray *)allDiretionsArray {
    if (!_allDiretionsArray) {
        _allDiretionsArray = [NSMutableArray arrayWithObjects:self.rowsFlyFromRight,self.rowsFlyFromBottom,self.rowsFlyFromBottom,nil];
    }
    return _allDiretionsArray;
}

- (NSMutableArray *)rowsFlyFromRight {
    if (!_rowsFlyFromRight) {
        _rowsFlyFromRight = [[NSMutableArray alloc] init];
    }
    return _rowsFlyFromRight;
}

- (NSMutableArray *)rowsFlyFromBottom {
    if (!_rowsFlyFromBottom) {
        _rowsFlyFromBottom = [[NSMutableArray alloc] init];
    }
    return _rowsFlyFromBottom;
}

- (NSMutableArray *)rowsFlyFromTop {
    if (!_rowsFlyFromTop) {
        _rowsFlyFromTop = [[NSMutableArray alloc] init];
    }
    return _rowsFlyFromTop;
}
@end
