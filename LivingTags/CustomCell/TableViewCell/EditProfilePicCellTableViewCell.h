//
//  EditProfilePicCellTableViewCell.h
//  LivingTags
//
//  Created by appsbeetech on 29/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface EditProfilePicCellTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIButton *btnProfileEdit;
@property(nonatomic,strong)IBOutlet UIButton *btnProfilePicUpdate;
@property(nonatomic,strong)IBOutlet UILabel *lblMemoriesCreated;
@property(nonatomic,strong)IBOutlet UILabel *lblLocation;
@property(nonatomic,strong)IBOutlet UILabel *lblMemoriesViewed;
@property(nonatomic,strong)IBOutlet UIImageView *imgProfile;

@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actProfileIndicator;

@property(nonatomic,strong)IBOutlet UIImageView *img;
@property(nonatomic,strong)IBOutlet UITextField *txt;
@property(nonatomic,strong)IBOutlet UITextField *txtName;
@property(nonatomic,strong)IBOutlet UILabel *lblPlaceHolders;
@property(nonatomic,strong)IBOutlet YTPlayerView *vwPlayer;

@property(nonatomic,strong)IBOutlet UIView *vwVimeo;

@property(nonatomic,strong)IBOutlet NSLayoutConstraint *constHeight;


@end
