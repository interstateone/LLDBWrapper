//
//  LLDBModule.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBModule : LLDBObject


- (LLDBFileSpec*)fileSpec;

//- (NSUInteger)numberOfCompileUnits;
//- (LLDBCompileUnit*)compileUnitAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfSymbols;
- (LLDBSymbol*)symbolAtIndex:(NSUInteger)index;

- (BOOL)isEqualToModule:(LLDBModule*)object;
- (BOOL)isEqual:(id)object;

@end



@interface LLDBModule (LLDBObjectiveCExtensions)
- (NSArray*)allCompileUnits;
- (NSArray*)allSymbols;
@end

