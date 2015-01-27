//
//  LLDBValueList.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBValueList.h"
#import "LLDB_Internals.h"

@implementation LLDBValueList
- (NSUInteger)count
{
	return	_raw.GetSize();
}
- (LLDBValue *)valueAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self count]);
	
	////

	auto	r	=	_raw.GetValueAtIndex((uint32_t)index);
	return	try_instantiation_of_wrapper<lldb::SBValue, LLDBValue>(r);
}
@end

@implementation LLDBValueList (LLDBObjectiveCExtensions)
- (NSArray *)allValues
{
	NSArray*	a1	=	@[];
	NSUInteger	c1	=	[self count];
	for (NSUInteger i=0; i<c1; i++)
	{
		a1	=	[a1 arrayByAddingObject:[self valueAtIndex:i]];
	}
	return	a1;
}
@end
