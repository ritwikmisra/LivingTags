//
//  ModelImageUpload.h
//  LivingTags
//
//  Created by appsbeetech on 17/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelImageUpload : ModelBaseClass

@property(nonatomic,strong)NSString *strAssetType;
@property(nonatomic,strong)NSString *strAssetURL;
@property(nonatomic,strong)NSString *strAudio;
@property(nonatomic,strong)NSString *strCreated;
@property(nonatomic,strong)NSString *strDateTaken;
@property(nonatomic,strong)NSString *strID;
@property(nonatomic,strong)NSString *strLivingTagsID;
@property(nonatomic,strong)NSString *strTitle;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
