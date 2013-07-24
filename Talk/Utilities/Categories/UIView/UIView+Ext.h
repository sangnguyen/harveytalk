

#import <Foundation/Foundation.h>

@interface UIView (Ext)
+ (id) loadView:(Class)clazz fromNibNamed:(NSString *)name;
+ (id) viewWithNibName: (NSString *) name;
+ (id) viewWithNibName: (NSString *) name owner: (id) owner options: (NSDictionary *) options;
- (void) addTapGestureRecognizer: (id) target action: (SEL) selector;
- (void) removeAllSubviews;
- (void) addToWindow;
- (UIView *) findFirstResponder;
- (BOOL) findAndResignFirstResponder;

@end
