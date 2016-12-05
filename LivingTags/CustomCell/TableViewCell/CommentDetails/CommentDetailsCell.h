//
//  CommentDetailsCell.h
//  LivingTags
//
//  Created by appsbeetech on 05/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentDetailsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UITextView *txtVwComments;
@property(nonatomic,strong)IBOutlet UIButton *btnTick;
@property(nonatomic,strong)IBOutlet UIImageView *imgAssets;

@end
