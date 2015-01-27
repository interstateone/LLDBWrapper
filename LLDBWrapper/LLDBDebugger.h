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
@property	(readonly,nonatomic,assign)		NSUInteger	numberOfTargets;
- (LLDBTarget*)targetAtIndex:(NSUInteger)index;

//- (LLDBSourceManager*)sourceManager;

- (BOOL)isEqual:(id)object UNIVERSE_UNAVAILABLE_METHOD;
- (BOOL)isEqualTo:(id)object UNIVERSE_UNAVAILABLE_METHOD;
- (id)copyScriptingValue:(id)value forKey:(NSString *)key withProperties:(NSDictionary *)properties UNIVERSE_UNAVAILABLE_METHOD;
@end

