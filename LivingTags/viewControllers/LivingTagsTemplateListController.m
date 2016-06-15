//
//  LivingTagsTemplateListController.m
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsTemplateListController.h"
#import "GetAllLivingTagsTemplatesService.h"
#import "TemplateCell.h"
#import "UIImageView+WebCache.h"
#import "ModelLivingTagsTemplateList.h"
#import "CreateLivingTagsViewController.h"

@interface LivingTagsTemplateListController ()<UIScrollViewDelegate>
{
    IBOutlet UICollectionView *collLivingTagsTemplate;
    NSMutableArray *arrTemplates;
    NSString *strSegueTemplateID;
    IBOutlet UILabel *lblTemplate;
}
@end

@implementation LivingTagsTemplateListController

//segueTemplate
- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"TemplateCell" bundle:nil];
    [collLivingTagsTemplate registerNib:cellNib forCellWithReuseIdentifier:@"TemplateCell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    collLivingTagsTemplate.delegate=self;
    collLivingTagsTemplate.dataSource=self;
    [[GetAllLivingTagsTemplatesService sharedInstance]getAllTemplateDesignsWithCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            
        }
        else
        {
            NSLog(@"%@",result);
            if ([result isKindOfClass:[NSMutableArray class]])
            {
                arrTemplates=(id)result;
                lblTemplate.text=[NSString stringWithFormat:@"Template Selection(1/%lu)",(unsigned long)arrTemplates.count];
            }
            else
            {
                [arrTemplates removeAllObjects];
                lblTemplate.text=@"Template Selection";
            }
            [collLivingTagsTemplate reloadData];
        }
    }];
}

#pragma mark
#pragma mark Collection View Delegate and Datasource
#pragma mark

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrTemplates.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"TemplateCell";
    TemplateCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    ModelLivingTagsTemplateList *obj=[arrTemplates objectAtIndex:indexPath.row];
    //image download
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgTemplate sd_setImageWithURL:[NSURL URLWithString:obj.strTemplateThumb]
                            placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                     options:SDWebImageHighPriority
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    }
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    });
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collLivingTagsTemplate.frame.size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelLivingTagsTemplateList *obj=[arrTemplates objectAtIndex:indexPath.row];
    NSLog(@"%@",obj.strTemplateID);
    strSegueTemplateID=obj.strTemplateID;
    [self performSegueWithIdentifier:@"segueTemplate" sender:self];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueTemplate"])
    {
        CreateLivingTagsViewController *master=[segue destinationViewController];
        master.strTemplateID=strSegueTemplateID;
    }
}


#pragma mark
#pragma mark scrollView Delegate
#pragma mark

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = collLivingTagsTemplate.frame.size.width;
    int currentPage = collLivingTagsTemplate.contentOffset.x / pageWidth;
    lblTemplate.text=[NSString stringWithFormat:@"Template Selection(%d/%lu)",currentPage+1,(unsigned long)arrTemplates.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    collLivingTagsTemplate.delegate=nil;
    collLivingTagsTemplate.dataSource=nil;
}

@end
