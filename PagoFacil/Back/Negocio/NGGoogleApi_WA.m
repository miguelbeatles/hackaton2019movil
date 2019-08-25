//
//  NGGoogleApi_WA.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGGoogleApi_WA.h"
#import "NGDireccion.h"
#import "NGRutaGoogle.h"

#define kGoogleKey  @"AIzaSyAndF_bbK1xXbymv0c34tNxhiExL4hrZwQ"

@implementation NGGoogleApi_WA

-(id)init
{
    if((self = [super init]))
    {
        
    }
    
    return self;
}

-(NGDireccion *)getAddressFromLatitude:(double)latitude longitude:(double)longitude
{
    serviceUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%.6f,%.6f&sensor=true&key=%@&language=es", latitude, longitude, kGoogleKey];
    
    NGDireccion *direccion = nil;
    
    if([self obtenerRespuestaGET:@"" parametro:@""])
    {
        NSString *response = json[@"status"] ? json[@"status"] : @"";
        if([response isEqualToString:@"OK"])
        {
            NSArray *results = json[@"results"] ? json[@"results"] : [NSArray array];
            if(results.count > 0)
            {
                direccion = [[NGDireccion alloc] initWithDictionary:results[0]];
            }
        }
    }
    
    return direccion;
}

-(NGRutaGoogle *)getRutaGoogleFromOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination
{
    serviceUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%.6f,%.6f&destination=%.6f, %.6f&sensor=true&language=es&key=%@", origin.latitude, origin.longitude, destination.latitude, destination.longitude, kGoogleKey];
    
    NGRutaGoogle *rutaGoogle = nil;
    
    if([self obtenerRespuestaGET:@"" parametro:@""])
    {
        NSString *response = json[@"status"] ? json[@"status"] : @"";
        if([response isEqualToString:@"OK"])
        {
            NSArray *routes = json[@"routes"] ? json[@"routes"] : [NSArray array];
            if(routes.count > 0)
            {
                rutaGoogle = [[NGRutaGoogle alloc] initWithDictionary:routes[0]];
            }
        }
    }
    
    return rutaGoogle;
}

@end
