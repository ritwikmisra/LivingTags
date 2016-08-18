//
//  CreateTagsCell.h
//  LivingTags
//
//  Created by appsbeetech on 26/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTagsCell : UICollectionViewCell

@property(nonatomic,strong)IBOutlet UIImageView *img;
@property(nonatomic,strong)IBOutlet UIProgressView *progressImageUpload;
@property(nonatomic,strong)IBOutlet UILabel *lblUploaded;
@property(nonatomic,strong)IBOutlet UIImageView *imgBackground;
@property(nonatomic,strong)IBOutlet UIButton *btnDelete;

@end
