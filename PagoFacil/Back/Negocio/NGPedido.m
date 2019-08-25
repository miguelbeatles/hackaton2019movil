//
//  NGPedido.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGPedido.h"

@implementation NGPedido

-(id)init
{
    if((self = [super init]))
    {
        _saldoActual = 0.0;
        _saldoAbonado = 0.0;
        _pedido = @"";
        _descripcion = @"";
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dicc
{
    if((self = [super init]))
    {
        _saldoActual = dicc[@"saldo"] ? [dicc[@"saldo"] doubleValue] : 0.0;
        _saldoAbonado = dicc[@"abonado"] ? [dicc[@"abonado"] doubleValue] : 0.0;
        _pedido = dicc[@"idPedido"] ? [[NSString alloc] initWithFormat:@"%.0f", [dicc[@"idPedido"] doubleValue]] : @"";
        _descripcion = dicc[@"descripcion"] ? [[NSString alloc] initWithString:dicc[@"descripcion"]] : @"";
    }
    
    return self;
}

-(double)saldoOriginal
{
    return _saldoActual + _saldoAbonado;
}

@end
