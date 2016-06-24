//
//  RecordViewController.m
//  LivingTags
//
//  Created by appsbeetech on 20/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "RecordViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface RecordViewController ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    IBOutlet UIButton *btnPlay;
    IBOutlet UIButton *btnRecord;
    IBOutlet UIButton *btnStop;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSString *strBase64Conversion;
}

@end

@implementation RecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [btnStop setEnabled:NO];
    [btnPlay setEnabled:NO];
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    //session get instance
    [[AVAudioSession sharedInstance] setCategory:
     AVAudioSessionCategoryPlayAndRecord error:NULL];
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute,
                            sizeof(audioRouteOverride), &audioRouteOverride);
    // Define the recorder setting
    /*NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];*/
    NSDictionary *recordSetting2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                                    [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:8000.0], AVSampleRateKey,
                                    nil];
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting2 error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnRecordPressed:(id)sender
{
    if (player.playing)
    {
        [player stop];
    }
    if (!recorder.recording)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        [btnRecord setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        // Pause recording
        [recorder pause];
        [btnRecord setTitle:@"Record" forState:UIControlStateNormal];
    }
    [btnStop setEnabled:YES];
    [btnPlay setEnabled:NO];
}

-(IBAction)btnPlayPressed:(id)sender
{
    if (!recorder.recording)
    {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player prepareToPlay];
        player.volume=4.5;
        [player play];
    }
}

-(IBAction)btnStopPressed:(id)sender
{
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

-(IBAction)btnSavePressed:(id)sender
{
    if (strBase64Conversion.length>0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getVoice:)])
        {
            [self.delegate getVoice:strBase64Conversion];
        }
    }
}

#pragma mark
#pragma mark audio player delegates
#pragma mark

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag
{
    [btnRecord setTitle:@"Record" forState:UIControlStateNormal];
    [btnStop setEnabled:NO];
    [btnPlay setEnabled:YES];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSData *data = [NSData dataWithContentsOfURL:recorder.url];
    //base 64 conversion
    NSString *str=[data base64EncodedStringWithOptions:0];
    NSLog(@"%@",str);
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:&playerError];
    NSLog(@"%f",audioPlayer.duration);
    strBase64Conversion=[NSString stringWithFormat:@"data:audio/m4a;base64,%@",str];
}


@end
