//
//  UIView+cornerRadiusSetting.m
//  DeviceCheck
//
//  Created by Rick on 17/06/2017.
//  Copyright © 2017 tanson. All rights reserved.
//

#import "UIView+cornerBorder.h"


@implementation UIView (cornerBorder)

- (void)setRk_cornerRadius:(CGFloat)rk_cornerRadius
{
    self.layer.cornerRadius = rk_cornerRadius;
    self.layer.masksToBounds = (rk_cornerRadius != 0);
}

- (CGFloat)rk_cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setRk_borderColor:(UIColor *)rk_borderColor
{
    self.layer.borderColor = rk_borderColor.CGColor;
}

- (UIColor *)rk_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setRk_borderWidth:(CGFloat)rk_borderWidth
{
    self.layer.borderWidth = rk_borderWidth;
}

- (CGFloat)rk_borderWidth
{
    return self.layer.borderWidth;
}
@end
