//
//  EyeTvMenu.h
//  viaplay
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRMediaMenuController.h"
#import <SBJson/SBJson.h>

@interface EyeTvMenu : BRMediaMenuController {
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
    NSArray *_items;
}

- (id)initWithService:(NSNetService *)service;

@end
