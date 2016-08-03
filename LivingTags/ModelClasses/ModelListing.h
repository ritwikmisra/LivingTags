//
//  ModelListing.h
//  LivingTags
//
//  Created by appsbeetech on 17/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelListing : ModelBaseClass

@property(nonatomic,strong) NSString *strID;
@property(nonatomic,strong)NSString *strUserID;
@property(nonatomic,strong)NSString *strTemplateID;
@property(nonatomic,strong)NSString *strCoverURI;
@property(nonatomic,strong)NSString *strPicURI;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strBorn;
@property(nonatomic,strong)NSString *strDied;
@property(nonatomic,strong)NSString *strAddress1;
@property(nonatomic,strong)NSString *strLat1;
@property(nonatomic,strong)NSString *strLong1;
@property(nonatomic,strong)NSString *strAddress2;
@property(nonatomic,strong)NSString *strLat2;
@property(nonatomic,strong)NSString *strLong2;
@property(nonatomic,strong)NSString *strAddress3;
@property(nonatomic,strong)NSString *strLatitude3;
@property(nonatomic,strong)NSString *strLongitude3;
@property(nonatomic,strong)NSString *strWebURI;
@property(nonatomic,strong)NSString *strCreated;
@property(nonatomic,strong)NSString *strPublished;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
