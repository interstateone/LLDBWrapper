//
//  LLDBThread.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBThread.h"
#import "LLDB_Internals.h"
#import "LLDBEnums.h"


//NSUInteger const		LLDBRunModeOnlyThisThread		=	lldb::eOnlyThisThread;
//NSUInteger const		LLDBRunModeAllThreads			=	lldb::eAllThreads;
//NSUInteger const		LLDBRunModeOnlyDuringStepping	=	lldb::eOnlyDuringStepping;
//
//static void
//assert_valid_run_mode_value(NSUInteger const value)
//{
//	switch (value)
//	{
//		case	LLDBRunModeOnlyThisThread:		return;
//		case	LLDBRunModeAllThreads:			return;
//		case	LLDBRunModeOnlyDuringStepping:	return;
//		default:
//		{
//			UNIVERSE_DEBUG_ASSERT(NO);
//		}
//	}
//}



@implementation LLDBThread
- (NSString *)name
{
	return	string_from_utf8_c_string(_raw.GetName());
}

- (void)stepOver
{
	[self stepOverWithRunMode:(LLDBRunModeOnlyDuringStepping)];
}
- (void)stepOverWithRunMode:(LLDBRunMode)stopOtherThreads
{
//	assert_valid_run_mode_value(stopOtherThreads);
	_raw.StepOver((lldb::RunMode)stopOtherThreads);
}
- (void)stepInto
{
	[self stepIntoWithRunMode:(LLDBRunModeOnlyDuringStepping)];
}
- (void)stepIntoWithRunMode:(LLDBRunMode)stopOtherThreads
{
//	assert_valid_run_mode_value(stopOtherThreads);
	_raw.StepInto((lldb::RunMode)stopOtherThreads);
}
- (void)stepOut
{
	_raw.StepOut();
}
- (void)stepOutOfFrame:(LLDBFrame *)frame
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(frame, LLDBFrame);
	
	////
	
	_raw.StepOutOfFrame(frame->_raw);
}
- (void)stepInstruction:(BOOL)stepOver
{
	_raw.StepInstruction(stepOver ? true : false);
}


- (BOOL)suspend
{
	return	_raw.Suspend() == true;
}
- (BOOL)resume
{
	return	_raw.Resume() == true;
}
- (BOOL)isSuspended
{
	return	_raw.IsSuspended() == true;
}
- (BOOL)isStopped
{
	return	_raw.IsSuspended() == true;
}





- (NSUInteger)numberOfFrames
{
	return	_raw.GetNumFrames();
}
- (LLDBFrame *)frameAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < UINT32_MAX);
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfFrames]);
	
	////
	
	LLDBFrame*	f1	=	[[LLDBFrame alloc] init];
	f1->_raw		=	_raw.GetFrameAtIndex((uint32_t)index);
	return	f1;
}

- (LLDBProcess *)process
{
	LLDBProcess*	p1	=	[[LLDBProcess alloc] init];
	p1->_raw			=	_raw.GetProcess();
	return	p1;
}

- (BOOL)isEqualToThread:(LLDBThread *)object
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(object, LLDBThread);
	
	////
	
	return	self == object || _raw.operator==(object->_raw) == true;
}
- (BOOL)isEqual:(id)object
{
	return	object == self || ([object isKindOfClass:[LLDBThread class]] && [self isEqualToThread:object]);
}

@end

@implementation LLDBThread (LLDBObjectiveCExtensions)
- (NSArray *)allFrames
{
	NSArray*	a1	=	@[];
	NSUInteger	c1	=	[self numberOfFrames];
	for (NSUInteger i=0; i<c1; i++)
	{
		a1	=	[a1 arrayByAddingObject:[self frameAtIndex:i]];
	}
	return	a1;
}
@end