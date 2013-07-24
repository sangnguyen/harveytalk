
#import "NSObject+Ext.h"

@implementation NSObject(Ext)

- (NSDictionary *)properties{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

- (id)checkNull{
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self;
}

@end
