


#import "NSURL+Ext.h"


@implementation NSURL (Ext)

- (NSString*)baseString {
	// Let's see if we can build it, it'll be the most accurate
	if([self scheme] && [self host]) {
		NSMutableString* baseString = [[NSMutableString alloc] initWithString:@""];
		
		[baseString appendFormat:@"%@://", [self scheme]];
		
		if([self user]) {
			if([self password]) {
				[baseString appendFormat:@"%@:%@@", [self user], [self password]];
			} else {
				[baseString appendFormat:@"%@@", [self user]];
			}
		}
		
		[baseString appendString:[self host]];
		
		if([self port]) {
			[baseString appendFormat:@":%d", [[self port] integerValue]];
		}
		
		[baseString appendString:@"/"];
		
		return [baseString autorelease];
	}
	
	// Oh Well, time to strip it down
	else {
		NSString* baseString = [self absoluteString];
		
		if(![[self path] isEqualToString:@"/"]) {
			baseString = [baseString stringByReplacingOccurrencesOfString:[self path] withString:@""];
		}
		
		if(self.query) {
			baseString = [baseString stringByReplacingOccurrencesOfString:[self query] withString:@""];
		}
		
		baseString = [baseString stringByReplacingOccurrencesOfString:@"?" withString:@""];
		
		if(![baseString hasSuffix:@"/"]) {
			baseString = [baseString stringByAppendingString:@"/"];
		}
		
		return baseString;
	}
}

@end
