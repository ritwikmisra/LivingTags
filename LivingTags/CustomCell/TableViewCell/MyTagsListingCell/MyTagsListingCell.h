//
//  MyTagsListingCell.h
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTagsListingCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UILabel *lblTiming;
@property(nonatomic,strong)IBOutlet UILabel *lblTagType;
@property(nonatomic,strong)IBOutlet UILabel *lblTagViews;
@property(nonatomic,strong)IBOutlet UILabel *lblTagComments;
@property(nonatomic,strong)IBOutlet UILabel *lblDiskSpace;


@property(nonatomic,strong)IBOutlet UIImageView *imgPerson;
@property(nonatomic,strong)IBOutlet UIImageView *imgTagType;
@property(nonatomic,strong)IBOutlet UIImageView *imgBottom;
@property(nonatomic,strong)IBOutlet UIButton *btnPreviewOnImage;
@property(nonatomic,strong)IBOutlet UIButton *btnPreviewOnName;


@property(nonatomic,strong)IBOutlet UIButton *btnEdit;
@end
