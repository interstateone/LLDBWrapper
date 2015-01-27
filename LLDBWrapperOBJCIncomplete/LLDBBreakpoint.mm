//
//  LLDBBreakpoint.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import "LLDBBreakpoint.h"
#import "LLDB_Internals.h"

@implementation LLDBBreakpoint
- (BOOL)isEnabled
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	_raw.IsEnabled() == true;
}
- (void)setEnabled:(BOOL)enabled
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	_raw.SetEnabled(enabled == YES);
}
@end
