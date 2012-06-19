//
//  EyeTvVideoAsset.h
//  viaplay
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import "BRBaseMediaAsset.h"

@interface EyeTvVideoAsset : BRBaseMediaAsset<BRMediaAsset> {
@private
    NSString *url;
}

- (id)initWithURLString:(NSString*)url;

@end
