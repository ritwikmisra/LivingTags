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

-(id)initWithDictionary:(NSDictionary *)dict;

@end
