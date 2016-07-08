
CC      = arm-linux-gnueabihf-gcc
LD      = arm-linux-gnueabihf-ld
AR      = arm-linux-gnueabihf-ar
OBJCOPY = arm-linux-gnueabihf-objcopy
OBJDUMP = arm-linux-gnueabihf-objdump


CFLAGS 		:= -Wall -O2
CPPFLAGS   	:= -nostdinc -fno-builtin 


objs := start.o init.o boot.o

boot.bin: $(objs)
	${LD} -Tboot.lds -o boot.elf $^
	${OBJCOPY} -O binary -S boot.elf $@
	${OBJDUMP} -D -m arm boot.elf > boot.dis

%.o:%.c
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

%.o:%.S
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

clean:
	rm -f boot.bin boot.elf *.dis
	
