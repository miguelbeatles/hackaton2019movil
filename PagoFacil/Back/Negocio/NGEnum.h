//
//  NGEnum.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#ifndef NGEnum_h
#define NGEnum_h

typedef NS_ENUM(int, NGTipoSexo)
{
    NGTipoSexoMasculino = 1,
    NGTipoSexoFemenino = 2
};

extern NSString *const NGOperacionFotoIDKey;
extern NSString *const NGOperacionFotoPathKey;
extern NSString *const NGOperacionFotoUpdateNotification;

extern NSString *const NGOperacionDireccionKey;
extern NSString *const NGOperacionDireccionNotification;

extern NSString *const NGOperacionGestorKey;
extern NSString *const NGOperacionGestorNotification;

#endif /* NGEnum_h */
