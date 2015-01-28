//
//  LLDBWatchpoint.m
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/01/28.
//
//

#import "LLDBWatchpoint.h"
#import "LLDB_Internals.h"

@implementation LLDBWatchpoint
LLDBOBJECT_INIT_IMPL(lldb::SBWatchpoint);
- (instancetype)init
{
	UNIVERSE_DELETED_METHOD();
}






- (LLDBError *)error
{
	return	[LLDBError errorWithMaybeCPPObject:_raw.GetError()];
}
- (LLDBWatchIDType)ID
{
	return	_raw.GetID();
}




- (int32_t)hardwareIndex
{
	return	_raw.GetHardwareIndex();
}
- (LLDBAddressType)watchAddress
{
	return	_raw.GetWatchAddress();
}
- (size_t)watchSize
{
	return	_raw.GetWatchSize();
}









- (BOOL)isEnabled
{
	return	_raw.IsEnabled() == true;
}
- (void)setEnabled:(BOOL)enabled
{
	_raw.SetEnabled(enabled == YES);
}


- (uint32_t)hitCount
{
	return	_raw.GetHitCount();
}
- (uint32_t)ignoreCount
{
	return	_raw.GetIgnoreCount();
}
- (void)setIgnoreCount:(uint32_t)ignoreCount
{
	_raw.SetIgnoreCount(ignoreCount);
}
- (NSString *)condition
{
	return	fromC(_raw.GetCondition());
}
- (void)setCondition:(NSString *)condition
{
	_raw.SetCondition(condition.UTF8String);
}










- (BOOL)isEqualTo:(id)object
{
	UNIVERSE_DELETED_METHOD();
}
- (BOOL)isEqual:(id)object
{
	UNIVERSE_DELETED_METHOD();
}
- (NSString *)description
{
	return	get_description_of(_raw, lldb::DescriptionLevel::eDescriptionLevelVerbose);
}

@end
