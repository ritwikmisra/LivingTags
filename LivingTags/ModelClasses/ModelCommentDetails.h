//
//  ModelCommentDetails.h
//  LivingTags
//
//  Created by appsbeetech on 29/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelCommentDetails : ModelBaseClass

@property(nonatomic,strong) NSString *strAKey;
@property(nonatomic,strong) NSString *strTCKey;
@property(nonatomic,strong) NSString *strTCFolder;
@property(nonatomic,strong) NSString *strTKey;
@property(nonatomic,strong) NSString *strTName;
@property(nonatomic,strong) NSString *strTLink;
@property(nonatomic,strong) NSString *strTCommenterName;
@property(nonatomic,strong) NSString *strTCommenterPhoto;
@property(nonatomic,strong) NSString *strTPhotoType;
@property(nonatomic,strong) NSString *strTCommenterLink;
@property(nonatomic,strong) NSString *strTCommenter;
@property(nonatomic,strong) NSString *strTPublished;
@property(nonatomic,strong) NSString *strTCommentTime;
@property(nonatomic,strong) NSMutableArray *arrCommentAsset;
@property(nonatomic,strong)NSString *strSize;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
