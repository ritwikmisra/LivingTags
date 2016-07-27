//
//  CreateTagsThirdStepCell.h
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTagsThirdStepCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)IBOutlet UIButton *btnBrowse;
@property(nonatomic,strong)IBOutlet UICollectionView *collPics;

@property(nonatomic,strong)IBOutlet UIButton *btnCalender;
@property(nonatomic,strong)IBOutlet UILabel *lblCalender;

@property(nonatomic,strong) IBOutlet UIButton *btnRecording;

@property(nonatomic,strong)IBOutlet UIButton *btnMorePicYes;
@property(nonatomic,strong)IBOutlet UIButton *btnMorePicNo;


@end
