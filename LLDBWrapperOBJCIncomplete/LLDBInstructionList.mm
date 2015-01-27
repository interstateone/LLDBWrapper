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
- (NSUInteger)count
{
	return	_raw.GetSize();
}
- (LLDBInstruction *)instructionAtIndex:(NSUInteger)index
{
	auto	r	=	_raw.GetInstructionAtIndex((uint32_t)index);
	return	try_instantiation_of_wrapper<lldb::SBInstruction, LLDBInstruction>(r);
}
@end

@implementation LLDBInstructionList (LLDBObjectiveCExtensions)
- (NSArray *)allInstructions
{
	NSArray*	a1	=	@[];
	NSUInteger	c1	=	[self count];
	for (NSUInteger i=0; i<c1; i++)
	{
		a1	=	[a1 arrayByAddingObject:[self instructionAtIndex:i]];
	}
	return	a1;
}
@end