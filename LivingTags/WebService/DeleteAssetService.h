//
//  DeleteAssetService.h
//  LivingTags
//
//  Created by appsbeetech on 31/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface DeleteAssetService : WebServiceBaseClass

+(id)service;

-(void)deleteAssetWithkey:(NSString *)strTAKey withCompletionHandler:(WebServiceCompletion)handler;

@end
