/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/BackRow.framework/BackRow
 */

#import "BackRow-Structs.h"
#import "BRViewController.h"

@class BRMediaMenuView, NSArray, NSTimer;

@interface BRDataQueryController : BRViewController {
@private
	BRMediaMenuView *_mediaMenuView;	// 60 = 0x3c
	NSArray *_data;	// 64 = 0x40
	ATVMediaQueryRef _preDataQuery;	// 68 = 0x44
	ATVMediaQueryRef _dataQuery;	// 72 = 0x48
	ATVMediaQueryRef _previewQuery;	// 76 = 0x4c
	NSTimer *_spinnerTimer;	// 80 = 0x50
	int _dataClientType;	// 84 = 0x54
	BOOL _showingSpinner;	// 88 = 0x58
	void *_dataItemToSelect;	// 92 = 0x5c
	ATVMediaQueryRef _playQuery;	// 96 = 0x60
	BOOL _handlingDataClientUpdate;	// 100 = 0x64
	BOOL _refreshNeeded;	// 101 = 0x65
	BOOL _reloadListViewNeeded;	// 102 = 0x66
	id _serverID;	// 104 = 0x68
}
@property(readonly, retain) NSArray *data;	// G=0x316785b1; converted property
@property(assign) int dataClientType;	// G=0x316785d1; S=0x31678af5; converted property
@property(assign) void *dataItemToSelect;	// G=0x316785e1; S=0x316792b5; converted property
@property(readonly, retain) BRMediaMenuView *mediaMenuView;	// G=0x316785a1; converted property
@property(retain) id serverID;	// G=0x316785c1; S=0x31678bad; converted property
+ (id)dataQueryControllerWithServerID:(id)serverID;	// 0x31678c25
- (id)init;	// 0x31678c0d
- (id)initWithServerID:(id)serverID;	// 0x31678d3d
- (void)_dataClientDidDisconnect:(id)_dataClient;	// 0x31678631
- (void)_dataClientUpdated:(id)updated;	// 0x3167873d
- (void)_dataQueryComplete;	// 0x31679699
- (void)_dataServerStateChanged:(id)changed;	// 0x316798a9
- (void)_dataServerUpdated:(id)updated;	// 0x3167993d
- (void)_executeDataQuery;	// 0x316792e5
- (void)_executePreDataQuery;	// 0x316793d5
- (void)_mediaItemPropertySetNotification:(id)notification;	// 0x316786bd
- (void)_playQueryComplete;	// 0x316787bd
- (void)_preDataQueryComplete;	// 0x31679859
- (void)_previewQueryComplete;	// 0x31679651
- (void)_setDataQuery:(ATVMediaQueryRef)query;	// 0x31679245
- (void)_setPlayQuery:(ATVMediaQueryRef)query;	// 0x316791d5
- (void)_setPreDataQuery:(ATVMediaQueryRef)query;	// 0x3167927d
- (void)_setPreviewQuery:(ATVMediaQueryRef)query;	// 0x3167920d
- (void)_showSpinner;	// 0x31679529
- (void)_showSpinner:(BOOL)spinner delay:(BOOL)delay;	// 0x31678939
- (ATVMediaQueryRef)createDataQuery;	// 0x31678601
- (ATVMediaQueryRef)createPlayQueryForIndexPath:(id)indexPath;	// 0x31678619
- (ATVMediaQueryRef)createPreDataQuery;	// 0x316785f9
- (ATVMediaQueryRef)createPreviewQueryForIndexPath:(id)indexPath;	// 0x31678609
// converted property getter: - (id)data;	// 0x316785b1
- (ATVDataClientRef)dataClient;	// 0x31679141
- (id)dataClientName;	// 0x31679199
// converted property getter: - (int)dataClientType;	// 0x316785d1
- (BOOL)dataClientUpdated:(ATVDataClientRef)updated;	// 0x31678629
- (void *)dataItemAtIndexPath:(id)indexPath;	// 0x31678615
// converted property getter: - (void *)dataItemToSelect;	// 0x316785e1
- (void)dataQueryComplete:(ATVMediaQueryRef)complete;	// 0x31678605
- (ATVDataServerRef)dataServer;	// 0x316791b5
- (BOOL)dataServerConnectionChanged:(ATVDataServerRef)changed;	// 0x3167862d
- (void)dealloc;	// 0x31678ed9
- (id)errorControlForQuery:(ATVMediaQueryRef)query;	// 0x31678625
- (id)errorForNoContent;	// 0x31678621
- (id)identifier;	// 0x31678bed
- (id)indexPathForDataItem:(void *)dataItem;	// 0x31678611
- (void)list:(id)list didFocusItemAtIndexPath:(id)indexPath;	// 0x316794b1
- (void)list:(id)list didPlayItemAtIndexPath:(id)indexPath;	// 0x31679455
- (id)list:(id)list menuItemForRowAtIndexPath:(id)indexPath;	// 0x316785f5
- (long)list:(id)list numberOfRowsInSection:(long)section;	// 0x316785f1
// converted property getter: - (id)mediaMenuView;	// 0x316785a1
- (void)playQueryComplete:(ATVMediaQueryRef)complete;	// 0x3167861d
- (BOOL)preDataQueryComplete:(id)complete;	// 0x316785fd
- (id)previewForItems:(id)items;	// 0x31678a19
- (BOOL)previewQueryComplete:(ATVMediaQueryRef)complete;	// 0x3167860d
- (void)restartDataQueryProcess;	// 0x31678ac9
// converted property getter: - (id)serverID;	// 0x316785c1
// converted property setter: - (void)setDataClientType:(int)type;	// 0x31678af5
// converted property setter: - (void)setDataItemToSelect:(void *)select;	// 0x316792b5
// converted property setter: - (void)setServerID:(id)anId;	// 0x31678bad
- (void)wasExhumed;	// 0x31678c59
- (void)wasPopped;	// 0x31678d01
- (void)wasPushed;	// 0x3167901d
@end

