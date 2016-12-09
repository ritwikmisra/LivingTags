//
//  AddImageCell.m
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AddImageCell.h"
#import "PersonImageCell.h"
#import "UIImageView+WebCache.h"
#import "PersonCell.h"
#import "ModelImageAndVideoAssets.h"

@implementation AddImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"ritwik");
    
    
    
    
    
    
    
    
    self.cllvwImages.backgroundColor=[UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"PersonImageCell" bundle:nil];
    [self.cllvwImages registerNib:cellNib forCellWithReuseIdentifier:@"PersonImageCell"];
    
    UINib *cellNib1 = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [self.cllvwImages registerNib:cellNib1 forCellWithReuseIdentifier:@"PersonCell"];

    
    self.cllvwImages.dataSource=self;
    self.cllvwImages.delegate=self;
    self.appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
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
    if (self.appDel.arrImageSet.count>0)
    {
        return self.appDel.arrImageSet.count;
    }
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"PersonImageCell";
    static NSString   *strIdentifier2=@"PersonCell";
    NSLog(@"%@",self.appDel.arrImageSet);
    if (self.appDel.arrImageSet.count>0)
    {
        if ([[self.appDel.arrImageSet objectAtIndex:indexPath.row]isKindOfClass:[NSString class]])
        {
            if ([[self.appDel.arrImageSet objectAtIndex:indexPath.row]isEqualToString:@"1"])
            {
                PersonImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
                [cell.btnFooter setTitle:@"ADD PHOTO" forState:UIControlStateNormal];
                cell.img.image=[UIImage imageNamed:@"pic"];
                [cell.btn addTarget:self action:@selector(btnImagesClicked:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else
            {
                PersonCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier2 forIndexPath:indexPath];
                NSLog(@"%@",[self.appDel.arrImageSet objectAtIndex:indexPath.row]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.imgPicl sd_setImageWithURL:[NSURL URLWithString:[self.appDel.arrImageSet objectAtIndex:indexPath.row]]
                                    placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                             options:SDWebImageHighPriority
                                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                [cell.actImages startAnimating];
                                            }
                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                               [cell.actImages stopAnimating];
                                               
                                           }];
                });
                cell.imgPlay.hidden=YES;
                cell.btnDelete.tag=indexPath.row;
                cell.btnDelete.hidden=YES;
                return cell;
            }
        }
        else if([[self.appDel.arrImageSet objectAtIndex:indexPath.row]isKindOfClass:[UIImage class]])
        {
            PersonCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier2 forIndexPath:indexPath];
            cell.imgPicl.image=[self.appDel.arrImageSet objectAtIndex:indexPath.row];
            cell.btnDelete.tag=indexPath.row;
            [cell.btnDelete addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
            cell.imgPlay.hidden=YES;
            return cell;
        }
        else
        {
            ModelImageAndVideoAssets *obj=[self.appDel.arrImageSet objectAtIndex:indexPath.row];
            NSLog(@"%@",obj.strPicURI);
            NSLog(@"%@",obj.strPicURI);
            PersonCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier2 forIndexPath:indexPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.imgPicl sd_setImageWithURL:[NSURL URLWithString:obj.strPicURI]
                                    placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                             options:SDWebImageHighPriority
                                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                [cell.actImages startAnimating];
                                            }
                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                               [cell.actImages stopAnimating];

                                           }];
            });
            cell.imgPlay.hidden=YES;
            cell.btnDelete.tag=indexPath.row;
            [cell.btnDelete addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
    else
    {
        PersonImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
        [cell.btnFooter setTitle:@"ADD PHOTO" forState:UIControlStateNormal];
        cell.img.image=[UIImage imageNamed:@"pic"];
        [cell.btn addTarget:self action:@selector(btnImagesClicked:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)btnImagesClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectImages)])
    {
        [self.delegate selectImages];
    }
}

-(void)btnDeletePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImagesFromIndex:)])
    {
        [self.delegate deleteImagesFromIndex:[sender tag]];
    }

}
@end
