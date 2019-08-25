//
//  DireccionViewController.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DireccionViewControllerDelegate <NSObject>

-(void)direccionViewControllerConfirmar;

@end

@interface DireccionViewController : UIViewController

@property (nonatomic, assign) id<DireccionViewControllerDelegate>delegate;

-(void)actualizarDireccionWithLatitude:(double)latitude longitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END
