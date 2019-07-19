//
//  UIView+cornerRadiusSetting.h
//  DeviceCheck
//
//  Created by Rick on 17/06/2017.
//  Copyright © 2017 tanson. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface UIView (cornerBorder)

@property (assign, nonatomic) IBInspectable CGFloat rk_cornerRadius;
@property (nonatomic) IBInspectable UIColor *rk_borderColor;
@property (nonatomic) IBInspectable CGFloat rk_borderWidth;

@end
