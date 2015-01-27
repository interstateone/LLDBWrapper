//
//  LLDBValue.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface LLDBValue : LLDBObject
@property	(readonly,nonatomic,copy)	NSString*	name;
@property	(readonly,nonatomic,copy)	NSString*	typeName;
@property	(readonly,nonatomic,copy)	NSString*	displayTypeName;
@property	(readonly,nonatomic,copy)	NSString*	value;
@property	(readonly,nonatomic,assign)	NSUInteger	numberOfChildren;
- (LLDBValue*)childAtIndex:(NSUInteger)index;
@property	(readonly,nonatomic,copy)	NSString*	location;
@property	(readonly,nonatomic,copy)	NSString*	summary;
@property	(readonly,nonatomic,copy)	NSString*	objectDescription;
@end
