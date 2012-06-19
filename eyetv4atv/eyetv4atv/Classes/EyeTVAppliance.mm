//
//  ATVAppliance.mm
//  atvHelloWorld
//
//  Created by Michael Gile on 8/21/11.
//  Copyright 2011 Michael Gile. All rights reserved.
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
		_topShelfController		= [[TopShelfController alloc] init];
		_applianceCategories	= [[EyeTVAppliance applianceCategories] retain];
    }
    
    return self;
}

- (void) dealloc {
	[_applianceCategories release];
	[_topShelfController release];
	[super dealloc];
}

- (id) applianceCategories {
	return _applianceCategories;
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
	id controller	= nil;
	
    controller = [[[EyeTvMenu alloc] init] autorelease];

	return controller;
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

@end
