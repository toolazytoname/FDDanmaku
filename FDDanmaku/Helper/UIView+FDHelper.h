//
//  UIView+FDHelper.h
//  FDDanmakuDemo
//
//  Created by weichao on 16/8/4.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FDHelper)

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

@end
