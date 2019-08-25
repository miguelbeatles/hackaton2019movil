//
//  UIView+BorderAddition.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BorderAddition)

-(void)createBorderWithColor:(UIColor *)borderColor shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius;
-(void)createBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
-(void)addFadeTransitionWithDuration:(CFTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
