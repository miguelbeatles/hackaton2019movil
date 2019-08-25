//
//  NGCliente.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGCliente.h"
#import "NGOperacionFoto.h"
#import "NGOperacionFotoManager.h"

@implementation NGCliente

-(id)init
{
    if((self = [super init]))
    {
        _nombre = @"";
        _ID = @"";
        _direccion = nil;
        _pedidos = nil;
        _edad = 0;
        _sexo = NGTipoSexoMasculino;
        _fotoURL = @"";
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        _nombre = dicc[@"nombre"] ? [[NSString alloc] initWithString:dicc[@"nombre"]] : @"";
        _ID = dicc[@"_id"] ? [[NSString alloc] initWithString:dicc[@"_id"]] : @"";
        
        NSDictionary *domicilio = dicc[@"domicilio"] ? dicc[@"domicilio"] : [NSDictionary dictionary];
        if(domicilio.count > 0)
        {
            _direccion = [[NGDireccion alloc] initWithDictionaryCliente:domicilio];
        }
        
        id objAux = dicc[@"pedidos"] ? dicc[@"pedidos"] : nil;
        NSArray *arrayPedidos = [objAux isKindOfClass:[NSDictionary class]] ? @[objAux] : [objAux isKindOfClass:[NSArray class]] ? objAux : nil;
        
        NSMutableArray *pedidosAux = [[NSMutableArray alloc] init];
        for(NSDictionary *pedidoAux in arrayPedidos)
        {
            NGPedido *pedido = [[NGPedido alloc] initWithDictionary:pedidoAux];
            [pedidosAux addObject:pedido];
        }
        
        if(pedidosAux.count > 0)
        {
            _pedidos = [[NSArray alloc] initWithArray:pedidosAux];
        }
        
        _fotoURL = dicc[@"foto"] ? dicc[@"foto"] : @"";
    }
    
    return self;
}

-(double)saldoTotal
{
    NSNumber *saldoTotal = [_pedidos valueForKeyPath:@"@sum.saldoActual"];
    return [saldoTotal doubleValue];
}

-(double)abonadoTotal
{
    NSNumber *saldoAbonado = [_pedidos valueForKeyPath:@"@sum.saldoAbonado"];
    return [saldoAbonado doubleValue];
}

-(void)consultarFoto
{
    if(_fotoURL.length > 0)
    {
        NGOperacionFoto *operacionFoto = [[NGOperacionFoto alloc] initWithID:_ID url:_fotoURL];
        [NGOperacionFotoManager agregarOperacion:operacionFoto];
    }
}

@end
