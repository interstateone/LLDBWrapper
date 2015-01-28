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




@class	LLDBDebugger;
@class	LLDBBreakpoint;

@class	LLDBTarget;
@class	LLDBProcess;
@class	LLDBThread;
@class	LLDBFrame;


//@class	LLDBSourceManager;
@class	LLDBFileSpec;
@class	LLDBLineEntry;

@class	LLDBModule;
@class	LLDBCompileUnit;
@class	LLDBFunction;
@class	LLDBBlock;
@class	LLDBInstructionList;
@class	LLDBInstruction;
@class	LLDBSymbol;
@class	LLDBValueList;
@class	LLDBValue;
@class	LLDBSymbolContext;

@class	LLDBError;

@class	LLDBBroadcaster;
@class	LLDBListener;
@class	LLDBEvent;





@class	LLDBObject;

