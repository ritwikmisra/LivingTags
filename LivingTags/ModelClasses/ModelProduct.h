//
//  ModelProduct.h
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelProduct : ModelBaseClass

@property(nonatomic,strong)NSString *strId;
@property(nonatomic,strong)NSString *strPkey;
@property(nonatomic,strong)NSString *strPfolder;
@property(nonatomic,strong)NSString *strPname;
@property(nonatomic,strong)NSString *strPuri;
@property(nonatomic,strong)NSString *strPrice;
@property(nonatomic,strong)NSString *strPabout;
@property(nonatomic,strong)NSString *strPavailable;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
