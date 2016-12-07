//
//  ModelFolders.h
//  LivingTags
//
//  Created by appsbeetech on 28/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelFolders : ModelBaseClass


@property(nonatomic,strong)NSString *strTkey;
@property(nonatomic,strong)NSString *strAudioFolder;
@property(nonatomic,strong)NSString *strVideoFolder;
@property(nonatomic,strong)NSString *strImageFolder;
@property(nonatomic,strong)NSString *strTFolder;
@property(nonatomic,strong)NSString *strProfileFolder;
@property(nonatomic,strong)NSString *strCoverPicFolder;

-(id)initWithDictionary:(NSDictionary *)dict;
@end
