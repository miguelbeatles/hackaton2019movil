//
//  PedidoTableViewCell.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "PedidoTableViewCell.h"
#import "PFUtilerias.h"

@interface PedidoTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *lblPedido;
@property (nonatomic, strong) IBOutlet UILabel *lblDescripcion;
@property (nonatomic, strong) IBOutlet UILabel *lblMontoAbonado;
@property (nonatomic, strong) IBOutlet UILabel *lblSaldo;

@end

@implementation PedidoTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)configurarConPedido:(NGPedido *)pedido
{
    _lblPedido.text = pedido.pedido;
    _lblDescripcion.text = pedido.descripcion;
    _lblMontoAbonado.text = [UTFormatUtilities stringFromNumber:pedido.saldoAbonado];
    _lblSaldo.text = [UTFormatUtilities stringFromNumber:pedido.saldoActual];
}

@end
