//
//  UIColor+Helper.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/31.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "UIColor+FDHelper.h"

@implementation UIColor (FDHelper)
+ (UIColor *)fd_colorWithHexString:(NSString *)hexString {
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([[hexString lowercaseString] hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString length] != 6) {
        return nil;
    }
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexString];
    unsigned hexValue = 0;
    if ([scanner scanHexInt:&hexValue] && [scanner isAtEnd]) {
        int r = ((hexValue & 0xFF0000) >> 16);
        int g = ((hexValue & 0x00FF00) >>  8);
        int b = ( hexValue & 0x0000FF)       ;
        return [self colorWithRed:((float)r / 255)
                            green:((float)g / 255)
                             blue:((float)b / 255)
                            alpha:1.0];
    }
    
    return nil;
}

@end
