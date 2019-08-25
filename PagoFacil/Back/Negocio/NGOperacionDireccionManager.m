//
//  NGOperacionDireccionManager.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionDireccionManager.h"
#import "NGOperacionDireccion.h"

@implementation NGOperacionDireccionManager
{
    NSOperationQueue *queue;
}

-(id)init
{
    if((self = [super init]))
    {
        queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void)agregar:(NGOperacionDireccion *)operacion
{
    [queue cancelAllOperations];
    [queue addOperation:operacion];
}

+(NGOperacionDireccionManager *)defaultManager
{
    static dispatch_once_t pred = 0;
    __strong static NGOperacionDireccionManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[NGOperacionDireccionManager alloc] init];
    });
    return sharedInstance;
}

+(void)agregarOperacion:(NGOperacionDireccion *)operacion
{
    NGOperacionDireccionManager *manager = [self defaultManager];
    [manager agregar:operacion];
}

@end
