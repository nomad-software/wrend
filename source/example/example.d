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
 * Main entry point.
 *
 * Params:
 *     args = An array of command line arguments passed to this program.
 */
void main(string[] args)
{
	Wren.initialHeapSize(1024 * 32);
	Wren.minHeapSize(1024);
	Wren.heapGrowthPercent(50);

	auto vm = Wren.create();

	vm.execute(`System.print("Hello, world!")`);
}
