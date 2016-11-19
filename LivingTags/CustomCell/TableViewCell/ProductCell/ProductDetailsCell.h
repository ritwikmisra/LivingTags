//
//  ProductDetailsCell.h
//  LivingTags
//
//  Created by appsbeetech on 19/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lblPrice;
@property(nonatomic,strong)IBOutlet UITextView *txtVwProductDetails;
@property(nonatomic,strong)IBOutlet UILabel *lblProductQuantities;
@property(nonatomic,strong)IBOutlet UIButton *btnPlus;
@property(nonatomic,strong)IBOutlet UIButton *btnMinus;

@end
