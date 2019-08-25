//
//  NGCliente.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGEnum.h"
#import "NGDireccion.h"
#import "NGPedido.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGCliente : NSObject

@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NGDireccion *direccion;
@property (nonatomic, strong) NSArray *pedidos;
@property (nonatomic) NSInteger edad;
@property (nonatomic) NGTipoSexo sexo;
@property (nonatomic, strong) NSString *fotoURL;

-(id)initWithDictionary:(NSDictionary *)dicc;

-(double)saldoTotal;
-(double)abonadoTotal;
-(void)consultarFoto;

@end

NS_ASSUME_NONNULL_END
