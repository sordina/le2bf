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
