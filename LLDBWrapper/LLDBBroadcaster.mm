//
//  LLDBBroadcaster.m
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/01/28.
//
//

#import "LLDBBroadcaster.h"
#import "LLDB_Internals.h"

@implementation LLDBBroadcaster
- (instancetype)init
{
	UNIVERSE_DELETED_METHOD();
}
- (instancetype)initWithName:(NSString *)name
{
	return	[self initWithCPPObject:lldb::SBBroadcaster(name.UTF8String)];
}

- (void)broadcastEvent:(LLDBEvent *)event unique:(BOOL)unique
{
	_raw.BroadcastEvent(event->_raw, unique);
}
- (void)broadcastEventByType:(uint32_t)eventType unique:(BOOL)unique
{
	_raw.BroadcastEventByType(eventType, unique);
}

- (NSString *)description
{
	UNIVERSE_DELETED_METHOD();
}
@end
