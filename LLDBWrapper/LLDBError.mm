//
//  LLDBError.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBError.h"
#import "LLDB_Internals.h"

@implementation LLDBError
LLDBOBJECT_INIT_IMPL(lldb::SBError);
+ (LLDBError *)errorWithMaybeCPPObject:(lldb::SBError)maybeCPPObject
{
	if (maybeCPPObject.IsValid())
	{
		return	[[LLDBError alloc] initWithCPPObject:maybeCPPObject];
	}
	else
	{
		return	nil;
	}
}
- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
