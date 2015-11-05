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
	 */
	static public void setHeap(size_t initialSize, size_t minSize, int percentGrowth)
	{
		this._config.initialHeapSize   = initialSize;
		this._config.minHeapSize       = minSize;
		this._config.heapGrowthPercent = percentGrowth;
	}

	/**
	 * Create a Wren virtual machine.
	 *
	 * Returns:
	 *     A Wren virtual machine.
	 */
	static public VM create()
	{
		return new VM(this._config);
	}
}
