//
//  ProductDetailsService.h
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ProductDetailsService : WebServiceBaseClass

+(id)service;

-(void)callProductDetailsServiceWithProductKey:(NSString *)strPKey withCompletionHandler:(WebServiceCompletion)handler;

@end
