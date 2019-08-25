//
//  UIViewController+MessageAddition.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UIViewController+MessageAddition.h"

@implementation UIViewController(Message)

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
