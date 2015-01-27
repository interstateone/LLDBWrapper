//
//  LLDBFrame.h
//  InteractiveDebugger
//
//  Created by Hoon H. on 9/7/14.
//
//

#import "LLDBObject.h"
#import "LLDBDeclarations.h"

@interface	LLDBFrame : LLDBObject
@property	(readonly,nonatomic,strong)	LLDBFunction*	function;
@property	(readonly,nonatomic,strong)	LLDBSymbol*		symbol;
@property	(readonly,nonatomic,strong)	LLDBValueList*	registers;
@end
