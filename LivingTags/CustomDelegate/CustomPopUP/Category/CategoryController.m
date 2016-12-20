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
#import "CategoryGridCell.h"


@interface CategoryController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UIView *vw;
    IBOutlet UITableView *tblCategory;
    IBOutlet UIButton *btnOK;
    IBOutlet UIButton *btnCancel;
    IBOutlet UITextField *txtCategory;
    NSMutableArray *arrSorted,*arrCollectionView;
    IBOutlet UICollectionView *collCategories;
    NSString *strCategoryName;
}

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    vw.layer.cornerRadius=10.0f;
    tblCategory.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblCategory.backgroundColor=[UIColor clearColor];
    NSLog(@"%@",self.arrCategoryList);
    [txtCategory setValue:[UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [tblCategory setBackgroundColor:[UIColor clearColor]];
    UINib *cellNib1 = [UINib nibWithNibName:@"CategoryGridCell" bundle:nil];
    [collCategories registerNib:cellNib1 forCellWithReuseIdentifier:@"CategoryGridCell"];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    ////round corner for preview button/////
    vw.layer.cornerRadius=10.0f;
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:btnOK.bounds
                              byRoundingCorners:(UIRectCornerBottomLeft )
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btnOK.bounds;
    maskLayer.path = maskPath.CGPath;
    btnOK.layer.mask = maskLayer;
    
    /////round corner for public button //////
    
    UIBezierPath *maskPath1= [UIBezierPath
                              bezierPathWithRoundedRect:btnCancel.bounds
                              byRoundingCorners:( UIRectCornerBottomRight)
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    maskLayer1.frame = btnCancel.bounds;
    maskLayer1.path = maskPath1.CGPath;
    btnCancel.layer.mask = maskLayer1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    arrSorted=[[NSMutableArray alloc]init];
    arrCollectionView=[[NSMutableArray alloc]init];
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
    return 40.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrSorted.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessCategoryCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.lblCategoryName.text=[arrSorted objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strCategoryName=[arrSorted objectAtIndex:indexPath.row];
    txtCategory.text=strCategoryName;
    tblCategory.hidden=YES;
    collCategories.hidden=NO;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnOKPressed:(id)sender
{
    if (arrCollectionView.count>0)
    {
        NSString * strCategory = [arrCollectionView  componentsJoinedByString:@","];
        NSLog(@"%@",strCategory);
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:strCategory forKey:@"tcategories"];
        NSLog(@"%@",dict);
        NSLog(@"%@",self.strTKey);
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
                    [self.delegate selectedCategoryWithName:strCategory];
                }
            }
        }];
    }
    else
    {
        [self displayErrorWithMessage:@"Please add a category."];
    }
}

-(IBAction)btnCancelPressed:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(IBAction)btnPlusTapped:(id)sender
{
    collCategories.hidden=NO;
    txtCategory.text=@"";
    if (strCategoryName.length>0)
    {
        [arrCollectionView addObject:strCategoryName];
        [collCategories reloadData];
        strCategoryName=@"";
    }
    else
    {
        [self displayErrorWithMessage:@"Please select a category"];
    }
}

-(void)btnDeletePressed:(id)sender
{
    [arrCollectionView removeObjectAtIndex:[sender tag]];
    [collCategories reloadData];
}

#pragma mark
#pragma mark Textfield delegates and  datasource
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(IBAction)textfieldEditingChanged:(id)sender
{
    UITextField *text=(id)sender;
    strCategoryName=text.text;
    if (text.text.length>0)
    {
        collCategories.hidden=YES;
        tblCategory.hidden=NO;
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"SELF beginswith[c] %@",
                                        text.text];
        arrSorted = [[_arrCategoryList filteredArrayUsingPredicate:resultPredicate] mutableCopy];
        if (arrSorted.count>0)
        {
            collCategories.hidden=YES;
        }
        else
        {
            collCategories.hidden=NO;
        }
        NSLog(@"searchResults arr=%@",arrSorted);
        [tblCategory reloadData];
    }
    else
    {
        tblCategory.hidden=YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark collection view datasource and delegate
#pragma mark

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrCollectionView.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString   *strIdentifier=@"CategoryGridCell";
    CategoryGridCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:strIdentifier forIndexPath:indexPath];
    cell.lblCategory.text=[arrCollectionView objectAtIndex:indexPath.row];
    [cell.btnCross addTarget:self action:@selector(btnDeletePressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnCross.tag=indexPath.row;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100.0f,30.0f);
}



- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,50,35);  // top, left, bottom, right
}

@end
