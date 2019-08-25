//
//  NGOperacionGestor.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacion.h"

NS_ASSUME_NONNULL_BEGIN

@interface NGOperacionGestor : NGOperacion

-(id)initWithLatitude:(double)lat longitude:(double)lon;

@end

NS_ASSUME_NONNULL_END
