//
//  MapaViewController.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

#import "MapaViewController.h"
#import "DireccionViewController.h"
#import "PFConstants.h"
#import "PFNegocio.h"
#import "ConfirmacionViewController.h"

@interface MapaViewController () <GMSMapViewDelegate, CLLocationManagerDelegate, DireccionViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *viewMapa;
@property (nonatomic, strong) IBOutlet UIView *viewDireccion;
@property (nonatomic, strong) IBOutlet UIImageView *imgPin;

@end

@implementation MapaViewController
{
    GMSMapView *mapa;
    GMSCircle *circle;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D lastLocation;
    
    DireccionViewController *direccionViewController;
    ConfirmacionViewController *confirmacionViewController;
    NSMutableArray *marcas;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        lastLocation = CLLocationCoordinate2DMake(0.0, 0.0);
        direccionViewController = nil;
        confirmacionViewController = nil;
        circle = nil;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]}
                                  forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.title = @"Busca a tu gestor";
    
    marcas = [[NSMutableArray alloc] init];
    
    [self startLocation];
    [self cargarMapa];
    [self cargarDireccion];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [locationManager startUpdatingLocation];
    mapa.frame = CGRectMake(0.0, 0.0, _viewMapa.frame.size.width, _viewMapa.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cargarGestores:) name:NGOperacionGestorNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self centrarMapa];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [locationManager stopUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Load

-(void)cargarMapa
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lastLocation.latitude longitude:lastLocation.longitude zoom:15];
    mapa = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapa.myLocationEnabled = YES;
    mapa.settings.myLocationButton = YES;
    mapa.delegate = self;
    
    [_viewMapa addSubview:mapa];
    [_viewMapa bringSubviewToFront:_imgPin];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)cargarDireccion
{
    direccionViewController = [[DireccionViewController alloc] init];
    [self addChildViewController:direccionViewController];
    [_viewDireccion addSubview:direccionViewController.view];
    [direccionViewController didMoveToParentViewController:self];
    direccionViewController.delegate = self;
    
    [_viewDireccion createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.5 cornerRadius:1.3];
}

-(void)cargarGestores:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        [self limpiarMapa];
        
        NSDictionary *userInfo = notification.userInfo;
        NSArray *gestores = userInfo[NGOperacionGestorKey];
        
        for(NGGestor *gestor in gestores)
        {
            GMSMarker *marca = [GMSMarker markerWithPosition:gestor.location];
            marca.title = gestor.nombre;
            marca.snippet = gestor.nombre;
            marca.icon = [UIImage imageNamed:@"IMG_pin_cobrador.png"];
            marca.userData = gestor;
            marca.map = self->mapa;
            [self->marcas addObject:marca];
        }
    });
}

-(UIImage *)markerWithColor
{
    NSString *iconName = @"IMG_pin_cobrador.png";
    UIImage *icon = [UIImage imageNamed:iconName];
    
    UIGraphicsBeginImageContext(icon.size);
    [icon drawInRect:CGRectMake(0, 0, 40.0, 40.0)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

-(void)limpiarMapa
{
    for(GMSMarker *mark in marcas)
    {
        mark.map = nil;
    }
    
    [marcas removeAllObjects];
//    [mapa clear];
}

#pragma mark - IBActions

-(IBAction)posicionarUbicacionActual:(id)sender
{
    [self centrarMapa];
}

#pragma mark - Mapa

-(void)centrarMapa
{
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:lastLocation zoom:15];
    [mapa animateWithCameraUpdate:cameraUpdate];
    
    [self mostrarRadio:lastLocation];
}

-(void)mostrarRadio:(CLLocationCoordinate2D)location
{
    if(!circle)
    {
        circle = [GMSCircle circleWithPosition:location radius:1000.0];
        circle.fillColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.1];
        circle.strokeColor = [UIColor colorWithRed:1.0 green:153.0/255.0 blue:51.0/255.0 alpha:0.5];
        circle.strokeWidth = 2.5;
        circle.map = mapa;
    }
    else
    {
        circle.position = location;
    }
    
    NGOperacionGestor *operacionGestor = [[NGOperacionGestor alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [NGOperacionGestorManager agregarOperacion:operacionGestor];
}

#pragma mark - GMSMapViewDelegate

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    return YES;
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    return nil;
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    [direccionViewController actualizarDireccionWithLatitude:position.target.latitude longitude:position.target.longitude];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude);
    [self mostrarRadio:location];
}

#pragma mark - CoreLocation

-(void)startLocation
{
    locationManager = [[CLLocationManager alloc] init];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.0f;
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"Please authorize location services");
        return;
    }
    
    NSLog(@"CLLocationManager error: %@", error.localizedFailureReason);
    return;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location: didUpdateLocations");
    
    CLLocation *location = [locations lastObject];
    lastLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
}

#pragma mark - DireccionViewControllerDelegate

-(void)direccionViewControllerConfirmar
{
    __block NGGestor *gestor = nil;
    __block NGRutaGoogle *rutaGoogle = nil;
    
    [self showHUDWithTitle:@"Buscando a gestores cercanos" message:@"Espere un momento" execution:^{
        
        if([self->marcas count] > 0)
        {
            gestor = ((GMSMarker *)self->marcas[0]).userData;
            
            CLLocationCoordinate2D origen = CLLocationCoordinate2DMake(self->mapa.camera.target.latitude, self->mapa.camera.target.longitude);
            CLLocationCoordinate2D destino = CLLocationCoordinate2DMake(gestor.location.latitude, gestor.location.longitude);
            
            NGGoogleApi_WA *googleWA = [[NGGoogleApi_WA alloc] init];
            rutaGoogle = [googleWA getRutaGoogleFromOrigin:origen destination:destino];
            if(rutaGoogle)
            {
                rutaGoogle.origen = origen;
                rutaGoogle.destino = destino;
            }
        }
        
    } completion:^{
        
        if(gestor && rutaGoogle)
        {
            self->confirmacionViewController = [[ConfirmacionViewController alloc] init];
            self->confirmacionViewController.gestor = gestor;
            self->confirmacionViewController.rutaGoogle = rutaGoogle;
            [self.navigationController pushViewController:self->confirmacionViewController animated:YES];
        }
        else
        {
            [self showMessage:@"No se encontraron gestores cercanos.\nInténtelo mas tarde" title:@"Atención"];
        }
    }];
}

@end
