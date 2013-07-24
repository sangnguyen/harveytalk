
#import <Foundation/Foundation.h>

@interface NSObject(Ext)
@property(readonly,getter = properties) NSDictionary* properties;

- (id)checkNull;
@end
