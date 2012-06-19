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

@interface EyeTvMenu () <SBJsonStreamParserAdapterDelegate, NSNetServiceDelegate>
@end

@implementation EyeTvMenu

- (id)initWithService:(NSNetService *)service {
    self = [super init];
    if (self) {
        // Initialization code here.
		[self setListTitle:[service name]];
        self.showSpinner = YES;
		
        // We don't want *all* the individual messages from the
        // SBJsonStreamParser, just the top-level objects. The stream
        // parser adapter exists for this purpose.
        adapter = [[SBJsonStreamParserAdapter alloc] init];
        
        // Set ourselves as the delegate, so we receive the messages
        // from the adapter.
        adapter.delegate = self;
        
        // Create a new stream parser..
        parser = [[SBJsonStreamParser alloc] init];
        
        // .. and set our adapter as its delegate.
        parser.delegate = adapter;
        
        // Normally it's an error if JSON is followed by anything but
        // whitespace. Setting this means that the parser will be
        // expecting the stream to contain multiple whitespace-separated
        // JSON documents.
        parser.supportMultipleDocuments = YES;
        
		BRImage *sp = [[BRThemeInfo sharedTheme] videoItemImage];
		
		[self setListIcon:sp horizontalOffset:0.0 kerningFactor:0.15];

        [service setDelegate:self];
        [service resolveWithTimeout:5.0];
		
        return self;
    }
    
    return self;
}

- (void)netServiceDidResolveAddress:(NSNetService *)aNetService {
    NSString* addr = [aNetService hostName];
    int port = 2170;
    NSString* urlString = [NSString stringWithFormat:@"http://%@:%d/live/recordings/0/0/-1/-1/-date/_REC_WIFIACCESS", addr, port];
    NSLog(@"EyeTV URL: %@", urlString);
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    [[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] autorelease];
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

- (float)heightForRow:(long)row {
	return 0.0f;
}

- (BOOL)rowSelectable:(long)selectable {
	return YES;
}

- (BOOL) brEventAction:(BREvent*)event {
	
	//NSLog(@"%s (%d): Remote action = %d", __PRETTY_FUNCTION__, __LINE__, [event remoteAction]);
	//NSLog(@"%s (%d): Remote value = %d", __PRETTY_FUNCTION__, __LINE__, [event value]);
	//NSLog(@"%s (%d): eventDictionary = %@", __PRETTY_FUNCTION__, __LINE__, [[event eventDictionary] description]);
	
	switch ([event remoteAction]) {
		case BREventMenuButtonAction:
			[[self stack] popController];
			break;
		case BREventUpButtonAction:
		case BREventDownButtonAction:
			[super brEventAction:event];
            [self resetPreviewController];
			break;
		case BREventOKButtonAction:
		case BREventLeftButtonAction:
		case BREventRightButtonAction:
		case BREventPlayPauseButtonAction:
			/* fallthrough */
		default:
			[super brEventAction:event];
			break;
	}
    
	return YES;
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
    
	NSURLCredential *credential = [NSURLCredential credentialWithUser:@"eyetv"
															 password:@"1309"
														  persistence:NSURLCredentialPersistenceForSession];
    
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Connection didReceiveData of length: %u", data.length);
    
	// Parse the new chunk of data. The parser will append it to
	// its internal buffer, then parse from where it left off in
	// the last chunk.
	SBJsonStreamParserStatus status = [parser parse:data];
    
	if (status == SBJsonStreamParserError) {
        //tweet.text = [NSString stringWithFormat: @"The parser encountered an error: %@", parser.error];
		NSLog(@"Parser error: %@", parser.error);
        
	} else if (status == SBJsonStreamParserWaitingForData) {
		NSLog(@"Parser waiting for more data");
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection finish loading");
    //[connection release];
    [adapter release];
    [parser release];
    self.showSpinner = NO;
}


@end
