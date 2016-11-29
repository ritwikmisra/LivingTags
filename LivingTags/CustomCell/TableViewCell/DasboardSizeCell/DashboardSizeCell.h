//
//  DashboardSizeCell.h
//  LivingTags
//
//  Created by appsbeetech on 10/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardSizeCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgPic;
@property(nonatomic,strong)IBOutlet UILabel *lblComment;
@property(nonatomic,strong)IBOutlet UILabel *lblViewed;
@property(nonatomic,strong)IBOutlet UILabel *lblAttachment;
@property(nonatomic,strong)IBOutlet UILabel *lblSize;

@end
