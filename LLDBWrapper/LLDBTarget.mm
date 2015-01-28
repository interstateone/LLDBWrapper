//
//  LLDBTarget.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import "LLDBTarget.h"
#import "LLDB_Internals.h"

@implementation LLDBTarget
LLDBOBJECT_INIT_IMPL(lldb::SBTarget);
- (instancetype)init
{
	UNIVERSE_DELETED_METHOD();
}
- (void)dealloc
{
	bool	f1	=	_raw.GetDebugger().DeleteTarget(_raw);
	UNIVERSE_DEBUG_ASSERT(f1 == true);
}

- (LLDBFileSpec *)executableFileSpec
{
	return	[[LLDBFileSpec alloc] initWithCPPObject:_raw.GetExecutable()];
}
- (LLDBBreakpoint *)createBreakpointByName:(NSString *)symbolName
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(symbolName, NSString);
	
	return	[[LLDBBreakpoint alloc] initWithCPPObject:_raw.BreakpointCreateByName([symbolName UTF8String], nullptr)];
}
- (LLDBBreakpoint *)createBreakpointByName:(NSString *)symbolName moduleName:(NSString *)moduleName
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(symbolName, NSString);
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(moduleName, NSString);
	
	return	[[LLDBBreakpoint alloc] initWithCPPObject:_raw.BreakpointCreateByName([symbolName UTF8String], [moduleName UTF8String])];
}

- (LLDBProcess *)launchProcessSimplyWithWorkingDirectory:(NSString *)workingDirectory
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(workingDirectory, NSString);
	
	////
	
	char const*	args[2]	=	{"AAA", NULL};
	char const*	envs[2]	=	{"aaa", NULL};
	
	auto p	=	_raw.LaunchSimple(args, envs, [workingDirectory UTF8String]);
	return	[[LLDBProcess alloc] initWithCPPObject:p];
	
//	LLDBProcess*	p1	=	[LLDBProcess LLDBObject____INTERNAL____instantiation];
//	p1->_raw			=	_raw.LaunchSimple(args, envs, [workingDirectory UTF8String]);
//	UNIVERSE_DEBUG_ASSERT(p1->_raw.IsValid() == true);
//	return	p1;
}
- (LLDBProcess *)attachToProcessWithID:(uint64_t)pid error:(LLDBError *__autoreleasing *)error
{
	UNIVERSE_DEBUG_ASSERT(pid != 0);
	UNIVERSE_DEBUG_ASSERT(error != nullptr);
	
	lldb::SBListener	lis1{};
	lldb::SBError		e{};
	auto const			p	=	_raw.AttachToProcessWithID(lis1, pid, e);
	*error					=	[LLDBError errorWithMaybeCPPObject:e];
	
	return	[[LLDBProcess alloc] initWithCPPObject:p];
}





- (uint32_t)numberOfModules
{
	return	_raw.GetNumModules();
}
- (LLDBModule *)moduleAtIndex:(uint32_t)index
{
	UNIVERSE_DEBUG_ASSERT(index < _raw.GetNumModules());

	return	[[LLDBModule alloc] initWithCPPObject:_raw.GetModuleAtIndex(index)];
}
- (LLDBModule *)findModule:(LLDBFileSpec *)fileSpec
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(fileSpec, LLDBFileSpec);
	
	return	[[LLDBModule alloc] initWithCPPObject:_raw.FindModule(fileSpec->_raw)];
}
- (NSString *)triple
{
	return	fromC(_raw.GetTriple());
}






- (uint32_t)numberOfBreakpoints
{
	return	_raw.GetNumBreakpoints();
}
- (LLDBBreakpoint *)breakpointAtIndex:(uint32_t)index
{
	UNIVERSE_DEBUG_ASSERT(index < _raw.GetNumBreakpoints());
	
	return	[[LLDBBreakpoint alloc] initWithCPPObject:_raw.GetBreakpointAtIndex(index)];
}





- (BOOL)isEqualToTarget:(LLDBTarget *)object
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(object, LLDBTarget);
	
	return	self == object || _raw.operator==(object->_raw) == true;
}
- (BOOL)isEqual:(id)object
{
	return	self == object || ([object isKindOfClass:[LLDBTarget class]] && [self isEqualToTarget:object]);
}




- (NSString *)description
{
	return	get_description_of(_raw, lldb::DescriptionLevel::eDescriptionLevelVerbose);
}
@end













