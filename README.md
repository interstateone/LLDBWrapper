Eonil/LLDBWrapper
=================
Hoon H.

2014/09/07
2015/01/20

**CURRENTLY WORK IN PROGRESS**

**DOCUMENTATION IS NOT ACCURATE NOR IN SYNC**


This is a wrapper of LLDB's public C++ API.
Wrapped in Objective-C, and intended to be used in Swift.

Named as `LLDBWrapper` to avoid possible name conflict with any existing system LLDB stuffs.
(I mean Xcode version)



Caution
-------
This project contains prebuilt binary of `LLDB.framework`, but this is not actually a binary.
This is just an empty hull that symlinked to LLDB.framework shipped within Xcode. 
(the only reason to makde this is to embed header files.)
that means this library will dynamically link to Xcode's LLDB component, and you may have
some troubles by Xcode versions.

This framework originally intended to use open-sourced LLDB build, but there were two problems.

-	Building of LLDb takes too much. And you are very likely to have several build issues. 
	(such as code signing)
-	Built binary is very large. It usually takes hundred megabytes. Then it also cannot be
	included in Git repository.

Anyway, if you want a stable build, you can link to your own build of LLDB.







History
-------
-	I have tried to generate SWIG-like C API from C++ source code, but I realised it require 
	too much work, and I don't have such time. DO NOT TRY THIS AT HOME.







License
-------
This project is licensed under "MIT License". That is limited only to my works. This project
contains files from LLVM/LLDB projects that are licensed under 
"University of Illinois/NCSA Open Source License". Product of this project will be dynamically
linked to some components of Xcode if there is one exists at runtime. I DO NOT redistribute
those components. So I don't think this linkage would not cause any license issue, but anyway, 
I am not a laywer. If you thinks something is wrong, please let me know.



