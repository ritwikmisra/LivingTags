//
//  CategoryController.h
//  LivingTags
//
//  Created by appsbeetech on 03/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import "ModelFolders.h"

@protocol SelectCategoryProtocol <NSObject>

-(void)selectedCategoryWithName:(NSString *)strName;

@end

@interface CategoryController : ViewControllerBaseClassViewController

@property(nonatomic,strong) NSMutableArray *arrCategoryList;
@property(nonatomic,strong)ModelFolders *objFolders;
@property(nonatomic,strong)NSString *strTKey;
@property(nonatomic,weak)id<SelectCategoryProtocol> delegate;

@end
