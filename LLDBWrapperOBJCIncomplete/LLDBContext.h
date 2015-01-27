//
//  LLDBContext.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/6/14.
//
//

#import	"LLDBObject.h"
#import "LLDBDeclarations.h"

/*!
 A root manager of all LLDB wrapper proxy objects.
 
 @note
 This is not a singleton object. You can make and destroy
 this object at anytime. But you can have only one instance
 of this object at a time.
 */
@interface LLDBContext : LLDBObject
- (LLDBDebugger*)instantiateDebugger;
@end
