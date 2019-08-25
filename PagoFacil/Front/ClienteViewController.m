//
//  ClienteViewController.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "ClienteViewController.h"
#import "MapaViewController.h"
#import "PFConstants.h"
#import "PedidoTableViewCell.h"
#import "PFUtilerias.h"

NSString *const PFClienteViewControllerRegresarNotification = @"PFClienteViewControllerRegresarNotification";

@interface ClienteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *viewNombre;
@property (nonatomic, strong) IBOutlet UIView *viewDireccion;
@property (nonatomic, strong) IBOutlet UIView *viewPedidos;
@property (nonatomic, strong) IBOutlet UIView *viewBotones;

@property (nonatomic, strong) IBOutlet UILabel *lblNombre;
@property (nonatomic, strong) IBOutlet UILabel *lblID;
@property (nonatomic, strong) IBOutlet UILabel *lblDireccion;
@property (nonatomic, strong) IBOutlet UILabel *lblSaldoTotal;

@property (nonatomic, strong) IBOutlet UITableView *tableviewPedidos;
@property (nonatomic, strong) IBOutlet UIImageView *imgCliente;

@end

@implementation ClienteViewController
{
    MapaViewController *mapaViewController;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        mapaViewController = nil;
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
    
    [_viewDireccion createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.0];
    [_viewPedidos createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.0];
    [_viewBotones createBorderWithColor:[UIColor clearColor] shadowColor:[UIColor blackColor] shadowOpacity:0.3 cornerRadius:1.0];
    
    self.title = @"Información personal";
    
    [_imgCliente createBorderWithColor:[UIColor clearColor] borderWidth:0.0 cornerRadius:_imgCliente.frame.size.width/2.0];
    
    [_viewNombre setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"IMG_fondo_verde.png"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminarFlujo:) name:PFClienteViewControllerRegresarNotification object:nil];
    [_cliente consultarFoto];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableviewPedidos reloadData];
    
    _lblNombre.text = _cliente.nombre;
    _lblID.text = _cliente.ID;
    _lblDireccion.text = _cliente.direccion.formatDireccion;
    _lblSaldoTotal.text = [UTFormatUtilities stringFromNumber:_cliente.saldoTotal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualizarFoto:) name:NGOperacionFotoUpdateNotification object:nil];
    [_cliente consultarFoto];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NGOperacionFotoUpdateNotification object:nil];
}

#pragma mark - IBAction

-(IBAction)continuar:(id)sender
{
    mapaViewController = [[MapaViewController alloc] init];
    [self.navigationController pushViewController:mapaViewController animated:YES];
}

#pragma mark - Notifications

-(void)actualizarFoto:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *pathFoto = userInfo[NGOperacionFotoPathKey];
    NSString *fotoID = userInfo[NGOperacionFotoIDKey];
    
    if([_cliente.ID isEqualToString:fotoID])
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        
            [self.imgCliente setImage:[UIImage imageWithContentsOfFile:pathFoto]];
            [self.imgCliente addFadeTransitionWithDuration:0.5];
        });
    }
}

-(void)terminarFlujo:(NSNotification *)notification
{
    [self.navigationController popToViewController:self animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cliente.pedidos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PedidoTableViewCell *pedidoCell = [tableView dequeueReusableCellWithClass:[PedidoTableViewCell class]];
    [pedidoCell configurarConPedido:_cliente.pedidos[indexPath.row]];
    
    return pedidoCell;
}

#pragma mark - UITableViewDelegate

@end
