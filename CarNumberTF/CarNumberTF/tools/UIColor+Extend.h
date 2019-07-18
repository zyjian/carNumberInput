//
//  UIColor+Extend.h
//  TestIOS
//
//  Created by 123 on 15/11/4.
//  Copyright © 2015年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Extend)
/**
 *  Hex string to UIColor. eg. '0x1a2b3c' or '#1a2b3c' or '1a2b3c'"
 */
+ (UIColor*)ColorWithHexString:(NSString*)hexString;
+ (UIColor*)ColorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha;
- (UIColor*)initWithHexString:(NSString*)hexString;
- (UIColor*)initWithHexString:(NSString*)hexString alpha:(CGFloat)alpha;
@end
