//
//  EyeTvVideoAsset.h
//  eyetv4atv
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Mads Tandrup. All rights reserved.
//

#import "BRBaseMediaAsset.h"

@interface EyeTvVideoAsset : BRBaseMediaAsset<BRMediaAsset> {
@private
    NSString *baseUrl;
    NSDictionary *item;
}

- (id)initWithBaseURLString:(NSString*)url andData:(NSDictionary *)item;

@end
