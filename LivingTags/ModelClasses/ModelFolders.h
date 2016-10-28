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

-(id)initWithDictionary:(NSDictionary *)dict;
@end
