/**
 * Wrend module.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module wrend.exception;

/**
 * A general Wren exception.
 */
class WrenException : Exception
{
	/**
	 * Constructor.
	 *
	 * Params:
	 *     msg = The exception message.
	 *     file = The file where the exception occurred.
	 *     line = The line where the exception occurred.
	 *     next = The next exception to throw.
	 */
    @nogc @safe pure nothrow this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable next = null)
    {
        super(msg, file, line, next);
    }

	/**
	 * Constructor.
	 *
	 * Params:
	 *     msg = The exception message.
	 *     next = The next exception to throw.
	 *     file = The file where the exception occurred.
	 *     line = The line where the exception occurred.
	 */
    @nogc @safe pure nothrow this(string msg, Throwable next, string file = __FILE__, size_t line = __LINE__)
    {
        super(msg, file, line, next);
    }
}
