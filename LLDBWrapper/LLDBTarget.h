//
//  LLDBTarget.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#pragma once
#import	"LLDBObject.h"
#import "LLDBDeclarations.h"





@interface	LLDBTarget : LLDBObject
- (instancetype)init UNIVERSE_UNAVAILABLE_METHOD;

- (LLDBFileSpec*)executableFileSpec;
- (LLDBBreakpoint*)createBreakpointByName:(NSString*)symbolName;
- (LLDBBreakpoint*)createBreakpointByName:(NSString*)symbolName moduleName:(NSString*)moduleName;

- (LLDBProcess*)launchProcessSimplyWithWorkingDirectory:(NSString*)workingDirectory;
//- (LLDBProcess*)instantiateProcessByLaunchingSimplyWithArguments:(NSArray*)arguments environments:(NSArray*)environments workingDirectory:(NSString*)workingDirectory;
- (LLDBProcess*)attachToProcessWithID:(uint64_t)pid error:(LLDBError**)error;		///<	`error` parameter cannot be `nil`.

@property	(readonly,nonatomic,assign)	uint32_t	numberOfModules;
- (LLDBModule*)moduleAtIndex:(uint32_t)index;
- (LLDBModule*)findModule:(LLDBFileSpec*)fileSpec;

- (NSString*)triple;

@property	(readonly,nonatomic,assign)	uint32_t	numberOfBreakpoints;
- (LLDBBreakpoint*)breakpointAtIndex:(uint32_t)index;

- (BOOL)	isEqualToTarget:(LLDBTarget*)object;
- (BOOL)	isEqual:(id)object;
@end
//
//@interface	LLDBTarget (LLDBObjectiveCLayerExtensions)
//- (NSArray*)allModules;
//- (NSArray*)allBreakpoints;
//@end
