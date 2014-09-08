//
//  VoiceRecorderViewController.m
//  VoiceRecorder
//
//  Created by おかやん on 2014/09/08.
//  Copyright (c) 2014年 nanosoftware.biz. All rights reserved.
//

#import "VoiceRecorderViewController.h"

//ユーザーインポート





@interface VoiceRecorderViewController ()
- (IBAction)Initialize:(UIButton *)sender;
- (IBAction)RecordStart:(UIButton *)sender;
- (IBAction)RecordStop:(UIButton *)sender;
- (IBAction)PlayRecordedData:(UIButton *)sender;

//@property (nonatomic,strong) AVAudioRecorder *myRecorder;

@property(nonatomic,strong) AVAudioRecorder *avRecorder;
@property(nonatomic,strong) AVAudioSession *audioSession;
@property(nonatomic,strong) AVAudioPlayer *avPlayer;



@end

@implementation VoiceRecorderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Initialize:(UIButton *)sender {
  
    
}

- (IBAction)RecordStart:(UIButton *)sender {

    self.audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    // 使用している機種が録音に対応しているか
    //if ([self.audioSession inputIsAvailable]) {
        [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    //}
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    // 録音機能をアクティブにする
    [self.audioSession setActive:YES error:&error];
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    // 録音中に音量をとる場合はYES
    //    AvRecorder.meteringEnabled = YES;
    
    self.avRecorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:nil error:&error];
    
    if(error){
        NSLog(@"error = %@",error);
        return;
    }
    self.avRecorder.delegate=self;
    //    ５秒録音して終了する場合
    //    [avRecorder recordForDuration: 5.0];
    [self.avRecorder record];
}

- (IBAction)RecordStop:(UIButton *)sender {
   // [self.myRecorder stop];
    [self.avRecorder stop];
}

- (IBAction)PlayRecordedData:(UIButton *)sender {

   /* NSURL *recordingURL = self.myRecorder.url;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordingURL error:nil];
    player.delegate = self;
    [player play];*/
    
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    //再生
    self.avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
    self.avPlayer.delegate = self;
    self.avPlayer.volume=1.0;
    [self.avPlayer play];
}
@end
