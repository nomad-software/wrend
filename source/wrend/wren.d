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
 * 	Wren.initialHeapSize(1024 * 32);
 * 	Wren.minHeapSize(1024);
 * 	Wren.heapGrowthPercent(50);
 * 
 * 	auto vm = Wren.create();
 * 
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
	 * Configure the initial heap size. If not set, the virtual machine 
	 * defaults to a heap size of 10Mb.
	 *
	 * Params:
	 *     size = The initial heap size in bytes.
	 *
	 * ---
	 * import wrend;
	 *
	 * void main(string[] args)
	 * {
	 * 	Wren.initialHeapSize(10_485_760) // 10Mb
	 *
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public void initialHeapSize(size_t size)
	{
		this._config.initialHeapSize = size;
	}

	/**
	 * Configure the minimum heap size. If not set, the virtual machine 
	 * defaults to a minimum heap size of 1Mb.
	 *
	 * Params:
	 *     size = The minimum heap size in bytes.
	 *
	 * ---
	 * import wrend;
	 *
	 * void main(string[] args)
	 * {
	 * 	Wren.minHeapSize(1_048_576) // 1Mb
	 *
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public void minHeapSize(size_t size)
	{
		this._config.minHeapSize = size;
	}

	/**
	 * Configure the percentage by which the heap will grow when exhausted. If 
	 * not set, the virtual machine defaults to a growth percentage of 50%.
	 *
	 * Params:
	 *     percent = The percentage by which the heap will grow.
	 *
	 * ---
	 * import wrend;
	 *
	 * void main(string[] args)
	 * {
	 * 	Wren.heapGrowthPercent(50) // 50%
	 *
	 * 	auto vm = Wren.create();
	 * 	vm.execute(`System.print("Hello, world!")`);
	 * }
	 * ---
	 */
	static public void heapGrowthPercent(int percent)
	{
		this._config.heapGrowthPercent = percent;
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
