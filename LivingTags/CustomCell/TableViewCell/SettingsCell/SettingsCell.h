//
//  SettingsCell.h
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lblSettings;
@property(nonatomic,strong)IBOutlet UIButton *btnSettings;
@property(nonatomic,strong)IBOutlet UIImageView *imgBtn;
@property(nonatomic,strong)IBOutlet UIImageView *imgSettingsBottom;
@property(nonatomic,strong)IBOutlet UISwitch *switchSettings;


@end
