//
//  NGDireccion.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGDireccion.h"

@implementation NGDireccion

-(id)init
{
    if((self = [super init]))
    {
        _calle = @"";
        _colonia = @"";
        _municipio = @"";
        _estado = @"";
        _pais = @"";
        _cp = @"";
        _numExt = @"";
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        NSArray *addressComponents = dicc[@"address_components"];
        for(NSDictionary *component in addressComponents)
        {
            NSArray *arrayTipo = component[@"types"];
            NSString *stringDato = component[@"long_name"];
            
            if([arrayTipo containsObject:@"street_number"])
               _numExt = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"route"] )
                _calle = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"neighborhood"] || [arrayTipo containsObject:@"sublocality"] || [arrayTipo containsObject:@"sublocality_level_1"])
                _colonia = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"locality"] )
                _municipio = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"administrative_area_level_1"] )
                _estado = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"country"] )
                _pais = [[NSString alloc] initWithString:stringDato];
            else if( [arrayTipo containsObject:@"postal_code"] )
                _cp = [[NSString alloc] initWithString:stringDato];
        }
        
        _formatDireccion = dicc[@"formatted_address"] ? [[NSString alloc] initWithString:dicc[@"formatted_address"]] : @"";
    }
    
    return self;
}

-(id)initWithDictionaryCliente:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        _calle = dicc[@"calle"] ? [[NSString alloc] initWithString:dicc[@"calle"]] : @"";
        _numExt = dicc[@"numero"] ? [[NSString alloc] initWithString:dicc[@"numero"]] : @"";
        _colonia = dicc[@"colonia"] ? [[NSString alloc] initWithString:dicc[@"colonia"]] : @"";
        _municipio = dicc[@"poblacion"] ? [[NSString alloc] initWithString:dicc[@"poblacion"]] : @"";
        _cp = dicc[@"cp"] ? [[NSString alloc] initWithString:dicc[@"cp"]] : @"";
        
        _formatDireccion = [NSString stringWithFormat:@"%@ %@, %@, %@, %@, México", _calle, _numExt, _colonia, _municipio, _cp];
    }
    
    return self;
}

@end
