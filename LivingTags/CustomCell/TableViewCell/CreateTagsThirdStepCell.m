//
//  CreateTagsThirdStepCell.m
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateTagsThirdStepCell.h"
#import "CreateTagsCell.h"
#import <QuartzCore/QuartzCore.h>

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
    cell.lblUploaded.hidden=YES;
    cell.btnDelete.tag=indexPath.row;
    cell.btnDelete.hidden=YES;
    NSLog(@"%@",_appDel.arrSuccessUpload);
    if (_appDel.arrSuccessUpload.count>0)
    {
        if (indexPath.row<_appDel.arrSuccessUpload.count)
        {
            if ([[_appDel.arrSuccessUpload objectAtIndex:indexPath.row] isEqualToString:@"1"])
            {
                cell.lblUploaded.hidden=NO;
                cell.btnDelete.hidden=NO;
            }
        }
    }
    [cell.btnDelete addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width,height;
    width = self.collPics.frame.size.height;
    height = self.collPics.frame.size.height;
    return CGSizeMake(width,height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //246 132 31
    CreateTagsCell *cell=(CreateTagsCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_appDel.arrSuccessUpload.count>0)
    {
        if (indexPath.row<_appDel.arrSuccessUpload.count)
        {
            if ([[_appDel.arrSuccessUpload objectAtIndex:indexPath.row] isEqualToString:@"1"])
            {
                //cell.imgBackground.backgroundColor=[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1];
                cell.img.clipsToBounds = YES;
                cell.img.layer.borderWidth=2.0f;
                cell.img.layer.borderColor=[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1].CGColor;
            }
        }
    }
    else
    {
        cell.img.clipsToBounds = YES;
        cell.img.layer.borderWidth=2.0f;
        cell.img.layer.borderColor=[UIColor lightGrayColor].CGColor;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCollectionViewWithRow:)])
    {
        [self.delegate didSelectCollectionViewWithRow:indexPath.row];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTagsCell *cell=(CreateTagsCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.img.layer.borderWidth=2.0f;
    cell.img.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor clearColor]);
}

-(void)btnDeletePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageWithButtonTag:)])
    {
        [self.delegate deleteImageWithButtonTag:[sender tag]];
    }
}

@end
