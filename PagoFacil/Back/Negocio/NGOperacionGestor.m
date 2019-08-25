//
//  NGOperacionGestor.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionGestor.h"
#import "NGConsultas_WA.h"

NSString *const NGOperacionGestorKey = @"NGOperacionGestorKey";
NSString *const NGOperacionGestorNotification = @"NGOperacionGestorNotification";

@implementation NGOperacionGestor
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
    NGConsultas_WA *consultaWA = [[NGConsultas_WA alloc] init];
    NSArray *gestores = [consultaWA consultarGestoresCercanosLatitude:latitude longitude:longitude];
    
    if(!self.isCancelled)
    {
        NSDictionary *userInfo = @{NGOperacionGestorKey:gestores};
        [[NSNotificationCenter defaultCenter] postNotificationName:NGOperacionGestorNotification object:nil userInfo:userInfo];
    }
}


@end
