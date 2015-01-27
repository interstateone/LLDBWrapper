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
- (NSString *)filename
{
	return	[NSString stringWithUTF8String:_raw.GetFilename()];
}
@end
