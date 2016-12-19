//
//  CategoryGridCell.h
//  LivingTags
//
//  Created by appsbeetech on 19/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryGridCell : UICollectionViewCell

@property(nonatomic,strong)IBOutlet UIView *vwLabel;
@property(nonatomic,strong)IBOutlet UILabel *lblCategory;
@property(nonatomic,strong)IBOutlet UIButton *btnCross;

@end
