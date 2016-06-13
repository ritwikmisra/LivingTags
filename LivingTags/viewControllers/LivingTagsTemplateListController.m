//
//  LivingTagsTemplateListController.m
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsTemplateListController.h"
#import "GetAllLivingTagsTemplatesService.h"

@interface LivingTagsTemplateListController ()

@end

@implementation LivingTagsTemplateListController

//segueTemplate
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GetAllLivingTagsTemplatesService sharedInstance]getAllTemplateDesignsWithCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            
        }
        else
        {
            NSLog(@"%@",result);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
