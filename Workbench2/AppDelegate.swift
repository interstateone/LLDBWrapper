//
//  AppDelegate.swift
//  Workbench2
//
//  Created by Hoon H. on 2015/01/29.
//
//

import Cocoa
import LLDBWrapper

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!


	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		let	dbg	=	LLDBDebugger()
		dbg.async	=	false
		print(dbg)

		let	u	=	NSBundle.mainBundle().bundleURL.URLByDeletingLastPathComponent!.URLByAppendingPathComponent("SampleProgram3")
		assert(NSFileManager.defaultManager().fileExistsAtPath(u.path!))
		
		let	t	=	dbg.createTargetWithFilename(u.path!, andArchname: LLDBArchDefault)
		let	b	=	t.createBreakpointByName("main")
		let	b1	=	t.createBreakpointByName("printf")
		b.enabled	=	true
		b1.enabled	=	true

		let	p	=	t.launchProcessSimplyWithWorkingDirectory(u.URLByDeletingLastPathComponent!.path!)

		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]?.lineEntry)
		p.`continue`()

		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]?.lineEntry)
		p.`continue`()
		
		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]?.lineEntry)
		p.`continue`()
		
		print(p.state.rawValue)
		print(p.allThreads[0].numberOfFrames)
		print(p.allThreads[0].allFrames[0]?.lineEntry.line)
		p.`continue`()
		
		print("done")
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}

