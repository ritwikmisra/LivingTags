//
//  ModelLivingTagsViewedAndCreated.h
//  LivingTags
//
//  Created by appsbeetech on 03/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelLivingTagsViewedAndCreated : ModelBaseClass

@property(nonatomic,strong)NSString *strCreated;
@property(nonatomic,strong)NSString *strViewd;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
