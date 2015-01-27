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

@property	(readonly,nonatomic,strong)	LLDBTarget*			target;
@property	(readonly,nonatomic,assign)	LLDBStateType		state;					///<	Use one of @c LLDBState~ constants.
@property	(readonly,nonatomic,assign)	int					exitStatus;
@property	(readonly,nonatomic,assign)	NSString*			exitDescription;

@property (readonly,nonatomic,assign)	NSUInteger	numberOfThreads;
- (LLDBThread*)threadAtIndex:(NSUInteger)index;

- (BOOL)	destroyWithError:(LLDBError**)error;
- (BOOL)	continueWithError:(LLDBError**)error;
- (BOOL)	stopWithError:(LLDBError**)error;
- (BOOL)	killWithError:(LLDBError**)error;
- (BOOL)	detachWithError:(LLDBError**)error;
//- (BOOL)	signal:(int)signal withError:(LLDBError**)error;
@end
