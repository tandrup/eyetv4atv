//
//  EyeTVAppliance.h
//  eyetv4atv
//
//  Created by Mads Tandrup on 8/21/11.
//  Copyright 2012 Mads Tandrup. All rights reserved.
//

#import "BackRowExtras.h"
#import "BackRow.h"
#import "EyeTvInstanceManager.h"

@class TopShelfController;

@interface EyeTVAppliance : BRBaseAppliance <EyeTvInstanceManagerDelegate> {
	TopShelfController*		_topShelfController;
}

@property(nonatomic, readonly, retain) id topShelfController;

- (NSArray*) applianceCategories;

@end
