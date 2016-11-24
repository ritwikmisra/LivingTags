//
//  ModelViewLocalTags.h
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelViewLocalTags : ModelBaseClass

@property(nonatomic,strong)NSString *strTPhoto;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strLat1;
@property(nonatomic,strong)NSString *strLong1;
@property(nonatomic,strong)NSString *strLink;
@property(nonatomic,strong)NSString *strCreated;
@property(nonatomic,strong)NSString *strDistance;
@property(nonatomic,strong)NSString *strPostedOn;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
