

#import "UIView+Ext.h"

@implementation UIView (Ext)
+ (id) loadView:(Class)clazz fromNibNamed:(NSString *)name {
	id obj = nil;
	NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
	for (id currentObject in topObjects) {
		if ([currentObject isKindOfClass:clazz]) {
			obj = currentObject;
			break;
		}
	}
	return obj;
}

+ (id) viewWithNibName: (NSString *) name
{
	return [self viewWithNibName:name owner:nil options:nil];
}

+ (id) viewWithNibName: (NSString *) name owner: (id) owner options: (NSDictionary *) options
{
	NSArray * toplevelObjects = [[NSBundle mainBundle] loadNibNamed:name owner:owner options:options];
	
	if([toplevelObjects count] > 0)
		return [toplevelObjects objectAtIndex:0];
	
	return nil;
}


- (void) addTapGestureRecognizer: (id) target action: (SEL) selector
{
	UITapGestureRecognizer * tapReg = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
	[self addGestureRecognizer:tapReg];
	[tapReg release];
}


- (void) removeAllSubviews
{
    for(UIView * subview in [self subviews])
    {
        [subview removeFromSuperview];
    }
}


- (void) addToWindow
{
    [self removeFromSuperview];
	UIWindow	*keyWindow	=	[UIApplication sharedApplication].keyWindow;
	
	if([[keyWindow subviews] count] > 0)
	{
		UIView		*rootView	=	[[keyWindow subviews] objectAtIndex:0];
        if([rootView isKindOfClass:[UIAlertView class]])
        {
            if([[keyWindow subviews] count] > 1)
            {
                rootView	=	[[keyWindow subviews] objectAtIndex:1];
            }
            else
            {
                rootView    =   keyWindow;
            }
        }
        
		[rootView addSubview:self];
	}
	else
	{
		[keyWindow addSubview:self];
	}
}

- (UIView *) findFirstResponder
{
	if(self.isFirstResponder)
		return self;
	
	for(UIView *subview in self.subviews)
	{
		UIView *aView	=	[subview findFirstResponder];
		
		if(aView)
			return aView;
	}
	
	return nil;
}

- (BOOL) findAndResignFirstResponder
{
	UIView *responser	=	[self findFirstResponder];
	if(responser)
	{
		[responser resignFirstResponder];
		return YES;
	}
	
	return NO;
}


@end
