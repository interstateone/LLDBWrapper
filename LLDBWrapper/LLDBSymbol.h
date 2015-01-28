//
//  LLDBSymbol.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBSymbol : LLDBObject
- (NSString*)name;
- (LLDBInstructionList*)instructionsForTarget:(LLDBTarget*)target;
@end
