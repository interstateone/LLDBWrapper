//
//  LLDBThread.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"
#import "LLDBEnums.h"


@interface	LLDBThread : LLDBObject
@property	(readonly,nonatomic,copy)	NSString*	name;

- (void)	stepOver;												///<	@c stoppOtherThreads==LLDBRunModeOnlyDuringStepping\.
- (void)	stepOverWithRunMode:(LLDBRunMode)stopOtherThreads;
- (void)	stepInto;												///<	@c stoppOtherThreads==LLDBRunModeOnlyDuringStepping\.
- (void)	stepIntoWithRunMode:(LLDBRunMode)stopOtherThreads;
- (void)	stepOut;
- (void)	stepOutOfFrame:(LLDBFrame*)frame;
- (void)	stepInstruction:(BOOL)stepOver;
//- (void)	stepOverUntil;


- (BOOL)	suspend;
- (BOOL)	resume;
- (BOOL)	isSuspended;
- (BOOL)	isStopped;

@property	(readonly,nonatomic,assign)	NSUInteger		numberOfFrames;
- (LLDBFrame*)frameAtIndex:(NSUInteger)index;

@property	(readonly,nonatomic,strong)	LLDBProcess*	process;

- (BOOL)	isEqualToThread:(LLDBThread*)object;
- (BOOL)	isEqual:(id)object;

@end
