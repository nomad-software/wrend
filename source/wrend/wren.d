/**
 * Wrend module.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module wrend.wren;

/**
 * Private imports.
 */
import std.conv;
import std.exception;
import std.stdio;
import wrend.bindings;
import wrend.vm;

/**
 * Factory class for creating a Wren VM.
 *
 * Using this class allows you to configure a Wren virtual machine before 
 * creating it.
 *
 * Example:
 * ---
 * import wrend;
 *
 * void main(string[] args)
 * {
 * 	auto vm = Wren.create();
 * 	vm.execute(`System.print("Hello, world!")`);
 * }
 * ---
 */
static final class Wren
{
	/**
	 * The virtual machine's configuration.
	 */
	static private WrenConfiguration _config;

	/**
	 * Constructor.
	 */
	static this()
	{
		wrenInitConfiguration(&this._config);

		this._config.writeFn = function(WrenVM* vm, const(char)* text) {
			assumeWontThrow(write(text.to!(string)));
		};

		this._config.initialHeapSize   = 1024 * 1024 * 10;
		this._config.minHeapSize       = 1024 * 1024;
		this._config.heapGrowthPercent = 50;

		this._config.reallocateFn = function(void* memory, size_t newSize) {
			import core.stdc.stdlib;
			if (newSize == 0)
			{
				free(memory);
				return null;
			}
			return realloc(memory, newSize);
		};
	}

	/**
	 * Create a Wren virtual machine.
	 *
	 * Returns:
	 *     A Wren virtual machine.
	 *
	 * Example:
	 * ---
	 * import wrend;
	 *
	 * void main(string[] args)
	 * {
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public VM create()
	{
		return new VM(this._config);
	}

	/**
	 * Configure the virtual machine's heap size in bytes.
	 *
	 * By default the initial heap size is 10Mb, the minimum heap size is 1Mb 
	 * and the heap growth percentage is 50%.
	 *
	 * Params:
	 *     initialSize = The initial heap size in bytes.
	 *     minSize = The minimum heap size in bytes.
	 *     percentGrowth = The percentage by which the heap will grow when exhausted.
	 *
	 * Example:
	 * ---
	 * import wrend;
	 *
	 * void main(string[] args)
	 * {
	 * 	Wren.setHeap(10_485_760, 1_048_576, 50);
	 *
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public void setHeap(size_t initialSize, size_t minSize, int percentGrowth) nothrow
	{
		this._config.initialHeapSize   = initialSize;
		this._config.minHeapSize       = minSize;
		this._config.heapGrowthPercent = percentGrowth;
	}

	/**
	 * Set the function which is responsible for all memory allocation in the 
	 * Wren virtual machine.
	 *
	 * Params:
	 *     func = The function that handles memory allocations.
	 *
	 * Function_Signature:
	 *     ---
	 *     extern(C) void* function(void* pointer, size_t size) nothrow
	 *     ---
	 *
	 * Allocation:
	 *     During the function call, if the pointer is null then size is the 
	 *     amount of bytes to allocate. Return a pointer to the newly allocated 
	 *     memory or null on failure.
	 *
	 * Reallocation:
	 *     During the function call, if the pointer is not null then size is 
	 *     the newly desired amount of bytes to allocate. Return the same 
	 *     pointer if it was able to grow or shrink in place, or a new one if 
	 *     not.
	 *
	 * Freeing:
	 *     If the size is zero, the pointer should be freed and null returned.
	 *
	 * Example:
	 * ---
	 * import wrend;
	 * import core.stdc.stdlib;
	 *
	 * extern(C) void* allocator(void* pointer, size_t size) nothrow
	 * {
	 * 	if (size == 0)
	 * 	{
	 * 		free(pointer);
	 * 		return null;
	 * 	}
	 * 	return realloc(pointer, size);
	 * }
	 *
	 * void main(string[] args)
	 * {
	 * 	Wren.setAllocationFunction(&allocator);
	 *
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public void setAllocationFunction(WrenReallocateFn func) nothrow
	{
		this._config.reallocateFn = func;
	}
}
