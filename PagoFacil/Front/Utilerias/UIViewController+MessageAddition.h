//
//  UIViewController+MessageAddition.h
//  
//
//  Created by Gildardo Azcarate on 10/12/15.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController(Message)

-(void)showMessage:(NSString *)message; // title = "Atención" button = "Aceptar"
-(void)showMessage:(NSString *)message title:(NSString *)title; // button = "Aceptar"
-(void)showMessage:(NSString *)message title:(NSString *)title button:(NSString *)button;

@end
