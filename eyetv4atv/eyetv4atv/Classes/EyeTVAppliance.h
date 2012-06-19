//
//  ATVAppliance.h
//  atvHelloWorld
//
//  Created by Michael Gile on 8/21/11.
//  Copyright 2011 Michael Gile All rights reserved.
//

#import "BackRowExtras.h"
#import "BackRow.h"

@class TopShelfController;

@interface EyeTVAppliance : BRBaseAppliance <NSNetServiceBrowserDelegate> {
	TopShelfController*		_topShelfController;
	NSArray*				_applianceCategories;
    NSNetServiceBrowser*    _serviceBrowser;
    NSMutableSet*           _services;
}

@property(nonatomic, readonly, retain) id topShelfController;

+ (NSArray*) applianceCategories;

@end
