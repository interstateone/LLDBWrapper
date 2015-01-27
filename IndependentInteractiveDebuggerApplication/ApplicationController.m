//
//  AppDelegate.m
//  IndependentInteractiveDebuggerApplication
//
//  Created by Hoon H. on 14/8/17.
//
//

#import "ApplicationController.h"
#import <LLDBWrapepr/LLDBWrapepr.h>

@implementation ApplicationController

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	@autoreleasepool
	{
		LLDBContext*	c1	=	[LLDBContext instantiation];
		@autoreleasepool
		{
			LLDBDebugger*	d1	=	[c1 instantiateDebugger];
			[d1 setAsync:NO];
			
			NSString*			a1	=	@"/Users/Eonil/Workshop/Temp/Xcode/Derivations/InteractiveDebugger-fxtrmrmmrbzuokdorjhxbwqqqlol/Build/Products/Debug/TestingSampleProgram1";
			LLDBTarget*			t1	=	[d1 instantiateTargetWithFilename:a1 andArchname:LLDBArchDefault];
			LLDBFileSpec*		f1	=	[t1 executableFileSpec];
			LLDBModule*			m1	=	[t1 findModule:f1];
			NSArray*			ss1	=	[m1 allSymbols];
			NSArray*	bps1	=	@[];
			for (LLDBSymbol* s1 in ss1)
			{
				LLDBBreakpoint*	bp1	=	[t1 createBreakpointByName:[s1 name] moduleName:[f1 filename]];
				bps1	=	[bps1 arrayByAddingObject:bp1];
			}
			LLDBBreakpoint*		b1	=	[t1 createBreakpointByName:@"main" moduleName:[f1 filename]];
			LLDBProcess*		p1	=	[t1 launchProcessSimplyWithWorkingDirectory:[[NSFileManager defaultManager] currentDirectoryPath]];
//			LLDBProcess*		p1	=	[t1 attachToProcessWithID:22647 error:NULL];
			
//			LLDBError*			e1	=	nil;
//			[p1 continueWithError:&e1];
//			NSLog(@"error = %@", e1);
			
			NSLog(@"target = %@", t1);
			NSLog(@"executable = %@", [f1 filename]);
			NSLog(@"module = %@", m1);
			NSLog(@"symbols = %@", ss1);
			NSLog(@"bp = %@, enabled = %@", b1, @([b1 isEnabled]));
//			NSLog(@"modules = %@", [t1 allModules]);
			NSLog(@"process state = %@, exit status = %@, exist description = %@", [d1 stringOfState:[p1 state]], @([p1 exitStatus]), [p1 exitDescription]);
			
			NSLog(@"debugger %@", d1);
			NSLog(@"process %@", p1);
			NSLog(@"threads = %@", [p1 allThreads]);
			NSLog(@"process state = %@", [d1 stringOfState:[p1 state]]);
		}
		NSLog(@"%@", c1);
	}
}

@end
