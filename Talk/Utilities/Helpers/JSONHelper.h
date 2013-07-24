

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject{
    
}



+ (NSArray *) getArrayValueFromJsonDict:(NSDictionary *)dict 
                                 forkey:(NSString *)key;
+ (NSArray *) getArrayValueFromJsonDict:(NSDictionary *)dict 
                                 forkey:(NSString *)key
                           valueForNull:(NSArray *)defaultValue;


+ (NSNumber *) getNumberValueFromJsonDict:(NSDictionary *)dict 
                                   forkey:(NSString *)key;
+ (NSNumber *) getNumberValueFromJsonDict:(NSDictionary *)dict 
                                   forkey:(NSString *)key
                             valueForNull:(NSNumber *)defaultValue;


+ (NSString *) getStringValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key;
+ (NSString *) getStringValueFromJsonDict:(NSDictionary *)dict
                                   forkey:(NSString *)key
                             valueForNull:(NSString *)defaultValue;



@end
