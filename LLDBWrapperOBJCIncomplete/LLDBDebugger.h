//
//  LLDBDebugger.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 14/8/17.
//
//

#import	"LLDBObject.h"
#import "LLDBDeclarations.h"
#import "LLDBEnums.h"



extern NSString* const		LLDBArchDefault;
extern NSString* const		LLDBArchDefault32Bit;
extern NSString* const		LLDBArchDefault64Bit;






@interface	LLDBDebugger : LLDBObject
@property	(readwrite,nonatomic,assign)	BOOL		async;
- (NSString*)stringOfState:(LLDBStateType)state;													///<	Use @c LLDBState~ constants.

- (LLDBTarget*)createTargetWithFilename:(NSString*)filename;
- (LLDBTarget*)createTargetWithFilename:(NSString*)filename andArchname:(NSString*)archname;		///<	You can use one of @c LLDBArchDefault~ constants.
- (NSUInteger)numberOfTargets;
- (LLDBTarget*)targetAtIndex:(NSUInteger)index;

//- (LLDBSourceManager*)sourceManager;
@end

@interface	LLDBDebugger (LLDBObjectiveCExtensions)
- (NSArray*)allTargets;
@end
