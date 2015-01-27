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
}




extension LLDBThread {
	var	allFrames:[LLDBFrame] {
		get {
			return	(0..<self.numberOfFrames).map { i in self.frameAtIndex(i) }
		}
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




