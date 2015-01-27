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

- (NSString *)description
{
	return	get_description_of(_raw);
}
@end
