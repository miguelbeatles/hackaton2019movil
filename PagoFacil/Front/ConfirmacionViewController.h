//
//  ConfirmacionViewController.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PFNegocio.h"

@interface ConfirmacionViewController : UIViewController

@property (nonatomic, strong) NGRutaGoogle *rutaGoogle;
@property (nonatomic, strong) NGGestor *gestor;

@end
