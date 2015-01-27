//
//  LLDBInstruction.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBInstruction.h"
#import "LLDB_Internals.h"

@implementation LLDBInstruction
- (NSString *)mnemonicForTarget:(LLDBTarget *)target
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(target, LLDBTarget);
	
	////
	
	return	string_from_utf8_c_string(_raw.GetMnemonic(target->_raw));
}
- (NSString *)operandsForTarget:(LLDBTarget *)target
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(target, LLDBTarget);
	
	////
	
	return	string_from_utf8_c_string(_raw.GetOperands(target->_raw));
}
- (NSString *)commentForTarget:(LLDBTarget *)target
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(target, LLDBTarget);
	
	////
	
	return	string_from_utf8_c_string(_raw.GetComment(target->_raw));
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
