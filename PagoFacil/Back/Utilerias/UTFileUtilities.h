//
//  UTFileUtilities.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UTFileUtilities : NSObject

+(NSString *)documentDirectory;
+(void)createDirectory:(NSString *)directory;
+(BOOL)fileExist:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
