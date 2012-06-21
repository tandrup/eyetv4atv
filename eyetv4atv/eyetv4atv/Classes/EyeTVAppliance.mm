//
//  EyeTVAppliance.mm
//  eyetv4atv
//
//  Created by Mads Tandrup on 20/06/12.
//  Copyright 2012 Mads Tandrup. All rights reserved.
//

#import "EyeTVAppliance.h"
#import "ApplianceConfig.h"
#import "TopShelfController.h"
#import "BRMediaPlayer.h"
#import "BRMediaPlayerManager.h"
#import "EyeTvMenu.h"

@implementation EyeTVAppliance

@synthesize topShelfController = _topShelfController;

+ (NSArray*) applianceCategories {
	
	NSMutableArray* categoryList = [[NSMutableArray alloc] initWithCapacity:5];
	
	[categoryList addObject:[BRApplianceCategory categoryWithName:@"EyeTV" 
													   identifier:@"EyeTV" 
												   preferredOrder:0]];
	
	return [NSArray arrayWithArray:[categoryList autorelease]];
}


+ (void) initialize {
	;
}

- (id)init {
    self = [super init];
    if (self) {
        _services               = [[NSMutableSet set] retain];
        _serviceBrowser         = [[NSNetServiceBrowser alloc] init];
        [_serviceBrowser setDelegate:self];
        [_serviceBrowser searchForServicesOfType:@"_http._tcp" inDomain:@""];
		_topShelfController		= [[TopShelfController alloc] init];
		_applianceCategories	= [[EyeTVAppliance applianceCategories] retain];
        
    }
    
    return self;
}

- (void) dealloc {
    [_serviceBrowser release];
    [_services release];
	[_applianceCategories release];
	[_topShelfController release];
	[super dealloc];
}

- (id) applianceCategories {
    NSMutableArray* categoryList = [[NSMutableArray alloc] initWithCapacity:[_services count]];
	
    int idx = 0;
    for (NSNetService* service in _services) {
        [categoryList addObject:[BRApplianceCategory categoryWithName:[[service name] substringFromIndex:6]
                                                           identifier:service
                                                       preferredOrder:idx++]];
    }
	
	return [NSArray arrayWithArray:[categoryList autorelease]];

	//return _applianceCategories;
}

- (id) identifierForContentAlias:(id)contentAlias {
	return APPLIANCE_MODULE_NAME;
}

- (id) selectCategoryWithIdentifier:(id)ident {
	NSLog(@"[DEBUG] %s (%d): ident = %@", __PRETTY_FUNCTION__, __LINE__, [ident description]);
	return nil;
}

- (BOOL) handleObjectSelection:(id)fp8 userInfo:(id)fp12 {
	NSLog(@"[ENTRY] %s (%d)", __PRETTY_FUNCTION__, __LINE__);
	return YES;
}

- (id) applianceSpecificControllerForIdentifier:(id)arg1 args:(id)arg2 {
	//NSLog(@"applianceSpecificControllerForIdentifier: %@ args: %@", arg1, arg2);
	return nil;
}

- (id) controllerForIdentifier:(id)identifier args:(id)args
{
    return [[[EyeTvMenu alloc] initWithService:identifier] autorelease];
}

- (id) localizedSearchTitle { 
	return APPLIANCE_LOCALIZED_NAME; 
}

- (id) applianceName { 
	return APPLIANCE_NAME; 
}

- (id) moduleName { 
	return APPLIANCE_MODULE_NAME; 
}

- (id) applianceKey { 
	return APPLIANCE_KEY; 
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    NSLog(@"Found service: %@", [aNetService name]);
    if ([[aNetService name] hasPrefix:@"EyeTV"]) {
        [_services addObject:aNetService];
    }
}

@end
