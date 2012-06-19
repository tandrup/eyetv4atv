//
//  JsonMenu.m
//  atvHelloWorld
//
//  Created by Mads Tandrup on 08/01/12.
//  Copyright 2012 Wayin Inc. All rights reserved.
//

#import "JsonMenu.h"
#import "ApplianceConfig.h"

@interface JsonMenu () <SBJsonStreamParserAdapterDelegate>
@end

@class BRWebView;

@implementation JsonMenu
- (id)initWithTitle:(NSString *)title andUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        // Initialization code here.
		[self setListTitle:title];
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
        
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60.0];
        
        [[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] autorelease];
        
		BRImage *sp = [[BRThemeInfo sharedTheme] videoItemImage];
		
		[self setListIcon:sp horizontalOffset:0.0 kerningFactor:0.15];
		
		return self;
    }
    
    return self;
}

-(void)dealloc {
	[super dealloc];
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

#pragma mark SBJsonStreamParserAdapterDelegate methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	NSLog(@"Connection foundArray: %@", array);
    [NSException raise:NSInternalInconsistencyException 
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	NSLog(@"Connection foundObject: %@", dict);
    [NSException raise:NSInternalInconsistencyException 
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
    
	NSURLCredential *credential = [NSURLCredential credentialWithUser:@"foo"
															 password:@"bar"
														  persistence:NSURLCredentialPersistenceForSession];
    
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
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
