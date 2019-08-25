//
//  NGDireccion.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGDireccion : NSObject

@property (nonatomic, strong) NSString *calle;
@property (nonatomic, strong) NSString *colonia;
@property (nonatomic, strong) NSString *municipio;
@property (nonatomic, strong) NSString *estado;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *cp;
@property (nonatomic, strong) NSString *numExt;
@property (nonatomic, strong) NSString *formatDireccion;

-(id)initWithDictionary:(NSDictionary *)dicc;
-(id)initWithDictionaryCliente:(NSDictionary *)dicc;

@end

NS_ASSUME_NONNULL_END
