//
//  ProductListingViewController.m
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProductListingViewController.h"
#import "ProductCell.h"
#import "ProductListingService.h"
#import "ModelProduct.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailsController.h"

@interface ProductListingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    IBOutlet UITextField *txtSearch;
    IBOutlet UICollectionView *collVwProducts;
    NSMutableArray *arrResponse;
    NSString *strPkey;
}

@end

@implementation ProductListingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search here" attributes:@{NSForegroundColorAttributeName: color}];
    collVwProducts.backgroundColor=[UIColor clearColor];
    UINib *cellNib = [UINib nibWithNibName:@"ProductCell" bundle:nil];
    [collVwProducts registerNib:cellNib forCellWithReuseIdentifier:@"ProductCell"];
    
    collVwProducts.dataSource=self;
    collVwProducts.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ProductListingService service]callProductListWebServiceWithPageNumbe:0 withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            arrResponse=(id)result;
            [collVwProducts reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark collectionview datasource and delegate
#pragma mark

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrResponse.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"ProductCell";
    ProductCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    ModelProduct *obj=[arrResponse objectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:obj.strPuri]
                        placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                 options:SDWebImageHighPriority
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    [cell.actIndicatorProduct startAnimating];
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [cell.actIndicatorProduct stopAnimating];
                                   
                               }];
    });
    cell.lblProductName.text=obj.strPname;
    cell.lblProductPrice.text=[NSString stringWithFormat:@"$ %@",obj.strPrice];
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width,height;
    width = collectionView.frame.size.width/2-3.0f;
    height = collectionView.frame.size.width/2-3.0f;
    return CGSizeMake(width,height);
}


- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //segueProductDetails
    ModelProduct *obj=[arrResponse objectAtIndex:indexPath.row];
    strPkey=obj.strPkey;
    [self performSegueWithIdentifier:@"segueProductDetails" sender:self];
}

#pragma mark
#pragma mark prepare for segue
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueProductDetails"])
    {
        ProductDetailsController *master=[segue destinationViewController];
        master.strPKey=strPkey;
    }
}

@end
