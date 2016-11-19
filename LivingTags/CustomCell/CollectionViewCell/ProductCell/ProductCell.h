//
//  ProductCell.h
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgProduct;
@property(nonatomic,strong)IBOutlet UILabel *lblProductName;
@property(nonatomic,strong)IBOutlet UILabel *lblProductPrice;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actIndicatorProduct;

@end
