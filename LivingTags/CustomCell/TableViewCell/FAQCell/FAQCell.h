//
//  FAQCell.h
//  LivingTags
//
//  Created by appsbeetech on 22/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lbl;
@property(nonatomic,strong)IBOutlet UIImageView *imgArrow;
@property(nonatomic,strong)IBOutlet UIView *vwFooter;
@property(nonatomic,strong)IBOutlet UITextView *txtVwDetails;

@property(nonatomic,strong)IBOutlet UIButton *btnHeader;

@end
