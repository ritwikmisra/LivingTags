//
//  ModelMyTagsCount.h
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelMyTagsCount : ModelBaseClass

@property(nonatomic,strong)NSString *strId;
@property(nonatomic,strong)NSString *strTcname;
@property(nonatomic,strong)NSString *strTotaltags;
@property(nonatomic,strong)NSString *strTCKey;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
