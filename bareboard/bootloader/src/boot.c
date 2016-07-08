#include "Setup.h"
static struct tag *params;
#define MACH_TYPE_S3C2440 362 //smdk2440
void setup_start_tags()
{
	
	params = (struct tag *)0x30000100;

	params->hdr.tag = ATAG_CORE;
	params->hdr.size = tag_size (tag_core);

	params->u.core.flags = 0;
	params->u.core.pagesize = 0;
	params->u.core.rootdev = 0;

	params = tag_next (params);
}
void setup_memory_tags()
{
	params->hdr.tag = ATAG_MEM;
	params->hdr.size = tag_size (tag_mem32);

	params->u.mem.start = 0x30000000;
	params->u.mem.size =  64*1024*1024;//64M

	params = tag_next (params);
}
int strlen(char * str)
{
	int i=0;
	while(str[i])
	{
		i++;
	}
	return i;
}
void strcpy(char * dest,char * src)
{
	while((*dest++=*src++)!='\0');
}
void setup_commandline_tags(char * cmdline)
{
	int len=strlen(cmdline)+1;
	params->hdr.tag = ATAG_CMDLINE;
	params->hdr.size =(sizeof (struct tag_header) + len + 3) >> 2;

	strcpy (params->u.cmdline.cmdline, cmdline);

	params = tag_next (params);
}
void setup_end_tag()
{
	params->hdr.tag = ATAG_NONE;
	params->hdr.size = 0;
}
int main(void)
{
	void (*theKernel)(int zero,int arch,unsigned int params);
		
	/*0.bootloader should init serial port, linux kernel don't do init job*/
	uart0_init();
	/*1.read kernel from nand flash*/
	puts("copy kernel form nand...\n\r");
	nand_read(0x4a0000+64,0x30008000,0x400000);
	/*2.set bootargs*/
	puts("set boot params...\n\r");
	setup_start_tags();
	setup_memory_tags();
	setup_commandline_tags("noninitrd root=/dev/mtdblock3 init=/linuxrc console＝dev/ttySAC0");
	setup_end_tag();

	/*3.jump to run linux kernel*/
	puts("boot linux kernel...\n\r");
	theKernel = (void(*)(int,int,unsigned int))0x30008000;
	theKernel(0,MACH_TYPE_S3C2440,0x30000100);
	/*never run to here*/
	puts("error...\n\r");
	return -1;
}
