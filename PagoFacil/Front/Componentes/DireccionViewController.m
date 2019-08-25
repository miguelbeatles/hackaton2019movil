//
//  DireccionViewController.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "DireccionViewController.h"
#import "PFConstants.h"
#import "PFConstants.h"
#import "PFNegocio.h"

@interface DireccionViewController ()

@property (nonatomic, strong) IBOutlet UILabel *lblDireccion;

@end

@implementation DireccionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actualizarDireccion:) name:NGOperacionDireccionNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)actualizarDireccionWithLatitude:(double)latitude longitude:(double)longitude
{
    NGOperacionDireccion *operacionDireccion = [[NGOperacionDireccion alloc] initWithLatitude:latitude longitude:longitude];
    [NGOperacionDireccionManager agregarOperacion:operacionDireccion];
}

#pragma mark - Notifications

-(void)actualizarDireccion:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NGDireccion *direccion = userInfo[NGOperacionDireccionKey];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        self.lblDireccion.text = direccion.formatDireccion;
    });
}

#pragma mark - IBActions

-(IBAction)confirmarDireccion:(id)sender
{
    if([_delegate respondsToSelector:@selector(direccionViewControllerConfirmar)])
    {
        [_delegate direccionViewControllerConfirmar];
    }
}

@end
