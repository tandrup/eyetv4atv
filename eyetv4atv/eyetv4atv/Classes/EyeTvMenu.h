//
//  EyeTvMenu.h
//  viaplay
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonMenu.h"

@interface EyeTvMenu : JsonMenu {
    NSArray *_items;
}

- (id)init;

@end
