//
//  LLDBDebugger.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 14/8/17.
//
//

#pragma once
#import	"LLDBObject.h"
#import "LLDBDeclarations.h"
#import "LLDBEnums.h"



extern NSString* const		LLDBArchDefault;
extern NSString* const		LLDBArchDefault32Bit;
extern NSString* const		LLDBArchDefault64Bit;






@interface	LLDBDebugger : LLDBObject
- (instancetype)init;
@property	(readwrite,nonatomic,assign)	BOOL		async;
- (NSString*)stringOfState:(LLDBStateType)state;													///<	Use @c LLDBState~ constants.
- (LLDBTarget*)createTargetWithFilename:(NSString*)filename;
- (LLDBTarget*)createTargetWithFilename:(NSString*)filename andArchname:(NSString*)archname;		///<	You can use one of @c LLDBArchDefault~ constants.
@property	(readonly,nonatomic,assign)		NSUInteger	numberOfTargets;
- (LLDBTarget*)targetAtIndex:(NSUInteger)index;

/*!
 As far as I discovered, `SBDebugger` is the only class that seems properly to "own" the `SBSourceManager`.
 So, `LLDBDebugger` will keep an instance to `LLDBSourceManager` object internally.
 */
@property	(readonly,nonatomic,strong)		LLDBSourceManager*		sourceManager;
//- (LLDBSourceManager*)sourceManager;

- (BOOL)isEqualTo:(id)object UNIVERSE_UNAVAILABLE_METHOD;
- (BOOL)isEqual:(id)object UNIVERSE_UNAVAILABLE_METHOD;
@end

