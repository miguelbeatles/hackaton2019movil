//
//  UTReachability.h
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

struct sockaddr_in;

typedef NS_ENUM(int, UTNetworkStatus)
{
    UTNetworkStatusNotReachable,
    UTNetworkStatusReachableViaWiFi,
    UTNetworkStatusReachableViaWWAN
};

extern NSString *const UTReachabilityChangedNotification;

@interface UTReachability : NSObject

+(BOOL)netConnection;

//reachabilityWithHostName- Use to check the reachability of a particular host name.
+(UTReachability *)reachabilityWithHostName:(NSString *)hostName;

//reachabilityWithAddress- Use to check the reachability of a particular IP address.
+(UTReachability *)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;

//reachabilityForInternetConnection- checks whether the default route is available.
// Should be used by applications that do not connect to a particular host
+(UTReachability *)reachabilityForInternetConnection;

//reachabilityForLocalWiFi- checks whether a local wifi connection is available.
+(UTReachability *)reachabilityForLocalWiFi;

//Start listening for reachability notifications on the current run loop
-(BOOL)startNotifier;
-(void)stopNotifier;
-(UTNetworkStatus)currentReachabilityStatus;

//WWAN may be available, but not active until a connection has been established.
//WiFi may require a connection for VPN on Demand.
-(BOOL)connectionRequired;

@end
