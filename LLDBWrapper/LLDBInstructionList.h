//
//  LLDBInstructionList.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface	LLDBInstructionList : LLDBObject
@property	(readonly,nonatomic,assign)		size_t		size;
- (LLDBInstruction*)instructionAtIndex:(uint32_t)index;
@end
