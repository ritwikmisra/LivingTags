//
//  CreateTagsSecondStepCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTagsSecondStepCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UITextField *txtName;
@property(nonatomic,strong)IBOutlet UIImageView *imgMale;
@property(nonatomic,strong)IBOutlet UIImageView *imgFemale;

@property(nonatomic,strong)IBOutlet UIButton *btnMale;
@property(nonatomic,strong)IBOutlet UIButton *btnFemale;

@property(nonatomic,strong)IBOutlet UIImageView *imgUser;
@property(nonatomic,strong)IBOutlet UIButton *btnBrowseUserPic;

@property(nonatomic,strong)IBOutlet UITextField *txtDateFrom;
@property(nonatomic,strong)IBOutlet UITextField *txtDateTo;

@property(nonatomic,strong)IBOutlet UIButton *btnGetLocation;

@property(nonatomic,strong)IBOutlet UIImageView *imgCover;
@property(nonatomic,strong)IBOutlet UIButton *btnBrowseCover;

@property(nonatomic,strong)IBOutlet UITextView *txtVwMemorialQuote;

@end
