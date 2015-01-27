//
//  LLDBDebugger.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 14/8/17.
//
//

#import <LLDB/LLDB.h>
#import "LLDBDebugger.h"
#import "LLDB_Internals.h"









NSString* const	LLDBArchDefault			=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT];
NSString* const	LLDBArchDefault32Bit	=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT_32BIT];
NSString* const	LLDBArchDefault64Bit	=	[NSString stringWithUTF8String:LLDB_ARCH_DEFAULT_64BIT];








@implementation LLDBDebugger
- (void)dealloc
{
	lldb::SBDebugger::Destroy(_raw);
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
//	UNIVERSE_DEBUG_ASSERT(state >= std::numeric_limits<std::underlying_type<LLDBStateType>::type>::min());
//	UNIVERSE_DEBUG_ASSERT(state <= std::numeric_limits<std::underlying_type<LLDBStateType>::type>::max());
	
	return	[NSString stringWithUTF8String:_raw.StateAsCString((lldb::StateType)state)];
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

@end

@implementation LLDBDebugger (LLDBObjectiveCExtensions)
- (NSArray *)allTargets
{
	NSArray*	a1	=	@[];
	NSUInteger	c1	=	[self numberOfTargets];
	for (NSUInteger i=0; i<c1; i++)
	{
		a1	=	[a1 arrayByAddingObject:[self targetAtIndex:i]];
	}
	return	a1;
}
@end








