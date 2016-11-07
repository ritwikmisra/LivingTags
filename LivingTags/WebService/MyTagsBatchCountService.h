//
//  MyTagsBatchCountService.h
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface MyTagsBatchCountService : WebServiceBaseClass

+(id)service;

-(void)getMyTagsBatchCountServiceWithCompletionHandler:(WebServiceCompletion)handler;

@end
