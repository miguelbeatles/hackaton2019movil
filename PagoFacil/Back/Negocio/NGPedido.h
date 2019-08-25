//
//  NGPedido.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGPedido : NSObject

@property (nonatomic, strong) NSString *pedido;
@property (nonatomic, strong) NSString *descripcion;
@property (nonatomic) double saldoActual;
@property (nonatomic) double saldoAbonado;
@property (nonatomic, readonly) double saldoOriginal;

-(id)initWithDictionary:(NSDictionary *)dicc;

@end

NS_ASSUME_NONNULL_END
