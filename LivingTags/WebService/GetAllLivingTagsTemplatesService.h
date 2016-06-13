//
//  GetAllLivingTagsTemplatesService.h
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface GetAllLivingTagsTemplatesService : WebServiceBaseClass


+(id)sharedInstance;

-(void)getAllTemplateDesignsWithCompletionHandler:(WebServiceCompletion)handler;
@end
