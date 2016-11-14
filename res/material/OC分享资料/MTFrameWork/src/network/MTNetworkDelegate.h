
#import <Foundation/Foundation.h>

@protocol MTNetworkDelegate
@required
// xml configure file name
- (NSString *)configureFileName;

// get the server name, "http://api.m.mtime.cn/"
- (NSString *)serverName;

// generate network request header dictionary
// the dictionary's key-value would be set to request directly
// 
- (NSDictionary *)requestHeader:(NSString *)abstractUrl andData:(NSDictionary *)dictionary;

// convert server time from string
- (NSDate *)convertServerTime:(NSString *)dateStr;

@optional

// host name for detect network reachability
// return the host name "api.m.mtime.com"
- (NSString *)hostNameForReachability;

// notification from MTService, that network reachability has been changed
// reachable, whether or not network can be reachable
- (void)networkReachabilityChanged:(BOOL)reachable;

@end

