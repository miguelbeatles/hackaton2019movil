//
//  NGGestor.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGGestor : NSObject

@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *numEmpleado;
@property (nonatomic, strong) NSString *empleadoID;
@property (nonatomic, strong) NSString *fotoURL;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) double distancia;

-(id)initWithDictionary:(NSDictionary *)dicc;
-(void)consultarFoto;

@end

NS_ASSUME_NONNULL_END
