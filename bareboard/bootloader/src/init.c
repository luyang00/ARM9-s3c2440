/*nand */
#define NFCONF *((volatile unsigned long*)0x4E000000)
#define NFCONT *((volatile unsigned long*)0x4E000004)
#define NFCMMD *((volatile unsigned char*)0x4E000008)
#define NFADDR *((volatile unsigned char*)0x4E00000c)
#define NFDATA *((volatile unsigned char*)0x4E000010)
#define NFSTAT *((volatile unsigned long*)0x4E000020)

/*UART GPIO*/
#define GPHCON              (*(volatile unsigned long *)0x56000070)
#define GPHDAT              (*(volatile unsigned long *)0x56000074)
#define GPHUP               (*(volatile unsigned long *)0x56000078)
/*UART registers*/
#define ULCON0              (*(volatile unsigned long *)0x50000000)
#define UCON0               (*(volatile unsigned long *)0x50000004)
#define UFCON0              (*(volatile unsigned long *)0x50000008)
#define UMCON0              (*(volatile unsigned long *)0x5000000c)
#define UTRSTAT0            (*(volatile unsigned long *)0x50000010)
#define UTXH0               (*(volatile unsigned char *)0x50000020)
#define URXH0               (*(volatile unsigned char *)0x50000024)
#define UBRDIV0             (*(volatile unsigned long *)0x50000028)

/*LED*/
#define GPFCON      (*(volatile unsigned long *)0x56000050)
#define GPFDAT      (*(volatile unsigned long *)0x56000054)


#define TXD0READY   (1<<2)
#define RXD0READY   (1)

#define PCLK            50000000    // init.c中的clock_init函数设置PCLK为50MHz
#define UART_CLK        PCLK        //  UART0的时钟源设为PCLK
#define UART_BAUD_RATE  115200      // 波特率
#define UART_BRD        ((UART_CLK  / (UART_BAUD_RATE * 16)) - 1)
void nand_init(void);
void nand_read(unsigned int addr,unsigned char *buf,unsigned int len);
/*
 * 初始化UART0
 * 115200,8N1,无流控
 */
void uart0_init(void)
{
    GPHCON  |= 0xa0;    // GPH2,GPH3用作TXD0,RXD0
    GPHUP   = 0x0c;     // GPH2,GPH3内部上拉

    ULCON0  = 0x03;     // 8N1(8个数据位，无较验，1个停止位)
    UCON0   = 0x05;     // 查询方式，UART时钟源为PCLK
    UFCON0  = 0x00;     // 不使用FIFO
    UMCON0  = 0x00;     // 不使用流控
    UBRDIV0 = UART_BRD; // 波特率为115200
}
/*
 * 发送一个字符
 */
void putc(unsigned char c)
{
    /* 等待，直到发送缓冲区中的数据已经全部发送出去 */
    while (!(UTRSTAT0 & TXD0READY));
    
    /* 向UTXH0寄存器中写入数据，UART即自动将它发送出去 */
    UTXH0 = c;
}
void puts(char *str)
{
	int i=0;
	while(str[i])
	{
		putc((unsigned char)str[i]);
		i++;
	}
}

void led_on()
{
    GPFCON = 0x00000100;    // 设置GPF4为输出口, 位[8:7]=0b01
    GPFDAT = 0x00000000;    // GPF4输出0，LED1点亮
}


int isBootFromNorFlash(void)
{
	volatile int *p =(volatile int *)0;
	int val;
	val = *p;
	*p = 0x12345678;
	if(*p == 0x12345678)
	{
		/* write success nand start*/
		*p=val;
		return 0;
	}
	else
	{
		/*nor can't write */
		return 1;
	}
	
		
}
void copy_code_to_sdram(unsigned char *src,unsigned char *dest,unsigned int length)
{
	int i=0;
	/*如果是NOR启动*/
	if(isBootFromNorFlash())
	{
		while(i<length)
		{
			*dest=*src;
			i++;
		}
	}
	else 
	{
		nand_read((unsigned int)src,dest,length);
	}
}
void clean_bss(void)
{
	extern int __bss_start,__bss_end;
	int *p = & __bss_start;
	for(;p<&__bss_end;p++)
		*p=0;
}

void nand_init(void)
{
	#define TACLS 	0
	#define TWRPH0  1
	#define TWRPH1 	0

	/* 设置时序 */
	NFCONF = (TACLS<<12)|(TWRPH0<<8)|(TWRPH1<<4);
	/* 使能NAND Flash控制器, 初始化ECC, 禁止片选 */
	NFCONT = (1<<4)|(1<<1)|(1<<0);	
}
void nand_cmd(unsigned char cmd)
{
	NFCMMD=cmd;
}
void nand_address(unsigned int addr)
{
	unsigned int col =addr/2048;
	unsigned int page =addr%2048;
	volatile  int i;
	NFADDR = col & 0xff;
	for(i=0;i<10;i++);
	NFADDR=(col>>8)&0xff;
	for(i=0;i<10;i++);
	NFADDR= page &0xff;
	for(i=0;i<10;i++);
	NFADDR=(page>>8)&0xff;
	for(i=0;i<10;i++);
	
}
void nand_select(void)
{
	NFCONT&=~(1<<1);
}
void nand_deselect(void)
{
	NFCONT&=~(0<<1);
}

void nand_wait_ready()
{
	while(!NFSTAT&0x01);
}
unsigned char nand_data(void)
{
	return NFDATA;
}
	
void nand_read(unsigned int addr,unsigned char *buf,unsigned int len)
{
int i=0;
while (i<len)
{
	int col=addr/2048;
	/*1.select(CE)*/
	nand_select();
	/*2.send write command*/
	nand_cmd(0x00);
	/*2.send column address*/
	nand_cmd(addr);
	/*3.send read command*/
	nand_cmd(0x30);
	/*4.wait for asynchoronous*/
	nand_wait_ready();
	/*5.read data*/		
	for(;(col<2048)&&i<(len);col++)
	{	
		buf[i]=nand_data();
		i++;
		addr++;
	}
	col=0;
	/*cancel select(CE)*/
	nand_deselect();
}
}
