//
//  LLDBTarget.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import	"LLDBObject.h"
#import "LLDBDeclarations.h"





@interface	LLDBTarget : LLDBObject
- (LLDBFileSpec*)executableFileSpec;
- (LLDBBreakpoint*)createBreakpointByName:(NSString*)symbolName moduleName:(NSString*)moduleName;

- (LLDBProcess*)launchProcessSimplyWithWorkingDirectory:(NSString*)workingDirectory;
//- (LLDBProcess*)instantiateProcessByLaunchingSimplyWithArguments:(NSArray*)arguments environments:(NSArray*)environments workingDirectory:(NSString*)workingDirectory;
- (LLDBProcess*)attachToProcessWithID:(uint64_t)pid error:(LLDBError**)error;

@property	(readonly,nonatomic,assign)	NSUInteger	numberOfModules;
- (LLDBModule*)moduleAtIndex:(NSUInteger)index;
- (LLDBModule*)findModule:(LLDBFileSpec*)fileSpec;

- (NSString*)triple;

@property	(readonly,nonatomic,assign)	NSUInteger	numberOfBreakpoints;
- (LLDBBreakpoint*)breakpointAtIndex:(NSUInteger)index;

- (BOOL)	isEqualToTarget:(LLDBTarget*)object;
- (BOOL)	isEqual:(id)object;
@end
//
//@interface	LLDBTarget (LLDBObjectiveCLayerExtensions)
//- (NSArray*)allModules;
//- (NSArray*)allBreakpoints;
//@end
