//
//  FDDanmakuConstant.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDanmakuConstant : NSObject
/**
 *  弹幕类型
 */
typedef NS_ENUM(NSInteger , FDDanmakuType) {
    /**
     *  普通
     */
    FDDanmakuTypeNormal,
    /**
     *  明星
     */
    FDDanmakuTypeStar,
    /**
     *  加精
     */
    FDDanmakuTypeHot,
    /**
     *  自己刚发的
     */
    FDDanmakuTypeSendByMyself
};

typedef NS_ENUM(NSInteger , FDDanmakuFontSizeType){
    FDDanmakuFontSizeTypeSmall,
    FDDanmakuFontSizeTypeMiddle,
    FDDanmakuFontSizeTypeLarge
};

/**
 *  弹幕背景色
 */
typedef NS_ENUM(NSInteger, FDDanmakuShadowColorType) {
    /**
     *  灰
     */
    FDDanmakuShadowColorTypeGray,
    /**
     *  紫
     */
    FDDanmakuShadowColorTypePurple,
    /**
     *  红
     */
    FDDanmakuShadowColorTypeRed,
    /**
     *  黄
     */
    FDDanmakuShadowColorTypeYellow,
    /**
     *  蓝
     */
    FDDanmakuShadowColorTypeBlue,
    /**
     *  绿
     */
    FDDanmakuShadowColorTypeGreen
};



@end
