//
//  LLDBDebugger.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 14/8/17.
//
//

#import "LLDBDebugger.h"

#include <atomic>
#import <LLDB/LLDB.h>
#import "LLDB_Internals.h"

using namespace lldb;








static std::atomic_int		num_live_debugger(0);




NSString* const	LLDBArchDefault			=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT];
NSString* const	LLDBArchDefault32Bit	=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT_32BIT];
NSString* const	LLDBArchDefault64Bit	=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT_64BIT];








@implementation LLDBDebugger
{
	@private
	LLDBSourceManager*	_srcmgr;
}

LLDBOBJECT_INIT_IMPL(lldb::SBDebugger);
- (instancetype)init
{
	self	=	[super init];
	if (self) {
		if (num_live_debugger == 0) {
			SBDebugger::Initialize();
		}
		num_live_debugger++;
		
		////
	
		_raw	=	SBDebugger::Create();
		_srcmgr	=	[[LLDBSourceManager alloc] initWithCPPObject:_raw.GetSourceManager()];
	}
	return	self;
}
- (void)dealloc
{
	precondition_valid_state_of(_raw);
	SBDebugger::Destroy(_raw);
	
	////
	
	num_live_debugger--;
	if (num_live_debugger == 0) {
		SBDebugger::Terminate();
	}
	UNIVERSE_DEBUG_ASSERT(num_live_debugger >= 0);
}



- (BOOL)async
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	_raw.GetAsync() ? YES : NO;
}
- (void)setAsync:(BOOL)async
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	_raw.SetAsync(async ? true : false);
}

- (NSString *)stringOfState:(LLDBStateType)state
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	fromC(_raw.StateAsCString(toCPP(state)));
}








- (LLDBTarget *)createTargetWithFilename:(NSString *)filename
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	[[LLDBTarget alloc] initWithCPPObject:_raw.CreateTarget(filename.UTF8String)];
}
- (LLDBTarget *)createTargetWithFilename:(NSString *)filename andArchname:(NSString *)archname
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	[[LLDBTarget alloc] initWithCPPObject:_raw.CreateTargetWithFileAndArch(filename.UTF8String, archname.UTF8String)];
}
- (uint32_t)numberOfTargets
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	_raw.GetNumTargets();
}
- (LLDBTarget *)targetAtIndex:(uint32_t)index
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	UNIVERSE_DEBUG_ASSERT(index < _raw.GetNumTargets());
	
	return	[[LLDBTarget alloc] initWithCPPObject:_raw.GetTargetAtIndex(index)];
}

- (LLDBSourceManager *)sourceManager
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	LLDBSourceManager*	m1	=	[[LLDBSourceManager alloc] initWithCPPObject:_raw.GetSourceManager()];
	return	m1;
}








- (NSString *)description
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	get_description_of(_raw);
}
@end








