/**
 * Wrend module.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module wrend.vm;

/**
 * Private imports.
 */
import std.string;
import wrend.bindings;
import wrend.exception;

/**
 * The Wren virtual machine.
 *
 * This class should not be instantiated by itself but rather created using the 
 * Wren factory class.
 */
final class VM
{
	/**
	 * The virtual machine.
	 */
	private WrenVM* _vm;

	/**
	 * The result of executing code.
	 */
	private WrenInterpretResult _result;

	/**
	 * Constructor
	 *
	 * Params:
	 *     config = The configuration used to create the VM.
	 */
	final public this(WrenConfiguration config)
	{
		this._vm = wrenNewVM(&config);
	}

	/**
	 * Execute some Wren code.
	 *
	 * Params:
	 *     code = The Wren code to execute.
	 */
	final public void execute(string code)
	{
		this._result = wrenInterpret(this._vm, code.toStringz());

		final switch(this._result)
		{
			case WrenInterpretResult.WREN_RESULT_SUCCESS:
				break;

			case WrenInterpretResult.WREN_RESULT_COMPILE_ERROR:
				throw new WrenException("Compiler error");

			case WrenInterpretResult.WREN_RESULT_RUNTIME_ERROR:
				throw new WrenException("Runtime error");
		}
	}

	/**
	 * Cleanup the virtual machine.
	 */
	~this()
	{
		wrenFreeVM(this._vm);
	}
}
