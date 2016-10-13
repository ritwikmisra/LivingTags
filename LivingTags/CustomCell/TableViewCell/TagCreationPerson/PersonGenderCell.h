//
//  PersonGenderCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonGenderCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgMale;
@property(nonatomic,strong)IBOutlet UIImageView *imgFemale;
@property(nonatomic,strong)IBOutlet UIButton *btnMale;
@property(nonatomic,strong)IBOutlet UIButton *btnFemale;

@end
