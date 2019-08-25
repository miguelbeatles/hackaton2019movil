//
//  NGGoogleApi_WA.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTWebApplication.h"
#import <CoreLocation/CoreLocation.h>

@class NGDireccion;
@class NGRutaGoogle;

NS_ASSUME_NONNULL_BEGIN

@interface NGGoogleApi_WA : UTWebApplication

-(NGDireccion *)getAddressFromLatitude:(double)latitud longitude:(double)longitude;
-(NGRutaGoogle *)getRutaGoogleFromOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination;

@end

NS_ASSUME_NONNULL_END
