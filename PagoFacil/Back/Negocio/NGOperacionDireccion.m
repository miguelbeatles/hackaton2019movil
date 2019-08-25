//
//  NGOperacionDireccion.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionDireccion.h"
#import "NGGoogleApi_WA.h"
#import "NGDireccion.h"

NSString *const NGOperacionDireccionKey = @"NGOperacionDireccionKey";
NSString *const NGOperacionDireccionNotification = @"NGOperacionDireccionNotification";

@implementation NGOperacionDireccion
{
    double latitude;
    double longitude;
}

-(id)initWithLatitude:(double)lat longitude:(double)lon
{
    if((self = [super init]))
    {
        latitude = lat;
        longitude = lon;
    }
    
    return self;
}

-(void)procesarOperacion
{
    NGGoogleApi_WA *googleWA = [[NGGoogleApi_WA alloc] init];
    NGDireccion *direccion = [googleWA getAddressFromLatitude:latitude longitude:longitude];
    
    if(!self.isCancelled)
    {
        NSDictionary *userInfo = @{NGOperacionDireccionKey:direccion};
        [[NSNotificationCenter defaultCenter] postNotificationName:NGOperacionDireccionNotification object:nil userInfo:userInfo];
    }
}

@end
