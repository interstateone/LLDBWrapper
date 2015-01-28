//
//  LLDBSymbol.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBSymbol.h"
#import "LLDB_Internals.h"

@implementation LLDBSymbol
LLDBOBJECT_INIT_IMPL(lldb::SBSymbol);
- (NSString *)name
{
	return	fromC(_raw.GetName());
}
- (LLDBInstructionList *)instructionsForTarget:(LLDBTarget *)target
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(target, LLDBTarget);
	
	////
	
	auto	r	=	_raw.GetInstructions(target->_raw);
	return	try_instantiation_of_wrapper<lldb::SBInstructionList, LLDBInstructionList>(r);
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
