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
LLDBOBJECT_INIT_IMPL(lldb::SBValueList);
- (uint32_t)size
{
	return	_raw.GetSize();
}
- (LLDBValue *)valueAtIndex:(uint32_t)index
{
	UNIVERSE_DEBUG_ASSERT(index < _raw.GetSize());
	
	////

	auto	r	=	_raw.GetValueAtIndex(index);
	return	try_instantiation_of_wrapper<lldb::SBValue, LLDBValue>(r);
}



- (NSString *)description
{
	UNIVERSE_DELETED_METHOD();
}
@end
