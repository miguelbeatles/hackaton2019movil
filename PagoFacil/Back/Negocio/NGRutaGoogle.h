//
//  NGRutaGoogle.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGRutaGoogle : NSObject

@property (nonatomic) CLLocationCoordinate2D origen;
@property (nonatomic) CLLocationCoordinate2D destino;
@property (nonatomic, strong) NSString *polyline;
@property (nonatomic, strong) NSString *tiempoTotal;
@property (nonatomic, strong) NSString *distanciaTotal;

-(id)initWithDictionary:(NSDictionary *)dicc;

@end

NS_ASSUME_NONNULL_END
