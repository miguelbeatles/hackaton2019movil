//
//  UIViewController+Execution.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UIViewController+Execution.h"
#import "MBProgressHUD.h"

@implementation UIViewController (Execution)

-(void)executeBlock:(dispatch_block_t)block completion:(dispatch_block_t)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        block();
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if(completion)
            {
                completion();
            }
        });
    });
}

-(void)showHUDWithTitle:(NSString *)title message:(NSString *)message execution:(dispatch_block_t)execution completion:(dispatch_block_t)completion
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:self.view.window];
    [self.view.window addSubview:hud];
    hud.labelText = title;
    hud.detailsLabelText = message;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES whileExecutingBlock:execution completionBlock:completion];
}

-(void)showMessage:(NSString *)message
{
    [self showMessage:message title:@"Atención"];
}

-(void)showMessage:(NSString *)message title:(NSString *)title
{
    [self showMessage:message title:title button:@"Aceptar"];
}

-(void)showMessage:(NSString *)message title:(NSString *)title button:(NSString *)button
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alert.view.tintColor = [UIColor colorWithRed:63.0/255.0 green:83.0/255.0 blue:121.0/255.0 alpha:1.0];
    [alert addAction:[UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
