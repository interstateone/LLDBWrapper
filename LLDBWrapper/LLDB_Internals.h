//
//  LLDB_Internals.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import <LLDB/LLDB.h>
#import "LLDBObject.h"
#import "LLDBDebugger.h"
#import "LLDBTarget.h"
#import "LLDBBreakpoint.h"
#import "LLDBSourceManager.h"
#import "LLDBFileSpec.h"
#import "LLDBProcess.h"
#import "LLDBThread.h"
#import "LLDBFrame.h"
#import "LLDBFunction.h"
#import "LLDBInstructionList.h"
#import "LLDBInstruction.h"
#import "LLDBSymbol.h"
#import "LLDBValueList.h"
#import "LLDBValue.h"
#import "LLDBError.h"
#import "LLDBModule.h"





@interface	LLDBObject ()
@end









@interface	LLDBDebugger ()
{
	@package
	lldb::SBDebugger	_raw;
}
@end

@interface	LLDBTarget ()
{
	@package
	lldb::SBTarget		_raw;
}
@end

@interface	LLDBBreakpoint ()
{
	@package
	lldb::SBBreakpoint	_raw;
}
@end

//@interface	LLDBSourceManager ()
//{
//	@package
//	lldb::SBSourceManager	_raw;
//}
//@end

@interface	LLDBFileSpec ()
{
	@package
	lldb::SBFileSpec	_raw;
}
@end

@interface	LLDBProcess ()
{
	@package
	lldb::SBProcess		_raw;
}
@end

@interface	LLDBThread ()
{
	@package
	lldb::SBThread		_raw;
}
@end

@interface	LLDBFrame ()
{
	@package
	lldb::SBFrame		_raw;
}
@end

@interface	LLDBFunction ()
{
	@package
	lldb::SBFunction	_raw;
}
@end

@interface	LLDBInstructionList ()
{
	@package
	lldb::SBInstructionList	_raw;
}
@end

@interface	LLDBInstruction ()
{
	@package
	lldb::SBInstruction		_raw;
}
@end

@interface	LLDBSymbol ()
{
	@package
	lldb::SBSymbol			_raw;
}
@end

@interface	LLDBValueList ()
{
	@package
	lldb::SBValueList		_raw;
}
@end

@interface	LLDBValue ()
{
	@package
	lldb::SBValue			_raw;
}
@end

@interface	LLDBError ()
{
	@package
	lldb::SBError			_raw;
}
@end

@interface	LLDBModule ()
{
	@package
	lldb::SBModule			_raw;
}
@end









template <typename T>
static inline T*
proxy_init(T* self, decltype(self->_raw) newRaw) {
	if (newRaw.IsValid()) {
		self->_raw	=	newRaw;
		return	self;
	} else {
		return	nil;
	}
}


template <typename RAW, typename WRAPPER>
static inline WRAPPER*
try_instantiation_of_wrapper(RAW raw)
{
	if (raw.IsValid())
	{
		WRAPPER*	w1		=	[[WRAPPER alloc] init];
		w1->_raw			=	raw;
		return	w1;
	}
	return	nil;
}





static inline BOOL
handle_error(lldb::SBError const& error, LLDBError** output)
{
	BOOL			ok1		=	error.IsValid() and error.Success();
	
	if (ok1 == NO && output != NULL)
	{
		LLDBError*	e1	=	[[LLDBError alloc] init];
		e1->_raw		=	error;
		*output			=	e1;
	}
	
	return	ok1;
}




static inline NSString*
string_from_utf8_c_string(char const* utf8_c_string)
{
	if (utf8_c_string == NULL)
	{
		return	nil;
	}
	return	[NSString stringWithUTF8String:utf8_c_string];
}








template <typename T>
static inline NSString*
get_description_of(T _raw)
{
	lldb::SBStream	s;
	bool			r	=	_raw.GetDescription(s);
	UNIVERSE_DEBUG_ASSERT(r == true);
	
	NSString*		s1	=	[[NSString alloc] initWithBytes:s.GetData() length:s.GetSize() encoding:NSUTF8StringEncoding];
	return			s1;
}






