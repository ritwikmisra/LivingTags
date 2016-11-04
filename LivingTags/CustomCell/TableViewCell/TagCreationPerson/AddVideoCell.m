//
//  AddVideoCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AddVideoCell.h"
#import "PersonImageCell.h"
#import "PersonCell.h"

@implementation AddVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cllvwImages.backgroundColor=[UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"PersonImageCell" bundle:nil];
    [self.cllvwImages registerNib:cellNib forCellWithReuseIdentifier:@"PersonImageCell"];
    
    UINib *cellNib1 = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [self.cllvwImages registerNib:cellNib1 forCellWithReuseIdentifier:@"PersonCell"];
    self.appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];

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
    if (self.appDel.arrVideoSet.count>0)
    {
        return self.appDel.arrVideoSet.count;
    }
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"PersonImageCell";
    static NSString   *strIdentifier2=@"PersonCell";
    if (self.appDel.arrVideoSet.count>0)
    {
        if ([[self.appDel.arrVideoSet objectAtIndex:indexPath.row]isKindOfClass:[NSString class]])
        {
            PersonImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
            [cell.btnFooter setTitle:@"ADD VIDEO" forState:UIControlStateNormal];
            cell.img.image=[UIImage imageNamed:@"pic"];
            [cell.btn addTarget:self action:@selector(btnVideoClicked:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else
        {
            PersonCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier2 forIndexPath:indexPath];
            cell.imgPicl.image=[self.appDel.arrVideoSet objectAtIndex:indexPath.row];
            cell.imgPicl.transform = CGAffineTransformMakeRotation(M_PI_2);
            cell.btnDelete.tag=indexPath.row;
            [cell.btnDelete addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
    else
    {
        PersonImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
        [cell.btnFooter setTitle:@"ADD VIDEO" forState:UIControlStateNormal];
        cell.img.image=[UIImage imageNamed:@"pic"];
        [cell.btn addTarget:self action:@selector(btnVideoClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width,height;
    width = self.cllvwImages.frame.size.height-10.0f;
    height = self.cllvwImages.frame.size.height-10.0f;
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

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnVideoClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectVideos)])
    {
        [self.delegate selectVideos];
    }
}

-(void)btnDeletePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteVideosFromIndex:)])
    {
        [self.delegate deleteVideosFromIndex:[sender tag]];
    }
    
}

@end
