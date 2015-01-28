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
	
		SBDebugger::Create();
	}
	return	self;
}
- (void)dealloc
{
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
	return	_raw.GetAsync() ? YES : NO;
}
- (void)setAsync:(BOOL)async
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	_raw.SetAsync(async ? true : false);
}

- (NSString *)stringOfState:(LLDBStateType)state
{	
	return	fromC(_raw.StateAsCString(toCPP(state)));
}








- (LLDBTarget *)createTargetWithFilename:(NSString *)filename
{
	return	proxy_init(
					   [[LLDBTarget alloc] init],
					   _raw.CreateTarget([filename UTF8String])
					   );
}
- (LLDBTarget *)createTargetWithFilename:(NSString *)filename andArchname:(NSString *)archname
{
	return	proxy_init(
					   [[LLDBTarget alloc] init],
					   _raw.CreateTargetWithFileAndArch([filename UTF8String], [archname UTF8String])
					   );
}
- (NSUInteger)numberOfTargets
{
	return	_raw.GetNumTargets();
}
- (LLDBTarget *)targetAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfTargets]);
	
	////
	
	LLDBTarget*	t1	=	[[LLDBTarget alloc] init];
	t1->_raw		=	_raw.GetTargetAtIndex((uint32_t)index);
	return	t1;
}

//- (LLDBSourceManager *)sourceManager
//{
//	LLDBSourceManager*	m1	=	[LLDBSourceManager LLDBObject____INTERNAL____instantiation];
//	m1->_raw				=	_raw.GetSourceManager();
//	return	m1;
//}






- (NSString *)description
{
	return	get_description_of(_raw);
}
@end








