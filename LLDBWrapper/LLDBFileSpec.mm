//
//  LLDBFileSpec.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import "LLDBFileSpec.h"
#import "LLDB_Internals.h"

@implementation LLDBFileSpec
LLDBOBJECT_INIT_IMPL(lldb::SBFileSpec);
- (NSString *)filename
{
	return	fromC(_raw.GetFilename());
}


- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
