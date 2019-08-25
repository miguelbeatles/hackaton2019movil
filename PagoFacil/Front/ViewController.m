//
//  ViewController.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "ViewController.h"
#import "ClienteViewController.h"
#import "PFConstants.h"
#import "PFNegocio.h"

@interface ViewController ()

@end

@implementation ViewController
{
    ClienteViewController *clienteViewController;
    NGCliente *cliente;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        clienteViewController = nil;
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
}

#pragma mark - IBAction

-(IBAction)ingresar:(id)sender
{
    [self showHUDWithTitle:@"Consultando información" message:@"Espere un momento" execution:^{
        
        NGConsultas_WA *consultasWA = [[NGConsultas_WA alloc] init];
        self->cliente = [consultasWA consultarDatosCliente:@"5d61b00dbbfad5c8e9d3e22f"];
        
    } completion:^{
        
        if(self->cliente)
        {
            self->clienteViewController = [[ClienteViewController alloc] init];
            self->clienteViewController.cliente = self->cliente;
            [self.navigationController pushViewController:self->clienteViewController animated:YES];
        }
    }];
}



@end
