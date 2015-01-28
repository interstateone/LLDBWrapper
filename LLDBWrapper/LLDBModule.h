//
//  LLDBModule.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBModule : LLDBObject
- (LLDBFileSpec*)fileSpec;

//@property (readonly,nonatomic,assign)	NSUInteger	numberOfCompileUnits;
//- (LLDBSymbol*)compileUnitAtIndex:(NSUInteger)index;


@property (readonly,nonatomic,assign)	NSUInteger	numberOfSymbols;
- (LLDBSymbol*)symbolAtIndex:(NSUInteger)index;

- (BOOL)isEqualToModule:(LLDBModule*)object;
- (BOOL)isEqual:(id)object;

@end


