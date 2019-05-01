module terminal;

import convert;

struct Terminal
{
public:
    enum COLOR : ubyte
    {
        BLACK = 0,
        BLUE = 1,
        GREEN = 2,
        CYAN = 3,
        RED = 4,
        MAGENTA = 5,
        BROWN = 6,
        LIGHT_GREY = 7,
        DARK_GREY = 8,
        LIGHT_BLUE = 9,
        LIGHT_GREEN = 10,
        LIGHT_CYAN = 11,
        LIGHT_RED = 12,
        LIGHT_MAGENTA = 13,
        LIGHT_BROWN = 14,
        WHITE = 15,
    };

    uint columns = 80;
    uint lines = 25;

    uint ypos = 0; //Starting points of the cursor
    uint xpos = 0;

    COLOR color = COLOR.WHITE;

    ubyte* vidmem = cast(ubyte*)0xFFFF_8000_000B_8000; //Video memory address

    this(int columns, int lines)
    {
        this.columns = columns;
        this.lines = lines;
        clear();
    }

    public void clear()
    {
        for (int i = 0; i < columns * lines * 2; i++) { //Loops through the screen and clears it
            *(vidmem + i) = 0;
        }
    }

    public void writeln(Args...)(Args args)
    {
        write(args, '\n');
    }

    public void write(Args...)(Args args)
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

    private void putchar(char c)
    {
        if (c == '\n')
        {
            xpos = 0;
            ypos++;
            return;
        }
        *(vidmem + (xpos + ypos * columns) * 2) = c & 0xFF; //Prints the character
        *(vidmem + (xpos + ypos * columns) * 2 + 1) = color; //Sets the colour
        xpos++;
    }

}
