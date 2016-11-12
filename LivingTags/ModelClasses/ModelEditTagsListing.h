//
//  ModelEditTagsListing.h
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelEditTagsListing : ModelBaseClass


@property(nonatomic,strong)NSString *strAkey;
@property(nonatomic,strong)NSString *strPosted_time;
@property(nonatomic,strong)NSString *strtkey;
@property(nonatomic,strong)NSString *strtphoto;
@property(nonatomic,strong)NSString *strTname;
@property(nonatomic,strong)NSString *strCname;
@property(nonatomic,strong)NSString *strTotal_comments;
@property(nonatomic,strong)NSString *strTotal_views;
@property(nonatomic,strong)NSString *strTsize;
@property(nonatomic,strong)NSString *strTLink;
@property(nonatomic,strong)NSString *strTCName;


-(id)initWithDictionary:(NSDictionary *)dict;

@end
