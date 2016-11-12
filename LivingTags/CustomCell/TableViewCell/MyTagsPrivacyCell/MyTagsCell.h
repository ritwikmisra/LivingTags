//
//  MyTagsCell.h
//  LivingTags
//
//  Created by appsbeetech on 12/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTagsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *imgPrivate;
@property(nonatomic,strong)IBOutlet UIImageView *imgPublic;
@property(nonatomic,strong)IBOutlet UIImageView *imgPic;

@property(nonatomic,strong)IBOutlet UIButton *btnPublic;
@property(nonatomic,strong)IBOutlet UIButton *btnPrivate;

@end
