//
//  UTWebApplication.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, UTWebContentType)
{
    UTWebContentTypeForm,
    UTWebContentTypeJson
};

typedef NS_ENUM(int, UTWebPOSTRequestType)
{
    UTWebPOSTRequestTypeURL,
    UTWebPOSTRequestTypeBody
};

@protocol UTWebApplication <NSObject>
@optional
// Metodos de comunicacion de Web Application
-(BOOL)obtenerRespuestaGET:(NSString *)metodo parametro:(NSString *)parametro;
-(BOOL)obtenerRespuestaGET:(NSString *)metodo parametro:(NSString *)parametro decodificar:(BOOL)decodificar;

-(BOOL)obtenerRespuestaPOST:(NSString *)metodo parametro:(NSString *)parametro;
-(BOOL)obtenerRespuestaPOST:(NSString *)metodo parametro:(NSString *)parametro decodificar:(BOOL)decodificar;

// Metodos de error. Implementar en la clase derivada
-(void)errorConexion:(NSString *)error;
-(void)errorParseo:(NSString *)error;
@end

@interface UTWebApplication : NSObject <UTWebApplication>
{
@protected
    id json;
    UTWebContentType contentType;
    NSString *serviceUrl;
    BOOL checkConnection;
    UTWebPOSTRequestType postRequestType;
}

@property (nonatomic) NSTimeInterval timeOut;
@property (nonatomic, readonly) BOOL foundErrorConexion;
@property (nonatomic, readonly) BOOL foundErrorParseo;

@end
