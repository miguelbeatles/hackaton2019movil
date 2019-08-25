//
//  PedidoTableViewCell.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/25/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNegocio.h"

NS_ASSUME_NONNULL_BEGIN

@interface PedidoTableViewCell : UITableViewCell

-(void)configurarConPedido:(NGPedido *)pedido;

@end

NS_ASSUME_NONNULL_END
