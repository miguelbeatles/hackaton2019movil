//
//  NGConsultas_WA.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGConsultas_WA.h"
#import "NGCliente.h"
#import "NGGestor.h"

@implementation NGConsultas_WA

-(id)init
{
    if((self = [super init]))
    {
        serviceUrl = @"http://10.0.15.119:8080";
    }
    
    return self;
}

-(NGCliente *)consultarDatosCliente:(NSString *)clienteID
{
    NGCliente *cliente = nil;
    
    if([self obtenerRespuestaGET:@"clientes" parametro:[NSString stringWithFormat:@"/%@", clienteID]])
    {
        cliente = [[NGCliente alloc] initWithDictionary:json];
    }
    
    return cliente;
}

-(NSArray *)consultarGestoresCercanosLatitude:(double)latitude longitude:(double)longitude
{
    NSArray *gestores = nil;
    
    if([self obtenerRespuestaGET:@"gestores/cercanos" parametro:[NSString stringWithFormat:@"?latitud=%.6f&longitud=%.6f", latitude, longitude]])
    {
        NSArray *arrayAux = [json isKindOfClass:[NSDictionary class]] ? @[json] : [json isKindOfClass:[NSArray class]] ? json : [NSArray array];
        
        NSMutableArray *arrayGestores = [[NSMutableArray alloc] init];
        for(NSDictionary *gestorAux in arrayAux)
        {
            NGGestor *gestor = [[NGGestor alloc] initWithDictionary:gestorAux];
            [arrayGestores addObject:gestor];
        }
        
        if(arrayGestores.count > 0)
        {
            gestores = [[NSArray alloc] initWithArray:arrayGestores];
        }
    }
    
    return gestores;
}

@end
