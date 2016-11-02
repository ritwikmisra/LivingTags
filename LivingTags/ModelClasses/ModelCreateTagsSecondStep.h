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
@property(nonatomic,strong)NSString *strtKey;
@property(nonatomic,strong)NSString *strAccountID;
@property(nonatomic,strong)NSString *strTemplateID;
@property(nonatomic,strong)NSString *strCoverURI;
@property(nonatomic,strong)NSString *strUserPicURI;
@property(nonatomic,strong)NSString *strtname;
@property(nonatomic,strong)NSString *strtborn;
@property(nonatomic,strong)NSString *strtdied;
@property(nonatomic,strong)NSString *strtlat1;
@property(nonatomic,strong)NSString *strtlong1;
@property(nonatomic,strong)NSString *strMemorialQuote;
@property(nonatomic,strong)NSString *strtgender;
@property(nonatomic,strong)NSString *strtaddress1;

@property(nonatomic,strong)NSString *strSlogan;
@property(nonatomic,strong)NSString *strTcname;
@property(nonatomic,strong)NSString *strTphone;
@property(nonatomic,strong)NSString *strTfax;
@property(nonatomic,strong)NSString *strEmail;
@property(nonatomic,strong)NSString *strTcategories;

@property(nonatomic,strong)NSString *strAddress2;
@property(nonatomic,strong)NSString *strLat2;
@property(nonatomic,strong)NSString *strlong2;

@property(nonatomic,strong)NSString *strMobile;
@property(nonatomic,strong)NSString *strWebsite;



-(id)initWithDictionary:(NSDictionary *)dict;

@end
