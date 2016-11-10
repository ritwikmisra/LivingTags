//
//  ProfileCell.h
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgProfilePic;
@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UILabel *lblEmail;
@property(nonatomic,strong)IBOutlet UILabel *lblOthers;
@property(nonatomic,strong)IBOutlet UIButton *btnProfileImage;
@end
