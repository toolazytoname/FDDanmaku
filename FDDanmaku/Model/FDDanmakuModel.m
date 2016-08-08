//
//  FDDanmakuModel.m
//  FDDanmakuDemo
//
//  Created by weichao on 16/7/29.
//  Copyright © 2016年 chaowei. All rights reserved.
//

#import "FDDanmakuModel.h"

NSString *const kFDDanmakuModelContent = @"c";
NSString *const kFDDanmakuModelShowTime = @"v";
NSString *const kFDDanmakuModelColor = @"t.c";
NSString *const kFDDanmakuModelSize = @"t.s";
NSString *const kFDDanmakuModelDirectionType = @"t.m";

@implementation FDDanmakuModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.content = [self objectOrNilForKey:kFDDanmakuModelContent fromDictionary:dict];
        self.showTime = [[self objectOrNilForKey:kFDDanmakuModelShowTime fromDictionary:dict] doubleValue];
        
        //color
        unsigned long long hexColor = [[dict valueForKeyPath:kFDDanmakuModelColor] longLongValue];
        if (hexColor > 0) {
            self.color = [NSString stringWithFormat:@"%llx", hexColor];
        }
        //size
        NSString *size = [dict valueForKeyPath:kFDDanmakuModelSize];
        if (size && size.length > 0) {
            if ([size isEqualToString:@"s"]) {
                self.fontSizeType = FDDanmakuFontSizeTypeSmall;
            }
            else if([size isEqualToString:@"m"]) {
                self.fontSizeType = FDDanmakuFontSizeTypeMiddle;
            }
            else if ([size isEqualToString:@"l"]) {
                self.fontSizeType = FDDanmakuFontSizeTypeLarge;
            }
        }
        //direction
        NSString *type = [dict valueForKeyPath:kFDDanmakuModelDirectionType];
        if (type && type.length > 0) {
            if ([type isEqualToString:@"l"]) {
                self.directionType = FDDanmakuDirectionTypeRight;
            }
            else if ([type isEqualToString:@"f"]) {
                self.directionType = FDDanmakuDirectionTypeBottom;
            }
        }
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.content forKey:kFDDanmakuModelContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.showTime] forKey:kFDDanmakuModelShowTime];
    [mutableDict setValue:self.color forKey:kFDDanmakuModelColor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fontSizeType] forKey:kFDDanmakuModelSize];
    [mutableDict setValue:[NSNumber numberWithInteger:self.directionType] forKey:kFDDanmakuModelDirectionType];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.content = [aDecoder decodeObjectForKey:kFDDanmakuModelContent];
    self.showTime = [aDecoder decodeDoubleForKey:kFDDanmakuModelShowTime];
    self.color = [aDecoder decodeObjectForKey:kFDDanmakuModelColor];
    self.fontSizeType = [aDecoder decodeIntegerForKey:kFDDanmakuModelSize];
    self.directionType = [aDecoder decodeIntegerForKey:kFDDanmakuModelDirectionType];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_content forKey:kFDDanmakuModelContent];
    [aCoder encodeDouble:_showTime forKey:kFDDanmakuModelShowTime];
    [aCoder encodeObject:_color forKey:kFDDanmakuModelColor];
    [aCoder encodeInteger:_fontSizeType forKey:kFDDanmakuModelSize];
    [aCoder encodeInteger:_directionType forKey:kFDDanmakuModelDirectionType];
}

- (id)copyWithZone:(NSZone *)zone {
    FDDanmakuModel *copy = [[FDDanmakuModel alloc] init];
    if (copy) {
        copy.content = self.content;
        copy.showTime = self.showTime;
        copy.color = self.color;
        copy.fontSizeType = self.fontSizeType;
        copy.directionType = self.directionType;
    }
    return copy;
}

@end
