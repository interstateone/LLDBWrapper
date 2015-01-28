//
//  LLDBValue.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBValue.h"
#import "LLDB_Internals.h"

@implementation LLDBValue
LLDBOBJECT_INIT_IMPL(lldb::SBValue);
- (NSString *)name
{
	return	fromC(_raw.GetName());
}
- (NSString *)typeName
{
	return	fromC(_raw.GetTypeName());
}
//- (NSString *)displayTypeName
//{
//	return	string_from_utf8_c_string(_raw.GetDisplayTypeName());
//}
- (NSString *)value
{
	return	fromC(_raw.GetValue());
}
- (NSInteger)numberOfChildren
{
	return	_raw.GetNumChildren();
}
- (LLDBValue *)childAtIndex:(NSInteger)index
{
	UNIVERSE_DEBUG_ASSERT(index < [self numberOfChildren]);
	
	////
	
	LLDBValue*	v1	=	[[LLDBValue alloc] init];
	v1->_raw		=	_raw.GetChildAtIndex((uint32_t)index);
	return	v1;
}
- (NSString *)location
{
	return	fromC(_raw.GetLocation());
}
- (NSString *)summary
{
	return	fromC(_raw.GetSummary());
}
- (NSString *)objectDescription
{
	return	fromC(_raw.GetObjectDescription());
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end





















