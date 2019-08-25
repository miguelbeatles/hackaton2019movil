//
//  NGOperacionGestorManager.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGOperacionGestor;

NS_ASSUME_NONNULL_BEGIN

@interface NGOperacionGestorManager : NSObject

+(void)agregarOperacion:(NGOperacionGestor *)operacion;

@end

NS_ASSUME_NONNULL_END
