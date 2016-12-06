//
//  ModelAssetDetails.h
//  LivingTags
//
//  Created by appsbeetech on 06/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelAssetDetails : ModelBaseClass

@property(nonatomic,strong)NSString *strTCAkey;
@property(nonatomic,strong)NSString *strTCKey;
@property(nonatomic,strong)NSString *strTCAType;
@property(nonatomic,strong)NSString *strAssets;
@property(nonatomic,strong)NSString *strAssetsSize;
@property(nonatomic,strong)NSString *strAssetsThumb;

-(id)initwithDictionary:(NSDictionary *)dict;

@end
