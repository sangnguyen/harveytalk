

#import "TalkXMPPService.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "DDXML.h"

#import "NSString+Ext.h"
#import "DBHelper.h"


#import "TalkAWSService.h"

#import "TalkUIAlertView.h"
#import "TalkUploadService.h"
#import "NSString+SBJSON.h"

#import "DateHelper.h"


static TalkXMPPService *xmppClient = nil;

#define BLOCKING_NAMESPACE  @"urn:xmpp:blocking"

@implementation TalkXMPPService

@synthesize useSSL = _useSSL,
            userName = _userName,
            passWord = _passWord,
            isXMPPConnected = _isXMPPConnected;

@synthesize xmppStream = _xmppStream;
@synthesize xmppReconnect = _xmppReconnect;
@synthesize xmppRoster = _xmppRoster;
@synthesize xmppRosterStorage = _xmppRosterStorage;
@synthesize xmppvCardTempModule = _xmppvCardTempModule;
@synthesize xmppvCardAvatarModule = _xmppvCardAvatarModule;
@synthesize xmppCapabilities = _xmppCapabilities;
@synthesize xmppCapabilitiesStorage = _xmppCapabilitiesStorage;
@synthesize xmppPing = _xmppPing;
@synthesize xmppTime = _xmppTime;
@synthesize countDisconnected = _countDisconnected,isReseted=_isReseted;

+ (TalkXMPPService*)sharedInstance{
   
        if (!xmppClient) {
            xmppClient = [[TalkXMPPService alloc] init];        
        }
    
    return xmppClient;
}





#pragma mark - Initialize methods
- (void)setupStream{
    _xmppStream = [[XMPPStream alloc]init];
    #if !TARGET_IPHONE_SIMULATOR
	{
		// Want xmpp to run in the background?
		// 
		// P.S. - The simulator doesn't support backgrounding yet.
		//        When you try to set the associated property on the simulator, it simply fails.
		//        And when you background an app on the simulator,
		//        it just queues network traffic til the app is foregrounded again.
		//        We are patiently waiting for a fix from Apple.
		//        If you do enableBackgroundingOnSocket on the simulator,
		//        you will simply see an error message from the xmpp stack when it fails to set the property.		
		_xmppStream.enableBackgroundingOnSocket = YES;
	}
    #endif
    _xmppReconnect = [[XMPPReconnect alloc]init];
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    _xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:_xmppRosterStorage];
    _xmppRoster.autoFetchRoster = YES;
	_xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    
    _xmppCapabilitiesStorage = [[XMPPCapabilitiesCoreDataStorage alloc] init];
	_xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:_xmppCapabilitiesStorage];
    _xmppCapabilities.autoFetchHashedCapabilities = YES;
    _xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    _xmppPing = [[XMPPPing alloc] init];
	_xmppTime = [[XMPPTime alloc] init];
    
}

- (void)activateModules{
    [_xmppReconnect activate:_xmppStream];
    //@@@ CHINH - Remove unused module to prevent crashing when using coredata
//	[_xmppRoster activate:_xmppStream];
//	[_xmppCapabilities activate:_xmppStream];
	[_xmppPing activate:_xmppStream];
	[_xmppTime activate:_xmppStream];
    
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_xmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
	[_xmppPing addDelegate:self delegateQueue:dispatch_get_main_queue()];
	[_xmppTime addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (id)init{
    self = [super init];
    if(self){    
        [self start];
    }
    return self;
}
-(void)pingServer
{
    [self.xmppPing sendPingToServer];
   // [self.xmppPing sendPingToJID:[[self xmppStream] myJID]];

}
/*
 Do setup Stream and init Modules
 */
- (void)start
{
    [self setupStream];
    [self activateModules];
}
-(void)resetXMPP
{     
    self.isReseted =TRUE;
   
}

- (XMPPStream *)xmppStream{
    return _xmppStream;
}

- (XMPPRoster *)xmppRoster{
    return _xmppRoster;
}

- (XMPPRosterCoreDataStorage *)xmppRosterStorage{
    return _xmppRosterStorage;
}

/*
 Connect to XMPP server
*/
- (BOOL)connect{

    
    [[self xmppStream]setHostName:kXmppServer];
    [[self xmppStream]setHostPort:kXmppPort];
    if (!_userName || _passWord == nil) {
       
        return NO;
    }    
    XMPPJID *jid = [XMPPJID jidWithString:[NSString jidWithName:_userName]];
    [[self xmppStream]setMyJID:jid];
    NSError *error = nil;
    if (![[self xmppStream]connect:&error]) {
        
        return NO;
    }
    return YES;
}

-(void)reconnect
{
    [self connect];
}
/*
 Disconnect to XMPP server
 */

- (void)disconnect{
    _isXMPPConnected = FALSE;
    [self offline];
    [[self xmppStream] disconnect];
}

/*
 Send online presence
 Called when Talk is offline
*/
- (void)online{
    XMPPPresence *presence = [XMPPPresence presence]; 
	[[self xmppStream] sendElement:presence];
}

/*
 Send offline presence
 Called when Talk is offline
 */

- (void)offline{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	[[self xmppStream] sendElement:presence];
}




/*
 Send text message request to xmpp server
 */
- (void)sendMessage:(NSString *)msg receivedId:(int)proId to:(NSString *)toJid{
    
    
    NSString * strDate = [NSString getStringDateFromDate:[NSDate date]];    	
    NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:msg];
    NSString *senderId = @"";//TODO
    NSString *receiverId = @"";//TODO
    XMPPMessage *message = [XMPPMessage message];
    [message addAttributeWithName:@"to" stringValue:toJid];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"bodytype" stringValue:@"text"];
    [message addAttributeWithName:@"username" stringValue:@"userName"];//TODO
    
    [message addAttributeWithName:@"receiveid" stringValue:receiverId];
    [message addAttributeWithName:@"senderid" stringValue:senderId];
    [message addAttributeWithName:@"timestamp" stringValue:strDate];    
    [message addChild:body];    
    [[self xmppStream]sendElement:message];       
    
}  

/*
 Send text message request to xmpp server
 */
- (void)sendPhotoAccessRequestMessage:(NSString *)msg receivedId:(int)proId to:(NSString *)toJid type:(NSString*)messageType{
    
       
}  

/*
 Send media message request to xmpp server
 */
- (void) sendMedia:(NSString *)mediaUrl thumUrl:(NSString*)thumbUrl mediaType:(NSObject*)chatType receivedId:(int)proId to:(NSString *)toJid tag:(NSInteger)tagId strDate:(NSString*)strDate{
    
}


#pragma mark Xmpp Stream Delegate
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket 
{
    
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    
   
    _countDisconnected = 0;
    __block NSError *error = nil;
    if (![[self xmppStream]authenticateWithPassword:_passWord error:&error]) {
#if DEBUG
        DLog(@"ERROR AUTHENTICATING:%@",error);
#endif
    }
    //TODO
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%@", [[self xmppStream] myJID]);
    //TODO
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    //TODO
}


- (void)xmppPing:(XMPPPing *)sender didReceivePong:(XMPPIQ *)pong withRTT:(NSTimeInterval)rtt{
   
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    DLog(@"errorcode: %@ == username: %@ == password: %@", error, _userName, _passWord);
   //TODO
}

// presence delegate
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    
    //TODO
                    
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{       
    
    
    NSLog(@"message: %@",message);
    //TODO
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
     
}
-(void)xmppPing:(XMPPPing *)sender didNotReceivePong:(NSString *)pingID dueToTimeout:(NSTimeInterval)timeout{
    //Ping fail
    DLog(@"didNotReceivePong");
}

- (void)xmppTime:(XMPPTime *)sender didReceiveResponse:(XMPPIQ *)iq withRTT:(NSTimeInterval)rtt{
    DLog(@"didReceiveResponse");   
}
- (BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkReachabilityFlags)reachabilityFlags
{		
    DLog(@"shouldAttemptAutoReconnect");       
	return YES;
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq{    
    DLog(@"didReceiveIQ");       
    return YES;
}

@end
