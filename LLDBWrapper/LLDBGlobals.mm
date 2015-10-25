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

//void
//initializeLLDBWrapper()
//{
//	// 하나의 프로세스에서 딱 한번만 호출되어야 함.
//	lldb::SBDebugger::Initialize();
//	isReady	=	true;
//}
//
//void
//terminateLLDBWrapper()
//{
//	// 하나의 프로세스에서 딱 한번만 호출되어야 함.
//	lldb::SBDebugger::Terminate();
//	isReady	=	false;
//}
//
//BOOL
//isLLDBWrapperReady()
//{
//	return	isReady;
//}








@implementation LLDBGlobals
+ (void)initializeLLDBWrapper
{
	// 하나의 프로세스에서 딱 한번만 호출되어야 함.
	lldb::SBDebugger::Initialize();
	isReady	=	true;
}
+ (void)terminateLLDBWrapper
{
	// 하나의 프로세스에서 딱 한번만 호출되어야 함.
	lldb::SBDebugger::Terminate();
	isReady	=	false;
}
+ (BOOL)isLLDBWrapperReady
{
	return	isReady;
}
@end