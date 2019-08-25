//
//  NGOperacionFoto.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "NGOperacionFoto.h"
#import "UTFileUtilities.h"

NSString *const NGOperacionFotoIDKey = @"NGOperacionFotoIDKey";
NSString *const NGOperacionFotoPathKey = @"NGOperacionFotoPathKey";
NSString *const NGOperacionFotoUpdateNotification = @"NGOperacionFotoUpdateNotification";

@implementation NGOperacionFoto
{
    NSString *fotoID;
    NSString *strURL;
    NSString *fotoDirectory;
}

-(id)init
{
    if((self = [super init]))
    {
        fotoID = @"";
        strURL = @"";
        fotoDirectory = @"Fotos";
    }
    
    return self;
}

-(id)initWithID:(NSString *)strID url:(NSString *)url
{
    if((self = [super init]))
    {
        fotoID = [[NSString alloc] initWithFormat:@"%@.png", strID];
        strURL = [[NSString alloc] initWithString:url];
        fotoDirectory = @"Fotos";
    }
    
    return self;
}

-(void)procesarOperacion
{
    [UTFileUtilities createDirectory:fotoDirectory];
    NSString *pathFoto = [fotoDirectory stringByAppendingPathComponent:fotoID];
    NSString *pathCompleto = [[UTFileUtilities documentDirectory] stringByAppendingPathComponent:pathFoto];
    
    if([UTFileUtilities fileExist:pathFoto])
    {
        pathCompleto = [[UTFileUtilities documentDirectory] stringByAppendingPathComponent:pathFoto];
    }
    else
    {
        NSString *finalURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *foto = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalURL]];
        if(foto)
        {
            [foto writeToFile:pathCompleto atomically:YES];
        }
        else
        {
            pathCompleto = [[NSBundle mainBundle] pathForResource:@"IMG_avatar" ofType:@"jpg"];
        }
    }
    
    NSDictionary *userInfo = @{NGOperacionFotoIDKey:[fotoID stringByReplacingOccurrencesOfString:@".png" withString:@""], NGOperacionFotoPathKey:pathCompleto};
    [[NSNotificationCenter defaultCenter] postNotificationName:NGOperacionFotoUpdateNotification object:nil userInfo:userInfo];
}

-(BOOL)isEqual:(id)object
{
    NSString *objFoto = object;
    return [fotoID isEqualToString:objFoto];
}

@end
