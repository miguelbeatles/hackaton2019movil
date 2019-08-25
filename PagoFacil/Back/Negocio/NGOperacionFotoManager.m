//
//  NGOperacionFotoManager.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionFotoManager.h"
#import "NGOperacionFoto.h"

@implementation NGOperacionFotoManager
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

-(void)agregar:(NGOperacionFoto *)operacion
{
    // Si ya existe una operacion en curso, excluir la nueva llamada
    if(![queue.operations containsObject:operacion])
    {
        [queue addOperation:operacion];
    }
}

+(NGOperacionFotoManager *)defaultManager
{
    static dispatch_once_t pred = 0;
    __strong static NGOperacionFotoManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[NGOperacionFotoManager alloc] init];
    });
    return sharedInstance;
}

+(void)agregarOperacion:(NGOperacionFoto *)operacion
{
    NGOperacionFotoManager *manager = [self defaultManager];
    [manager agregar:operacion];
}

@end
