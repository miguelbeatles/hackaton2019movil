//
//  NGConsultas_WA.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTWebApplication.h"

@class NGCliente;

NS_ASSUME_NONNULL_BEGIN

@interface NGConsultas_WA : UTWebApplication

-(NGCliente *)consultarDatosCliente:(NSString *)clienteID;
-(NSArray *)consultarGestoresCercanosLatitude:(double)latitude longitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END
