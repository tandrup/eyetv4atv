//
//  EyeTvVideoAsset.m
//  eyetv4atv
//
//  Created by Mads Tandrup on 28/01/12.
//  Copyright 2012 Mads Tandrup. All rights reserved.
//

#import "EyeTvVideoAsset.h"
#import "BRURLImageProxy.h"
#import "BRMediaType.h"
#import "BRImageLoader.h"

@implementation EyeTvVideoAsset

- (id)initWithBaseURLString:(NSString *)link andData:(NSDictionary*)data
{
    [super init];
    baseUrl = [link retain];
    item = [data retain];
    return self;
}

- (void) dealloc {
    [baseUrl release];
    [item release];
	[super dealloc];
}

#pragma mark BRMediaPreviewFactoryDelegate

- (BOOL)mediaPreviewShouldShowMetadata{ 
	return YES;
}
- (BOOL)mediaPreviewShouldShowMetadataImmediately{ 
	return YES;
}


#pragma mark BRMediaAsset
- (id)provider {
	return nil;
}

- (id)assetID {
	return [item objectForKey:@"id"];
};

- (id)titleForSorting {
	return [self title];
};

-(id)title {
 	return [[item objectForKey:@"info"] objectForKey:@"recording title"];
}

- (id)artist {
	return @"artist";
};

- (id)artistForSorting {
	return [self artist];
};

- (id)AlbumName {
	return @"Album Name";
};

- (id)AlbumID {
	return @"1234";
}

- (id)TrackNum {
	return @"1";
};

- (id)composer {
	return nil;
};

- (id)composerForSorting {
	return nil;
};

- (id)copyright {
	return nil;
};

- (void)setUserStarRating:(float)fp8 {
	
};

- (float)starRating {
	return 4;
};

- (BOOL)isHD {
	return NO;
};

- (long)duration; {
	return 147;
}

- (BOOL)isWidescreen {
	return YES;
};

- (BOOL)closedCaptioned {
	return NO;
};

- (BOOL)dolbyDigital {
	return NO;
};

- (long)performanceCount {
	return 1;
};

- (void)incrementPerformanceCount {
	
};

- (void)incrementPerformanceOrSkipCount:(unsigned int)fp8 {
	
};

- (BOOL)hasBeenPlayed {
	return YES;
};

- (void)setHasBeenPlayed:(BOOL)fp8 {
	
};

- (id)previewURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/live/thumbnail/0/%@", baseUrl, [self assetID]]];
};
- (id)trickPlayURL {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
	return nil;
};
- (id)imageProxy {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
	return [BRURLImageProxy proxyWithURL:[self previewURL]];
};

- (id)imageProxyWithBookMarkTimeInMS:(unsigned int)fp8 {	
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
	return nil;
};
- (BOOL)hasCoverArt {
	return YES;
};
- (BOOL)isProtectedContent {
	return NO;
};
- (id)playbackRightsOwner {
	return nil;
};
- (BOOL)isDisabled {
	return NO;
};
- (id)collections {
	return nil;
};
- (id)primaryCollection {
	return nil;
};
- (id)artistCollection {
	return nil;
};
- (id)primaryCollectionTitle {
	return @"displaytitle";
};
- (id)primaryCollectionTitleForSorting {
	return nil;
};
- (int)primaryCollectionOrder {
	return 0;
};
- (int)physicalMediaID {
	return 0;
};
- (id)seriesName {
	return @"seriesName";
};
- (id)seriesNameForSorting {
	return nil;
};
- (id)broadcaster {
	return nil;
};

- (id)genres {
	return nil;
};
- (id)dateAcquired {
	return nil;
};
- (id)dateAcquiredString {
	return nil;
};
- (id)dateCreated {
	return nil;
};
- (id)dateCreatedString {
	return nil;
};
- (id)datePublishedString {
	return nil;
};
- (void)setBookmarkTimeInMS:(unsigned int)fp8 {
	
};
- (void)setBookmarkTimeInSeconds:(unsigned int)fp8 {
	
};
- (unsigned int)bookmarkTimeInMS {
	return 1;
};
- (unsigned int)bookmarkTimeInSeconds {
	return 1;
};
- (unsigned int)startTimeInMS {
	return 1;
};
- (unsigned int)startTimeInSeconds {
	return 1;
};
- (unsigned int)stopTimeInMS {
	return 1;
};
- (unsigned int)stopTimeInSeconds {
	return 1;
};
- (id)lastPlayed {
	return nil;
};
- (void)setLastPlayed:(id)fp8 {
	
};
- (id)resolution {
	return nil;
};
- (BOOL)canBePlayedInShuffle {
	return YES;
};
- (BOOL)isLocal {
	return NO;
};
- (BOOL)isAvailable {
	return YES;
};
- (void)skip {
	
};
- (id)authorName {
	return nil;
};
- (id)keywords {
	return nil;
};
- (id)viewCount {
	return nil;
};
- (id)category {
	return nil;
};
- (BOOL)isInappropriate; {
	return NO;
}
- (int)grFormat {
	return 1;
};
- (void)willBeDeleted {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
};
- (void)preparePlaybackContext{
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
};

- (void)cleanUpPlaybackContext {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
};

- (long)parentalControlRatingSystemID {
	return 1;
};
- (long)parentalControlRatingRank {
	return 1;
};
- (BOOL)isExplicit {
	return NO;
};
- (BOOL)playable {
	return YES;
};
- (id)playbackMetadata {
	return nil;
};
/*
 - (void *)createMovieWithProperties:(void *)fp8 count:(long)fp12 {
 NSLog(@"createMovieWithProperties");
 };
 */
- (BOOL)isCheckedOut {
	return YES;
};
- (id)sourceID {
	return nil;
};
- (BOOL)isPlaying {
	return NO;
};
- (BOOL)isPlayingOrPaused {
	return NO;
};
- (id)publisher {
	return nil;
};
- (id)rating {
	return nil;
};
- (id)mediaDescription {
	return [[item objectForKey:@"info"] objectForKey:@"episode title"];
};
- (id)mediaSummary {
	return nil;
};
- (id)primaryGenre {
	return nil;
};
- (id)datePublished {
	return nil;
};
- (float)userStarRating {
	return 2;
};
- (id)cast {
	return nil;
};
- (id)directors {
	return nil;
};
- (id)producers {
	return nil;
};
- (BOOL)hasVideoContent {
	return YES;
};

- (id)mediaType {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
	return [BRMediaType TVShow];
};

- (id)mediaURL {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
    return [NSString stringWithFormat:@"%@/live/recordingFile/%@/refmovie.mov", baseUrl, [self assetID]];
}

#pragma mark BRImageProvider

- (NSString*) imageID { 
	return nil;
}

- (void)registerAsPendingImageProvider:(BRImageLoader*)loader {
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
}

- (void)loadImage:(BRImageLoader*)loader{ 
	NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__);
}

@end
