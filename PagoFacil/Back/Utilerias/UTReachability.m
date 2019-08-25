//
//  UTReachability.m
//  PagoFacil
//
//  Created by Luis Batsu on 8/24/19.
//  Copyright © 2019 Luis Batsu. All rights reserved.
//

#import "UTReachability.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <CoreFoundation/CoreFoundation.h>

NSString *const UTReachabilityChangedNotification = @"UTReachabilityChangedNotification";

#define UTShouldPrintReachabilityFlags 0

static void PrintReachabilityFlags(SCNetworkReachabilityFlags flags, const char* comment)
{
#if UTShouldPrintReachabilityFlags
    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
          (flags & kSCNetworkReachabilityFlagsIsWWAN)	? 'W' : '-',
          (flags & kSCNetworkReachabilityFlagsReachable) ? 'R' : '-',
          (flags & kSCNetworkReachabilityFlagsTransientConnection) ? 't' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionRequired) ? 'c' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) ? 'C' : '-',
          (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) ? 'D' : '-',
          (flags & kSCNetworkReachabilityFlagsIsLocalAddress) ? 'l' : '-',
          (flags & kSCNetworkReachabilityFlagsIsDirect) ? 'd' : '-',
          comment
          );
#endif
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject*) info isKindOfClass:[UTReachability class]], @"info was wrong class in ReachabilityCallback");
    
    //We're on the main RunLoop, so an NSAutoreleasePool is not necessary, but is added defensively
    // in case someon uses the Reachablity object in a different thread.
    @autoreleasepool
    {
        UTReachability *noteObject = (__bridge UTReachability *)info;
        // Post a notification to notify the client that the network reachability changed.
        [[NSNotificationCenter defaultCenter] postNotificationName:UTReachabilityChangedNotification object:noteObject];
    }
}

@implementation UTReachability
{
    BOOL localWiFiRef;
    SCNetworkReachabilityRef reachabilityRef;   
}

-(BOOL)startNotifier
{
    BOOL retVal = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    if(SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback, &context))
    {
        if(SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode)) // DFH CFRunLoopGetCurrent()
        {
            retVal = YES;
        }
    }
    return retVal;
}

-(void)stopNotifier
{
    if(reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);	// CFRunLoopGetCurrent()
    }
}

-(void)dealloc
{
    [self stopNotifier];
    if(reachabilityRef!= NULL)
    {
        CFRelease(reachabilityRef);
    }
}

+(BOOL)netConnection
{
	UTReachability *reachability = [UTReachability reachabilityForInternetConnection];
	UTNetworkStatus netStatus = [reachability currentReachabilityStatus];
	return (netStatus != UTNetworkStatusNotReachable);
}

+(UTReachability *)reachabilityWithHostName:(NSString *)hostName;
{
    UTReachability *retVal = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if(reachability != NULL)
    {
        retVal = [[self alloc] init];
        if(retVal != NULL)
        {
            retVal->reachabilityRef = reachability;
            retVal->localWiFiRef = NO;
        }
    }
    return retVal;
}

+(UTReachability *)reachabilityWithAddress:(const struct sockaddr_in*)hostAddress;
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
    UTReachability *retVal = NULL;
    if(reachability != NULL)
    {
        retVal = [[self alloc] init];
        if(retVal != NULL)
        {
            retVal->reachabilityRef = reachability;
            retVal->localWiFiRef = NO;
        }
    }
    return retVal;
}

+(UTReachability *)reachabilityForInternetConnection;
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress: &zeroAddress];
}

+(UTReachability *)reachabilityForLocalWiFi;
{
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    
    // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    UTReachability *retVal = [self reachabilityWithAddress:&localWifiAddress];
    if(retVal != NULL)
    {
        retVal->localWiFiRef = YES;
    }
    return retVal;
}

#pragma mark Network Flag Handling

-(UTNetworkStatus)localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "localWiFiStatusForFlags");
    BOOL retVal = UTNetworkStatusNotReachable;
    if((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
    {
        retVal = UTNetworkStatusReachableViaWiFi;
    }
    return retVal;
}

-(UTNetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    if((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        // if target host is not reachable
        return UTNetworkStatusNotReachable;
    }
    
    BOOL retVal = UTNetworkStatusNotReachable;
    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        retVal = UTNetworkStatusReachableViaWiFi;
    }
    
    if((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs
        if((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            retVal = UTNetworkStatusReachableViaWiFi;
        }
    }
    
    if((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        // ... but WWAN connections are OK if the calling application
        // is using the CFNetwork (CFSocketStream?) APIs.
        retVal = UTNetworkStatusReachableViaWWAN;
    }
    return retVal;
}

-(BOOL)connectionRequired;
{
    NSAssert(reachabilityRef != NULL, @"connectionRequired called with NULL reachabilityRef");
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    }
    return NO;
}

-(UTNetworkStatus)currentReachabilityStatus
{
    NSAssert(reachabilityRef != NULL, @"currentNetworkStatus called with NULL reachabilityRef");
    UTNetworkStatus retVal = UTNetworkStatusNotReachable;
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        if(localWiFiRef)
        {
            retVal = [self localWiFiStatusForFlags: flags];
        }
        else
        {
            retVal = [self networkStatusForFlags: flags];
        }
    }
    return retVal;
}

@end
