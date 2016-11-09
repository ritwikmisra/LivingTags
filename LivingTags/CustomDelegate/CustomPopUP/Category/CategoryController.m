//
//  CategoryController.m
//  LivingTags
//
//  Created by appsbeetech on 03/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CategoryController.h"
#import "BusinessCategoryCell.h"
#import "LivingTagsSecondStepService.h"

@interface CategoryController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIView *vw;
    IBOutlet UITableView *tblCategory;
    NSMutableDictionary *dict;
}

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    vw.layer.cornerRadius=10.0f;
    tblCategory.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblCategory.backgroundColor=[UIColor clearColor];
    NSLog(@"%@",self.arrCategoryList);
    dict=[[NSMutableDictionary alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview datasource and delegates
#pragma mark

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrCategoryList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessCategoryCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.lblCategoryName.text=[self.arrCategoryList objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCategoryCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.lblCategoryName.text);
    //tdata[tcategories],
    [dict setObject:cell.lblCategoryName.text forKey:@"tcategories"];
    if (self.strTKey.length>0)
    {
        [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dict tKey:self.strTKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                [self.view removeFromSuperview];
                if (_delegate && [_delegate respondsToSelector:@selector(selectedCategoryWithName:)])
                {
                    [self.delegate selectedCategoryWithName:cell.lblCategoryName.text];
                }
            }
        }];

    }
    else
    {
        [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dict tKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                [self.view removeFromSuperview];
                if (_delegate && [_delegate respondsToSelector:@selector(selectedCategoryWithName:)])
                {
                    [self.delegate selectedCategoryWithName:cell.lblCategoryName.text];
                }
            }
        }];
    }
}


@end
