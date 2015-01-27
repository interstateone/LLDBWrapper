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
- (void)dealloc
{
	bool	f1	=	_raw.GetDebugger().DeleteTarget(_raw);
	UNIVERSE_DEBUG_ASSERT(f1 == true);
}

- (LLDBFileSpec *)executableFileSpec
{
	return	try_instantiation_of_wrapper<lldb::SBFileSpec, LLDBFileSpec>(_raw.GetExecutable());
}
- (LLDBBreakpoint *)createBreakpointByName:(NSString *)symbolName moduleName:(NSString *)moduleName
{
	return	try_instantiation_of_wrapper<lldb::SBBreakpoint, LLDBBreakpoint>(_raw.BreakpointCreateByName([symbolName UTF8String], [moduleName UTF8String]));
}

- (LLDBProcess *)launchProcessSimplyWithWorkingDirectory:(NSString *)workingDirectory
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(workingDirectory, NSString);
	
	////
	
	char const*	args[2]	=	{"AAA", NULL};
	char const*	envs[2]	=	{"aaa", NULL};
	
	return	try_instantiation_of_wrapper<lldb::SBProcess, LLDBProcess>(_raw.LaunchSimple(args, envs, [workingDirectory UTF8String]));
	
//	LLDBProcess*	p1	=	[LLDBProcess LLDBObject____INTERNAL____instantiation];
//	p1->_raw			=	_raw.LaunchSimple(args, envs, [workingDirectory UTF8String]);
//	UNIVERSE_DEBUG_ASSERT(p1->_raw.IsValid() == true);
//	return	p1;
}
- (LLDBProcess *)attachToProcessWithID:(uint64_t)pid error:(LLDBError *__autoreleasing *)error
{
	UNIVERSE_DEBUG_ASSERT(pid != 0);
	
	////
	
	LLDBProcess*		p1	=	[[LLDBProcess alloc] init];
	lldb::SBListener	lis1{};
	lldb::SBError		err1{};
	UNIVERSE_DEBUG_ASSERT(lis1.IsValid() == false);
	UNIVERSE_DEBUG_ASSERT(err1.IsValid() == false);
	
	p1->_raw			=	_raw.AttachToProcessWithID(lis1, pid, err1);
	UNIVERSE_DEBUG_ASSERT(err1.IsValid() or p1->_raw.IsValid());
	handle_error(err1, error);
	
	return	p1;
}

- (NSUInteger)numberOfModules
{
	return	_raw.GetNumModules();
}
- (LLDBModule *)moduleAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfModules]);
	
	////

	return	try_instantiation_of_wrapper<lldb::SBModule, LLDBModule>(_raw.GetModuleAtIndex((uint32_t)index));
}
- (LLDBModule *)findModule:(LLDBFileSpec *)fileSpec
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(fileSpec, LLDBFileSpec);
	
	////
	
	return	try_instantiation_of_wrapper<lldb::SBModule, LLDBModule>(_raw.FindModule(fileSpec->_raw));
}
- (NSString *)triple
{
	return	string_from_utf8_c_string(_raw.GetTriple());
}


- (NSUInteger)numberOfBreakpoints
{
	return	_raw.GetNumModules();
}
- (LLDBBreakpoint *)breakpointAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfBreakpoints]);
	
	////
	
	return	try_instantiation_of_wrapper<lldb::SBBreakpoint, LLDBBreakpoint>(_raw.GetBreakpointAtIndex((uint32_t)index));
}

- (BOOL)isEqualToTarget:(LLDBTarget *)object
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(object, LLDBTarget);
	
	////
	
	return	self == object || _raw.operator==(object->_raw) == true;
}
- (BOOL)isEqual:(id)object
{
	return	self == object || ([object isKindOfClass:[LLDBTarget class]] && [self isEqualToTarget:object]);
}




- (NSString *)description
{
	lldb::SBStream	s;
	bool			r	=	_raw.GetDescription(s, lldb::DescriptionLevel::eDescriptionLevelVerbose);
	UNIVERSE_DEBUG_ASSERT(r == true);
	
	NSString*		s1	=	[[NSString alloc] initWithBytes:s.GetData() length:s.GetSize() encoding:NSUTF8StringEncoding];
	return			s1;
}
@end













