//
//  AddImageCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)IBOutlet UICollectionView *cllvwImages;

@end
