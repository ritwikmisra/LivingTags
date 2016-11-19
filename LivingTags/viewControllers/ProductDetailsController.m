//
//  ProductDetailsController.m
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProductDetailsController.h"
#import "UIImageView+WebCache.h"
#import "ProductDetailsService.h"
#import "ModelProduct.h"
#import "ProductDetailsCell.h"

@interface ProductDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgProductPic;
    ModelProduct *obj;
    IBOutlet UIActivityIndicatorView *actIndicatorProduct;
    IBOutlet UILabel *lblProductName;
    IBOutlet UITableView *tblProductDetails;
    int quantity;
    NSString *strQuantity;
}

@end

@implementation ProductDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblProductDetails.separatorStyle=UITableViewCellSeparatorStyleNone;
    strQuantity=@"1";
    tblProductDetails.backgroundColor=[UIColor clearColor];
    NSLog(@"%@",self.strPKey);
    [[ProductDetailsService service]callProductDetailsServiceWithProductKey:self.strPKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            obj=[[ModelProduct alloc]initWithDictionary:result];
            lblProductName.text=obj.strPname;
            NSMutableDictionary *dic=[[result objectForKey:@"ppuri"] firstObject];
            NSString *strPicURL=[dic objectForKey:@"ppuri"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgProductPic sd_setImageWithURL:[NSURL URLWithString:strPicURL]
                                   placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                            options:SDWebImageHighPriority
                                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                               [actIndicatorProduct startAnimating];
                                           }
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              [actIndicatorProduct stopAnimating];
                                              
                                          }];
            });
            [tblProductDetails reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark tableview delegate and datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 65.0f;
            break;
            
        case 1:
            return 90.0f;
            break;
            
        case 2:
            return 65.0f;
            break;

        default:
            return 50.0f;
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    switch (indexPath.row)
    {
        case 0:
        {
            ProductDetailsCell *cellP=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
            if (!cellP)
            {
                cellP=[[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:indexPath.row];
            }
            NSLog(@"%@",obj.strPrice);
            cellP.lblPrice.text=obj.strPrice;
            cell=cellP;
            break;
        }
            
        case 1:
        {
            ProductDetailsCell *cellP=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
            if (!cellP)
            {
                cellP=[[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:indexPath.row];
            }
            cellP.txtVwProductDetails.text=obj.strPabout;
            cellP.txtVwProductDetails.userInteractionEnabled=NO;
            cell=cellP;
            break;
        }
            
        case 2:
        {
            ProductDetailsCell *cellP=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
            if (!cellP)
            {
                cellP=[[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:indexPath.row];
            }
            cellP.lblProductQuantities.text=strQuantity;
            NSLog(@"%@",cellP.lblProductQuantities.text);
            [cellP.btnPlus addTarget:self action:@selector(btnPlusTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cellP.btnMinus addTarget:self action:@selector(btnMinusTapped:) forControlEvents:UIControlEventTouchUpInside];
            cell=cellP;
            break;
        }
        case 3:
        {
            ProductDetailsCell *cellP=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
            if (!cellP)
            {
                cellP=[[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:indexPath.row];
            }

            cell=cellP;
            break;
        }
        default:
            break;
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark
#pragma mark ibaction
#pragma mark

-(void)btnPlusTapped:(id)sender
{
    quantity=quantity+1;
    strQuantity=[NSString stringWithFormat:@"%d",quantity];
    [tblProductDetails beginUpdates];
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
    // Add them in an index path array
    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, nil];
    // Launch reload for the two index path
    [tblProductDetails reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    [tblProductDetails endUpdates];
}

-(void)btnMinusTapped:(id)sender
{
    quantity=quantity-1;
    if (quantity<=1)
    {
        quantity=1;
    }
    strQuantity=[NSString stringWithFormat:@"%d",quantity];
    [tblProductDetails beginUpdates];
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
    // Add them in an index path array
    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, nil];
    // Launch reload for the two index path
    [tblProductDetails reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    [tblProductDetails endUpdates];

}



@end
