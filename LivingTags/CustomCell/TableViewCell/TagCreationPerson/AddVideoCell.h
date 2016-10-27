//
//  AddVideoCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol TagsCreateVideosSelect <NSObject>

@optional
-(void)selectVideos;
-(void)deleteVideosFromIndex:(NSInteger)i;

@end

@interface AddVideoCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)IBOutlet UICollectionView *cllvwImages;
@property(nonatomic,weak)id<TagsCreateVideosSelect>delegate;
@property(nonatomic,strong)AppDelegate *appDel;

@end
