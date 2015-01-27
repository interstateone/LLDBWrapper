//
//  LLDBFunction.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBFunction : LLDBObject
- (NSString*)name;
- (NSString*)mangledName;
- (LLDBInstructionList*)instructionsForTarget:(LLDBTarget*)target;
@end
