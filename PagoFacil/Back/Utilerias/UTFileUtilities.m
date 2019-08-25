//
//  UTFileUtilities.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTFileUtilities.h"

@implementation UTFileUtilities

+(NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

+(void)createDirectory:(NSString *)directory
{
    NSString *path = [[self documentDirectory] stringByAppendingPathComponent:directory];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:path])
    {
        NSError *error = nil;
        if(![fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error])
        {
            NSLog(@"No se pudo crear la carpeta %@: %@", directory, error.localizedDescription);
        }
    }
}

+(BOOL)fileExist:(NSString *)filename
{
    NSString *path = [[self documentDirectory] stringByAppendingPathComponent:filename];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
