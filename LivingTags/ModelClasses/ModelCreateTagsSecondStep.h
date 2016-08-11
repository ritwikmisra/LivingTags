//
//  ModelCreateTagsSecondStep.h
//  LivingTags
//
//  Created by appsbeetech on 19/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelCreateTagsSecondStep : ModelBaseClass

@property(nonatomic,strong)NSString *strID;
@property(nonatomic,strong)NSString *strAccountID;
@property(nonatomic,strong)NSString *strTemplateID;
@property(nonatomic,strong)NSString *strCoverURI;
@property(nonatomic,strong)NSString *strUserPicURI;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strBorn;
@property(nonatomic,strong)NSString *strDied;
@property(nonatomic,strong)NSString *strLat1;
@property(nonatomic,strong)NSString *strLat2;
@property(nonatomic,strong)NSString *strLat3;
@property(nonatomic,strong)NSString *strLong1;
@property(nonatomic,strong)NSString *strLong2;
@property(nonatomic,strong)NSString *strLong3;
@property(nonatomic,strong)NSString *strMemorialQuote;
@property(nonatomic,strong)NSString *strGender;
@property(nonatomic,strong)NSString *strAddress1;
@property(nonatomic,strong)NSString *strAddress2;
@property(nonatomic,strong)NSString *strAddress3;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
