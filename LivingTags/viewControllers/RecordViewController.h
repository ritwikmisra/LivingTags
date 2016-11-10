//
//  RecordViewController.h
//  LivingTags
//
//  Created by appsbeetech on 20/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import "ModelFolders.h"

@protocol RecordVoiceDelegate <NSObject>

-(void)getVoice:(NSString *)strBase64;


@end
@interface RecordViewController : ViewControllerBaseClassViewController

@property(weak,nonatomic)id<RecordVoiceDelegate>delegate;
@property(nonatomic,strong)ModelFolders *objFolders;
@property(nonatomic,strong)NSString *strAudioFolder;
@property(nonatomic,strong)NSString *strTKey;

@end
