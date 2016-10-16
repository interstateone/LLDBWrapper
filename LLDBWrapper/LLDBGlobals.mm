//
//  LLDBGlobals.m
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/10/25.
//
//

#import <Foundation/Foundation.h>
#import <LLDB/LLDB.h>
#import "LLDB_Internals.h"
#import "LLDBGlobals.h"

static BOOL isReady	=	false;

@implementation LLDBGlobals
+ (void)initializeLLDBWrapper
{
    // Must be called ONLY ONCE in a process.
	lldb::SBDebugger::Initialize();
	isReady	=	true;
}
+ (void)terminateLLDBWrapper
{
    // Must be called ONLY ONCE in a process.
	lldb::SBDebugger::Terminate();
	isReady	=	false;
}
+ (BOOL)isLLDBWrapperReady
{
	return	isReady;
}
@end
