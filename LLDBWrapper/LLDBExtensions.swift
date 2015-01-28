//
//  LLDBExtensions.swift
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/01/28.
//
//

import Foundation
import LLDBWrapper





extension LLDBDebugger {
	var	allTargets:[LLDBTarget] {
		get {
			return	(0..<self.numberOfTargets).map { i in self.targetAtIndex(i) }
		}
	}
}


extension LLDBTarget {
	var	allModules:[LLDBModule] {
		get {
			return	(0..<self.numberOfModules).map { i in self.moduleAtIndex(i) }
		}
	}
	var allBreakpoints:[LLDBBreakpoint] {
		get {
			return	(0..<self.numberOfBreakpoints).map { i in self.breakpointAtIndex(i) }
		}
	}
}

extension LLDBModule {
	var	allSymbols:[LLDBSymbol] {
		get {
			return	(0..<self.numberOfSymbols).map { i in self.symbolAtIndex(i) }
		}
	}
}

extension LLDBProcess {
	var	allThreads:[LLDBThread] {
		get {
			return	(0..<self.numberOfThreads).map { i in self.threadAtIndex(i) }
		}
	}
	func writeToStandardInput(source:NSData) -> Int {
		let	sz				=	source.length
		let	sz1				=	size_t(sz)
		let	written_len		=	self.putStandardInput(UnsafePointer<CChar>(source.bytes), length: sz1)
		let	written_len1	=	Int(written_len)
		return	written_len1
	}
//	///	Crashes if source data couldn't be fully written.
//	func writeToStandardInput(source:String) {
//		let	d	=	source.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//		let	len	=	writeToStandardInput(d)
//		precondition(len == d.length, "Couldn't write all string to STDIN.")
	//	}
	func readFromStandardOutput(maximumLength:Int) -> NSData {
		let	d			=	NSMutableData()
		let	len			=	size_t(maximumLength)
		d.length		=	maximumLength
		let	read_len	=	self.getStandardOutput(UnsafeMutablePointer<CChar>(d.mutableBytes), length: len)
		let	read_len1	=	Int(read_len)
		let	d1			=	d.subdataWithRange(NSRange(location: 0, length: read_len1))
		return	d1
	}
	func readFromStandardError(maximumLength:Int) -> NSData {
		let	d			=	NSMutableData()
		let	len			=	size_t(maximumLength)
		d.length		=	maximumLength
		let	read_len	=	self.getStandardError(UnsafeMutablePointer<CChar>(d.mutableBytes), length: len)
		let	read_len1	=	Int(read_len)
		let	d1			=	d.subdataWithRange(NSRange(location: 0, length: read_len1))
		return	d1
	}
	
	func readMemory(range:Range<LLDBAddressType>) -> (data:NSData, error:LLDBError?) {
		let	len		=	range.endIndex - range.startIndex
		let	d		=	NSMutableData()
		var	e		=	 nil as LLDBError?
		d.length	=	Int(len)

		let	avail	=	self.readMemory(range.startIndex, buffer: d.mutableBytes, size: size_t(len), error: &e)
		let	avail1	=	Int(avail)
		let	d1		=	d.subdataWithRange(NSRange(location: 0, length: avail1))
		return	(d1, e)
	}
	func writeMemory(range:Range<LLDBAddressType>, data:NSData) -> (length:Int, error:LLDBError?) {
		let	sz		=	range.endIndex - range.startIndex
		let	sz1		=	size_t(sz)
		var	e		=	nil as LLDBError?
		
		let	avail	=	self.writeMemory(range.startIndex, buffer: data.bytes, size: sz1, error: &e)
		let	avail1	=	Int(avail)
		return	(avail1, e)
	}
	
	class func allRestartedReasonsForEvent(event:LLDBEvent) -> [String] {
		return	(0..<self.numberOfRestartedReasonsFromEvent(event)).map { i in self.restartedReasonAtIndexFromEvent(event, index: i) }
	}
	var numberOfSupportedHardwareWatchpoints:(number:Int, error:LLDBError?) {
		get {
			var	e	=	nil as LLDBError?
			let	r	=	self.numberOfSupportedHardwareWatchpoints(&e)
			let	r1	=	Int(r)
			return	(r1,e)
		}
	}
	
	func loadImage(imageSpec:LLDBFileSpec) -> (Int, LLDBError?) {
		var	e	=	nil as LLDBError?
		let	r	=	self.loadImage(imageSpec, error: &e)
		let	r1	=	Int(r)
		return	(r1, e)
	}
	
//	var	allExtendedBacktraceTypes:[String] {
//		get {
//			return	(0..<numberOfExtendedBacktraceTypes).map { i in self.extendedBacktraceTypeAtIndex(i) }
//		}
//	}
}




extension LLDBThread {
	var	allFrames:[LLDBFrame] {
		get {
			return	(0..<self.numberOfFrames).map { i in self.frameAtIndex(i) }
		}
	}
	var	allStopReasonData:[UInt64] {
		get {
			return	(0..<self.stopReasonDataCount).map { i in self.stopReasonDataAtIndex(UInt32(i)) }
		}
	}
	func returnFromFrame(frame:LLDBFrame) -> (returnValue:LLDBValue, error:LLDBError?) {
		var	v	=	nil as LLDBValue?
		let	e	=	self.returnFromFrame(frame, returnValue: &v);
		return	(v!,e)
	}
}


extension LLDBValueList: CollectionType {
	public var count:Int {
		get {
			return	Int(size)
		}
	}
	public var startIndex:Int {
		get {
			return	0
		}
	}
	public var endIndex:Int {
		get {
			return	count
		}
	}
	public subscript(index:Int) -> LLDBValue {
		get {
			return	valueAtIndex(UInt32(index))
		}
	}
	public func generate() -> GeneratorOf<LLDBValue> {
		var	idx	=	0
		return	GeneratorOf { [weak self] in
			idx++
			if idx == self!.count {
				return	nil
			} else {
				return	self![idx]
			}
		}
	}
	var	allValues:[LLDBValue] {
		get {
			return	(0..<self.count).map { i in self[i] }
		}
	}
}









extension LLDBInstructionList: CollectionType {
	public var count:Int {
		get {
			return	Int(size)
		}
	}
	public var startIndex:Int {
		get {
			return	0
		}
	}
	public var endIndex:Int {
		get {
			return	Int(count)
		}
	}
	public subscript(index:Int) -> LLDBInstruction {
		get {
			return	instructionAtIndex(UInt32(index))
		}
	}
	public func generate() -> GeneratorOf<LLDBInstruction> {
		var	idx	=	0
		return	GeneratorOf { [weak self] in
			idx++
			if idx == self!.count {
				return	nil
			} else {
				return	self![idx]
			}
		}
	}
	var	allInstructions:[LLDBInstruction] {
		get {
			return	(0..<self.count).map { i in self[i] }
		}
	}
}






extension LLDBValue {
	var	allChildren:[LLDBValue] {
		get {
			return	(0..<self.numberOfChildren).map { i in self.childAtIndex(i) }
		}
	}
}




























///	MARK:
///	MARK:	Source Tracking

extension LLDBCompileUnit {
	var	allLineEntries:[LLDBLineEntry] {
		get {
			return	(0..<self.numberOfLineEntries).map { i in self.lineEntryAtIndex(i) }
		}
	}
	var	allSupportFiles:[LLDBFileSpec] {
		get {
			return	(0..<self.numberOfSupportFiles).map { i in self.supportFileAtIndex(i) }
		}
	}
}




























///	MARK:
///	MARK:	Event Listening Related

extension LLDBBroadcaster {
	func broadcastEventByType2(eventType:UInt32) {
		self.broadcastEventByType(eventType, unique: false);
	}
}






