module serial;

import io : outp;
import convert;

struct SerialDevice
{
public:
    enum COMPORT : ushort
    {
        COM1 = 0x3f8,
        COM2 = 0x2F8,
    };

    COMPORT port = COMPORT.COM1;

    private void init() {
        outp!ubyte(cast(ushort)(port + 1), cast(ubyte)0x00);    // Disable all interrupts
        outp!ubyte(cast(ushort)(port + 3), cast(ubyte)0x80);    // Enable DLAB (set baud rate divisor)
        outp!ubyte(cast(ushort)(port + 0), cast(ubyte)0x03);    // Set divisor to 3 (lo byte) 38400 baud
        outp!ubyte(cast(ushort)(port + 1), cast(ubyte)0x00);    //                  (hi byte)
        outp!ubyte(cast(ushort)(port + 3), cast(ubyte)0x03);    // 8 bits, no parity, one stop bit
        outp!ubyte(cast(ushort)(port + 2), cast(ubyte)0xC7);    // Enable FIFO, clear them, with 14-byte threshold
        outp!ubyte(cast(ushort)(port + 4), cast(ubyte)0x0B);    // IRQs enabled, RTS/DSR set
    }

    this(COMPORT port)
    {
        this.port = port;
        init();
    }

    void log(Args...)(Args args)
    {
        writeln("[LOG] ", args);
    }

    void writeln(Args...)(Args args)
    {
        write(args, '\r', '\n');
    }

    void write(Args...)(Args args)
    {
        foreach (arg; args) {
            alias T = typeof(arg);
            static if (is(T : const char[]))
            {
                putstr(arg);
            }
            else static if (is(T : char))
            {
                putchar(arg);
            }
            else static if (is(T : int))
            {
                putstr(convert.itoa(arg, 10));
            }
            else static if (is(T : ubyte))
            {
                putstr(convert.itoa(arg, 16));
            }
        }
    }

    private void putstr(string str)
    {
        foreach(c; str)
            putchar(c);
    }

    void putchar(char c)
    {
        outp(this.port, c);
    }
}

