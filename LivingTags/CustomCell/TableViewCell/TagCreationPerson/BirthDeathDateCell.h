//
//  BirthDeathDateCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthDeathDateCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIButton *btnLiving;
@property(nonatomic,strong)IBOutlet UIImageView *imgLiving;
@property(nonatomic,strong)IBOutlet UITextField *txtBirth;
@property(nonatomic,strong)IBOutlet UITextField *txtDeath;

@property(nonatomic,strong)IBOutlet UIButton *btnBirthDate;
@property(nonatomic,strong)IBOutlet UIButton *btnDeathDate;

@end
