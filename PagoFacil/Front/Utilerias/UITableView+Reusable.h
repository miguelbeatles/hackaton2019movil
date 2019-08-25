//
//  UITableView+Reusable.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Reusable)

-(id)dequeueReusableCellWithClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
