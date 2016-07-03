cmd_libbb/perror_nomsg.o := arm-linux-gnueabihf-gcc -Wp,-MD,libbb/.perror_nomsg.o.d   -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BB_VER=KBUILD_STR(1.24.1)" -DBB_BT=AUTOCONF_TIMESTAMP  -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strlen -finline-limit=0 -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os     -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(perror_nomsg)"  -D"KBUILD_MODNAME=KBUILD_STR(perror_nomsg)" -c -o libbb/perror_nomsg.o libbb/perror_nomsg.c

deps_libbb/perror_nomsg.o := \
  libbb/perror_nomsg.c \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/stdc-predef.h \
  include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /usr/local/linaro/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.8.3/include-fixed/limits.h \
  /usr/local/linaro/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.8.3/include-fixed/syslimits.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/limits.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/features.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/sys/cdefs.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/wordsize.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/gnu/stubs.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/gnu/stubs-hard.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/posix1_lim.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/local_lim.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/linux/limits.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/posix2_lim.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/xopen_lim.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/stdio_lim.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/byteswap.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/byteswap.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/types.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/typesizes.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/byteswap-16.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/endian.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/endian.h \
  /usr/local/linaro/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.8.3/include/stdint.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/stdint.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/wchar.h \
  /usr/local/linaro/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.8.3/include/stdbool.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/unistd.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/posix_opt.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/environments.h \
  /usr/local/linaro/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/4.8.3/include/stddef.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/bits/confname.h \
  /usr/local/linaro/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include/getopt.h \

libbb/perror_nomsg.o: $(deps_libbb/perror_nomsg.o)

$(deps_libbb/perror_nomsg.o):
