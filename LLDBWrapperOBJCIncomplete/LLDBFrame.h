//
//  LLDBFrame.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface	LLDBFrame : LLDBObject
- (LLDBFunction*)function;
- (LLDBSymbol*)symbol;
- (LLDBValueList*)registers;
@end
