//
//  socialLoginFirstService.h
//  LivingTags
//
//  Created by appsbeetech on 11/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface socialLoginFirstService : WebServiceBaseClass

+(id)service;

-(void)callSocialServiceFirstTymWithSocialAccountID:(NSString *)strSocialAccountID email:(NSString *)strEmail picture:(NSString *)strPicURL name:(NSString *)strName socialSite:(NSString *)strSocialSite socialEmailAvailable:(NSString *)strEmailAvailable withCompletionHandler:(WebServiceCompletion)Completionhandler;
@end
