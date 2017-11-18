//
//  LLDBExtensions.swift
//  LLDBWrapper
//
//  Created by Hoon H. on 2015/01/28.
//
//

import Foundation














///	MARK:
///	MARK:	Drivers


public extension LLDBDebugger {
	public var	allTargets:[LLDBTarget] {
		get {
			return	(0..<self.numberOfTargets).map { i in self.target(at: i) }
		}
	}
}


public extension LLDBTarget {
	public var	allModules:[LLDBModule] {
		get {
			return	(0..<self.numberOfModules).map { i in self.module(at: i) }
		}
	}
	public var allBreakpoints:[LLDBBreakpoint] {
		get {
			return	(0..<self.numberOfBreakpoints).map { i in self.breakpoint(at: i) }
		}
	}
	public func createBreakpointByLocationWithFilePath(_ file:String, lineNumber:UInt32) -> LLDBBreakpoint {
		let	fs	=	LLDBFileSpec(path: file, resolve: true)
		return	self.createBreakpointByLocation(with: fs, lineNumber: lineNumber)
	}
}

































///	MARK:
///	MARK:	Execution States

public extension LLDBProcess {
	public var	allThreads:[LLDBThread] {
		get {
			return	(0..<self.numberOfThreads).map { i in self.thread(at: i) }
		}
	}
	public func writeToStandardInput(_ source:Data) -> Int {
		let	sz				=	source.count
		let	sz1				=	size_t(sz)
		let	written_len		=	self.putStandardInput((source as NSData).bytes.bindMemory(to: CChar.self, capacity: source.count), length: sz1)
		let	written_len1	=	Int(written_len)
		return	written_len1
	}
//	///	Crashes if source data couldn't be fully written.
//	func writeToStandardInput(source:String) {
//		let	d	=	source.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//		let	len	=	writeToStandardInput(d)
//		precondition(len == d.length, "Couldn't write all string to STDIN.")
	//	}
	public func readFromStandardOutput() -> Data {
		let	len			=	size_t(8192)
        var buffer      =   Data()
        buffer.count    =   len
        let read_len    =   buffer.withUnsafeMutableBytes { (p: UnsafeMutablePointer<CChar>) -> Int in
            return getStandardOutput(p, length: len)
        }
		let	buffer1     =	buffer.subdata(in: 0..<read_len)
		return buffer1
	}
	public func readFromStandardError() -> Data {
		let	len			=	size_t(8192)
        var buffer      =   Data()
		buffer.count    =	len
        let read_len    =   buffer.withUnsafeMutableBytes { (p: UnsafeMutablePointer<CChar>) -> Int in
            return getStandardError(p, length: len)
        }
        let buffer1     =   buffer.subdata(in: 0..<read_len)
		return buffer1
	}
	
	public func readMemory(_ range:Range<LLDBAddressType>) -> (data:Data, error:LLDBError?) {
		let	len		=	range.upperBound - range.lowerBound
		let	d		=	NSMutableData()
		var	e		=	 nil as LLDBError?
		d.length	=	Int(len)

		let	avail	=	self.readMemory(range.lowerBound, buffer: d.mutableBytes, size: size_t(len), error: &e)
		let	avail1	=	Int(avail)
		let	d1		=	d.subdata(with: NSRange(location: 0, length: avail1))
		return	(d1, e)
	}
	public func writeMemory(_ range:Range<LLDBAddressType>, data:Data) -> (length:Int, error:LLDBError?) {
		let	sz		=	range.upperBound - range.lowerBound
		let	sz1		=	size_t(sz)
		var	e		=	nil as LLDBError?
		
		let	avail	=	self.writeMemory(range.lowerBound, buffer: (data as NSData).bytes, size: sz1, error: &e)
		let	avail1	=	Int(avail)
		return	(avail1, e)
	}
	
	public class func allRestartedReasonsForEvent(_ event:LLDBEvent) -> [String] {
		return	(0..<self.numberOfRestartedReasons(from: event)).map { i in self.restartedReasonAtIndex(from: event, index: i) }
	}
	public var numberOfSupportedHardwareWatchpoints:(number:Int, error:LLDBError?) {
		get {
			var	e	=	nil as LLDBError?
			let	r	=	self.number(ofSupportedHardwareWatchpoints: &e)
			let	r1	=	Int(r)
			return	(r1,e)
		}
	}
	
	public func loadImage(_ imageSpec:LLDBFileSpec) -> (Int, LLDBError?) {
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

public extension LLDBProcess {
	typealias	BroadcastBit	=	LLDbProcessBroadcastBit
}
//	Values are explicitly assigned at C++ level, so it seems safe to copy them here.
public struct LLDbProcessBroadcastBit: OptionSet {
	public typealias RawValue			=	UInt32
	
	public static let allZeros			=	LLDbProcessBroadcastBit(rawValue: 0)
	public static let StateChanged		=	LLDbProcessBroadcastBit(rawValue: 1 << 0)
	public static let Interrupt			=	LLDbProcessBroadcastBit(rawValue: 1 << 1)
	public static let STDOUT			=	LLDbProcessBroadcastBit(rawValue: 1 << 2)
	public static let STDERR			=	LLDbProcessBroadcastBit(rawValue: 1 << 3)
	public static let ProfileData		=	LLDbProcessBroadcastBit(rawValue: 1 << 4)
	
	public let	rawValue:RawValue
	
	public init(rawValue:RawValue) {
		self.rawValue	=	rawValue
	}
	public init(nilLiteral:()) {
		self.rawValue	=	0
	}
}



public extension LLDBThread {
//	///	Returns collection of all valid frames.
//	///	Number of returned frames may be different
//	///	because `frameAtIndex` may return `nil`,
//	public var frames:[LLDBFrame] {
//		get {
//		}
//	}
	public var	allFrames:[LLDBFrame?] {
		get {
			return	(0..<self.numberOfFrames).map { i in self.frame(at: i) }
		}
	}
	public var	allStopReasonData:[UInt64] {
		get {
			return	(0..<self.stopReasonDataCount).map { i in self.stopReasonData(at: UInt32(i)) }
		}
	}
	public func returnFromFrame(_ frame:LLDBFrame) -> (returnValue:LLDBValue, error:LLDBError?) {
		var	v	=	nil as LLDBValue?
		let	e	=	self.return(from: frame, return: &v);
		return	(v!,e)
	}
}

//public extension LLDBThread {
//	typealias	BroadcastBit	=	LLDbThreadBroadcastBit
//}
////	Values are explicitly assigned at C++ level, so it seems safe to copy them here.
//public struct LLDbThreadBroadcastBit: RawOptionSetType {
//	public typealias RawValue	=	UInt32
//	
//	public static let allZeros					=	LLDbThreadBroadcastBit(rawValue: 0)
//	public static let StackChanged				=	LLDbThreadBroadcastBit(rawValue: 1 << 0)
//	public static let ThreadSuspended			=	LLDbThreadBroadcastBit(rawValue: 1 << 1)
//	public static let ThreadResumed				=	LLDbThreadBroadcastBit(rawValue: 1 << 2)
//	public static let SelectedFrameChanged		=	LLDbThreadBroadcastBit(rawValue: 1 << 3)
//	public static let ThreadSelected			=	LLDbThreadBroadcastBit(rawValue: 1 << 4)
//	
//	public let	rawValue:RawValue
//	
//	public init(rawValue:RawValue) {
//		self.rawValue	=	rawValue
//	}
//	public init(nilLiteral:()) {
//		self.rawValue	=	0
//	}
//}













extension LLDBValueList: Sequence {
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
			return	value(at: UInt32(index))
		}
	}
	public func makeIterator() -> AnyIterator<LLDBValue> {
		var	idx	=	0
		return	AnyIterator { [weak self] in
			idx += 1
			if idx == self!.count {
				return	nil
			} else {
				return	self![idx]
			}
		}
	}
	public var	allValues:[LLDBValue?] {
		get {
			return	(0..<self.count).map { i in self[i] }
		}
	}
	public var allAvailableValues:[LLDBValue] {
		get {
			return	allValues.filter({ v in v != nil }).map({ v in v! })
		}
	}
}



public extension LLDBValue {
	public var	allChildren:[LLDBValue?] {
		get {
			return	(0..<self.numberOfChildren).map { i in self.child(at: i) }
		}
	}
	public var allAvailableChildren:[LLDBValue] {
		get {
			return	allChildren.filter({ v in v != nil }).map({ v in v! })
		}
	}
}































///	MARK:
///	MARK:	Code Database

public extension LLDBModule {
	public var	allSymbols:[LLDBSymbol] {
		get {
			return	(0..<self.numberOfSymbols).map { i in self.symbol(at: i) }
		}
	}
}


extension LLDBInstructionList: Sequence {
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
			return	instruction(at: UInt32(index))
		}
	}
	public func makeIterator() -> AnyIterator<LLDBInstruction> {
		var	idx	=	0
		return	AnyIterator { [weak self] in
			idx += 1
			if idx == self!.count {
				return	nil
			} else {
				return	self![idx]
			}
		}
	}
	public var	allInstructions:[LLDBInstruction] {
		get {
			return	(0..<self.count).map { i in self[i] }
		}
	}
}






























///	MARK:
///	MARK:	Source Tracking

public extension LLDBCompileUnit {
	public var	allLineEntries:[LLDBLineEntry] {
		get {
			return	(0..<self.numberOfLineEntries).map { i in self.lineEntry(at: i) }
		}
	}
	public var	allSupportFiles:[LLDBFileSpec] {
		get {
			return	(0..<self.numberOfSupportFiles).map { i in self.supportFile(at: i) }
		}
	}
}
































///	MARK:
///	MARK:	Event Listening Related

public extension LLDBBroadcaster {
//	func broadcastEventByType2(eventType:UInt32) {
//		self.broadcastEventByType(eventType, unique: false);
//	}
	
//	func addListener<T:RawOptionSetType where T.RawValue == UInt32>(listener: LLDBListener, eventMask: T) {
//		self.addListener(listener, eventMask: eventMask.rawValue)
//	}
}
public extension LLDBProcess {
	/// Return the event bits that were granted to the listener
	func addListener(_ listener: LLDBListener, eventMask: LLDBProcess.BroadcastBit) -> LLDBProcess.BroadcastBit {
		return	LLDBProcess.BroadcastBit(rawValue: self.broadcaster.add(listener, eventMask: eventMask.rawValue))
	}
	func removeListener(_ listener: LLDBListener, eventMask: LLDBProcess.BroadcastBit) -> Bool {
		return	self.broadcaster.remove(listener, eventMask: eventMask.rawValue)
	}
}
//public extension LLDBThread {
//	func addListener(listener: LLDBListener, eventMask: LLDBThread.BroadcastBit) {
//		self.broadcaster.addListener(listener, eventMask: eventMask.rawValue)
//	}
//	func removeListener(listener: LLDBListener, eventMask: LLDBThread.BroadcastBit) {
//		self.broadcaster.removeListener(listener, eventMask: eventMask.rawValue)
//	}
//}

public extension LLDBListener {
	/// Returns `nil` for timeout.
	func waitForEvent(_ seconds:Int) -> LLDBEvent? {
		let	s	=	UInt32(seconds)
		var	e	=	nil as LLDBEvent?
		let	ok	=	self.wait(forEvent: s, event: &e)
		if ok {
			return	e
		} else {
			return	nil
		}
	}
}

















///	MARK:
///	MARK:	Infrastructure Utilities

public extension LLDBData {
	public var	data:Data {
		get {
			let	d		=	NSMutableData()
			var	e		=	nil as LLDBError?
			d.length	=	Int(self.byteSize)
			let	sz1		=	self.readRawData(withOffset: LLDBOffsetType(0), buffer: d.mutableBytes, size: self.byteSize, error: &e)
			precondition(e == nil, "An error `\(e!)` occured while reading from this object.")
			precondition(sz1 == d.length)
			precondition(sz1 == self.byteSize)
			return	d as Data
		}
		set(v) {
			var	e		=	nil as LLDBError?
			self.setDataWithBuffer((v as NSData).bytes, size: size_t(v.count), endian: self.byteOrder, addressSize: self.addressByteSize, error: &e)
			
			precondition(e == nil, "An error `\(e!)` occured while writing to this object.")
		}
	}
}







