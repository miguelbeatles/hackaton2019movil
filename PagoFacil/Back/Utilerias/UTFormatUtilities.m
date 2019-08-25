//
//  UTFormatUtilities.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTFormatUtilities.h"

@implementation UTFormatUtilities

+(NSString *)stringFromNumber:(double)number
{
    return [NSString stringWithFormat:@"%@%@", @"$", [UTFormatUtilities stringFromNumber:number decimals:0]];
}

+(NSString *)stringFromNumber:(double)number decimals:(int)decimals
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSNumber *n = [NSNumber numberWithDouble:number];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.roundingMode = NSNumberFormatterRoundDown;
    nf.maximumFractionDigits = decimals;
    nf.locale = locale;
    
    return [NSString stringWithFormat:@"%@", [nf stringFromNumber:n]];
}

@end
