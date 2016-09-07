# le2bf

Converts line-ending pairs to brainfuck code.

Rules:

	Unix +  Unix = '>'
	Unix +  DOS  = '<'
	Unix +  Mac  = '+'
	DOS  +  Unix = '-'
	DOS  +  DOS  = '.'
	DOS  +  Mac  = ','
	Mac  +  Unix = '['
	Mac  +  DOS  = ']'

Usage:

	$ le2bf --help
	Usage: le2bf [--reverse]

	Available options:
		-h,--help                Show this help text

Roundtrip:

	$ le2bf --reverse < test/programs/hello.bf | le2bf | bf
	Hello World!
