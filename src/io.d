module io;

void outp(T)(ushort port, T d) {
    uint data = d;
    static if (T.sizeof == 1)
    {
        asm {
            "outb %0, %1"
            : : "a"(data),
                "Nd"(port);
        };
    }
    else static if (T.sizeof == 4)
    {
        asm {
            "outw %0, %1"
            : : "a"(data),
                "Nd"(port);
        };
    }
    else static if (T.sizeof == 4)
    {
        asm {
            "outl %0, %1"
            : : "a"(data),
                "Nd"(port);
        };
    }
}
