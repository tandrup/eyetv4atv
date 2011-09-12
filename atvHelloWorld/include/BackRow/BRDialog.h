/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/BackRow.framework/BackRow
 */


@class BRWindow, NSString, BRControl;

@interface BRDialog : NSObject {
@private
	BRWindow *_window;	// 4 = 0x4
	BRControl *_control;	// 8 = 0x8
	NSString *_identifier;	// 12 = 0xc
}
@property(readonly, retain) BRControl *control;	// G=0x315a59f1; converted property
@property(readonly, retain) NSString *identifier;	// G=0x315a5c35; converted property
+ (void)dismissDialogWithIdentifier:(id)identifier;	// 0x315a5d0d
+ (void)initialize;	// 0x315a5911
+ (BOOL)isDialogCurrentlyPosted;	// 0x316289bd
+ (BOOL)isDialogPostedWithIdentifier:(id)identifier;	// 0x316289e1
+ (void)postDialogWithControl:(id)control identifier:(id)identifier;	// 0x31628991
+ (void)postDialogWithControl:(id)control identifier:(id)identifier style:(int)style opaque:(BOOL)opaque;	// 0x31628d21
+ (void)postModalDialog:(id)dialog;	// 0x31628e49
+ (void)postModalDialogWithControl:(id)control identifier:(id)identifier;	// 0x315a5965
+ (void)postModalDialogWithControl:(id)control identifier:(id)identifier style:(int)style opaque:(BOOL)opaque;	// 0x316288f5
+ (void)postModalDialogWithController:(id)controller identifier:(id)identifier;	// 0x31628965
+ (void)postModalDialogWithController:(id)controller identifier:(id)identifier style:(int)style opaque:(BOOL)opaque;	// 0x31629035
- (id)initWithControl:(id)control identifier:(id)identifier style:(int)style opaque:(BOOL)opaque;	// 0x31628bd1
- (void)_dialogStackBankrupt:(id)bankrupt;	// 0x316288c1
- (void)_transitionCompleted:(id)completed;	// 0x31628845
// converted property getter: - (id)control;	// 0x315a59f1
- (void)dealloc;	// 0x315a5c65
// converted property getter: - (id)identifier;	// 0x315a5c35
- (void)transitionIn;	// 0x31628b2d
- (void)transitionOut;	// 0x31628a3d
@end

