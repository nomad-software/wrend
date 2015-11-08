/**
 * Main module.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module main;

/**
 * Imports.
 */
import wrend;

/**
 * Customer allocator.
 *
 * Params:
 *     pointer = A pointer that may point to existing memory.
 *     size = The size to allocate.
 */
extern(C) void* allocator(void* pointer, size_t size) nothrow
{
	import core.stdc.stdlib;
	if (size == 0)
	{
		free(pointer);
		return null;
	}
	return realloc(pointer, size);
}

/**
 * Main entry point.
 *
 * Params:
 *     args = An array of command line arguments passed to this program.
 */
void main(string[] args)
{
	Wren.setHeap(1024 * 32, 1024, 50);

	Wren.setAllocationFunction(&allocator);

	auto vm = Wren.create();

	vm.execute(`System.print("Hello, world!")`);
}
