//
//  LLDBExpressionOptions.m
//  LLDBWrapper
//
//  Created by Brandon Evans on 2017-11-19.
//

#import <LLDB/LLDB.h>
#import "LLDBExpressionOptions.h"
#import "LLDB_Internals.h"

@implementation LLDBExpressionOptions

LLDBOBJECT_INIT_IMPL(lldb::SBExpressionOptions);

- (__nullable instancetype)init {
    self = [self initWithCPPObject:lldb::SBExpressionOptions()];
    return self;
}

- (BOOL)unwindOnError {
    return _raw.GetUnwindOnError();
}

- (void)setUnwindOnError:(BOOL)unwindOnError {
    _raw.SetUnwindOnError(unwindOnError);
}

- (BOOL)ignoreBreakpoints {
    return _raw.GetIgnoreBreakpoints();
}

- (void)setIgnoreBreakpoints:(BOOL)ignoreBreakpoints {
    _raw.SetIgnoreBreakpoints(ignoreBreakpoints);
}

- (uint32_t)timeoutInMicroseconds {
    return _raw.GetTimeoutInMicroSeconds();
}

- (void)setTimeoutInMicroseconds:(uint32_t)timeoutInMicroseconds {
    _raw.SetTimeoutInMicroSeconds(timeoutInMicroseconds);
}

- (BOOL)trapExceptions {
    return _raw.GetTrapExceptions();
}

- (void)setTrapExceptions:(BOOL)trapExceptions {
    _raw.SetTrapExceptions(trapExceptions);
}

- (BOOL)autoApplyFixIts {
    return _raw.GetAutoApplyFixIts();
}

- (void)setAutoApplyFixIts:(BOOL)autoApplyFixIts {
    _raw.SetAutoApplyFixIts(autoApplyFixIts);
}

- (void)setLanguage:(LLDBLanguageType)language {
    _raw.SetLanguage(toCPP(language));
}

- (BOOL)stopOthers {
    return _raw.GetStopOthers();
}

- (void)setStopOthers:(BOOL)stop {
    _raw.SetStopOthers(stop);
}

- (void)setPlaygroundTransformEnabled:(BOOL)enabled {
    _raw.SetPlaygroundTransformEnabled(enabled);
}

@end
