//
//  ModelLivingTagsTemplateList.h
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelLivingTagsTemplateList : ModelBaseClass

-(id)initWithDictionary:(NSDictionary *)dict;

@property(nonatomic,strong)NSString *strTemplateID;
@property(nonatomic,strong)NSString *strTemplateURI;
@property(nonatomic,strong)NSString *strTemplateName;
@property(nonatomic,strong)NSString *strTemplateThumb;

@end
