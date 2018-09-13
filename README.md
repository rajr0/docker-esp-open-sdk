# docker-esp-open-sdk
Docker file for building a docker-image for esp-open-sdk Setup

## Build
```
git clone https://github.com/rajr0/docker-esp-open-sdk.git
docker build -t rajr/esp-open-sdk .
```

## Build Blinky
```
docker run -it --rm test/esp-open-sdk
nonroot@0582cfa711dc:~$ cd esp-open-sdk/examples/blinky/
nonroot@0582cfa711dc:~/esp-open-sdk/examples/blinky$ make
xtensa-lx106-elf-gcc -I. -mlongcalls   -c -o blinky.o blinky.c
blinky.c: In function 'user_init':
blinky.c:36:3: warning: passing argument 1 of 'ets_timer_setfn' discards 'volatile' qualifier from pointer target type [enabled by default]
...
/home/nonroot/esp-open-sdk/xtensa-lx106-elf/xtensa-lx106-elf/sysroot/usr/include/osapi.h:65:6: note: expected 'struct ETSTimer *' but argument is of type 'volatile struct ETSTimer *'
 void ets_timer_arm_new(os_timer_t *ptimer, uint32_t time, bool repeat_flag, bool ms_flag);
      ^
xtensa-lx106-elf-gcc -Teagle.app.v6.ld  blinky.o  -nostdlib -Wl,--start-group -lmain -lnet80211 -lwpa -llwip -lpp -lphy -lc -Wl,--end-group -lgcc -o blinky
esptool.py elf2image blinky
esptool.py v1.2
nonroot@0582cfa711dc:~/esp-open-sdk/examples/blinky$ ls
Makefile  blinky  blinky-0x00000.bin  blinky-0x10000.bin  blinky.c  blinky.o  user_config.h
```

