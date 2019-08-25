//
//  NGOperacion.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NGOperacion <NSObject>
@required
-(void)procesarOperacion;
@end

@interface NGOperacion : NSInvocationOperation <NGOperacion>

@end

NS_ASSUME_NONNULL_END
