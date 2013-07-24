

#import "JSONHelper.h"
#import "JSON.h"

@implementation JSONHelper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


+ (NSArray *) getArrayValueFromJsonDict:(NSDictionary *)dict 
                                 forkey:(NSString *)key
{
    return [self getArrayValueFromJsonDict:dict 
                                       forkey:key 
                                 valueForNull:nil];
}

+ (NSArray *) getArrayValueFromJsonDict:(NSDictionary *)dict 
                                 forkey:(NSString *)key
                           valueForNull:(NSArray *)defaultValue
{
    id value = [dict objectForKey:key];
    if (!value || [value class] == [NSNull class])
        return defaultValue;
    return (NSArray *)value;  
}

+ (NSNumber *) getNumberValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key
{
    return [self getNumberValueFromJsonDict:dict 
                                        forkey:key 
                                  valueForNull:[NSNumber numberWithInt:0]];
}

+ (NSNumber *) getNumberValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key
                             valueForNull:(NSNumber *)defaultValue
{
    id value = [dict objectForKey:key];
    if (!value || [value class] == [NSNull class])
        return defaultValue;
    return (NSNumber *)value;    
}

+ (NSString *) getStringValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key
{
    return [self getStringValueFromJsonDict:dict 
                                        forkey:key 
                                  valueForNull:@""];
}

+ (NSString *) getStringValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key
                             valueForNull:(NSString *)defaultValue
{
    id value = [dict objectForKey:key];
    if (!value || [value class] == [NSNull class])
        return defaultValue;
    if ([value respondsToSelector:@selector(stringValue)])
        return [value stringValue];
    if(![value isKindOfClass:[NSString class]]){
        return @"";
    }
    return (NSString *)value;
}

@end
