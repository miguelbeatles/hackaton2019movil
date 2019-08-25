//
//  UTWebApplication.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTWebApplication.h"
#import "UTReachability.h"

@implementation UTWebApplication

-(id)init
{
    if((self = [super init]))
    {
        json                = nil;
        contentType         = UTWebContentTypeForm;
        postRequestType     = UTWebPOSTRequestTypeBody;
        serviceUrl          = @"";
        checkConnection     = YES;
        _timeOut            = 60;
        _foundErrorConexion = NO;
        _foundErrorParseo   = NO;
    }
    return self;
}

#pragma mark - Metodos de comunicacion de Web Application

-(BOOL)obtenerRespuestaGET:(NSString *)metodo parametro:(NSString *)parametro
{
    return [self obtenerRespuestaGET:metodo parametro:parametro decodificar:NO];
}

-(BOOL)obtenerRespuestaGET:(NSString *)metodo parametro:(NSString *)parametro decodificar:(BOOL)decodificar
{
    [self limpiarRespuesta];
    if(checkConnection && ![UTReachability netConnection])
    {
        _foundErrorConexion = YES;
        [self errorConexion:@"No se cuenta con cobertura para realizar la operacion"];
        return NO;
    }
    
    NSMutableString *urlFinal = [[NSMutableString alloc] initWithString:[serviceUrl stringByAppendingPathComponent:metodo]];
    [urlFinal appendString:parametro];
    
//    NSURL *url = [NSURL URLWithString:[urlFinal stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]];
    
    NSURL *url = [NSURL URLWithString:[urlFinal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    urlRequest.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    urlRequest.timeoutInterval = _timeOut;
    
    NSError *error = nil;
    NSURLResponse *urlResponse = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];
    if(!data)
    {
        _foundErrorConexion = YES;
        [self errorConexion:[NSString stringWithFormat:@"Error al consultar el servicio: %@", error.localizedDescription]];
        return NO;
    }
    
    json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(!json)
    {
        _foundErrorParseo = YES;
        [self errorParseo:[NSString stringWithFormat:@"Error al decodificar el objeto json: %@", error.localizedDescription]];
        return NO;
    }
    
    return YES;
}

-(BOOL)obtenerRespuestaPOST:(NSString *)metodo parametro:(NSString *)parametro
{
    return [self obtenerRespuestaPOST:metodo parametro:parametro decodificar:NO];
}

-(BOOL)obtenerRespuestaPOST:(NSString *)metodo parametro:(NSString *)parametro decodificar:(BOOL)decodificar
{
    [self limpiarRespuesta];
    if(checkConnection && ![UTReachability netConnection])
    {
        _foundErrorConexion = YES;
        [self errorConexion:@"No se cuenta con cobertura para realizar la operacion"];
        return NO;
    }
    
    NSString *urlFinal = [serviceUrl stringByAppendingPathComponent:metodo];
    NSData *dataPeticion = nil;
    
    if (postRequestType == UTWebPOSTRequestTypeBody)
    {
        dataPeticion = [parametro dataUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        dataPeticion = [NSData data]; // Para HTTPBody vacío
        urlFinal = [NSString stringWithFormat:@"%@?%@",urlFinal,parametro];
    }
    
    NSURL *url = [NSURL URLWithString:[urlFinal stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]];
    //NSURL *url = [NSURL URLWithString:[urlFinal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    if(contentType == UTWebContentTypeForm)
    {
        [urlRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    else
    {
        //[urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    [urlRequest addValue:[NSString stringWithFormat:@"%d", (int)dataPeticion.length] forHTTPHeaderField:@"Content-Length"];
    urlRequest.HTTPMethod = @"POST";
    urlRequest.HTTPBody = dataPeticion;
    urlRequest.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    urlRequest.timeoutInterval = _timeOut;
    
    NSError *error = nil;
    NSURLResponse *urlResponse;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];
    if(!data)
    {
        _foundErrorConexion = YES;
         [self errorConexion:[NSString stringWithFormat:@"Error al consultar el servicio: %@", error.localizedDescription]];
        return NO;
    }
    
    json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(!json)
    {
        _foundErrorParseo = YES;
        [self errorParseo:[NSString stringWithFormat:@"Error al decodificar el objeto json: %@", error.localizedDescription]];
        return NO;
    }
    
    return YES;
}

-(void)limpiarRespuesta
{
    _foundErrorConexion = NO;
    _foundErrorParseo = NO;
    json = nil;
}

#pragma mark - Metodos de error. Implementar en la clase derivada

-(void)errorConexion:(NSString *)error
{
    NSLog(@"%@", error);
}

-(void)errorParseo:(NSString *)error
{
    NSLog(@"%@", error);
}

@end
