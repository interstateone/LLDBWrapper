//
//  LLDBObject.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#pragma once
#import "BasicObject.h"
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

/*!
 Base class of all LLDB proxy objects.
 */
@interface LLDBObject : BasicObject

- (instancetype)init;

@end
