//
//  CloudinaryImageUploadService.h
//  LivingTags
//
//  Created by appsbeetech on 28/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CloudinaryImageUploadService : WebServiceBaseClass

+(id)service;

-(void)callCloudinaryImageUploadServiceWithBytes:(NSString *)strBytes created_date:(NSString *)strCreatedDate fileName:(NSString *)strFileName k_key:(NSString *)strt_key type:(NSString *)strType public_id:(NSString *)strPublicID withCompletionHandler:(WebServiceCompletion)completionHandler;
@end
