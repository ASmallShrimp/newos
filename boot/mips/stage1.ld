OUTPUT_FORMAT("elf32-bigmips", "elf32-bigmips", "elf32-bigmips")
OUTPUT_ARCH(mips)

/*
PHDRS 
{
	reginfo 0x70000000;
	text PT_LOAD;
}
*/

ENTRY(_start)
SECTIONS
{

	. = 0x88002000;

	/* text/read-only data */
	.text :	{ *(.text .gnu.linkonce.t.*) }

	__ctor_list = .;
	.ctors : { *(.ctors) }
	__ctor_end = .;

	.rodata :
	{ 
		*(.rodata)
		. = ALIGN(0x1000);
	} =0x9000

	/* writable data  */
	__data_start = .;
	.data : { *(.data .gnu.linkonce.d.*) }

	/* unintialized data (in same segment as writable data) */
	__bss_start = .;
	.bss : { *(.bss) }

	. = ALIGN(0x1000); 
	_end = . ;

	/* Strip unnecessary stuff */
	/DISCARD/ : { *(.reginfo .comment .note .eh_frame .dtors) }
}
