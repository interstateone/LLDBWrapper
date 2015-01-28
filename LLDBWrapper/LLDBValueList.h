//
//  LLDBValueList.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBValueList : LLDBObject
@property	(readonly,nonatomic,assign)	uint32_t	size;			///<	Number of values.
- (LLDBValue*)valueAtIndex:(uint32_t)index;

- (NSString *)description UNIVERSE_UNAVAILABLE_METHOD;
@end
