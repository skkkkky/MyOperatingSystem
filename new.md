page fault at 0x00001000: K/R [no page found].
swap_out: i 0, store page in vaddr 0x2000 to disk swap entry 3
swap_in: load disk swap entry 2 with swap_page in vadr 0x1000
count is 0, total is 5
check_swap() succeeded!
++ setup timer interrupts
this initproc, pid = 1, name = "init"
To U: "Hello world!!".
To U: "en.., Bye, Bye. :)"
kernel panic at kern/process/proc.c:352:
    process exit!!.

stack trackback:
ebp:0xc030cfa8 eip:0xc0100a89 args:0xc0107fe2 0xc012a044 0xc030a0c0 0xc030cfdc 
    kern/debug/kdebug.c:309: print_stackframe+21
ebp:0xc030cfc8 eip:0xc010045c args:0xc010b36d 0x00000160 0xc010b381 0xc012a044 
    kern/debug/panic.c:27: __panic+107
ebp:0xc030cfe8 eip:0xc0108566 args:0x00000000 0xc010b400 0x00000000 0x00000010 
    kern/process/proc.c:352: do_exit+28
Welcome to the kernel debug monitor!!
Type 'help' for a list of commands.
K> qemu-system-i386: terminating on signal 2

shiyt16thu@ubuntu:~/Desktop/os/os2019-skkkkky/labcodes/lab4$ make grade
Check VMM:               (1.5s)
  -check pmm:                                OK
  -check page table:                         OK
  -check vmm:                                OK
  -check swap page fault:                    OK
  -check ticks:                              OK
  -check initproc:                           OK
Total Score: 90/90

