//
//  NGGestor.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGGestor.h"
#import "NGOperacionFoto.h"
#import "NGOperacionFotoManager.h"

@implementation NGGestor

-(id)initWithDictionary:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        _nombre = dicc[@"nombre"] ? [[NSString alloc] initWithString:dicc[@"nombre"]] : @"";
        _numEmpleado = dicc[@"numeroEmpleado"] ? [[NSString alloc] initWithString:dicc[@"numeroEmpleado"]] : @"";
        _empleadoID = dicc[@"_id"] ? [[NSString alloc] initWithString:dicc[@"_id"]] : @"";
        _fotoURL = dicc[@"foto"] ? [[NSString alloc] initWithString:dicc[@"foto"]] : @"";
        
        double latitude = dicc[@"latitud"] ? [dicc[@"latitud"] doubleValue] : 0.0;
        double longitude = dicc[@"longitud"] ? [dicc[@"longitud"] doubleValue] : 0.0;
        _location = CLLocationCoordinate2DMake(latitude, longitude);
        _distancia = dicc[@"distancia"] ? [dicc[@"distancia"] doubleValue] : 0.0;
     }
    
    return self;
}

-(void)consultarFoto
{
    if(_fotoURL.length > 0)
    {
        NGOperacionFoto *operacionFoto = [[NGOperacionFoto alloc] initWithID:_empleadoID url:_fotoURL];
        [NGOperacionFotoManager agregarOperacion:operacionFoto];
    }
}

-(BOOL)isEqual:(id)object
{
    NGGestor *gestor = (NGGestor *)object;
    return [gestor.empleadoID isEqualToString:_empleadoID];
}

@end
