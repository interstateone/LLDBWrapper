//
//  LLDBGlobal.h
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/10/25.
//
//

#pragma once
#import <Foundation/Foundation.h>

//// 하나의 프로세스에서 딱 한번만 호출되어야 함.
//void initializeLLDBWrapper();
//
//// 하나의 프로세스에서 딱 한번만 호출되어야 함.
//void terminateLLDBWrapper();
//
//BOOL isLLDBWrapperReady();

@interface LLDBGlobals: NSObject
// 하나의 프로세스에서 딱 한번만 호출되어야 함.
+ (void)initializeLLDBWrapper;

// 하나의 프로세스에서 딱 한번만 호출되어야 함.
+ (void)terminateLLDBWrapper;

+ (BOOL)isLLDBWrapperReady;
@end