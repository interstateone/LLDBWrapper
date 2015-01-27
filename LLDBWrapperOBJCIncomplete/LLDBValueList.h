//
//  LLDBValueList.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBValueList : LLDBObject
- (NSUInteger)count;						///<	Number of values.
- (LLDBValue*)valueAtIndex:(NSUInteger)index;
@end

@interface	LLDBValueList (LLDBObjectiveCExtensions)
- (NSArray*)allValues;
@end
