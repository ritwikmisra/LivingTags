//
//  VoiceTagCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceTagCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIButton *btnVoice;

@property(nonatomic,strong)IBOutlet UIButton *btnRecordPlay;
@property(nonatomic,strong)IBOutlet UISlider *sliderRecorder;


@end
