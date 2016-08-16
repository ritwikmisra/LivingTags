//
//  CreateTagsThirdStepCell.m
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateTagsThirdStepCell.h"
#import "CreateTagsCell.h"

@implementation CreateTagsThirdStepCell

- (void)awakeFromNib
{
    // Initialization code
    [self.collPics setBackgroundColor:[UIColor clearColor]];
    UINib *cellNib = [UINib nibWithNibName:@"CreateTagsCell" bundle:nil];
    [self.collPics registerNib:cellNib forCellWithReuseIdentifier:@"CreateTagsCell"];
    self.collPics.dataSource=self;
    self.collPics.delegate=self;
    self.appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.btnAddPhoto.layer.cornerRadius=5.0f;
    self.btnBrowse.layer.cornerRadius=5.0f;
    self.btnNext.layer.cornerRadius=5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark
#pragma mark collection view datasource and delegate
#pragma mark

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.appDel.arrCreateTagsUploadImage.count>0)
    {
        return self.appDel.arrCreateTagsUploadImage.count;
    }
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"CreateTagsCell";
    CreateTagsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    if (self.appDel.arrCreateTagsUploadImage.count>0)
    {
        cell.img.image=[self.appDel.arrCreateTagsUploadImage objectAtIndex:indexPath.row];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width,height;
    width = self.collPics.frame.size.height-13.0f;
    height = self.collPics.frame.size.height;
    return CGSizeMake(width,height);
}

@end
