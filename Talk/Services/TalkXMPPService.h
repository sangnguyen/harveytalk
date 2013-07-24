

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"


@interface TalkXMPPService : NSObject<XMPPStreamDelegate,XMPPPingDelegate,XMPPTimeDelegate,XMPPRosterMemoryStorageDelegate,XMPPReconnectDelegate>{
   
}
+ (TalkXMPPService*) sharedInstance;
@property (nonatomic,assign) BOOL useSSL;
@property BOOL isReseted;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passWord;
@property (nonatomic,assign) BOOL isXMPPConnected;
@property (nonatomic,assign) int countDisconnected;

@property (nonatomic, strong) XMPPPing *xmppPing;
@property (nonatomic, strong) XMPPTime *xmppTime;

@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
-(void)resetXMPP;
- (void)start;
- (BOOL) connect;
- (void) disconnect;
- (void) online;
- (void) offline;
- (void) sendMessage:(NSString *)msg receivedId:(int)proId to:(NSString *)toJid;
- (void)sendPhotoAccessRequestMessage:(NSString *)msg receivedId:(int)proId to:(NSString *)toJid type:(NSString*)messageType;
//- (void) blockUser:(NSString *)jid;
//- (void) unblockUser:(NSString *)jid;
- (void) sendMedia:(NSString *)mediaUrl thumUrl:(NSString*)thumbUrl mediaType:(NSObject*)chatType receivedId:(int)proId to:(NSString *)toJid tag:(NSInteger)tagId strDate:(NSString*)strDate;
-(void)pingServer;
@end

