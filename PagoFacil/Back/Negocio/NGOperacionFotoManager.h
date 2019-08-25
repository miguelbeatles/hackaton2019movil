//
//  NGOperacionFotoManager.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGOperacionFoto;

NS_ASSUME_NONNULL_BEGIN

@interface NGOperacionFotoManager : NSObject

+(void)agregarOperacion:(NGOperacionFoto *)operacion;

@end

NS_ASSUME_NONNULL_END
