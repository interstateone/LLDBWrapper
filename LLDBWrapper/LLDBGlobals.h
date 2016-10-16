//
//  LLDBGlobal.h
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/10/25.
//
//

#pragma once
#import <Foundation/Foundation.h>

@interface LLDBGlobals: NSObject
// Must be called ONLY ONCE in a process.
+ (void)initializeLLDBWrapper;

// Must be called ONLY ONCE in a process.
+ (void)terminateLLDBWrapper;

+ (BOOL)isLLDBWrapperReady;
@end
