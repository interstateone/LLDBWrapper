//
//  LLDBProcess.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBProcess.h"
#import "LLDB_Internals.h"




@implementation LLDBProcess

- (LLDBTarget *)target
{
	LLDBTarget*	t1	=	[[LLDBTarget alloc] init];
	t1->_raw		=	_raw.GetTarget();
	return	t1;
}

- (LLDBStateType)state
{
	return	(LLDBStateType)_raw.GetState();
}
- (int)exitStatus
{
	return	_raw.GetExitStatus();
}
- (NSString *)exitDescription
{
	return	string_from_utf8_c_string(_raw.GetExitDescription());
}


- (NSUInteger)numberOfThreads
{
	return	_raw.GetNumThreads();
}
- (LLDBThread *)threadAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfThreads]);
	
	////
	
	auto	r	=	_raw.GetThreadAtIndex(index);
	return	try_instantiation_of_wrapper<lldb::SBThread, LLDBThread>(r);
}
- (BOOL)destroyWithError:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	err1	=	_raw.Destroy();
	return	handle_error(err1, error);
}
- (BOOL)continueWithError:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	err1	=	_raw.Continue();
	return	handle_error(err1, error);
}
- (BOOL)stopWithError:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	err1	=	_raw.Stop();
	return	handle_error(err1, error);
}
- (BOOL)killWithError:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	err1	=	_raw.Kill();
	return	handle_error(err1, error);
}
- (BOOL)detachWithError:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	err1	=	_raw.Detach();
	return	handle_error(err1, error);
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end









