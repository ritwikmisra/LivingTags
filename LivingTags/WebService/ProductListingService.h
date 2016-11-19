//
//  ProductListingService.h
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ProductListingService : WebServiceBaseClass

+(id)service;

-(void)callProductListWebServiceWithPageNumbe:(int)page withCompletionHandler:(WebServiceCompletion)handler;

@end
