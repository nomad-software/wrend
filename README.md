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
import wrend;

void main(string[] args)
{
	Wren.setHeap(1024 * 32, 1024, 50);

	auto vm = Wren.create();

	vm.execute(`System.print("Hello, world!")`);
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
