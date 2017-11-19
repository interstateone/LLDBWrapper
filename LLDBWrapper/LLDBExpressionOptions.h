//
//  LLDBExpressionOptions.h
//  LLDBWrapper
//
//  Created by Brandon Evans on 2017-11-19.
//

#pragma once
#import "LLDBObject.h"
#import "LLDBEnums.h"

@interface LLDBExpressionOptions : LLDBObject

@property(nonatomic, assign) BOOL unwindOnError;
@property(nonatomic, assign) BOOL ignoreBreakpoints;
@property(nonatomic, assign) uint32_t timeoutInMicroseconds;
@property(nonatomic, assign) BOOL trapExceptions;
@property(nonatomic, assign) BOOL autoApplyFixIts;

- (__nullable instancetype)init;

- (void)setLanguage:(LLDBLanguageType)language;

@end
