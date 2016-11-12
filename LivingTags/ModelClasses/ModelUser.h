//
//  ModelUser.h
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelUser : ModelBaseClass

@property(nonatomic,strong)NSString *strKey;
@property(nonatomic,strong)NSString *strEmail;
@property(nonatomic,strong)NSString *strName;
@property(nonatomic,strong)NSString *strPhone;
@property(nonatomic,strong)NSString *strPicURI;
@property(nonatomic,strong)NSString *strAddress;
@property(nonatomic,strong)NSString *strLat;
@property(nonatomic,strong)NSString *strLong;
@property(nonatomic,strong)NSString *strAfolder;
@property(nonatomic,strong)NSString *strProfilePicFolder;
@property(nonatomic,strong)NSString *strTkey;
@property(nonatomic,strong)NSString *strAkey;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
