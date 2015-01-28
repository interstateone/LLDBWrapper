//
//  LLDBFunction.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBFunction.h"
#import "LLDB_Internals.h"

@implementation LLDBFunction
LLDBOBJECT_INIT_IMPL(lldb::SBFunction);
- (NSString *)name
{
	return	fromC(_raw.GetName());
}
- (NSString *)mangledName
{
	return	fromC(_raw.GetMangledName());
}
- (id)instructionsForTarget:(LLDBTarget *)target
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(target, LLDBTarget);
	
	////
	
	return	try_instantiation_of_wrapper<lldb::SBInstructionList, LLDBInstructionList>(_raw.GetInstructions(target->_raw));
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
