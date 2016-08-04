//
//  FDDanmakuConstant.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDanmakuConstant : NSObject

#define FDRequestTimeInterval                  18000     //5小时

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

/**
 *  弹幕飞行方向枚举
 */
typedef NS_ENUM(NSInteger , FDDanmakuDirectionType) {
    /**
     *  从右向左
     */
    FDDanmakuDirectionTypeRight,
    /**
     *  从下往上
     */
    FDDanmakuDirectionTypeTop,
    /**
     *  从上往下
     */
    FDDanmakuDirectionTypeBottom
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


/**
 *  弹幕view类型
 */
typedef NS_ENUM(NSInteger, FDDanmakuFrameType) {
    /**
     *  Phone小屏
     */
    FDDanmakuFrameTypePhoneInline,
    /**
     *  Phone全屏
     */
    FDDanmakuFrameTypePhoneFullScreen,
    /**
     *  Pad小屏
     */
    FDDanmakuFrameTypePadInline,
    /**
     *  Pad大屏
     */
    FDDanmakuFrameTypePadFullScreen
};


@end
