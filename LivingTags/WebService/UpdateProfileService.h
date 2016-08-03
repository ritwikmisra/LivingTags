//
//  UpdateProfileService.h
//  LivingTags
//
//  Created by appsbeetech on 03/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface UpdateProfileService : WebServiceBaseClass

+(id)service;

-(void)callUpdateProfileRequestWIthUserID:(NSString *)strUserID Name:(NSString *)strName Address:(NSString *)strAddress Latitude:(NSString *)strLatitude Longitude:(NSString *)strLongitude videoURI:(NSString *)strvideoURI phoneNumber :(NSString *)strPhoneNumber userFile:(UIImage *)imgChosen withCompletionHandler:(WebServiceCompletion)completionHandler;

@end
