//
//  EmojiHelper.m
//  Say
//
//  Created by MSN on 7/20/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import "EmojiHelper.h"

@implementation EmojiHelper
+ (NSMutableDictionary *) getPreferences{
    NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kEmojiHelperPreferencesFile];
	if (!prefs) {
        DLog(@"Can not get pref");
	}
	return prefs;
}
+ (void)enableEmoji{
    NSMutableDictionary *prefs = [self getPreferences];
    if (prefs) {
        [prefs setObject:[NSNumber numberWithBool:YES] forKey:kEmojiKey];
        [prefs writeToFile:kEmojiHelperPreferencesFile atomically:NO];
    }
}
@end
