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

		$ le2bf-exe --help
		Usage: le2bf-exe [--reverse]

		Available options:
			-h,--help                Show this help text

