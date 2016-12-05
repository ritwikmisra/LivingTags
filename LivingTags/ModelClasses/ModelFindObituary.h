//
//  ModelFindObituary.h
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelFindObituary : ModelBaseClass

@property(nonatomic,strong)NSString *strID;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strObituaryPic;
@property(nonatomic,strong)NSString *strDate;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
