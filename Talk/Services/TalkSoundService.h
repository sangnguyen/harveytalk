//
//  TalkSoundService.h
//  Talk
//
//  Created by MSN on 9/8/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface TalkSoundService : NSObject<AVAudioPlayerDelegate>
{
     AVAudioPlayer * player;
}
+ (id)sharedInstance;
- (void)playIncomeMessage;
@end
