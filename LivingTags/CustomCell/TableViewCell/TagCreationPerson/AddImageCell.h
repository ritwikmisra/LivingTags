//
//  AddImageCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol TagsCreateImageSelect <NSObject>

@optional
-(void)selectImages;
-(void)deleteImagesFromIndex:(NSInteger)i;
-(void)editProfilePicPressed;

@end
@interface AddImageCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)IBOutlet UICollectionView *cllvwImages;
@property(nonatomic,weak)id<TagsCreateImageSelect>delegate;
@property(nonatomic,strong)AppDelegate *appDel;

@end
