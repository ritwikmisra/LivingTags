//
//  PersonImageCell.h
//  LivingTags
//
//  Created by appsbeetech on 14/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonImageCell : UICollectionViewCell

@property (nonatomic,strong)IBOutlet UIImageView *img;
@property(nonatomic,strong)IBOutlet UIButton *btn;
@property(nonatomic,strong)IBOutlet UIImageView *imgBackground;
@property(nonatomic,strong)IBOutlet UIButton *btnFooter;
@end
