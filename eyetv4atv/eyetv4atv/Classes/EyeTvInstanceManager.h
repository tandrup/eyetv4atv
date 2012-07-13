//
//  EyeTvInstanceManager.h
//  eyetv4atv
//
//  Created by Mads Tandrup on 12/07/12.
//  Copyright (c) 2012 Wayin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EyeTvInstanceManagerDelegate <NSObject>
@optional

- (void)servicesChanged;

@end

@interface EyeTvInstanceManager : NSObject <NSNetServiceBrowserDelegate> {
    NSNetServiceBrowser*    _serviceBrowser;
    NSMutableSet*           _services;
    id <EyeTvInstanceManagerDelegate> _delegate;
}

-(id)init;

-(void)setDelegate:(id <EyeTvInstanceManagerDelegate>)delegate;

-(NSSet*)services;

@end
