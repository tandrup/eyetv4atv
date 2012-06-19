//
//  JsonMenu.h
//  atvHelloWorld
//
//  Created by Mads Tandrup on 08/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import "BRMediaMenuController.h"
#import <SBJson/SBJson.h>

@interface JsonMenu : BRMediaMenuController  {
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
}
- (id)initWithTitle:(NSString *)title andUrl:(NSURL *)url;

//list provider
- (float)heightForRow:(long)row;
- (BOOL)rowSelectable:(long)selectable;

@end
