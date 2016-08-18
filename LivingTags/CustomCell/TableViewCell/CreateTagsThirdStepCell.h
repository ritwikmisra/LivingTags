//
//  CreateTagsThirdStepCell.h
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol CollectionViewSelectionDelegate <NSObject>

@optional
-(void)didSelectCollectionViewWithRow:(NSInteger)rowNumber;

@end

@interface CreateTagsThirdStepCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)IBOutlet UIButton *btnBrowse;//
@property(nonatomic,strong)IBOutlet UICollectionView *collPics;
@property(nonatomic,strong)IBOutlet UILabel *lbl;

@property(nonatomic,strong)IBOutlet UITextField *txtCaptions;

@property(nonatomic,strong)IBOutlet UIButton *btnCalender;
@property(nonatomic,strong)IBOutlet UILabel *lblCalender;

@property(nonatomic,strong)IBOutlet NSLayoutConstraint *constVerticalSpacing;

@property(nonatomic,strong) IBOutlet UIButton *btnRecording;

@property(nonatomic,strong)IBOutlet UIButton *btnNext;//
@property(nonatomic,strong)IBOutlet UIButton *btnAddPhoto;//

@property(nonatomic,strong)IBOutlet UILabel *lblRecording;

@property(nonatomic,strong)AppDelegate *appDel;
@property(nonatomic,weak)id<CollectionViewSelectionDelegate>delegate;

@end
