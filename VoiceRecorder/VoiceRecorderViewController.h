//
//  VoiceRecorderViewController.h
//  VoiceRecorder
//
//  Created by おかやん on 2014/09/08.
//  Copyright (c) 2014年 nanosoftware.biz. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>

@interface VoiceRecorderViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@end
