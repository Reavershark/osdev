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
    else static if (T.sizeof == 2)
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

T inp(T)(ushort port) {
    T ret;
    static if (T.sizeof == 1)
    {
        asm {
            "inb %1, %0"
            : "=a"(ret)
            : "Nd"(port);
        };
    }
    else static if (T.sizeof == 2)
    {
        asm {
            "inw %1, %0"
            : "=a"(ret)
            : "Nd"(port);
        };
    }
    else static if (T.sizeof == 4)
    {
        asm {
            "inl %1, %0"
            : "=a"(ret)
            : "Nd"(port);
        };
    }
    return ret;
}

void ioWait()
{
    asm {
        "jmp 1f\n\t"
        "1:jmp 2f\n\t"
        "2:";
    }
}
