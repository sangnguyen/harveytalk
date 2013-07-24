

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (void) push: (id)item;
- (id) pop;
- (id) peek;

@end

@interface NSArray(Utilities)

- (NSArray *) firstNObjects: (NSInteger) numberOfObjects;
- (NSArray *) lastNObjects: (NSInteger) numberOfObjects;

@end
