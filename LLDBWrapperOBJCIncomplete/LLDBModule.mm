//
//  LLDBModule.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBModule.h"
#import "LLDB_Internals.h"

@implementation LLDBModule
- (LLDBFileSpec *)fileSpec
{
	LLDBFileSpec*	f1	=	[[LLDBFileSpec alloc] init];
	f1->_raw			=	_raw.GetFileSpec();
	return	f1;
}


- (NSUInteger)numberOfSymbols
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	_raw.GetNumSymbols();
}
- (LLDBSymbol *)symbolAtIndex:(NSUInteger)index
{
	UNIVERSE_DEBUG_ASSERT(_raw.IsValid());
	
	return	try_instantiation_of_wrapper<lldb::SBSymbol, LLDBSymbol>(_raw.GetSymbolAtIndex(index));
}

- (BOOL)isEqualToModule:(LLDBModule *)object
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(object, LLDBModule);
	
	////
	
	return	self == object || _raw.operator==(object->_raw);
}
- (BOOL)isEqual:(id)object
{
	return	self == object || ([object isKindOfClass:[LLDBModule class]] && [self isEqualToModule:object]);
}

@end






@implementation LLDBModule (LLDBObjectiveCExtensions)
- (NSArray *)allCompileUnits {
	abort();
}
- (NSArray *)allSymbols
{
	NSArray*	a1	=	@[];
	NSUInteger	c1	=	[self numberOfSymbols];
	for (NSUInteger i=0; i<c1; i++)
	{
		a1	=	[a1 arrayByAddingObject:[self symbolAtIndex:i]];
	}
	return	a1;
}
@end
















