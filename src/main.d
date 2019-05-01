module main;

import terminal;
 
extern(C) void main(uint magic, uint addr) {

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
	terminal.writeln("    ", "Printing ubyte '0xdd': ", cast(ubyte)0xdd);
	terminal.writeln(":/");
 
	for (;;) {
	}
}
