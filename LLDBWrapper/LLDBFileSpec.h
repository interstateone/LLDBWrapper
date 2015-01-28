//
//  LLDBFileSpec.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#pragma once
#import	"LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBFileSpec : LLDBObject
@property (readonly,nonatomic,assign) NSString* filename;
@end
