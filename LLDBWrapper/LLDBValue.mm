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
- (NSString *)name
{
	return	[NSString stringWithUTF8String:_raw.GetName()];
}
- (NSString *)typeName
{
	return	string_from_utf8_c_string(_raw.GetTypeName());
}
//- (NSString *)displayTypeName
//{
//	return	string_from_utf8_c_string(_raw.GetDisplayTypeName());
//}
- (NSString *)value
{
	return	[NSString stringWithUTF8String:_raw.GetValue()];
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
	return	string_from_utf8_c_string(_raw.GetLocation());
}
- (NSString *)summary
{
	return	string_from_utf8_c_string(_raw.GetSummary());
}
- (NSString *)objectDescription
{
	return	string_from_utf8_c_string(_raw.GetObjectDescription());
}



- (NSString *)description
{
	return	get_description_of(_raw);
}
@end





















