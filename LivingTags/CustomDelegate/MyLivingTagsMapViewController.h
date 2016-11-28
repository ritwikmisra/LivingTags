//
//  MyLivingTagsMapViewController.h
//  LivingTags
//
//  Created by appsbeetech on 19/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"

@protocol RemoveMapFromListDelegate <NSObject>

@optional
-(void)removeMapFromSuperview;
-(void)moveToWebview:(NSString *)str;

@end

@interface MyLivingTagsMapViewController : ViewControllerBaseClassViewController

@property(nonatomic,weak)id<RemoveMapFromListDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *arrListFromMap;
+(id)instance;
@end
