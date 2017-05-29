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
		let	dbg = LLDBDebugger()!
		dbg.async = false
		print(dbg)

		let	u = Bundle.main.bundleURL.deletingLastPathComponent().appendingPathComponent("SampleProgram3")
		assert(FileManager.default.fileExists(atPath: u.path))


		let	t = dbg.createTarget(withFilename: u.path, andArchname: LLDBArchDefault)!
		let	b = t.createBreakpoint(byName: "main")!
		let	b1 = t.createBreakpoint(byName: "printf")!
		b.isEnabled	=	true
		b1.isEnabled	=	true


		let	p = t.launchProcessSimply(withWorkingDirectory: u.deletingLastPathComponent().path)!

		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]!.lineEntry)
		p.`continue`()

		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]!.lineEntry)
		p.`continue`()
		
		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]!.lineEntry)
		p.`continue`()
		
		print(p.state.rawValue)
		print(p.allThreads[0].numberOfFrames)
		print(p.allThreads[0].allFrames[0]!.lineEntry.line)
		p.`continue`()
		
		print("done")
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}

