//
//  EyeTvMenu.m
//  viaplay
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import "EyeTvMenu.h"
#import "EyeTvVideoAsset.h"
#import "ApplianceConfig.h"
#import "BRImageManager.h"
#import "BRMediaPreviewControlFactory.h"

@implementation EyeTvMenu

- (id)init {
    self = [super initWithTitle:@"EyeTV" andUrl:[NSURL URLWithString:@"http://192.168.1.2:2170/live/recordings/0/0/-1/-1/-date/_REC_WIFIACCESS"]];
    if (self) {
        // Initialization code here.
		return self;
    }
    
    return self;
}

-(void)dealloc {
    [_items release];
	[super dealloc];
}

- (id)previewControlForItem:(long)item {
    NSLog(@"previewControlForItem: %ld", item);
	NSDictionary *itemObj = [_items objectAtIndex:item];
        BRImageAndSyncingPreviewController *controller = [[BRImageAndSyncingPreviewController alloc] init];
        [controller setStatusMessage:[itemObj objectForKey:@"display title"]];
        return controller;
}

- (void)itemSelected:(long)selected {	
	NSDictionary *itemObj = [_items objectAtIndex:selected];
    NSLog(@"%s (%d) item selected: %@", __PRETTY_FUNCTION__, __LINE__, itemObj);
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.2:2170/live/recordingFile/%@/refmovie.mov", [itemObj objectForKey:@"id"]];
    NSLog(@"URL %@", url);
    [[BRMediaPlayerManager singleton] presentMediaAsset:[[[EyeTvVideoAsset alloc] initWithURLString:url] autorelease] options:nil];
}

- (long)itemCount {
	return [_items count];
}

- (id)titleForItem:(NSDictionary *)item {
    return [item objectForKey:@"display title"];
}

- (id)itemForRow:(long)row {	
	if(row > [_items count])
		return nil;
	
	BRMenuItem* menuItem	= [[BRMenuItem alloc] init];
	NSDictionary* item		= [_items objectAtIndex:row];
	NSString* menuTitle = [self titleForItem:item];
	[menuItem setText:menuTitle withAttributes:[[BRThemeInfo sharedTheme] menuItemTextAttributes]];
    [menuItem addAccessoryOfType:0];
	return menuItem;
}

- (id)titleForRow:(long)row {
	return [[_items objectAtIndex:row] objectForKey:@"display title"];
}

#pragma mark SBJsonStreamParserAdapterDelegate methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	NSLog(@"Connection foundArray: %@", array);
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	NSLog(@"Connection foundObject: %@", dict);
    id obj = [dict objectForKey:@"recordings"];
    
    if ([obj isKindOfClass:[NSArray class]]) {
        _items = [obj retain];
    } else if (obj != nil) {
        _items = [[NSArray arrayWithObject:obj] retain];
    } else {
        _items = [[NSArray array] retain];
    }
    
    [[self list] setDatasource:self];
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
    
	NSURLCredential *credential = [NSURLCredential credentialWithUser:@"eyetv"
															 password:@"1309"
														  persistence:NSURLCredentialPersistenceForSession];
    
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

@end
