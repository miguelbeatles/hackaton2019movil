//
//  UIView+BorderAddition.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UIView+BorderAddition.h"

@implementation UIView (BorderAddition)

-(void)createBorderWithColor:(UIColor *)borderColor shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius
{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.clipsToBounds = NO;
}

-(void)createBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.clipsToBounds = YES;
}

-(void)addFadeTransitionWithDuration:(CFTimeInterval)duration
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = duration;
    [self.layer addAnimation:transition forKey:nil];
}

@end
