//
//  CategoryService.h
//  LivingTags
//
//  Created by appsbeetech on 03/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CategoryService : WebServiceBaseClass

+(id)service;

-(void)callCategoryServiceWithCompletionHandler:(WebServiceCompletion)handler;

@end
