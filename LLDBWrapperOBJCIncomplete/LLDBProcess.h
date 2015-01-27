//
//  LLDBProcess.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"
//#import "LLDBStateType.h"
#import "LLDBEnums.h"

@interface	LLDBProcess : LLDBObject

- (LLDBTarget*)target;

- (LLDBStateType)state;					///<	Use one of @c LLDBState~ constants.
- (int)		exitStatus;
- (NSString*)exitDescription;

- (NSUInteger)numberOfThreads;
- (LLDBThread*)threadAtIndex:(NSUInteger)index;

- (BOOL)	destroyWithError:(LLDBError**)error;
- (BOOL)	continueWithError:(LLDBError**)error;
- (BOOL)	stopWithError:(LLDBError**)error;
- (BOOL)	killWithError:(LLDBError**)error;
- (BOOL)	detachWithError:(LLDBError**)error;
//- (BOOL)	signal:(int)signal withError:(LLDBError**)error;
@end

@interface	LLDBProcess (LLDBObjectiveCExtensions)
- (NSArray*)allThreads;
@end
