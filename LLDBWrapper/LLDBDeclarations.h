//
//  LLDBDeclarations.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "LLDBObject.h"





typedef	uint64_t	LLDBAddressType;
typedef uint64_t	LLDBThreadIDType;
typedef uint64_t	LLDBProcessIDType;
typedef uint64_t	LLDBQueueIDType;
typedef int32_t		LLDBBreakpointIDType;
typedef	uint64_t	LLDBOffsetType;



@class	LLDBDebugger;
@class	LLDBBreakpoint;
@class	LLDBBreakpointLocation;

@class	LLDBTarget;
@class	LLDBProcess;
@class	LLDBThread;
@class	LLDBFrame;


@class	LLDBSourceManager;
@class	LLDBFileSpec;
@class	LLDBLineEntry;

@class	LLDBModule;
@class	LLDBCompileUnit;
@class	LLDBSection;
@class	LLDBFunction;
@class	LLDBBlock;
@class	LLDBInstructionList;
@class	LLDBInstruction;
@class	LLDBSymbol;
@class	LLDBValueList;
@class	LLDBValue;
@class	LLDBSymbolContext;


@class	LLDBBroadcaster;
@class	LLDBListener;
@class	LLDBEvent;



@class	LLDBError;
@class	LLDBData;

@class	LLDBObject;

