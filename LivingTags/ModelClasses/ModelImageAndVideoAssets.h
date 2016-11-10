//
//  ModelImageAndVideoAssets.h
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelImageAndVideoAssets : ModelBaseClass

@property(nonatomic,strong)NSString *strTkey;
@property(nonatomic,strong)NSString *strPicURI;
@property(nonatomic,strong)NSString  *strVideoThumb;
@property(nonatomic,strong)NSString *strTAKey;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
