

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void) push: (id)item {
    [self addObject:item];
}

- (id) pop {
    id item = nil;
    if ([self count] != 0) {
        item = [[[self lastObject] retain] autorelease];
        [self removeLastObject];
    }
    return item;
}

- (id) peek {
    id item = nil;
    if ([self count] != 0) {
        item = [[[self lastObject] retain] autorelease];
    }
    return item;
}

@end


@implementation NSMutableArray (Utilities)

- (NSArray *) lastNObjects: (NSInteger) numberOfObjects
{
    if(numberOfObjects >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(self.count - numberOfObjects, numberOfObjects)];
}

- (NSArray *) firstNObjects: (NSInteger) numberOfObjects
{
    if(numberOfObjects >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(0, numberOfObjects)];
}


@end