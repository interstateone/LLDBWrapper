//
//  AppDelegate.swift
//  TestdriveApp
//
//  Created by Hoon H. on 2015/02/01.
//
//

import Cocoa
import LLDBWrapper





@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	
	let	sv	=	NSScrollView()
	let	tv	=	ExecutionStateTreeViewController()
	
	lazy var	dbg	=	LLDBDebugger()!
	let	l	=	LLDBListener(name: "My Listener 1")

	func applicationDidFinishLaunching(_ aNotification: Notification) {
        LLDBGlobals.initializeLLDBWrapper()
		sv.documentView		=	tv.view
		window.contentView	=	sv
		
		dbg.async	=	false
		
		let	f	=	((Bundle.main.bundlePath as NSString).deletingLastPathComponent as NSString).appendingPathComponent("SampleProgram3")
		assert(FileManager.default.fileExists(atPath: f))

        let t   =   dbg.createTarget(withFilename: f, andArchname: LLDBArchDefault)!

		let	b	=	t.createBreakpoint(byName: "main")!
        b.isEnabled =   true

		let	p	=	t.launchProcessSimply(withWorkingDirectory: (f as NSString).deletingLastPathComponent)!
		
		print(t.triple())
		print(p.state.rawValue)
		print(p.allThreads[0].allFrames[0]?.lineEntry)
		print(p.allThreads[0].allFrames[0]?.functionName)
		
//		let	r	=	p.addListener(l, eventMask: LLDBProcess.BroadcastBit.StateChanged | LLDBProcess.BroadcastBit.Interrupt | LLDBProcess.BroadcastBit.STDOUT)
//		assert(r == LLDBProcess.BroadcastBit.StateChanged | LLDBProcess.BroadcastBit.Interrupt | LLDBProcess.BroadcastBit.STDOUT)
//		dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
//			let	e	=	self.l.waitForEvent(10)
//			let	s	=	e?.description
//			dispatch_async(dispatch_get_main_queue()) {
//				println(s)
//				println(p.description)
//				self.tv.debugger	=	nil
//				self.tv.debugger	=	self.dbg
////
////				let	d	=	self.dbg.allTargets[0].process.readFromStandardOutput()
////				let	s1	=	NSString(data: d, encoding: NSUTF8StringEncoding)
////				println("A: \(s1)")
//			}
//		}
		
		
		t.process.`continue`()
		tv.debugger	=	dbg

	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	
	@IBAction @objc
	func performStepOver(_: AnyObject?) {
//		tv.debugger	=	nil
//		dbg.allTargets[0].process.allThreads[0].stepOver()
//		tv.debugger	=	dbg
//		
//		let	d	=	dbg.allTargets[0].process.readFromStandardOutput()
//		let	s	=	NSString(data: d, encoding: NSUTF8StringEncoding)
//		println(s)
	}

}



class ExecutionStateTreeViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
	var	outlineView:NSOutlineView {
		get {
			return	view as! NSOutlineView
		}
	}
	
	var	debugger:LLDBDebugger? {
		get {
			return	self.representedObject as! LLDBDebugger?
		}
		set(v) {
			self.representedObject	=	v
		}
	}


    override var representedObject: Any? {
		get {
			return	super.representedObject as AnyObject?
		}
		set(v) {
			precondition(v == nil || v is LLDBDebugger)
			super.representedObject	=	v
			
			_rootNode	=	v == nil ? nil : DebuggerNode(v as! LLDBDebugger)
			
			self.outlineView.reloadData()
			if _rootNode != nil {
				self.outlineView.expandItem(_rootNode, expandChildren: true)
			}
		}
	}
	
	override func loadView() {
		super.view	=	NSOutlineView()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.outlineView.dataSource = self
		self.outlineView.delegate = self
		
		let	tc1	=	NSTableColumn()
		self.outlineView.addTableColumn(tc1)
		self.outlineView.outlineTableColumn	=	tc1
	}
	
	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
		if item == nil {
			return	debugger == nil ? 0 : 1
		}
		let	n	=	item as! NodeBase
		return	n.subnodes.count
	}
	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
		if item == nil {
			return	_rootNode!
		}
		let	n	=	item as! NodeBase
		return	n.subnodes[index]
	}
	func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
		let	n	=	item as! NodeBase
		return	n.label
	}
	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
		return	self.outlineView(outlineView, numberOfChildrenOfItem: item) > 0
	}
	
	////
	
	fileprivate var	_rootNode:DebuggerNode?
}


















class NodeBase {
	var	label		=	""
	var	subnodes	=	[] as [NodeBase]
}

class DebuggerNode: NodeBase {
	var	data:LLDBDebugger
	init(_ data:LLDBDebugger) {
		self.data		=	data
		
		super.init()
		self.label		=	data.description
		self.subnodes	=	data.allTargets.map({ v in TargetNode(v) })
	}
}

class TargetNode: NodeBase {
	var	data:LLDBTarget
	init(_ data:LLDBTarget) {
		self.data		=	data
		
		super.init()
		self.label		=	data.description
		self.subnodes	=	data.process == nil ? [] : [ProcessNode(data.process)]
	}
}

class ProcessNode: NodeBase {
	var	data:LLDBProcess
	init(_ data:LLDBProcess) {
		self.data		=	data
		
		super.init()
		self.label		=	data.description
		self.subnodes	=	data.allThreads.map({ v in ThreadNode(v) })
	}
}

class ThreadNode: NodeBase {
	var	data:LLDBThread
	init(_ data:LLDBThread) {
		self.data		=	data
		
		super.init()
		self.label		=	data.description
		self.subnodes	=	data.allFrames.filter({ v in v != nil }).map({ v in FrameNode(v!) })
	}
}

class FrameNode: NodeBase {
	var	data:LLDBFrame
	init(_ data:LLDBFrame) {
		self.data		=	data
		
		super.init()
		self.label		=	data.description
		self.subnodes	=	[]
	}
}





























