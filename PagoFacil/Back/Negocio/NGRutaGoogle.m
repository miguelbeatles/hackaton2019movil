//
//  NGRutaGoogle.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGRutaGoogle.h"

@implementation NGRutaGoogle

-(id)initWithDictionary:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        [self obtenerDatosTotales:dicc];
        [self obtenerPolyline:dicc];
    }
    
    return self;
}

-(void)obtenerDatosTotales:(NSDictionary *)dicc
{
    NSArray *arrayLegs = dicc[@"legs"];
    if(arrayLegs.count > 0)
    {
        [self obtenerDatosTotalosDeDiccionario:arrayLegs[0]];
    }
}

-(void)obtenerDatosTotalosDeDiccionario:(NSDictionary *)diccPaso
{
    NSDictionary *diccDistance = diccPaso[@"distance"] ? diccPaso[@"distance"] : nil;
    NSDictionary *diccDuration = diccPaso[@"duration"] ? diccPaso[@"duration"] : nil;
    
    if(diccDistance && diccDuration)
    {
        _distanciaTotal = diccDistance[@"text"] ? [[NSString alloc] initWithString:diccDistance[@"text"]] : @"";
        _tiempoTotal = diccDuration[@"text"] ? [[NSString alloc] initWithString:diccDuration[@"text"]] : @"";
    }
}

- (void)obtenerPolyline:(NSDictionary *)diccRuta
{
    NSDictionary *diccOverview = diccRuta[@"overview_polyline"];
    if(diccOverview.count > 0)
    {
        _polyline = diccOverview[@"points"] ?  [[NSString alloc] initWithString:diccOverview[@"points"]] : @"";
    }
}

@end
