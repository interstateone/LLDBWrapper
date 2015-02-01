Eonil/LLDBWrapper
=================
Hoon H.

2014/09/07
2015/02/01




This is a wrapper of LLDB's public C++ API.
Wrapped in Objective-C++, and complemented in Swift. 
Intended to be used in Swift.

Named as `LLDBWrapper` to avoid possible name conflict with any existing system LLDB stuffs.
(I mean Xcode version)



Caution
-------
Though this framework originally intended to work with open-sourced LLDB build, but there were
two problems.

-	Building of LLDB takes too long and needs some unfamiliar works. You are very likely to 
	have several build issues. (such as code signing)

-	Built binary is very large. It usually takes hundred megabytes. Then it also cannot be
	included in Git repository. (Github allows only files up to about 100MiB)

To avoid these problems, this project currently contains a "fake" prebuilt `LLDB.framework` 
that just symlinked to binaries of LLDB.framework shipped within Xcode. Anyway this fake 
framework is required to expose header files to build process.

This means this library will dynamically link to Xcode's LLDB component at runtime, and you 
may have some troubles by Xcode versions or another C++ binary code interfacing issues. 

If you want, you can link to your own build of LLDB by changing link settings. (such as 
`LD_RUNPATH_SEARCH_PATHS`) Linking to Xcode component is just current decision, and can be 
changed later.

Currently, enum constant values are explicitly designated. These values are generated by Clang
library so should be correct. But I think this is not truly reliable because original enums 
does not define specific value, and that means it must be treated as symbols rather than 
numbers to be reliable. I will change this later to use name-based mapping. 

This does not fully cover all API. Only covers what I need.
For example, this fully lacks asynchronous event notification part. Anyway such features
can be added later if I feel need for it.





Lessons from History
--------------------
-	I have tried to generate SWIG-like C API from C++ source code, but I realised it requires 
	too much work and Swift compiler is not stable enough yet. I don't have such time. DO NOT 
	TRY THIS AT HOME EVER AGAIN unless you have enough idle time. (I wasted about 3 weeks and
	finally abandoned the approach --- failure)








Wrapping Design Choices
-----------------------
-	Only valid API object will become an Objective-C object. (`IsValid() == true`) Calling `init...`
	method with invalid object will return `nil`.

-	`SB~` classes are also proxies, and can become invalid state (`IsValid() == true`) at any time.
	Objective-C object will perform debug mode assertions for calling any method on invalid state.

-	Equality and comparison operators will be provided if original C++ classes provides corresponding 
	operators.

-	Identity of Objective-C object has no meaning. Do not rely on it. Generally, there's no generic 
	identity check. Anyway some equality check provides identity check case by case.

-	Use C numeric types as is as much as possible. Convert them in Swift-side extensions where needed.
	If the numeric type is `typedef`ed inside of C++ namespaces/classes, then make a new C `typedef`
	manually, and `static_assert` for equality.

-	Strings will always be passed by copying into a new `NSString` by default. Raw C-string pointers
	will not be exposed unless required.

-	Enums should be redefined in C side, and mapped to corresponding C++ constants.

-	No exception. Because (1) to be used with Swift. (2) I don't think exceptions are truly good one.
	Wrapper method must return a proper error or crash reliably.
	







License
-------
This project is licensed under "MIT License". That is limited only to my works. This project
contains files from LLVM/LLDB projects that are licensed under 
"University of Illinois/NCSA Open Source License". Product of this project will be dynamically
linked to some components of Xcode if there is one exists at runtime. I DO NOT redistribute
those components. So I don't think this linkage would cause any license issue, but anyway, 
I am not a laywer. If you think something is wrong, please let me know.



