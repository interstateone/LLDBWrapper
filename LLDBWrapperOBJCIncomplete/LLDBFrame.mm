//
//  LLDBFrame.m
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBFrame.h"
#import	"LLDB_Internals.h"

@implementation LLDBFrame
- (LLDBFunction *)function
{
	LLDBFunction*	f1	=	[[LLDBFunction alloc] init];
	f1->_raw			=	_raw.GetFunction();
	return	f1;
}
- (id)symbol
{
	LLDBSymbol*		s1	=	[[LLDBSymbol alloc] init];
	s1->_raw			=	_raw.GetSymbol();
	return	s1;
}
- (LLDBValueList *)registers
{
	LLDBValueList*	l1	=	[[LLDBValueList alloc] init];
	l1->_raw			=	_raw.GetRegisters();
	return	l1;
}
@end
