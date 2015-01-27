//
//  LLDBTarget.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import	"LLDBObject.h"
#import "LLDBDeclarations.h"



//@protocol	LLDBTarget
//- (LLDBFileSpec*)executable;
//- (LLDBBreakpoint*)instantiateBreakpointByName:(NSString*)symbolName;
//
//- (LLDBProcess*)launchSimpleWithWorkingDirectory:(NSString*)workingDirectory;
//- (LLDBProcess*)instantiateProcessByAttachingToProcessWithID:(uint64_t)pid error:(LLDBError**)error;
//
//- (NSUInteger)numberOfModules;
//- (LLDBModule*)moduleAtIndex:(NSUInteger)index;
//
//- (NSString*)triple;
//
//- (NSUInteger)numberOfBreakpoints;
//- (LLDBBreakpoint*)breakpointAtIndex:(NSUInteger)index;
//
//- (BOOL)	isEqualToTarget:(LLDBTarget*)object;
//- (BOOL)	isEqual:(id)object;
//@end
//
//@protocol	LLDBTargetExtensions
//- (NSArray*)allModules;
//- (NSArray*)allBreakpoints;
//@end



@interface	LLDBTarget : LLDBObject
- (LLDBFileSpec*)executableFileSpec;
- (LLDBBreakpoint*)instantiateBreakpointByName:(NSString*)symbolName moduleName:(NSString*)moduleName;

- (LLDBProcess*)instantiateProcessByLaunchingSimplyWithWorkingDirectory:(NSString*)workingDirectory;
//- (LLDBProcess*)instantiateProcessByLaunchingSimplyWithArguments:(NSArray*)arguments environments:(NSArray*)environments workingDirectory:(NSString*)workingDirectory;
- (LLDBProcess*)instantiateProcessByAttachingToProcessWithID:(uint64_t)pid error:(LLDBError**)error;

- (NSUInteger)numberOfModules;
- (LLDBModule*)moduleAtIndex:(NSUInteger)index;
- (LLDBModule*)moduleForFileSpec:(LLDBFileSpec*)fileSpec;

- (NSString*)triple;

- (NSUInteger)numberOfBreakpoints;
- (LLDBBreakpoint*)breakpointAtIndex:(NSUInteger)index;

- (BOOL)	isEqualToTarget:(LLDBTarget*)object;
- (BOOL)	isEqual:(id)object;
@end

@interface	LLDBTarget (LLDBObjectiveCExtensions) 
- (NSArray*)allModules;
- (NSArray*)allBreakpoints;
@end
