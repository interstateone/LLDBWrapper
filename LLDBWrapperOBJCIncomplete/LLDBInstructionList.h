//
//  LLDBInstructionList.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface	LLDBInstructionList : LLDBObject
- (NSUInteger)count;
- (LLDBInstruction*)instructionAtIndex:(NSUInteger)index;
@end

@interface	LLDBInstructionList (LLDBObjectiveCExtensions)
- (NSArray*)allInstructions;
@end