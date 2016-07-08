#define S3C2440_MPLL_200MHZ ((0x5c<<12)|(0x01<<4)|(0x02))
#define MEM_CTRL_BASE	0x48000000
.text
.global _start

_start:
	@1.close wathdog
	ldr r0,=0x53000000
	mov r1,#0
	str r1,[r0]
	@2.set systemclock
	ldr r0,=0x4c000014
	mov r1,#0x03
	str r1,[r0]
	@FCLK:HCLK:PCLK=1:2:4
	@change fast bus mode to asynchoronous mode
	mrc p15,0,r1,c1,c0,0	@read control register
	orr r1,r1,#0xc0000000	@set asynchronous mode
	mcr p15,0,r1,c1,c0,0	@write it into control register
	@set MPLL
	ldr r0,=0x4c000000
	ldr r1,=S3C2440_MPLL_200MHZ
	str	r1,[r0]
	@3.init SDRAM
	ldr r0,=MEM_CTRL_BASE
	adr r1,sdram_config
	add r3,r0,#(13*4)
1:
	ldr r2,[r1],#4
	str r2,[r0],#4
	cmp r0,r3
	bne 1b
	@4.relocation code from 4kb RAM to it linked address
	ldr sp,=0x34000000

	bl nand_init
	
	mov r0,#0
	ldr r1,=_start
	ldr r2,=__bss_start
	bl copy_code_to_sdram
	bl clean_bss
	@5.excute main function
	ldr lr,=halt
	ldr pc,=main
halt:
	b halt
	
	
	
	

sdram_config:
	.long	0x22011110		@ BWSCON
	.long	0x00000700		@ BANKCON0
	.long	0x00000700		@ BANKCON1
	.long	0x00000700		@ BANKCON2
	.long	0x00000700		@ BANKCON3	
	.long	0x00000700		@ BANKCON4
	.long	0x00000700		@ BANKCON5
	.long	0x00018005		@ BANKCON6
	.long	0x00018005		@ BANKCON7
	.long	0x008C07A3		@ REFRESH
	.long	0x000000B1		@ BANKSIZE
	.long	0x00000030		@ MRSRB6
	.long	0x00000030		@ MRSRB7
	
	
	
	
	
