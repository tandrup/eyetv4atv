//
//  EyeTvInstanceManager.m
//  eyetv4atv
//
//  Created by Mads Tandrup on 12/07/12.
//  Copyright (c) 2012 Wayin Inc. All rights reserved.
//

#import "EyeTvInstanceManager.h"

@implementation EyeTvInstanceManager

- (id)init {
    self = [super init];
    if (self) {
        _services               = [[NSMutableSet set] retain];
        _serviceBrowser         = [[NSNetServiceBrowser alloc] init];
        [_serviceBrowser setDelegate:self];
        [_serviceBrowser searchForServicesOfType:@"_http._tcp" inDomain:@""];
        NSLog(@"EyeTVAppliance started search for EyeTV services");
    }
    return self;
}

-(void)setDelegate:(id<EyeTvInstanceManagerDelegate>)delegate {
    _delegate = delegate;
}

-(NSSet *)services {
    return _services;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    NSLog(@"Found service: %@", [aNetService name]);
    if ([[aNetService name] hasPrefix:@"EyeTV"]) {
        [_services addObject:aNetService];
        [_delegate servicesChanged];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser {
    NSLog(@"EyeTV: %s", __PRETTY_FUNCTION__);    
}

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)aNetServiceBrowser {
    NSLog(@"EyeTV: %s", __PRETTY_FUNCTION__);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didNotSearch:(NSDictionary *)errorDict {
    NSLog(@"EyeTV: %s %@", __PRETTY_FUNCTION__, errorDict);
}

@end
