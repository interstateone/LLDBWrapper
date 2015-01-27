//
//  LLDBContext.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import "LLDBContext.h"
#import "LLDB_Internals.h"

static LLDBContext*	_the_one	=	nil;

@implementation LLDBContext
+ (id)allocWithZone:(NSZone*)zone
{
	UNIVERSE_DEBUG_ASSERT(_the_one == nil);
	
	id		a1	=	[super allocWithZone:zone];
	_the_one	=	a1;
	return	a1;
}
+ (id)alloc
{
	UNIVERSE_DEBUG_ASSERT(_the_one == nil);
	
	return	[super alloc];
}
- (id)init
{
	self	=	[super init];
	if (self)
	{
		lldb::SBDebugger::Initialize();
		lldb::SBHostOS::ThreadCreated ("<lldb.driver.main-thread>");
	}
	return	self;
}
- (void)dealloc
{
	lldb::SBDebugger::Terminate();
	_the_one	=	nil;
}
- (LLDBDebugger *)instantiateDebugger
{
	return	try_instantiation_of_wrapper<lldb::SBDebugger, LLDBDebugger>(lldb::SBDebugger::Create(false));
}
@end












