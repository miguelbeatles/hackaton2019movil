//
//  ConfirmacionViewController.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "ConfirmacionViewController.h"
#import "PFConstants.h"

@interface ConfirmacionViewController ()

@property (nonatomic, strong) IBOutlet UIView *viewContainer;
@property (nonatomic, strong) IBOutlet UIView *viewMapa;
@property (nonatomic, strong) IBOutlet UIView *viewTotales;
@property (nonatomic, strong) IBOutlet UIView *viewEncabezado;

@property (nonatomic, strong) IBOutlet UILabel *lblNombre;
@property (nonatomic, strong) IBOutlet UILabel *lblNumEmpleado;
@property (nonatomic, strong) IBOutlet UILabel *lblTiempo;
@property (nonatomic, strong) IBOutlet UILabel *lblDistancia;
@property (nonatomic, strong) IBOutlet UILabel *lblMensaje;

@property (nonatomic, strong) IBOutlet UIImageView *imgGestor;

@end

@implementation ConfirmacionViewController
{
    GMSMapView *mapa;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]}
                                  forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    [self cargarMapa];
    [self mostrarRuta];
    
    [_viewContainer createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.3];
    
    [_lblMensaje createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.3];
    [_viewTotales createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.3];
    
    [_imgGestor createBorderWithColor:[UIColor clearColor] borderWidth:0.0 cornerRadius:_imgGestor.frame.size.width/2.0];
    
    [_viewEncabezado setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"IMG_fondo_verde.png"]]];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _lblNombre.text = _gestor.nombre;
    _lblNumEmpleado.text = _gestor.numEmpleado;
    _lblTiempo.text = _rutaGoogle.tiempoTotal;
    _lblDistancia.text = _rutaGoogle.distanciaTotal;
    
    [_gestor consultarFoto];
    
    mapa.frame = CGRectMake(0.0, 0.0, _viewMapa.frame.size.width, _viewMapa.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualizarFoto:) name:NGOperacionFotoUpdateNotification object:nil];
    [_gestor consultarFoto];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NGOperacionFotoUpdateNotification object:nil];
}

#pragma mark - Load

-(void)cargarMapa
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_rutaGoogle.origen.latitude longitude:_rutaGoogle.origen.longitude zoom:13];
    mapa = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapa.myLocationEnabled = YES;
    mapa.settings.myLocationButton = YES;
    
    [_viewMapa addSubview:mapa];
    [_viewMapa bringSubviewToFront:_viewTotales];
}

-(void)mostrarRuta
{
    GMSMarker *marcaGestor = [GMSMarker markerWithPosition:_rutaGoogle.origen];
    marcaGestor.title = _gestor.nombre;
    marcaGestor.snippet = _gestor.nombre;
    marcaGestor.icon = [UIImage imageNamed:@"IMG_pin_cobrador.png"];
    marcaGestor.map = self->mapa;
    
    GMSMarker *marcaDestino = [GMSMarker markerWithPosition:_rutaGoogle.destino];
    marcaDestino.icon = [UIImage imageNamed:@"IMG_pin_casa.png"];
    marcaDestino.map = self->mapa;
    
    GMSPath *path = [GMSPath pathFromEncodedPath:_rutaGoogle.polyline];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    polyline.strokeWidth = 5;
    polyline.zIndex = 1;
    polyline.map = mapa;
}

#pragma mark - Notifications

-(void)actualizarFoto:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *pathFoto = userInfo[NGOperacionFotoPathKey];
    NSString *fotoID = userInfo[NGOperacionFotoIDKey];
    
    if([_gestor.empleadoID isEqualToString:fotoID])
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self.imgGestor setImage:[UIImage imageWithContentsOfFile:pathFoto]];
            [self.imgGestor addFadeTransitionWithDuration:0.5];
        });
    }
}

#pragma mark - IBActions

-(IBAction)terminar:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PFClienteViewControllerRegresarNotification object:nil];
}

@end
