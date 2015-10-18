#wrend
**Bindings to the Wren language for use with the D programming language**

---

## Overview
Wren is a small, fast, class-based concurrent scripting language. Think 
Smalltalk in a Lua-sized package with a dash of Erlang and wrapped up in a 
familiar, modern syntax.

### Website
http://munificent.github.io/wren/

### Github
https://github.com/munificent/wren

## Usage

### Example
```d
import std.conv;
import std.exception;
import std.stdio;
import wrend.bindings;

void main(string[] args)
{
	WrenWriteFn writeFunction = function(WrenVM* vm, const(char)* text) {
		assumeWontThrow(writeln(text.to!(string)));
	};

	WrenConfiguration config;
	wrenInitConfiguration(&config);
	config.writeFn = writeFunction;

	WrenVM* vm = wrenNewVM(&config);
	scope (exit) wrenFreeVM(vm);

	WrenInterpretResult result = wrenInterpret(vm, `System.print("Hello, world!")`);
	writeln(result);
}
```

### Compiling
When using these bindings you must compile Wren and link it to your program. If 
you are using Ubuntu 64bit and compiling using dub, this should happen 
automatically.

#### Building Wren
http://munificent.github.io/wren/getting-started.html

## Supported platforms
These bindings have been developed with the latest DMD compiler. Other 
compilers have not been tested but should build fine.
