SECTIONS {
	. = 0x33f80000;
	.text : (*(.text))
	
	.=ALIGN(4);
	.rodata : (*(.rodata*))

	.=ALIGN(4);
	.data ALIGN(4):(*(.data))

	.=ALIGN(4);
	__bss_start = .;
	.bss ALIGN(4) : (*(.bss) *(COMMON))
	_bss_end = .;
	
}
