//
//  NGOperacionGestorManager.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionGestorManager.h"
#import "NGOperacionGestor.h"

@implementation NGOperacionGestorManager
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

-(void)agregar:(NGOperacionGestor *)operacion
{
    [queue cancelAllOperations];
    [queue addOperation:operacion];
}

+(NGOperacionGestorManager *)defaultManager
{
    static dispatch_once_t pred = 0;
    __strong static NGOperacionGestorManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[NGOperacionGestorManager alloc] init];
    });
    return sharedInstance;
}

+(void)agregarOperacion:(NGOperacionGestor *)operacion
{
    NGOperacionGestorManager *manager = [self defaultManager];
    [manager agregar:operacion];
}

@end
