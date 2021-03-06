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

## Status

This project is not abandoned, just waiting for Wren to mature a little before
continuing.

## Usage

### Example

The simplest example of embedding and using Wren is as follows. This uses the 
default virtual machine configuration.

```d
import wrend;

void main(string[] args)
{
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
