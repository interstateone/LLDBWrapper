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
- (NSString *)name
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	string_from_utf8_c_string(_raw.GetName());
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
