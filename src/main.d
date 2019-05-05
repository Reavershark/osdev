module main;

import terminal;
import serial;
 
extern(C) void main(uint magic, uint addr) {

    // Serial COM1
    auto serial = SerialDevice(SerialDevice.COMPORT.COM1);
    serial.log("Kernel image loaded successfully");
    serial.log("Welcome to BetterNamePendingOS!");
    serial.log("Runnings tests for convert.d");
    serial.writeln("Printing int '10': ", 10);
    serial.writeln("Printing int '15': ", 15);
    serial.writeln("Printing int '124': ", 124);
    serial.writeln("Printing int '-1333': ", -1333);

    // VGA terminal
    auto terminal = Terminal(80, 25);

    terminal.color = terminal.COLOR.GREEN;
    terminal.writeln("Terminal initialized");
    terminal.writeln("Kernel image loaded successfully");

    terminal.color = terminal.COLOR.WHITE;
    terminal.writeln();
    terminal.writeln("Welcome to BetterNamePendingOS!");
    terminal.writeln();
    terminal.writeln("Running tests on all availiable modules:");
    terminal.writeln();
    terminal.writeln("convert.d");
    terminal.writeln("    ", "Printing int '10': ", 10);
    terminal.writeln("    ", "Printing int '15': ", 15);
    terminal.writeln("    ", "Printing int '124': ", 124);
    terminal.writeln("    ", "Printing int '-1333': ", -1333);
    terminal.writeln();
    terminal.writeln(":/");

    for (;;) {
    }
}
