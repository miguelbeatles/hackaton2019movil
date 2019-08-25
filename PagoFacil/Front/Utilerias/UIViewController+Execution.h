//
//  UIViewController+Execution.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Execution)

-(void)executeBlock:(dispatch_block_t)block completion:(dispatch_block_t)completion;
-(void)showHUDWithTitle:(NSString *)title message:(NSString *)message execution:(dispatch_block_t)execution completion:(dispatch_block_t)completion;

-(void)showMessage:(NSString *)message title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
