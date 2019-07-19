//
//  UIColor+Extend.m
//  TestIOS
//
//  Created by 123 on 15/11/4.
//  Copyright © 2015年 ly. All rights reserved.
//

#import "UIColor+Extend.h"


#define kColorConvertErrorHexStringFormat  @"Wrong hex string format.  Should like this:'0x1a2b3c' or '#1a2b3c' or '1a2b3c'"
#define kColorConvertErrorAlphaFormat      @"Wrong alpha value. Must be in [0.0, 1.0], otherwise will be set to 1.0"


@implementation UIColor (Extend)

+ (UIColor*)ColorWithHexString:(NSString *)hexString {
    return [[UIColor alloc] initWithHexString:hexString];
}

+ (UIColor*)ColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithHexString:hexString alpha:alpha];
}

- (UIColor*)initWithHexString:(NSString *)hexString {
    return [self initWithHexString:hexString alpha:1.0];
}

- (UIColor*)initWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    CGFloat _red = 0.0;
    CGFloat _green = 0.0;
    CGFloat _blue = 0.0;
    CGFloat _alpha = 1.0;
    
    //rgb
    if (hexString.length >= 6) {
        NSString *tempString = [hexString lowercaseString];
        if ([tempString hasPrefix:@"0x"]) {
            tempString = [tempString substringFromIndex:2];
        } else if ([tempString hasPrefix:@"#"]) {
            tempString = [tempString substringFromIndex:1];
        } else {
            //--
        }
        
        if (tempString.length == 6) {
            NSScanner *scanner = [[NSScanner alloc] initWithString:tempString];
            uint64_t hexValue = 0;
            if ([scanner scanHexLongLong:&hexValue]) {
                _red = ((hexValue & 0xFF0000) >> 16)/255.0;
                _green = ((hexValue & 0x00FF00) >> 8)/255.0;
                _blue = (hexValue & 0x0000FF)/255.0;
            }
        } else {
            NSLog(kColorConvertErrorHexStringFormat);
        }
    } else {
        NSLog(kColorConvertErrorHexStringFormat);
    }
    
    //alpha
    if (alpha >= 0.0 && alpha <= 1.0) {
        _alpha = alpha;
    } else {
        NSLog(kColorConvertErrorAlphaFormat);
    }
    
    return [self initWithRed:_red green:_green blue:_blue alpha:_alpha];
}

@end
