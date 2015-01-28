//
//  LLDBInstruction.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"
#import	"LLDBDeclarations.h"

@interface LLDBInstruction : LLDBObject
- (NSString*)mnemonicForTarget:(LLDBTarget*)target;
- (NSString*)operandsForTarget:(LLDBTarget*)target;
- (NSString*)commentForTarget:(LLDBTarget*)target;
@end

