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

static EyeTvInstanceManager* _instanceManager;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        _instanceManager = [[EyeTvInstanceManager alloc] init];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [_instanceManager setDelegate:self];
		_topShelfController		= [[TopShelfController alloc] init];
        NSLog(@"EyeTVAppliance initialized");
    }
    
    return self;
}

- (void) dealloc {
	[_topShelfController release];
	[super dealloc];
}

- (id) applianceCategories {
    NSSet* _services = [_instanceManager services];
    NSMutableArray* categoryList = [[NSMutableArray alloc] initWithCapacity:[_services count]];
	
    int idx = 0;
    for (NSNetService* service in _services) {
        [categoryList addObject:[BRApplianceCategory categoryWithName:[[service name] substringFromIndex:6]
                                                           identifier:service
                                                       preferredOrder:idx++]];
    }

    NSLog(@"applianceCategories %d", idx);

	return [NSArray arrayWithArray:[categoryList autorelease]];
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

- (id) applianceInfo {
    NSLog(@"applianceInfo");
    BRApplianceInfo* appInfo = [[BRApplianceInfo alloc] init];
    appInfo.isRemoteAppliance = YES;
    return appInfo;
}

- (void)servicesChanged {
    [self reloadCategories];
}

@end
