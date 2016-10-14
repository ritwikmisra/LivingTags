//
//  AddVideoCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AddVideoCell.h"
#import "PersonImageCell.h"

@implementation AddVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cllvwImages.backgroundColor=[UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"PersonImageCell" bundle:nil];
    [self.cllvwImages registerNib:cellNib forCellWithReuseIdentifier:@"PersonImageCell"];
    self.cllvwImages.dataSource=self;
    self.cllvwImages.delegate=self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark
#pragma mark collection view delegate and datasource
#pragma mark

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"PersonImageCell";
    PersonImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    [cell.btn setTitle:@"ADD VIDEOS" forState:UIControlStateNormal];
    cell.img.image=[UIImage imageNamed:@"vid"];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width,height;
    width = self.cllvwImages.frame.size.height;
    height = self.cllvwImages.frame.size.height;
    return CGSizeMake(width,height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}



@end
