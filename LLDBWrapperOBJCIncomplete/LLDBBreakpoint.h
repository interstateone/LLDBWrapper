//
//  LLDBBreakpoint.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import	"LLDBObject.h"
#import "LLDBDeclarations.h"

@interface	LLDBBreakpoint : LLDBObject
@property	(readwrite,nonatomic,assign,getter = isEnabled)	BOOL	enabled;
@end
