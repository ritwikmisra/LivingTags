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

@interface ProductDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgProductPic;
    ModelProduct *obj;
    IBOutlet UIActivityIndicatorView *actIndicatorProduct;
    IBOutlet UILabel *lblProductName;
    IBOutlet UITableView *tblProductDetails;
}

@end

@implementation ProductDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
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



@end
