//
//  DashboardCell.h
//  LivingTags
//
//  Created by appsbeetech on 09/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardCell : UITableViewCell

//// for single icon

@property (nonatomic,strong)IBOutlet UIImageView *imgDashboard;
@property(nonatomic,strong)IBOutlet UILabel *lblName;

// for double icon

@property(nonatomic,strong)IBOutlet UIImageView *imgBackgroundLeft;
@property(nonatomic,strong)IBOutlet UIImageView *imgBackgroundRight;
@property(nonatomic,strong)IBOutlet UIImageView *imgIconleft;
@property(nonatomic,strong)IBOutlet UIImageView *imgIconRight;
@property(nonatomic,strong)IBOutlet UIButton *btnLeft;
@property(nonatomic,strong)IBOutlet UIButton *btnRIght;
@property(nonatomic,strong)IBOutlet UILabel *lblLeft;
@property(nonatomic,strong)IBOutlet UILabel *lblRight;

@end
