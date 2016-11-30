//
//  RecordViewController.m
//  LivingTags
//
//  Created by appsbeetech on 20/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "RecordViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CLCloudinary.h"
#import "CLUploader.h"
#import <AVFoundation/AVFoundation.h>
#import "LivingTagsSecondStepService.h"


@interface RecordViewController ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate,CLUploaderDelegate>
{
    IBOutlet UIButton *btnPlay;
    IBOutlet UIButton *btnRecord;
    IBOutlet UIButton *btnStop;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    IBOutlet UILabel *lblTimer;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnDiscard;
    
    ////stop watch variables
    NSTimer *stopTimer;
    NSDate *startDate;
    BOOL running;
    
    NSData *dataVoice;
    
    // cloudinary instance
    CLCloudinary *cloudinary;
    NSString *strPublicKey;
}

@end


@implementation RecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnSave.hidden=YES;
    btnDiscard.hidden=YES;
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
    
    //cloudinary initialisation
    cloudinary = [[CLCloudinary alloc] init];
    
    ////////////// developer cloudinary//////////////
    /*
    [cloudinary.config setValue:@"dlivingtags" forKey:@"cloud_name"];
    [cloudinary.config setValue:@"354245266233988" forKey:@"api_key"];
    [cloudinary.config setValue:@"4bNjgpPL3q-UnNH54aeHdLDs_3U" forKey:@"api_secret"];
     */
    
        /////////////////////staging cloudinary///////////////////
    [cloudinary.config setValue:@"livingtags-staging" forKey:@"cloud_name"];
    [cloudinary.config setValue:@"886456191378635" forKey:@"api_key"];
    [cloudinary.config setValue:@"0Zh1hG_DxqNaVaFEX8uP3qR6h4Y" forKey:@"api_secret"];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (___isIphone6)
    {
        lblTimer.font=[lblTimer.font fontWithSize:90];
    }
    else if (___isIphone6Plus)
    {
        lblTimer.font=[lblTimer.font fontWithSize:110];
        
    }
    
    btnSave.layer.cornerRadius=7.0f;
    btnDiscard.layer.cornerRadius=7.0f;
    running = FALSE;
    startDate = [NSDate date];
    [btnPlay setEnabled:NO];
    [btnStop setEnabled:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    btnDiscard.hidden=YES;
    btnSave.hidden=YES;
    if (stopTimer == nil)
    {
        stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                     target:self
                                                   selector:@selector(updateTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    }
    else
    {
        running = FALSE;
        [stopTimer invalidate];
        stopTimer = nil;
    }
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
        // [btnRecord setTitle:@"Pause" forState:UIControlStateNormal];
    }
    /*else
     {
     // Pause recording
     [recorder pause];
     [btnRecord setTitle:@"Record" forState:UIControlStateNormal];
     }
     [btnStop setEnabled:YES];
     [btnPlay setEnabled:NO];*/
    [btnRecord setEnabled:NO];
    [btnRecord setBackgroundImage:[UIImage imageNamed:@"recording"] forState:UIControlStateNormal];
    [btnStop setEnabled:YES];
    [btnStop setBackgroundImage:[UIImage imageNamed:@"stop_enable"] forState:UIControlStateNormal];
    [btnPlay setEnabled:NO];
    [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:UIControlStateNormal];
}

-(IBAction)btnPlayPressed:(id)sender
{
    lblTimer.text = @"00:00";
    btnDiscard.hidden=YES;
    btnSave.hidden=YES;
    if (stopTimer == nil)
    {
        stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                     target:self
                                                   selector:@selector(updateTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    }
    else
    {
        running = FALSE;
        [stopTimer invalidate];
        stopTimer = nil;
    }
    if (!recorder.recording)
    {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player prepareToPlay];
        player.volume=4.5;
        [player play];
    }
    [btnRecord setEnabled:NO];
    [btnRecord setBackgroundImage:[UIImage imageNamed:@"recording"] forState:UIControlStateNormal];
    [btnStop setEnabled:YES];
    [btnStop setBackgroundImage:[UIImage imageNamed:@"stop_enable"] forState:UIControlStateNormal];
    [btnPlay setEnabled:NO];
    [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:UIControlStateNormal];
}

-(IBAction)btnStopPressed:(id)sender
{
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    /*if(!running)
     {
     running = TRUE;
     if (stopTimer == nil)
     {
     stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
     target:self
     selector:@selector(updateTimer)
     userInfo:nil
     repeats:YES];
     }
     }
     else
     {
     running = FALSE;
     [stopTimer invalidate];
     stopTimer = nil;
     }*/
    [self resetTimer];
    lblTimer.text = @"00:00";
    [btnRecord setEnabled:YES];
    [btnRecord setBackgroundImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [btnStop setEnabled:NO];
    [btnStop setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [btnPlay setEnabled:YES];
    [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_enable"] forState:UIControlStateNormal];
}



-(IBAction)btnSavePressed:(id)sender
{
    /* if (strBase64Conversion.length>0)
     {
     [self.navigationController popViewControllerAnimated:YES];
     if (self.delegate && [self.delegate respondsToSelector:@selector(getVoice:)])
     {
     [self.delegate getVoice:strBase64Conversion];
     }
     }*/
    if (dataVoice.length>0)
    {
        NSString * strTimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        if (_objFolders)
        {
            strPublicKey=[NSString stringWithFormat:@"%@/%@",self.objFolders.strAudioFolder,strTimestamp];
        }
        else
        {
            strPublicKey=[NSString stringWithFormat:@"%@/%@",self.strAudioFolder,strTimestamp];
        }
        
        CLUploader* uploader = [[CLUploader alloc] init:cloudinary delegate:self];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:strPublicKey forKey:@"public_id"];
        [dict setObject:@"auto" forKey:@"resource_type"];
        [self displayNetworkActivity];
        [uploader upload:dataVoice options:dict withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
            NSLog(@"%@",errorResult);
            if (errorResult.length>0)
            {
                [self hideNetworkActivity];
                [self displayErrorWithMessage:@"Failure in uploading voice"];
            }
            NSLog(@"%@",successResult);
            if (successResult.count>0)
            {
                @try
                {
                    NSString *strBytes=[successResult objectForKey:@"bytes"];
                    NSString *strPublicID=[successResult objectForKey:@"public_id"];
                    NSString *strFileName=[[successResult objectForKey:@"public_id"] lastPathComponent];
                    appDel.strAudioURL=[successResult objectForKey:@"secure_url"];
                    appDel.audioLength=[[successResult objectForKey:@"duration"] floatValue];
                    NSLog(@"%f",appDel.audioLength);
                    NSLog(@"%@",strFileName);
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                    [dict setObject:strFileName forKey:@"tdata[tvoice]"];
                    [dict setObject:strBytes forKey:@"tdata[tvoicesize]"];
                    [dict setObject:strPublicID forKey:@"public_id"];
                    
                    //web service called
                    if (_objFolders)
                    {
                        [[LivingTagsSecondStepService service]callCloudinaryAudioServiceWithDIctionary:dict tKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                            if (isError)
                            {
                                [self displayErrorWithMessage:strMsg];
                            }
                            else
                            {
                                [self.navigationController popViewControllerAnimated:YES];
                                
                            }
                        }];
                    }
                    else
                    {
                        [[LivingTagsSecondStepService service]callCloudinaryAudioServiceWithDIctionary:dict tKey:self.strTKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                            if (isError)
                            {
                                [self displayErrorWithMessage:strMsg];
                            }
                            else
                            {
                                [self.navigationController popViewControllerAnimated:YES];
                                
                            }
                        }];
                    }

                }
                @catch (NSException *exception)
                {
                    [self displayErrorWithMessage:exception.reason];
                }
                @finally
                {
                    
                }
            }
        } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
            
        }];
    }
    else
    {
        [self displayErrorWithMessage:@"Please record a voice"];
    }
}

-(IBAction)btnDiscardPressed:(id)sender
{
    dataVoice=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark audio player delegates
#pragma mark

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag
{
    btnSave.hidden=NO;
    btnDiscard.hidden=NO;
    dataVoice = [NSData dataWithContentsOfURL:recorder.url];
    [self resetTimer];
    lblTimer.text = @"00:00";
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    btnDiscard.hidden=NO;
    btnSave.hidden=NO;
    [self resetTimer];
    lblTimer.text = @"00:00";
    dataVoice= [NSData dataWithContentsOfURL:recorder.url];
    //base 64 conversion
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:&playerError];
    NSLog(@"%f",audioPlayer.duration);
    //strBase64Conversion=[NSString stringWithFormat:@"data:audio/m4a;base64,%@",str];
    [btnRecord setEnabled:YES];
    [btnRecord setBackgroundImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [btnStop setEnabled:NO];
    [btnStop setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [btnPlay setEnabled:YES];
    [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_enable"] forState:UIControlStateNormal];
}



#pragma mark
#pragma mark STOPWATCH methods
#pragma mark

-(void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"mm:ss"];
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter1 stringFromDate:timerDate];
    lblTimer.text = timeString;
}

#pragma mark
#pragma mark reset timer
#pragma mark

-(void)resetTimer
{
    [stopTimer invalidate];
    stopTimer = nil;
    startDate = [NSDate date];
    running = FALSE;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self resetTimer];
}

@end
