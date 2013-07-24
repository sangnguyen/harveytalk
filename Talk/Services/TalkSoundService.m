//
//  TalkSoundService.m
//  Talk
//
//  Created by MSN on 9/8/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import "TalkSoundService.h"
static TalkSoundService *soundInstance = nil;
@implementation TalkSoundService
+ (id)sharedInstance{
    @synchronized(self){
        if (!soundInstance) {
            soundInstance = [[TalkSoundService alloc] init];
        }
    }
    return soundInstance;
}
- (id)init
{
    self = [super init];
    if(self)
    {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Tri-tone" ofType:@"caf"];
        player =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
        player.delegate = self;
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    }
    return self;
}

- (void)playIncomeMessage
{
    [player play];
}
@end
