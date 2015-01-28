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
LLDBOBJECT_INIT_IMPL(lldb::SBProcess)
- (LLDBTarget *)target
{
	return	[[LLDBTarget alloc] initWithCPPObject:_raw.GetTarget()];
}




- (size_t)putStandardInput:(const char *)source length:(size_t)length
{
	return	_raw.PutSTDIN(source, length);
}
- (size_t)getStandardOutput:(char *)destination length:(size_t)length
{
	return	_raw.GetSTDOUT(destination, length);
}
- (size_t)getStandardError:(char *)destination length:(size_t)length
{
	return	_raw.GetSTDERR(destination, length);
}







- (NSUInteger)numberOfThreads
{
	return	_raw.GetNumThreads();
}
- (LLDBThread *)threadAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfThreads]);
	
	////
	
	return	[[LLDBThread alloc] initWithCPPObject:_raw.GetThreadAtIndex(index)];
}
//- (LLDBThread *)threadByID:(LLDBThreadIDType)threadID
//{
//	return	[LLDBThread threadWithMaybeCPPObject:_raw.GetThreadByID(threadID)];
//}
//- (LLDBThread *)threadByIndexID:(uint32_t)indexID
//{
//	return	[LLDBThread threadWithMaybeCPPObject:_raw.GetThreadByIndexID(indexID)];
//}
- (LLDBThread *)selectedThread
{
	return	[LLDBThread threadWithMaybeCPPObject:_raw.GetSelectedThread()];
}
- (BOOL)setSelectedThread:(LLDBThread *)selectedThread
{
	return	_raw.SetSelectedThread(selectedThread->_raw) == true;
}






- (LLDBStateType)state
{
	return	fromCPP(_raw.GetState());
}
- (int)exitStatus
{
	return	_raw.GetExitStatus();
}
- (NSString *)exitDescription
{
	return	fromC(_raw.GetExitDescription());
}






- (LLDBProcessIDType)processID
{
	return	_raw.GetProcessID();
}
- (uint32_t)uniqueID
{
	return	_raw.GetUniqueID();
}


- (uint32_t)addressByteSize
{
	return	_raw.GetAddressByteSize();
}











- (LLDBError *)destroy
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Destroy()];
}
- (LLDBError *)continue
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Continue()];
}
- (LLDBError *)stop
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Stop()];
}
- (LLDBError *)kill
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Kill()];
}
- (LLDBError *)detach
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Detach()];
}
- (LLDBError *)detach:(BOOL)keepStopped
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Detach(keepStopped)];
}
- (LLDBError *)signal:(int)signal
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.Signal(signal)];
}


- (void)sendAsynchronousInterrupt
{
	_raw.SendAsyncInterrupt();
}
- (uint32_t)stopID:(BOOL)includeExpressionStops
{
	return	_raw.GetStopID(includeExpressionStops == true);
}
- (uint32_t)stopID
{
	return	[self stopID:NO];
}






- (size_t)readMemory:(LLDBAddressType)address buffer:(void *)buffer size:(size_t)size error:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	e;
	auto const		r	=	_raw.ReadMemory(address, buffer, size, e);
	handle_error(e, error);
	return	r;
}
- (size_t)writeMemory:(LLDBAddressType)address buffer:(const void *)buffer size:(size_t)size error:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	e;
	auto const		r	=	_raw.WriteMemory(address, buffer, size, e);
	handle_error(e, error);
	return	r;
}




+ (LLDBStateType)stateFromEvent:(LLDBEvent *)event
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(event, LLDBEvent);
	
	auto const	r	=	lldb::SBProcess::GetStateFromEvent(event->_raw);
	auto const	r1	=	fromCPP(r);
	return		r1;
}
+ (BOOL)restartedFromEvent:(LLDBEvent *)event
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(event, LLDBEvent);
	
	return	lldb::SBProcess::GetRestartedFromEvent(event->_raw) == true;
}
+ (size_t)numberOfRestartedReasonsFromEvent:(LLDBEvent *)event
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(event, LLDBEvent);
	
	return	lldb::SBProcess::GetNumRestartedReasonsFromEvent(event->_raw);
}
+ (NSString *)restartedReasonAtIndexFromEvent:(LLDBEvent *)event index:(size_t)index
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(event, LLDBEvent);
	
	return	fromC(lldb::SBProcess::GetRestartedReasonAtIndexFromEvent(event->_raw, index));
}





- (LLDBBroadcaster *)broadcaster
{
	return	[[LLDBBroadcaster alloc] initWithCPPObject:_raw.GetBroadcaster()];
}
+ (NSString *)broadcasterClass
{
	return	[[NSString alloc] initWithUTF8String:lldb::SBProcess::GetBroadcasterClass()];
}



- (uint32_t)numberOfSupportedHardwareWatchpoints:(LLDBError *__autoreleasing *)error
{
	lldb::SBError	e;
	auto const		r	=	_raw.GetNumSupportedHardwareWatchpoints(e);
	handle_error(e, error);
	return	r;
}
- (uint32_t)loadImage:(LLDBFileSpec *)imageSpec error:(LLDBError *__autoreleasing *)error
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(imageSpec, LLDBFileSpec);
	
	lldb::SBError	e;
	auto const		r	=	_raw.LoadImage(imageSpec->_raw, e);
	handle_error(e, error);
	return	r;
}
- (LLDBError *)unloadImage:(uint32_t)imageToken
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.UnloadImage(imageToken)];
}










- (uint32_t)numberOfExtendedBacktraceTypes
{
	return	_raw.GetNumExtendedBacktraceTypes();
}
- (NSString *)extendedBacktraceTypeAtIndex:(uint32_t)index
{
	return	fromC(_raw.GetExtendedBacktraceTypeAtIndex(index));
}


- (NSString *)description
{
	return	get_description_of(_raw);
}
@end









