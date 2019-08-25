//
//  UITableView+Reusable.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UITableView+Reusable.h"

@implementation UITableView (Reusable)

-(id)dequeueReusableCellWithClass:(Class)aClass
{
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(aClass) owner:nil options:nil].firstObject;
    }
    return cell;
}

@end
