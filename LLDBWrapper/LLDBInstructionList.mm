//
//  LLDBInstructionList.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBInstructionList.h"
#import "LLDB_Internals.h"

@implementation LLDBInstructionList
- (size_t)size
{
	return	_raw.GetSize();
}
- (LLDBInstruction *)instructionAtIndex:(uint32_t)index
{
	auto	r	=	_raw.GetInstructionAtIndex(index);
	return	try_instantiation_of_wrapper<lldb::SBInstruction, LLDBInstruction>(r);
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
