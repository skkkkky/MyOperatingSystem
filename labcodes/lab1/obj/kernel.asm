
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 14             	sub    $0x14,%esp
  100007:	e8 aa 02 00 00       	call   1002b6 <__x86.get_pc_thunk.bx>
  10000c:	81 c3 44 e9 00 00    	add    $0xe944,%ebx
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100012:	c7 c0 c0 fd 10 00    	mov    $0x10fdc0,%eax
  100018:	89 c2                	mov    %eax,%edx
  10001a:	c7 c0 50 e9 10 00    	mov    $0x10e950,%eax
  100020:	29 c2                	sub    %eax,%edx
  100022:	89 d0                	mov    %edx,%eax
  100024:	83 ec 04             	sub    $0x4,%esp
  100027:	50                   	push   %eax
  100028:	6a 00                	push   $0x0
  10002a:	c7 c0 50 e9 10 00    	mov    $0x10e950,%eax
  100030:	50                   	push   %eax
  100031:	e8 35 31 00 00       	call   10316b <memset>
  100036:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100039:	e8 3f 18 00 00       	call   10187d <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10003e:	8d 83 48 50 ff ff    	lea    -0xafb8(%ebx),%eax
  100044:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100047:	83 ec 08             	sub    $0x8,%esp
  10004a:	ff 75 f4             	pushl  -0xc(%ebp)
  10004d:	8d 83 64 50 ff ff    	lea    -0xaf9c(%ebx),%eax
  100053:	50                   	push   %eax
  100054:	e8 d0 02 00 00       	call   100329 <cprintf>
  100059:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  10005c:	e8 07 0a 00 00       	call   100a68 <print_kerninfo>

    grade_backtrace();
  100061:	e8 ce 00 00 00       	call   100134 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100066:	e8 60 2d 00 00       	call   102dcb <pmm_init>

    pic_init();                 // init interrupt controller
  10006b:	e8 9c 19 00 00       	call   101a0c <pic_init>
    idt_init();                 // init interrupt descriptor table
  100070:	e8 2e 1b 00 00       	call   101ba3 <idt_init>
    cprintf("1");
  100075:	83 ec 0c             	sub    $0xc,%esp
  100078:	8d 83 69 50 ff ff    	lea    -0xaf97(%ebx),%eax
  10007e:	50                   	push   %eax
  10007f:	e8 a5 02 00 00       	call   100329 <cprintf>
  100084:	83 c4 10             	add    $0x10,%esp
    clock_init();   
  100087:	e8 ed 0e 00 00       	call   100f79 <clock_init>
    cprintf("2");            // init clock interrupt
  10008c:	83 ec 0c             	sub    $0xc,%esp
  10008f:	8d 83 6b 50 ff ff    	lea    -0xaf95(%ebx),%eax
  100095:	50                   	push   %eax
  100096:	e8 8e 02 00 00       	call   100329 <cprintf>
  10009b:	83 c4 10             	add    $0x10,%esp
    intr_enable();
  10009e:	e8 b1 1a 00 00       	call   101b54 <intr_enable>
    cprintf("3");              // enable irq interrupt
  1000a3:	83 ec 0c             	sub    $0xc,%esp
  1000a6:	8d 83 6d 50 ff ff    	lea    -0xaf93(%ebx),%eax
  1000ac:	50                   	push   %eax
  1000ad:	e8 77 02 00 00       	call   100329 <cprintf>
  1000b2:	83 c4 10             	add    $0x10,%esp
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  1000b5:	eb fe                	jmp    1000b5 <kern_init+0xb5>

001000b7 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  1000b7:	55                   	push   %ebp
  1000b8:	89 e5                	mov    %esp,%ebp
  1000ba:	53                   	push   %ebx
  1000bb:	83 ec 04             	sub    $0x4,%esp
  1000be:	e8 ef 01 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  1000c3:	05 8d e8 00 00       	add    $0xe88d,%eax
    mon_backtrace(0, NULL, NULL);
  1000c8:	83 ec 04             	sub    $0x4,%esp
  1000cb:	6a 00                	push   $0x0
  1000cd:	6a 00                	push   $0x0
  1000cf:	6a 00                	push   $0x0
  1000d1:	89 c3                	mov    %eax,%ebx
  1000d3:	e8 7e 0e 00 00       	call   100f56 <mon_backtrace>
  1000d8:	83 c4 10             	add    $0x10,%esp
}
  1000db:	90                   	nop
  1000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000df:	c9                   	leave  
  1000e0:	c3                   	ret    

001000e1 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000e1:	55                   	push   %ebp
  1000e2:	89 e5                	mov    %esp,%ebp
  1000e4:	53                   	push   %ebx
  1000e5:	83 ec 04             	sub    $0x4,%esp
  1000e8:	e8 c5 01 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  1000ed:	05 63 e8 00 00       	add    $0xe863,%eax
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000f2:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000f8:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1000fe:	51                   	push   %ecx
  1000ff:	52                   	push   %edx
  100100:	53                   	push   %ebx
  100101:	50                   	push   %eax
  100102:	e8 b0 ff ff ff       	call   1000b7 <grade_backtrace2>
  100107:	83 c4 10             	add    $0x10,%esp
}
  10010a:	90                   	nop
  10010b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10010e:	c9                   	leave  
  10010f:	c3                   	ret    

00100110 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  100110:	55                   	push   %ebp
  100111:	89 e5                	mov    %esp,%ebp
  100113:	83 ec 08             	sub    $0x8,%esp
  100116:	e8 97 01 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  10011b:	05 35 e8 00 00       	add    $0xe835,%eax
    grade_backtrace1(arg0, arg2);
  100120:	83 ec 08             	sub    $0x8,%esp
  100123:	ff 75 10             	pushl  0x10(%ebp)
  100126:	ff 75 08             	pushl  0x8(%ebp)
  100129:	e8 b3 ff ff ff       	call   1000e1 <grade_backtrace1>
  10012e:	83 c4 10             	add    $0x10,%esp
}
  100131:	90                   	nop
  100132:	c9                   	leave  
  100133:	c3                   	ret    

00100134 <grade_backtrace>:

void
grade_backtrace(void) {
  100134:	55                   	push   %ebp
  100135:	89 e5                	mov    %esp,%ebp
  100137:	83 ec 08             	sub    $0x8,%esp
  10013a:	e8 73 01 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  10013f:	05 11 e8 00 00       	add    $0xe811,%eax
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  100144:	8d 80 b0 16 ff ff    	lea    -0xe950(%eax),%eax
  10014a:	83 ec 04             	sub    $0x4,%esp
  10014d:	68 00 00 ff ff       	push   $0xffff0000
  100152:	50                   	push   %eax
  100153:	6a 00                	push   $0x0
  100155:	e8 b6 ff ff ff       	call   100110 <grade_backtrace0>
  10015a:	83 c4 10             	add    $0x10,%esp
}
  10015d:	90                   	nop
  10015e:	c9                   	leave  
  10015f:	c3                   	ret    

00100160 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100160:	55                   	push   %ebp
  100161:	89 e5                	mov    %esp,%ebp
  100163:	53                   	push   %ebx
  100164:	83 ec 14             	sub    $0x14,%esp
  100167:	e8 4a 01 00 00       	call   1002b6 <__x86.get_pc_thunk.bx>
  10016c:	81 c3 e4 e7 00 00    	add    $0xe7e4,%ebx
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100172:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100175:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100178:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10017b:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10017e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100182:	0f b7 c0             	movzwl %ax,%eax
  100185:	83 e0 03             	and    $0x3,%eax
  100188:	89 c2                	mov    %eax,%edx
  10018a:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100190:	83 ec 04             	sub    $0x4,%esp
  100193:	52                   	push   %edx
  100194:	50                   	push   %eax
  100195:	8d 83 6f 50 ff ff    	lea    -0xaf91(%ebx),%eax
  10019b:	50                   	push   %eax
  10019c:	e8 88 01 00 00       	call   100329 <cprintf>
  1001a1:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  1001a4:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1001a8:	0f b7 d0             	movzwl %ax,%edx
  1001ab:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001b1:	83 ec 04             	sub    $0x4,%esp
  1001b4:	52                   	push   %edx
  1001b5:	50                   	push   %eax
  1001b6:	8d 83 7d 50 ff ff    	lea    -0xaf83(%ebx),%eax
  1001bc:	50                   	push   %eax
  1001bd:	e8 67 01 00 00       	call   100329 <cprintf>
  1001c2:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  1001c5:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  1001c9:	0f b7 d0             	movzwl %ax,%edx
  1001cc:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001d2:	83 ec 04             	sub    $0x4,%esp
  1001d5:	52                   	push   %edx
  1001d6:	50                   	push   %eax
  1001d7:	8d 83 8b 50 ff ff    	lea    -0xaf75(%ebx),%eax
  1001dd:	50                   	push   %eax
  1001de:	e8 46 01 00 00       	call   100329 <cprintf>
  1001e3:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  1001e6:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001ea:	0f b7 d0             	movzwl %ax,%edx
  1001ed:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001f3:	83 ec 04             	sub    $0x4,%esp
  1001f6:	52                   	push   %edx
  1001f7:	50                   	push   %eax
  1001f8:	8d 83 99 50 ff ff    	lea    -0xaf67(%ebx),%eax
  1001fe:	50                   	push   %eax
  1001ff:	e8 25 01 00 00       	call   100329 <cprintf>
  100204:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  100207:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10020b:	0f b7 d0             	movzwl %ax,%edx
  10020e:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100214:	83 ec 04             	sub    $0x4,%esp
  100217:	52                   	push   %edx
  100218:	50                   	push   %eax
  100219:	8d 83 a7 50 ff ff    	lea    -0xaf59(%ebx),%eax
  10021f:	50                   	push   %eax
  100220:	e8 04 01 00 00       	call   100329 <cprintf>
  100225:	83 c4 10             	add    $0x10,%esp
    round ++;
  100228:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  10022e:	83 c0 01             	add    $0x1,%eax
  100231:	89 83 70 01 00 00    	mov    %eax,0x170(%ebx)
}
  100237:	90                   	nop
  100238:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10023b:	c9                   	leave  
  10023c:	c3                   	ret    

0010023d <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  10023d:	55                   	push   %ebp
  10023e:	89 e5                	mov    %esp,%ebp
  100240:	e8 6d 00 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  100245:	05 0b e7 00 00       	add    $0xe70b,%eax
    //LAB1 CHALLENGE 1 : TODO
}
  10024a:	90                   	nop
  10024b:	5d                   	pop    %ebp
  10024c:	c3                   	ret    

0010024d <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  10024d:	55                   	push   %ebp
  10024e:	89 e5                	mov    %esp,%ebp
  100250:	e8 5d 00 00 00       	call   1002b2 <__x86.get_pc_thunk.ax>
  100255:	05 fb e6 00 00       	add    $0xe6fb,%eax
    //LAB1 CHALLENGE 1 :  TODO
}
  10025a:	90                   	nop
  10025b:	5d                   	pop    %ebp
  10025c:	c3                   	ret    

0010025d <lab1_switch_test>:

static void
lab1_switch_test(void) {
  10025d:	55                   	push   %ebp
  10025e:	89 e5                	mov    %esp,%ebp
  100260:	53                   	push   %ebx
  100261:	83 ec 04             	sub    $0x4,%esp
  100264:	e8 4d 00 00 00       	call   1002b6 <__x86.get_pc_thunk.bx>
  100269:	81 c3 e7 e6 00 00    	add    $0xe6e7,%ebx
    lab1_print_cur_status();
  10026f:	e8 ec fe ff ff       	call   100160 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100274:	83 ec 0c             	sub    $0xc,%esp
  100277:	8d 83 b8 50 ff ff    	lea    -0xaf48(%ebx),%eax
  10027d:	50                   	push   %eax
  10027e:	e8 a6 00 00 00       	call   100329 <cprintf>
  100283:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100286:	e8 b2 ff ff ff       	call   10023d <lab1_switch_to_user>
    lab1_print_cur_status();
  10028b:	e8 d0 fe ff ff       	call   100160 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100290:	83 ec 0c             	sub    $0xc,%esp
  100293:	8d 83 d8 50 ff ff    	lea    -0xaf28(%ebx),%eax
  100299:	50                   	push   %eax
  10029a:	e8 8a 00 00 00       	call   100329 <cprintf>
  10029f:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  1002a2:	e8 a6 ff ff ff       	call   10024d <lab1_switch_to_kernel>
    lab1_print_cur_status();
  1002a7:	e8 b4 fe ff ff       	call   100160 <lab1_print_cur_status>
}
  1002ac:	90                   	nop
  1002ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002b0:	c9                   	leave  
  1002b1:	c3                   	ret    

001002b2 <__x86.get_pc_thunk.ax>:
  1002b2:	8b 04 24             	mov    (%esp),%eax
  1002b5:	c3                   	ret    

001002b6 <__x86.get_pc_thunk.bx>:
  1002b6:	8b 1c 24             	mov    (%esp),%ebx
  1002b9:	c3                   	ret    

001002ba <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002ba:	55                   	push   %ebp
  1002bb:	89 e5                	mov    %esp,%ebp
  1002bd:	53                   	push   %ebx
  1002be:	83 ec 04             	sub    $0x4,%esp
  1002c1:	e8 ec ff ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1002c6:	05 8a e6 00 00       	add    $0xe68a,%eax
    cons_putc(c);
  1002cb:	83 ec 0c             	sub    $0xc,%esp
  1002ce:	ff 75 08             	pushl  0x8(%ebp)
  1002d1:	89 c3                	mov    %eax,%ebx
  1002d3:	e8 e8 15 00 00       	call   1018c0 <cons_putc>
  1002d8:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  1002db:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002de:	8b 00                	mov    (%eax),%eax
  1002e0:	8d 50 01             	lea    0x1(%eax),%edx
  1002e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002e6:	89 10                	mov    %edx,(%eax)
}
  1002e8:	90                   	nop
  1002e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002ec:	c9                   	leave  
  1002ed:	c3                   	ret    

001002ee <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002ee:	55                   	push   %ebp
  1002ef:	89 e5                	mov    %esp,%ebp
  1002f1:	53                   	push   %ebx
  1002f2:	83 ec 14             	sub    $0x14,%esp
  1002f5:	e8 b8 ff ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1002fa:	05 56 e6 00 00       	add    $0xe656,%eax
    int cnt = 0;
  1002ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100306:	ff 75 0c             	pushl  0xc(%ebp)
  100309:	ff 75 08             	pushl  0x8(%ebp)
  10030c:	8d 55 f4             	lea    -0xc(%ebp),%edx
  10030f:	52                   	push   %edx
  100310:	8d 90 6a 19 ff ff    	lea    -0xe696(%eax),%edx
  100316:	52                   	push   %edx
  100317:	89 c3                	mov    %eax,%ebx
  100319:	e8 db 31 00 00       	call   1034f9 <vprintfmt>
  10031e:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100321:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100324:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100327:	c9                   	leave  
  100328:	c3                   	ret    

00100329 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100329:	55                   	push   %ebp
  10032a:	89 e5                	mov    %esp,%ebp
  10032c:	83 ec 18             	sub    $0x18,%esp
  10032f:	e8 7e ff ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  100334:	05 1c e6 00 00       	add    $0xe61c,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100339:	8d 45 0c             	lea    0xc(%ebp),%eax
  10033c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10033f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100342:	83 ec 08             	sub    $0x8,%esp
  100345:	50                   	push   %eax
  100346:	ff 75 08             	pushl  0x8(%ebp)
  100349:	e8 a0 ff ff ff       	call   1002ee <vcprintf>
  10034e:	83 c4 10             	add    $0x10,%esp
  100351:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100354:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100357:	c9                   	leave  
  100358:	c3                   	ret    

00100359 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100359:	55                   	push   %ebp
  10035a:	89 e5                	mov    %esp,%ebp
  10035c:	53                   	push   %ebx
  10035d:	83 ec 04             	sub    $0x4,%esp
  100360:	e8 4d ff ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  100365:	05 eb e5 00 00       	add    $0xe5eb,%eax
    cons_putc(c);
  10036a:	83 ec 0c             	sub    $0xc,%esp
  10036d:	ff 75 08             	pushl  0x8(%ebp)
  100370:	89 c3                	mov    %eax,%ebx
  100372:	e8 49 15 00 00       	call   1018c0 <cons_putc>
  100377:	83 c4 10             	add    $0x10,%esp
}
  10037a:	90                   	nop
  10037b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10037e:	c9                   	leave  
  10037f:	c3                   	ret    

00100380 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  100380:	55                   	push   %ebp
  100381:	89 e5                	mov    %esp,%ebp
  100383:	83 ec 18             	sub    $0x18,%esp
  100386:	e8 27 ff ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  10038b:	05 c5 e5 00 00       	add    $0xe5c5,%eax
    int cnt = 0;
  100390:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100397:	eb 14                	jmp    1003ad <cputs+0x2d>
        cputch(c, &cnt);
  100399:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10039d:	83 ec 08             	sub    $0x8,%esp
  1003a0:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1003a3:	52                   	push   %edx
  1003a4:	50                   	push   %eax
  1003a5:	e8 10 ff ff ff       	call   1002ba <cputch>
  1003aa:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1003ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1003b0:	8d 50 01             	lea    0x1(%eax),%edx
  1003b3:	89 55 08             	mov    %edx,0x8(%ebp)
  1003b6:	0f b6 00             	movzbl (%eax),%eax
  1003b9:	88 45 f7             	mov    %al,-0x9(%ebp)
  1003bc:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1003c0:	75 d7                	jne    100399 <cputs+0x19>
    }
    cputch('\n', &cnt);
  1003c2:	83 ec 08             	sub    $0x8,%esp
  1003c5:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1003c8:	50                   	push   %eax
  1003c9:	6a 0a                	push   $0xa
  1003cb:	e8 ea fe ff ff       	call   1002ba <cputch>
  1003d0:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1003d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003d6:	c9                   	leave  
  1003d7:	c3                   	ret    

001003d8 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003d8:	55                   	push   %ebp
  1003d9:	89 e5                	mov    %esp,%ebp
  1003db:	53                   	push   %ebx
  1003dc:	83 ec 14             	sub    $0x14,%esp
  1003df:	e8 d2 fe ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  1003e4:	81 c3 6c e5 00 00    	add    $0xe56c,%ebx
    int c;
    while ((c = cons_getc()) == 0)
  1003ea:	e8 0b 15 00 00       	call   1018fa <cons_getc>
  1003ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003f6:	74 f2                	je     1003ea <getchar+0x12>
        /* do nothing */;
    return c;
  1003f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003fb:	83 c4 14             	add    $0x14,%esp
  1003fe:	5b                   	pop    %ebx
  1003ff:	5d                   	pop    %ebp
  100400:	c3                   	ret    

00100401 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100401:	55                   	push   %ebp
  100402:	89 e5                	mov    %esp,%ebp
  100404:	53                   	push   %ebx
  100405:	83 ec 14             	sub    $0x14,%esp
  100408:	e8 a9 fe ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  10040d:	81 c3 43 e5 00 00    	add    $0xe543,%ebx
    if (prompt != NULL) {
  100413:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100417:	74 15                	je     10042e <readline+0x2d>
        cprintf("%s", prompt);
  100419:	83 ec 08             	sub    $0x8,%esp
  10041c:	ff 75 08             	pushl  0x8(%ebp)
  10041f:	8d 83 f7 50 ff ff    	lea    -0xaf09(%ebx),%eax
  100425:	50                   	push   %eax
  100426:	e8 fe fe ff ff       	call   100329 <cprintf>
  10042b:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  10042e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100435:	e8 9e ff ff ff       	call   1003d8 <getchar>
  10043a:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10043d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100441:	79 0a                	jns    10044d <readline+0x4c>
            return NULL;
  100443:	b8 00 00 00 00       	mov    $0x0,%eax
  100448:	e9 87 00 00 00       	jmp    1004d4 <readline+0xd3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10044d:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100451:	7e 2c                	jle    10047f <readline+0x7e>
  100453:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10045a:	7f 23                	jg     10047f <readline+0x7e>
            cputchar(c);
  10045c:	83 ec 0c             	sub    $0xc,%esp
  10045f:	ff 75 f0             	pushl  -0x10(%ebp)
  100462:	e8 f2 fe ff ff       	call   100359 <cputchar>
  100467:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  10046a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10046d:	8d 50 01             	lea    0x1(%eax),%edx
  100470:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100473:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100476:	88 94 03 90 01 00 00 	mov    %dl,0x190(%ebx,%eax,1)
  10047d:	eb 50                	jmp    1004cf <readline+0xce>
        }
        else if (c == '\b' && i > 0) {
  10047f:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100483:	75 1a                	jne    10049f <readline+0x9e>
  100485:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100489:	7e 14                	jle    10049f <readline+0x9e>
            cputchar(c);
  10048b:	83 ec 0c             	sub    $0xc,%esp
  10048e:	ff 75 f0             	pushl  -0x10(%ebp)
  100491:	e8 c3 fe ff ff       	call   100359 <cputchar>
  100496:	83 c4 10             	add    $0x10,%esp
            i --;
  100499:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10049d:	eb 30                	jmp    1004cf <readline+0xce>
        }
        else if (c == '\n' || c == '\r') {
  10049f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1004a3:	74 06                	je     1004ab <readline+0xaa>
  1004a5:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1004a9:	75 8a                	jne    100435 <readline+0x34>
            cputchar(c);
  1004ab:	83 ec 0c             	sub    $0xc,%esp
  1004ae:	ff 75 f0             	pushl  -0x10(%ebp)
  1004b1:	e8 a3 fe ff ff       	call   100359 <cputchar>
  1004b6:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  1004b9:	8d 93 90 01 00 00    	lea    0x190(%ebx),%edx
  1004bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004c2:	01 d0                	add    %edx,%eax
  1004c4:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1004c7:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
  1004cd:	eb 05                	jmp    1004d4 <readline+0xd3>
        c = getchar();
  1004cf:	e9 61 ff ff ff       	jmp    100435 <readline+0x34>
        }
    }
}
  1004d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1004d7:	c9                   	leave  
  1004d8:	c3                   	ret    

001004d9 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1004d9:	55                   	push   %ebp
  1004da:	89 e5                	mov    %esp,%ebp
  1004dc:	53                   	push   %ebx
  1004dd:	83 ec 14             	sub    $0x14,%esp
  1004e0:	e8 d1 fd ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  1004e5:	81 c3 6b e4 00 00    	add    $0xe46b,%ebx
    if (is_panic) {
  1004eb:	8b 83 90 05 00 00    	mov    0x590(%ebx),%eax
  1004f1:	85 c0                	test   %eax,%eax
  1004f3:	75 65                	jne    10055a <__panic+0x81>
        goto panic_dead;
    }
    is_panic = 1;
  1004f5:	c7 83 90 05 00 00 01 	movl   $0x1,0x590(%ebx)
  1004fc:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1004ff:	8d 45 14             	lea    0x14(%ebp),%eax
  100502:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100505:	83 ec 04             	sub    $0x4,%esp
  100508:	ff 75 0c             	pushl  0xc(%ebp)
  10050b:	ff 75 08             	pushl  0x8(%ebp)
  10050e:	8d 83 fa 50 ff ff    	lea    -0xaf06(%ebx),%eax
  100514:	50                   	push   %eax
  100515:	e8 0f fe ff ff       	call   100329 <cprintf>
  10051a:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  10051d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100520:	83 ec 08             	sub    $0x8,%esp
  100523:	50                   	push   %eax
  100524:	ff 75 10             	pushl  0x10(%ebp)
  100527:	e8 c2 fd ff ff       	call   1002ee <vcprintf>
  10052c:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10052f:	83 ec 0c             	sub    $0xc,%esp
  100532:	8d 83 16 51 ff ff    	lea    -0xaeea(%ebx),%eax
  100538:	50                   	push   %eax
  100539:	e8 eb fd ff ff       	call   100329 <cprintf>
  10053e:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
  100541:	83 ec 0c             	sub    $0xc,%esp
  100544:	8d 83 18 51 ff ff    	lea    -0xaee8(%ebx),%eax
  10054a:	50                   	push   %eax
  10054b:	e8 d9 fd ff ff       	call   100329 <cprintf>
  100550:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
  100553:	e8 9f 06 00 00       	call   100bf7 <print_stackframe>
  100558:	eb 01                	jmp    10055b <__panic+0x82>
        goto panic_dead;
  10055a:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  10055b:	e8 05 16 00 00       	call   101b65 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100560:	83 ec 0c             	sub    $0xc,%esp
  100563:	6a 00                	push   $0x0
  100565:	e8 d2 08 00 00       	call   100e3c <kmonitor>
  10056a:	83 c4 10             	add    $0x10,%esp
  10056d:	eb f1                	jmp    100560 <__panic+0x87>

0010056f <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  10056f:	55                   	push   %ebp
  100570:	89 e5                	mov    %esp,%ebp
  100572:	53                   	push   %ebx
  100573:	83 ec 14             	sub    $0x14,%esp
  100576:	e8 3b fd ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  10057b:	81 c3 d5 e3 00 00    	add    $0xe3d5,%ebx
    va_list ap;
    va_start(ap, fmt);
  100581:	8d 45 14             	lea    0x14(%ebp),%eax
  100584:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100587:	83 ec 04             	sub    $0x4,%esp
  10058a:	ff 75 0c             	pushl  0xc(%ebp)
  10058d:	ff 75 08             	pushl  0x8(%ebp)
  100590:	8d 83 2a 51 ff ff    	lea    -0xaed6(%ebx),%eax
  100596:	50                   	push   %eax
  100597:	e8 8d fd ff ff       	call   100329 <cprintf>
  10059c:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  10059f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005a2:	83 ec 08             	sub    $0x8,%esp
  1005a5:	50                   	push   %eax
  1005a6:	ff 75 10             	pushl  0x10(%ebp)
  1005a9:	e8 40 fd ff ff       	call   1002ee <vcprintf>
  1005ae:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1005b1:	83 ec 0c             	sub    $0xc,%esp
  1005b4:	8d 83 16 51 ff ff    	lea    -0xaeea(%ebx),%eax
  1005ba:	50                   	push   %eax
  1005bb:	e8 69 fd ff ff       	call   100329 <cprintf>
  1005c0:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1005c3:	90                   	nop
  1005c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1005c7:	c9                   	leave  
  1005c8:	c3                   	ret    

001005c9 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1005c9:	55                   	push   %ebp
  1005ca:	89 e5                	mov    %esp,%ebp
  1005cc:	e8 e1 fc ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1005d1:	05 7f e3 00 00       	add    $0xe37f,%eax
    return is_panic;
  1005d6:	8b 80 90 05 00 00    	mov    0x590(%eax),%eax
}
  1005dc:	5d                   	pop    %ebp
  1005dd:	c3                   	ret    

001005de <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1005de:	55                   	push   %ebp
  1005df:	89 e5                	mov    %esp,%ebp
  1005e1:	83 ec 20             	sub    $0x20,%esp
  1005e4:	e8 c9 fc ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1005e9:	05 67 e3 00 00       	add    $0xe367,%eax
    int l = *region_left, r = *region_right, any_matches = 0;
  1005ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f1:	8b 00                	mov    (%eax),%eax
  1005f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005f6:	8b 45 10             	mov    0x10(%ebp),%eax
  1005f9:	8b 00                	mov    (%eax),%eax
  1005fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  100605:	e9 d2 00 00 00       	jmp    1006dc <stab_binsearch+0xfe>
        int true_m = (l + r) / 2, m = true_m;
  10060a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10060d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100610:	01 d0                	add    %edx,%eax
  100612:	89 c2                	mov    %eax,%edx
  100614:	c1 ea 1f             	shr    $0x1f,%edx
  100617:	01 d0                	add    %edx,%eax
  100619:	d1 f8                	sar    %eax
  10061b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10061e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100621:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100624:	eb 04                	jmp    10062a <stab_binsearch+0x4c>
            m --;
  100626:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  10062a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10062d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100630:	7c 1f                	jl     100651 <stab_binsearch+0x73>
  100632:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100635:	89 d0                	mov    %edx,%eax
  100637:	01 c0                	add    %eax,%eax
  100639:	01 d0                	add    %edx,%eax
  10063b:	c1 e0 02             	shl    $0x2,%eax
  10063e:	89 c2                	mov    %eax,%edx
  100640:	8b 45 08             	mov    0x8(%ebp),%eax
  100643:	01 d0                	add    %edx,%eax
  100645:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100649:	0f b6 c0             	movzbl %al,%eax
  10064c:	39 45 14             	cmp    %eax,0x14(%ebp)
  10064f:	75 d5                	jne    100626 <stab_binsearch+0x48>
        }
        if (m < l) {    // no match in [l, m]
  100651:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100654:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100657:	7d 0b                	jge    100664 <stab_binsearch+0x86>
            l = true_m + 1;
  100659:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10065c:	83 c0 01             	add    $0x1,%eax
  10065f:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100662:	eb 78                	jmp    1006dc <stab_binsearch+0xfe>
        }

        // actual binary search
        any_matches = 1;
  100664:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10066b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10066e:	89 d0                	mov    %edx,%eax
  100670:	01 c0                	add    %eax,%eax
  100672:	01 d0                	add    %edx,%eax
  100674:	c1 e0 02             	shl    $0x2,%eax
  100677:	89 c2                	mov    %eax,%edx
  100679:	8b 45 08             	mov    0x8(%ebp),%eax
  10067c:	01 d0                	add    %edx,%eax
  10067e:	8b 40 08             	mov    0x8(%eax),%eax
  100681:	39 45 18             	cmp    %eax,0x18(%ebp)
  100684:	76 13                	jbe    100699 <stab_binsearch+0xbb>
            *region_left = m;
  100686:	8b 45 0c             	mov    0xc(%ebp),%eax
  100689:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10068c:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10068e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100691:	83 c0 01             	add    $0x1,%eax
  100694:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100697:	eb 43                	jmp    1006dc <stab_binsearch+0xfe>
        } else if (stabs[m].n_value > addr) {
  100699:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10069c:	89 d0                	mov    %edx,%eax
  10069e:	01 c0                	add    %eax,%eax
  1006a0:	01 d0                	add    %edx,%eax
  1006a2:	c1 e0 02             	shl    $0x2,%eax
  1006a5:	89 c2                	mov    %eax,%edx
  1006a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1006aa:	01 d0                	add    %edx,%eax
  1006ac:	8b 40 08             	mov    0x8(%eax),%eax
  1006af:	39 45 18             	cmp    %eax,0x18(%ebp)
  1006b2:	73 16                	jae    1006ca <stab_binsearch+0xec>
            *region_right = m - 1;
  1006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006ba:	8b 45 10             	mov    0x10(%ebp),%eax
  1006bd:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1006bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006c2:	83 e8 01             	sub    $0x1,%eax
  1006c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1006c8:	eb 12                	jmp    1006dc <stab_binsearch+0xfe>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1006ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1006d0:	89 10                	mov    %edx,(%eax)
            l = m;
  1006d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1006d8:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1006dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1006e2:	0f 8e 22 ff ff ff    	jle    10060a <stab_binsearch+0x2c>
        }
    }

    if (!any_matches) {
  1006e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1006ec:	75 0f                	jne    1006fd <stab_binsearch+0x11f>
        *region_right = *region_left - 1;
  1006ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006f1:	8b 00                	mov    (%eax),%eax
  1006f3:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006f6:	8b 45 10             	mov    0x10(%ebp),%eax
  1006f9:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1006fb:	eb 3f                	jmp    10073c <stab_binsearch+0x15e>
        l = *region_right;
  1006fd:	8b 45 10             	mov    0x10(%ebp),%eax
  100700:	8b 00                	mov    (%eax),%eax
  100702:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100705:	eb 04                	jmp    10070b <stab_binsearch+0x12d>
  100707:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  10070b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10070e:	8b 00                	mov    (%eax),%eax
  100710:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100713:	7e 1f                	jle    100734 <stab_binsearch+0x156>
  100715:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100718:	89 d0                	mov    %edx,%eax
  10071a:	01 c0                	add    %eax,%eax
  10071c:	01 d0                	add    %edx,%eax
  10071e:	c1 e0 02             	shl    $0x2,%eax
  100721:	89 c2                	mov    %eax,%edx
  100723:	8b 45 08             	mov    0x8(%ebp),%eax
  100726:	01 d0                	add    %edx,%eax
  100728:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10072c:	0f b6 c0             	movzbl %al,%eax
  10072f:	39 45 14             	cmp    %eax,0x14(%ebp)
  100732:	75 d3                	jne    100707 <stab_binsearch+0x129>
        *region_left = l;
  100734:	8b 45 0c             	mov    0xc(%ebp),%eax
  100737:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10073a:	89 10                	mov    %edx,(%eax)
}
  10073c:	90                   	nop
  10073d:	c9                   	leave  
  10073e:	c3                   	ret    

0010073f <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10073f:	55                   	push   %ebp
  100740:	89 e5                	mov    %esp,%ebp
  100742:	53                   	push   %ebx
  100743:	83 ec 34             	sub    $0x34,%esp
  100746:	e8 6b fb ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  10074b:	81 c3 05 e2 00 00    	add    $0xe205,%ebx
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100751:	8b 45 0c             	mov    0xc(%ebp),%eax
  100754:	8d 93 48 51 ff ff    	lea    -0xaeb8(%ebx),%edx
  10075a:	89 10                	mov    %edx,(%eax)
    info->eip_line = 0;
  10075c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100766:	8b 45 0c             	mov    0xc(%ebp),%eax
  100769:	8d 93 48 51 ff ff    	lea    -0xaeb8(%ebx),%edx
  10076f:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_namelen = 9;
  100772:	8b 45 0c             	mov    0xc(%ebp),%eax
  100775:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10077c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077f:	8b 55 08             	mov    0x8(%ebp),%edx
  100782:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100785:	8b 45 0c             	mov    0xc(%ebp),%eax
  100788:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10078f:	c7 c0 44 42 10 00    	mov    $0x104244,%eax
  100795:	89 45 f4             	mov    %eax,-0xc(%ebp)
    stab_end = __STAB_END__;
  100798:	c7 c0 f4 be 10 00    	mov    $0x10bef4,%eax
  10079e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  1007a1:	c7 c0 f5 be 10 00    	mov    $0x10bef5,%eax
  1007a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  1007aa:	c7 c0 c9 df 10 00    	mov    $0x10dfc9,%eax
  1007b0:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  1007b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1007b6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1007b9:	76 0d                	jbe    1007c8 <debuginfo_eip+0x89>
  1007bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1007be:	83 e8 01             	sub    $0x1,%eax
  1007c1:	0f b6 00             	movzbl (%eax),%eax
  1007c4:	84 c0                	test   %al,%al
  1007c6:	74 0a                	je     1007d2 <debuginfo_eip+0x93>
        return -1;
  1007c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007cd:	e9 91 02 00 00       	jmp    100a63 <debuginfo_eip+0x324>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1007d2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1007d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1007dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007df:	29 c2                	sub    %eax,%edx
  1007e1:	89 d0                	mov    %edx,%eax
  1007e3:	c1 f8 02             	sar    $0x2,%eax
  1007e6:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1007ec:	83 e8 01             	sub    $0x1,%eax
  1007ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1007f2:	ff 75 08             	pushl  0x8(%ebp)
  1007f5:	6a 64                	push   $0x64
  1007f7:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1007fa:	50                   	push   %eax
  1007fb:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1007fe:	50                   	push   %eax
  1007ff:	ff 75 f4             	pushl  -0xc(%ebp)
  100802:	e8 d7 fd ff ff       	call   1005de <stab_binsearch>
  100807:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  10080a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10080d:	85 c0                	test   %eax,%eax
  10080f:	75 0a                	jne    10081b <debuginfo_eip+0xdc>
        return -1;
  100811:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100816:	e9 48 02 00 00       	jmp    100a63 <debuginfo_eip+0x324>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  10081b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10081e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100821:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100824:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100827:	ff 75 08             	pushl  0x8(%ebp)
  10082a:	6a 24                	push   $0x24
  10082c:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10082f:	50                   	push   %eax
  100830:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100833:	50                   	push   %eax
  100834:	ff 75 f4             	pushl  -0xc(%ebp)
  100837:	e8 a2 fd ff ff       	call   1005de <stab_binsearch>
  10083c:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  10083f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100842:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100845:	39 c2                	cmp    %eax,%edx
  100847:	7f 7c                	jg     1008c5 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100849:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10084c:	89 c2                	mov    %eax,%edx
  10084e:	89 d0                	mov    %edx,%eax
  100850:	01 c0                	add    %eax,%eax
  100852:	01 d0                	add    %edx,%eax
  100854:	c1 e0 02             	shl    $0x2,%eax
  100857:	89 c2                	mov    %eax,%edx
  100859:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10085c:	01 d0                	add    %edx,%eax
  10085e:	8b 00                	mov    (%eax),%eax
  100860:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100863:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100866:	29 d1                	sub    %edx,%ecx
  100868:	89 ca                	mov    %ecx,%edx
  10086a:	39 d0                	cmp    %edx,%eax
  10086c:	73 22                	jae    100890 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10086e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100871:	89 c2                	mov    %eax,%edx
  100873:	89 d0                	mov    %edx,%eax
  100875:	01 c0                	add    %eax,%eax
  100877:	01 d0                	add    %edx,%eax
  100879:	c1 e0 02             	shl    $0x2,%eax
  10087c:	89 c2                	mov    %eax,%edx
  10087e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100881:	01 d0                	add    %edx,%eax
  100883:	8b 10                	mov    (%eax),%edx
  100885:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100888:	01 c2                	add    %eax,%edx
  10088a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10088d:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100890:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100893:	89 c2                	mov    %eax,%edx
  100895:	89 d0                	mov    %edx,%eax
  100897:	01 c0                	add    %eax,%eax
  100899:	01 d0                	add    %edx,%eax
  10089b:	c1 e0 02             	shl    $0x2,%eax
  10089e:	89 c2                	mov    %eax,%edx
  1008a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a3:	01 d0                	add    %edx,%eax
  1008a5:	8b 50 08             	mov    0x8(%eax),%edx
  1008a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ab:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  1008ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008b1:	8b 40 10             	mov    0x10(%eax),%eax
  1008b4:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1008b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1008bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1008c3:	eb 15                	jmp    1008da <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008c8:	8b 55 08             	mov    0x8(%ebp),%edx
  1008cb:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1008ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1008d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1008d7:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1008da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008dd:	8b 40 08             	mov    0x8(%eax),%eax
  1008e0:	83 ec 08             	sub    $0x8,%esp
  1008e3:	6a 3a                	push   $0x3a
  1008e5:	50                   	push   %eax
  1008e6:	e8 e0 26 00 00       	call   102fcb <strfind>
  1008eb:	83 c4 10             	add    $0x10,%esp
  1008ee:	89 c2                	mov    %eax,%edx
  1008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f3:	8b 40 08             	mov    0x8(%eax),%eax
  1008f6:	29 c2                	sub    %eax,%edx
  1008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008fb:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1008fe:	83 ec 0c             	sub    $0xc,%esp
  100901:	ff 75 08             	pushl  0x8(%ebp)
  100904:	6a 44                	push   $0x44
  100906:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100909:	50                   	push   %eax
  10090a:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  10090d:	50                   	push   %eax
  10090e:	ff 75 f4             	pushl  -0xc(%ebp)
  100911:	e8 c8 fc ff ff       	call   1005de <stab_binsearch>
  100916:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  100919:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10091c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10091f:	39 c2                	cmp    %eax,%edx
  100921:	7f 24                	jg     100947 <debuginfo_eip+0x208>
        info->eip_line = stabs[rline].n_desc;
  100923:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100926:	89 c2                	mov    %eax,%edx
  100928:	89 d0                	mov    %edx,%eax
  10092a:	01 c0                	add    %eax,%eax
  10092c:	01 d0                	add    %edx,%eax
  10092e:	c1 e0 02             	shl    $0x2,%eax
  100931:	89 c2                	mov    %eax,%edx
  100933:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100936:	01 d0                	add    %edx,%eax
  100938:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10093c:	0f b7 d0             	movzwl %ax,%edx
  10093f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100942:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100945:	eb 13                	jmp    10095a <debuginfo_eip+0x21b>
        return -1;
  100947:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10094c:	e9 12 01 00 00       	jmp    100a63 <debuginfo_eip+0x324>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100951:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100954:	83 e8 01             	sub    $0x1,%eax
  100957:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10095a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10095d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100960:	39 c2                	cmp    %eax,%edx
  100962:	7c 56                	jl     1009ba <debuginfo_eip+0x27b>
           && stabs[lline].n_type != N_SOL
  100964:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100967:	89 c2                	mov    %eax,%edx
  100969:	89 d0                	mov    %edx,%eax
  10096b:	01 c0                	add    %eax,%eax
  10096d:	01 d0                	add    %edx,%eax
  10096f:	c1 e0 02             	shl    $0x2,%eax
  100972:	89 c2                	mov    %eax,%edx
  100974:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100977:	01 d0                	add    %edx,%eax
  100979:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10097d:	3c 84                	cmp    $0x84,%al
  10097f:	74 39                	je     1009ba <debuginfo_eip+0x27b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100981:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100984:	89 c2                	mov    %eax,%edx
  100986:	89 d0                	mov    %edx,%eax
  100988:	01 c0                	add    %eax,%eax
  10098a:	01 d0                	add    %edx,%eax
  10098c:	c1 e0 02             	shl    $0x2,%eax
  10098f:	89 c2                	mov    %eax,%edx
  100991:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100994:	01 d0                	add    %edx,%eax
  100996:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10099a:	3c 64                	cmp    $0x64,%al
  10099c:	75 b3                	jne    100951 <debuginfo_eip+0x212>
  10099e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009a1:	89 c2                	mov    %eax,%edx
  1009a3:	89 d0                	mov    %edx,%eax
  1009a5:	01 c0                	add    %eax,%eax
  1009a7:	01 d0                	add    %edx,%eax
  1009a9:	c1 e0 02             	shl    $0x2,%eax
  1009ac:	89 c2                	mov    %eax,%edx
  1009ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009b1:	01 d0                	add    %edx,%eax
  1009b3:	8b 40 08             	mov    0x8(%eax),%eax
  1009b6:	85 c0                	test   %eax,%eax
  1009b8:	74 97                	je     100951 <debuginfo_eip+0x212>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1009ba:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1009bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1009c0:	39 c2                	cmp    %eax,%edx
  1009c2:	7c 46                	jl     100a0a <debuginfo_eip+0x2cb>
  1009c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009c7:	89 c2                	mov    %eax,%edx
  1009c9:	89 d0                	mov    %edx,%eax
  1009cb:	01 c0                	add    %eax,%eax
  1009cd:	01 d0                	add    %edx,%eax
  1009cf:	c1 e0 02             	shl    $0x2,%eax
  1009d2:	89 c2                	mov    %eax,%edx
  1009d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009d7:	01 d0                	add    %edx,%eax
  1009d9:	8b 00                	mov    (%eax),%eax
  1009db:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1009de:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1009e1:	29 d1                	sub    %edx,%ecx
  1009e3:	89 ca                	mov    %ecx,%edx
  1009e5:	39 d0                	cmp    %edx,%eax
  1009e7:	73 21                	jae    100a0a <debuginfo_eip+0x2cb>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1009e9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009ec:	89 c2                	mov    %eax,%edx
  1009ee:	89 d0                	mov    %edx,%eax
  1009f0:	01 c0                	add    %eax,%eax
  1009f2:	01 d0                	add    %edx,%eax
  1009f4:	c1 e0 02             	shl    $0x2,%eax
  1009f7:	89 c2                	mov    %eax,%edx
  1009f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009fc:	01 d0                	add    %edx,%eax
  1009fe:	8b 10                	mov    (%eax),%edx
  100a00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a03:	01 c2                	add    %eax,%edx
  100a05:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a08:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100a0a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100a0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a10:	39 c2                	cmp    %eax,%edx
  100a12:	7d 4a                	jge    100a5e <debuginfo_eip+0x31f>
        for (lline = lfun + 1;
  100a14:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a17:	83 c0 01             	add    $0x1,%eax
  100a1a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100a1d:	eb 18                	jmp    100a37 <debuginfo_eip+0x2f8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a22:	8b 40 14             	mov    0x14(%eax),%eax
  100a25:	8d 50 01             	lea    0x1(%eax),%edx
  100a28:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a2b:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100a2e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a31:	83 c0 01             	add    $0x1,%eax
  100a34:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a37:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100a3a:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100a3d:	39 c2                	cmp    %eax,%edx
  100a3f:	7d 1d                	jge    100a5e <debuginfo_eip+0x31f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a41:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a44:	89 c2                	mov    %eax,%edx
  100a46:	89 d0                	mov    %edx,%eax
  100a48:	01 c0                	add    %eax,%eax
  100a4a:	01 d0                	add    %edx,%eax
  100a4c:	c1 e0 02             	shl    $0x2,%eax
  100a4f:	89 c2                	mov    %eax,%edx
  100a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a54:	01 d0                	add    %edx,%eax
  100a56:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100a5a:	3c a0                	cmp    $0xa0,%al
  100a5c:	74 c1                	je     100a1f <debuginfo_eip+0x2e0>
        }
    }
    return 0;
  100a5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100a63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100a66:	c9                   	leave  
  100a67:	c3                   	ret    

00100a68 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100a68:	55                   	push   %ebp
  100a69:	89 e5                	mov    %esp,%ebp
  100a6b:	53                   	push   %ebx
  100a6c:	83 ec 04             	sub    $0x4,%esp
  100a6f:	e8 42 f8 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100a74:	81 c3 dc de 00 00    	add    $0xdedc,%ebx
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100a7a:	83 ec 0c             	sub    $0xc,%esp
  100a7d:	8d 83 52 51 ff ff    	lea    -0xaeae(%ebx),%eax
  100a83:	50                   	push   %eax
  100a84:	e8 a0 f8 ff ff       	call   100329 <cprintf>
  100a89:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100a8c:	83 ec 08             	sub    $0x8,%esp
  100a8f:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a95:	50                   	push   %eax
  100a96:	8d 83 6b 51 ff ff    	lea    -0xae95(%ebx),%eax
  100a9c:	50                   	push   %eax
  100a9d:	e8 87 f8 ff ff       	call   100329 <cprintf>
  100aa2:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100aa5:	83 ec 08             	sub    $0x8,%esp
  100aa8:	c7 c0 97 39 10 00    	mov    $0x103997,%eax
  100aae:	50                   	push   %eax
  100aaf:	8d 83 83 51 ff ff    	lea    -0xae7d(%ebx),%eax
  100ab5:	50                   	push   %eax
  100ab6:	e8 6e f8 ff ff       	call   100329 <cprintf>
  100abb:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100abe:	83 ec 08             	sub    $0x8,%esp
  100ac1:	c7 c0 50 e9 10 00    	mov    $0x10e950,%eax
  100ac7:	50                   	push   %eax
  100ac8:	8d 83 9b 51 ff ff    	lea    -0xae65(%ebx),%eax
  100ace:	50                   	push   %eax
  100acf:	e8 55 f8 ff ff       	call   100329 <cprintf>
  100ad4:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100ad7:	83 ec 08             	sub    $0x8,%esp
  100ada:	c7 c0 c0 fd 10 00    	mov    $0x10fdc0,%eax
  100ae0:	50                   	push   %eax
  100ae1:	8d 83 b3 51 ff ff    	lea    -0xae4d(%ebx),%eax
  100ae7:	50                   	push   %eax
  100ae8:	e8 3c f8 ff ff       	call   100329 <cprintf>
  100aed:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100af0:	c7 c0 c0 fd 10 00    	mov    $0x10fdc0,%eax
  100af6:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100afc:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100b02:	29 c2                	sub    %eax,%edx
  100b04:	89 d0                	mov    %edx,%eax
  100b06:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100b0c:	85 c0                	test   %eax,%eax
  100b0e:	0f 48 c2             	cmovs  %edx,%eax
  100b11:	c1 f8 0a             	sar    $0xa,%eax
  100b14:	83 ec 08             	sub    $0x8,%esp
  100b17:	50                   	push   %eax
  100b18:	8d 83 cc 51 ff ff    	lea    -0xae34(%ebx),%eax
  100b1e:	50                   	push   %eax
  100b1f:	e8 05 f8 ff ff       	call   100329 <cprintf>
  100b24:	83 c4 10             	add    $0x10,%esp
}
  100b27:	90                   	nop
  100b28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100b2b:	c9                   	leave  
  100b2c:	c3                   	ret    

00100b2d <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100b2d:	55                   	push   %ebp
  100b2e:	89 e5                	mov    %esp,%ebp
  100b30:	53                   	push   %ebx
  100b31:	81 ec 24 01 00 00    	sub    $0x124,%esp
  100b37:	e8 7a f7 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100b3c:	81 c3 14 de 00 00    	add    $0xde14,%ebx
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100b42:	83 ec 08             	sub    $0x8,%esp
  100b45:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100b48:	50                   	push   %eax
  100b49:	ff 75 08             	pushl  0x8(%ebp)
  100b4c:	e8 ee fb ff ff       	call   10073f <debuginfo_eip>
  100b51:	83 c4 10             	add    $0x10,%esp
  100b54:	85 c0                	test   %eax,%eax
  100b56:	74 17                	je     100b6f <print_debuginfo+0x42>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100b58:	83 ec 08             	sub    $0x8,%esp
  100b5b:	ff 75 08             	pushl  0x8(%ebp)
  100b5e:	8d 83 f6 51 ff ff    	lea    -0xae0a(%ebx),%eax
  100b64:	50                   	push   %eax
  100b65:	e8 bf f7 ff ff       	call   100329 <cprintf>
  100b6a:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100b6d:	eb 67                	jmp    100bd6 <print_debuginfo+0xa9>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b76:	eb 1c                	jmp    100b94 <print_debuginfo+0x67>
            fnname[j] = info.eip_fn_name[j];
  100b78:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b7e:	01 d0                	add    %edx,%eax
  100b80:	0f b6 00             	movzbl (%eax),%eax
  100b83:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b8c:	01 ca                	add    %ecx,%edx
  100b8e:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b94:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b97:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100b9a:	7c dc                	jl     100b78 <print_debuginfo+0x4b>
        fnname[j] = '\0';
  100b9c:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ba5:	01 d0                	add    %edx,%eax
  100ba7:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100baa:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100bad:	8b 55 08             	mov    0x8(%ebp),%edx
  100bb0:	89 d1                	mov    %edx,%ecx
  100bb2:	29 c1                	sub    %eax,%ecx
  100bb4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100bb7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100bba:	83 ec 0c             	sub    $0xc,%esp
  100bbd:	51                   	push   %ecx
  100bbe:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100bc4:	51                   	push   %ecx
  100bc5:	52                   	push   %edx
  100bc6:	50                   	push   %eax
  100bc7:	8d 83 12 52 ff ff    	lea    -0xadee(%ebx),%eax
  100bcd:	50                   	push   %eax
  100bce:	e8 56 f7 ff ff       	call   100329 <cprintf>
  100bd3:	83 c4 20             	add    $0x20,%esp
}
  100bd6:	90                   	nop
  100bd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100bda:	c9                   	leave  
  100bdb:	c3                   	ret    

00100bdc <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100bdc:	55                   	push   %ebp
  100bdd:	89 e5                	mov    %esp,%ebp
  100bdf:	83 ec 10             	sub    $0x10,%esp
  100be2:	e8 cb f6 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  100be7:	05 69 dd 00 00       	add    $0xdd69,%eax
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100bec:	8b 45 04             	mov    0x4(%ebp),%eax
  100bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100bf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100bf5:	c9                   	leave  
  100bf6:	c3                   	ret    

00100bf7 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100bf7:	55                   	push   %ebp
  100bf8:	89 e5                	mov    %esp,%ebp
  100bfa:	56                   	push   %esi
  100bfb:	53                   	push   %ebx
  100bfc:	83 ec 20             	sub    $0x20,%esp
  100bff:	e8 b2 f6 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100c04:	81 c3 4c dd 00 00    	add    $0xdd4c,%ebx
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100c0a:	89 e8                	mov    %ebp,%eax
  100c0c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100c0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    uint32_t ebp = read_ebp();
  100c12:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uint32_t eip = read_eip();
  100c15:	e8 c2 ff ff ff       	call   100bdc <read_eip>
  100c1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int i;
    for(i = 0; i < STACKFRAME_DEPTH && ebp!=0; i++)
  100c1d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100c24:	eb 6b                	jmp    100c91 <print_stackframe+0x9a>
    {
        uint32_t *call_argu = (uint32_t *) ebp + 2;
  100c26:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c29:	83 c0 08             	add    $0x8,%eax
  100c2c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        cprintf("ebp:0x%08x eip:0x%08x args:0x%08x 0x%08x 0x%08x 0x%08x 0x%08x\n", ebp, eip, call_argu[0], call_argu[1], call_argu[2], call_argu[3]);
  100c2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c32:	83 c0 0c             	add    $0xc,%eax
  100c35:	8b 30                	mov    (%eax),%esi
  100c37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c3a:	83 c0 08             	add    $0x8,%eax
  100c3d:	8b 08                	mov    (%eax),%ecx
  100c3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c42:	83 c0 04             	add    $0x4,%eax
  100c45:	8b 10                	mov    (%eax),%edx
  100c47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c4a:	8b 00                	mov    (%eax),%eax
  100c4c:	83 ec 04             	sub    $0x4,%esp
  100c4f:	56                   	push   %esi
  100c50:	51                   	push   %ecx
  100c51:	52                   	push   %edx
  100c52:	50                   	push   %eax
  100c53:	ff 75 f0             	pushl  -0x10(%ebp)
  100c56:	ff 75 f4             	pushl  -0xc(%ebp)
  100c59:	8d 83 24 52 ff ff    	lea    -0xaddc(%ebx),%eax
  100c5f:	50                   	push   %eax
  100c60:	e8 c4 f6 ff ff       	call   100329 <cprintf>
  100c65:	83 c4 20             	add    $0x20,%esp
        print_debuginfo(eip - 1);
  100c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100c6b:	83 e8 01             	sub    $0x1,%eax
  100c6e:	83 ec 0c             	sub    $0xc,%esp
  100c71:	50                   	push   %eax
  100c72:	e8 b6 fe ff ff       	call   100b2d <print_debuginfo>
  100c77:	83 c4 10             	add    $0x10,%esp
        eip = *((uint32_t *) ebp + 1);
  100c7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c7d:	83 c0 04             	add    $0x4,%eax
  100c80:	8b 00                	mov    (%eax),%eax
  100c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = *((uint32_t *) ebp);
  100c85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c88:	8b 00                	mov    (%eax),%eax
  100c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(i = 0; i < STACKFRAME_DEPTH && ebp!=0; i++)
  100c8d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100c91:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100c95:	7f 06                	jg     100c9d <print_stackframe+0xa6>
  100c97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c9b:	75 89                	jne    100c26 <print_stackframe+0x2f>
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100c9d:	90                   	nop
  100c9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100ca1:	5b                   	pop    %ebx
  100ca2:	5e                   	pop    %esi
  100ca3:	5d                   	pop    %ebp
  100ca4:	c3                   	ret    

00100ca5 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100ca5:	55                   	push   %ebp
  100ca6:	89 e5                	mov    %esp,%ebp
  100ca8:	53                   	push   %ebx
  100ca9:	83 ec 14             	sub    $0x14,%esp
  100cac:	e8 05 f6 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100cb1:	81 c3 9f dc 00 00    	add    $0xdc9f,%ebx
    int argc = 0;
  100cb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100cbe:	eb 0c                	jmp    100ccc <parse+0x27>
            *buf ++ = '\0';
  100cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  100cc3:	8d 50 01             	lea    0x1(%eax),%edx
  100cc6:	89 55 08             	mov    %edx,0x8(%ebp)
  100cc9:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  100ccf:	0f b6 00             	movzbl (%eax),%eax
  100cd2:	84 c0                	test   %al,%al
  100cd4:	74 20                	je     100cf6 <parse+0x51>
  100cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  100cd9:	0f b6 00             	movzbl (%eax),%eax
  100cdc:	0f be c0             	movsbl %al,%eax
  100cdf:	83 ec 08             	sub    $0x8,%esp
  100ce2:	50                   	push   %eax
  100ce3:	8d 83 e4 52 ff ff    	lea    -0xad1c(%ebx),%eax
  100ce9:	50                   	push   %eax
  100cea:	e8 9f 22 00 00       	call   102f8e <strchr>
  100cef:	83 c4 10             	add    $0x10,%esp
  100cf2:	85 c0                	test   %eax,%eax
  100cf4:	75 ca                	jne    100cc0 <parse+0x1b>
        }
        if (*buf == '\0') {
  100cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  100cf9:	0f b6 00             	movzbl (%eax),%eax
  100cfc:	84 c0                	test   %al,%al
  100cfe:	74 69                	je     100d69 <parse+0xc4>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100d00:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100d04:	75 14                	jne    100d1a <parse+0x75>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100d06:	83 ec 08             	sub    $0x8,%esp
  100d09:	6a 10                	push   $0x10
  100d0b:	8d 83 e9 52 ff ff    	lea    -0xad17(%ebx),%eax
  100d11:	50                   	push   %eax
  100d12:	e8 12 f6 ff ff       	call   100329 <cprintf>
  100d17:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d1d:	8d 50 01             	lea    0x1(%eax),%edx
  100d20:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100d23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d2d:	01 c2                	add    %eax,%edx
  100d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  100d32:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d34:	eb 04                	jmp    100d3a <parse+0x95>
            buf ++;
  100d36:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  100d3d:	0f b6 00             	movzbl (%eax),%eax
  100d40:	84 c0                	test   %al,%al
  100d42:	74 88                	je     100ccc <parse+0x27>
  100d44:	8b 45 08             	mov    0x8(%ebp),%eax
  100d47:	0f b6 00             	movzbl (%eax),%eax
  100d4a:	0f be c0             	movsbl %al,%eax
  100d4d:	83 ec 08             	sub    $0x8,%esp
  100d50:	50                   	push   %eax
  100d51:	8d 83 e4 52 ff ff    	lea    -0xad1c(%ebx),%eax
  100d57:	50                   	push   %eax
  100d58:	e8 31 22 00 00       	call   102f8e <strchr>
  100d5d:	83 c4 10             	add    $0x10,%esp
  100d60:	85 c0                	test   %eax,%eax
  100d62:	74 d2                	je     100d36 <parse+0x91>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d64:	e9 63 ff ff ff       	jmp    100ccc <parse+0x27>
            break;
  100d69:	90                   	nop
        }
    }
    return argc;
  100d6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100d6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100d70:	c9                   	leave  
  100d71:	c3                   	ret    

00100d72 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100d72:	55                   	push   %ebp
  100d73:	89 e5                	mov    %esp,%ebp
  100d75:	56                   	push   %esi
  100d76:	53                   	push   %ebx
  100d77:	83 ec 50             	sub    $0x50,%esp
  100d7a:	e8 37 f5 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100d7f:	81 c3 d1 db 00 00    	add    $0xdbd1,%ebx
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100d85:	83 ec 08             	sub    $0x8,%esp
  100d88:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100d8b:	50                   	push   %eax
  100d8c:	ff 75 08             	pushl  0x8(%ebp)
  100d8f:	e8 11 ff ff ff       	call   100ca5 <parse>
  100d94:	83 c4 10             	add    $0x10,%esp
  100d97:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100d9a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100d9e:	75 0a                	jne    100daa <runcmd+0x38>
        return 0;
  100da0:	b8 00 00 00 00       	mov    $0x0,%eax
  100da5:	e9 8b 00 00 00       	jmp    100e35 <runcmd+0xc3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100daa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100db1:	eb 5f                	jmp    100e12 <runcmd+0xa0>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100db3:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100db6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100db9:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100dbf:	89 d0                	mov    %edx,%eax
  100dc1:	01 c0                	add    %eax,%eax
  100dc3:	01 d0                	add    %edx,%eax
  100dc5:	c1 e0 02             	shl    $0x2,%eax
  100dc8:	01 f0                	add    %esi,%eax
  100dca:	8b 00                	mov    (%eax),%eax
  100dcc:	83 ec 08             	sub    $0x8,%esp
  100dcf:	51                   	push   %ecx
  100dd0:	50                   	push   %eax
  100dd1:	e8 04 21 00 00       	call   102eda <strcmp>
  100dd6:	83 c4 10             	add    $0x10,%esp
  100dd9:	85 c0                	test   %eax,%eax
  100ddb:	75 31                	jne    100e0e <runcmd+0x9c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100ddd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100de0:	8d 8b 18 00 00 00    	lea    0x18(%ebx),%ecx
  100de6:	89 d0                	mov    %edx,%eax
  100de8:	01 c0                	add    %eax,%eax
  100dea:	01 d0                	add    %edx,%eax
  100dec:	c1 e0 02             	shl    $0x2,%eax
  100def:	01 c8                	add    %ecx,%eax
  100df1:	8b 10                	mov    (%eax),%edx
  100df3:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100df6:	83 c0 04             	add    $0x4,%eax
  100df9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100dfc:	83 e9 01             	sub    $0x1,%ecx
  100dff:	83 ec 04             	sub    $0x4,%esp
  100e02:	ff 75 0c             	pushl  0xc(%ebp)
  100e05:	50                   	push   %eax
  100e06:	51                   	push   %ecx
  100e07:	ff d2                	call   *%edx
  100e09:	83 c4 10             	add    $0x10,%esp
  100e0c:	eb 27                	jmp    100e35 <runcmd+0xc3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100e0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100e15:	83 f8 02             	cmp    $0x2,%eax
  100e18:	76 99                	jbe    100db3 <runcmd+0x41>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100e1a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100e1d:	83 ec 08             	sub    $0x8,%esp
  100e20:	50                   	push   %eax
  100e21:	8d 83 07 53 ff ff    	lea    -0xacf9(%ebx),%eax
  100e27:	50                   	push   %eax
  100e28:	e8 fc f4 ff ff       	call   100329 <cprintf>
  100e2d:	83 c4 10             	add    $0x10,%esp
    return 0;
  100e30:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100e35:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100e38:	5b                   	pop    %ebx
  100e39:	5e                   	pop    %esi
  100e3a:	5d                   	pop    %ebp
  100e3b:	c3                   	ret    

00100e3c <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100e3c:	55                   	push   %ebp
  100e3d:	89 e5                	mov    %esp,%ebp
  100e3f:	53                   	push   %ebx
  100e40:	83 ec 14             	sub    $0x14,%esp
  100e43:	e8 6e f4 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100e48:	81 c3 08 db 00 00    	add    $0xdb08,%ebx
    cprintf("Welcome to the kernel debug monitor!!\n");
  100e4e:	83 ec 0c             	sub    $0xc,%esp
  100e51:	8d 83 20 53 ff ff    	lea    -0xace0(%ebx),%eax
  100e57:	50                   	push   %eax
  100e58:	e8 cc f4 ff ff       	call   100329 <cprintf>
  100e5d:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100e60:	83 ec 0c             	sub    $0xc,%esp
  100e63:	8d 83 48 53 ff ff    	lea    -0xacb8(%ebx),%eax
  100e69:	50                   	push   %eax
  100e6a:	e8 ba f4 ff ff       	call   100329 <cprintf>
  100e6f:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100e72:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e76:	74 0e                	je     100e86 <kmonitor+0x4a>
        print_trapframe(tf);
  100e78:	83 ec 0c             	sub    $0xc,%esp
  100e7b:	ff 75 08             	pushl  0x8(%ebp)
  100e7e:	e8 11 0f 00 00       	call   101d94 <print_trapframe>
  100e83:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100e86:	83 ec 0c             	sub    $0xc,%esp
  100e89:	8d 83 6d 53 ff ff    	lea    -0xac93(%ebx),%eax
  100e8f:	50                   	push   %eax
  100e90:	e8 6c f5 ff ff       	call   100401 <readline>
  100e95:	83 c4 10             	add    $0x10,%esp
  100e98:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100e9b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100e9f:	74 e5                	je     100e86 <kmonitor+0x4a>
            if (runcmd(buf, tf) < 0) {
  100ea1:	83 ec 08             	sub    $0x8,%esp
  100ea4:	ff 75 08             	pushl  0x8(%ebp)
  100ea7:	ff 75 f4             	pushl  -0xc(%ebp)
  100eaa:	e8 c3 fe ff ff       	call   100d72 <runcmd>
  100eaf:	83 c4 10             	add    $0x10,%esp
  100eb2:	85 c0                	test   %eax,%eax
  100eb4:	78 02                	js     100eb8 <kmonitor+0x7c>
        if ((buf = readline("K> ")) != NULL) {
  100eb6:	eb ce                	jmp    100e86 <kmonitor+0x4a>
                break;
  100eb8:	90                   	nop
            }
        }
    }
}
  100eb9:	90                   	nop
  100eba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100ebd:	c9                   	leave  
  100ebe:	c3                   	ret    

00100ebf <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100ebf:	55                   	push   %ebp
  100ec0:	89 e5                	mov    %esp,%ebp
  100ec2:	56                   	push   %esi
  100ec3:	53                   	push   %ebx
  100ec4:	83 ec 10             	sub    $0x10,%esp
  100ec7:	e8 ea f3 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100ecc:	81 c3 84 da 00 00    	add    $0xda84,%ebx
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ed2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100ed9:	eb 44                	jmp    100f1f <mon_help+0x60>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100edb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ede:	8d 8b 14 00 00 00    	lea    0x14(%ebx),%ecx
  100ee4:	89 d0                	mov    %edx,%eax
  100ee6:	01 c0                	add    %eax,%eax
  100ee8:	01 d0                	add    %edx,%eax
  100eea:	c1 e0 02             	shl    $0x2,%eax
  100eed:	01 c8                	add    %ecx,%eax
  100eef:	8b 08                	mov    (%eax),%ecx
  100ef1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ef4:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100efa:	89 d0                	mov    %edx,%eax
  100efc:	01 c0                	add    %eax,%eax
  100efe:	01 d0                	add    %edx,%eax
  100f00:	c1 e0 02             	shl    $0x2,%eax
  100f03:	01 f0                	add    %esi,%eax
  100f05:	8b 00                	mov    (%eax),%eax
  100f07:	83 ec 04             	sub    $0x4,%esp
  100f0a:	51                   	push   %ecx
  100f0b:	50                   	push   %eax
  100f0c:	8d 83 71 53 ff ff    	lea    -0xac8f(%ebx),%eax
  100f12:	50                   	push   %eax
  100f13:	e8 11 f4 ff ff       	call   100329 <cprintf>
  100f18:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100f1b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f22:	83 f8 02             	cmp    $0x2,%eax
  100f25:	76 b4                	jbe    100edb <mon_help+0x1c>
    }
    return 0;
  100f27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f2c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100f2f:	5b                   	pop    %ebx
  100f30:	5e                   	pop    %esi
  100f31:	5d                   	pop    %ebp
  100f32:	c3                   	ret    

00100f33 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100f33:	55                   	push   %ebp
  100f34:	89 e5                	mov    %esp,%ebp
  100f36:	53                   	push   %ebx
  100f37:	83 ec 04             	sub    $0x4,%esp
  100f3a:	e8 73 f3 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  100f3f:	05 11 da 00 00       	add    $0xda11,%eax
    print_kerninfo();
  100f44:	89 c3                	mov    %eax,%ebx
  100f46:	e8 1d fb ff ff       	call   100a68 <print_kerninfo>
    return 0;
  100f4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f50:	83 c4 04             	add    $0x4,%esp
  100f53:	5b                   	pop    %ebx
  100f54:	5d                   	pop    %ebp
  100f55:	c3                   	ret    

00100f56 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100f56:	55                   	push   %ebp
  100f57:	89 e5                	mov    %esp,%ebp
  100f59:	53                   	push   %ebx
  100f5a:	83 ec 04             	sub    $0x4,%esp
  100f5d:	e8 50 f3 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  100f62:	05 ee d9 00 00       	add    $0xd9ee,%eax
    print_stackframe();
  100f67:	89 c3                	mov    %eax,%ebx
  100f69:	e8 89 fc ff ff       	call   100bf7 <print_stackframe>
    return 0;
  100f6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f73:	83 c4 04             	add    $0x4,%esp
  100f76:	5b                   	pop    %ebx
  100f77:	5d                   	pop    %ebp
  100f78:	c3                   	ret    

00100f79 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100f79:	55                   	push   %ebp
  100f7a:	89 e5                	mov    %esp,%ebp
  100f7c:	53                   	push   %ebx
  100f7d:	83 ec 14             	sub    $0x14,%esp
  100f80:	e8 31 f3 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  100f85:	81 c3 cb d9 00 00    	add    $0xd9cb,%ebx
  100f8b:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100f91:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f95:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f99:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f9d:	ee                   	out    %al,(%dx)
  100f9e:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100fa4:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100fa8:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100fac:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100fb0:	ee                   	out    %al,(%dx)
  100fb1:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100fb7:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100fbb:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100fbf:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100fc3:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100fc4:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  100fca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("++ setup timer interrupts\n");
  100fd0:	83 ec 0c             	sub    $0xc,%esp
  100fd3:	8d 83 7a 53 ff ff    	lea    -0xac86(%ebx),%eax
  100fd9:	50                   	push   %eax
  100fda:	e8 4a f3 ff ff       	call   100329 <cprintf>
  100fdf:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100fe2:	83 ec 0c             	sub    $0xc,%esp
  100fe5:	6a 00                	push   $0x0
  100fe7:	e8 e7 09 00 00       	call   1019d3 <pic_enable>
  100fec:	83 c4 10             	add    $0x10,%esp
}
  100fef:	90                   	nop
  100ff0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100ff3:	c9                   	leave  
  100ff4:	c3                   	ret    

00100ff5 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100ff5:	55                   	push   %ebp
  100ff6:	89 e5                	mov    %esp,%ebp
  100ff8:	83 ec 10             	sub    $0x10,%esp
  100ffb:	e8 b2 f2 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101000:	05 50 d9 00 00       	add    $0xd950,%eax
  101005:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10100b:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10100f:	89 c2                	mov    %eax,%edx
  101011:	ec                   	in     (%dx),%al
  101012:	88 45 f1             	mov    %al,-0xf(%ebp)
  101015:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  10101b:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10101f:	89 c2                	mov    %eax,%edx
  101021:	ec                   	in     (%dx),%al
  101022:	88 45 f5             	mov    %al,-0xb(%ebp)
  101025:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  10102b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10102f:	89 c2                	mov    %eax,%edx
  101031:	ec                   	in     (%dx),%al
  101032:	88 45 f9             	mov    %al,-0x7(%ebp)
  101035:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  10103b:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  10103f:	89 c2                	mov    %eax,%edx
  101041:	ec                   	in     (%dx),%al
  101042:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  101045:	90                   	nop
  101046:	c9                   	leave  
  101047:	c3                   	ret    

00101048 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  101048:	55                   	push   %ebp
  101049:	89 e5                	mov    %esp,%ebp
  10104b:	83 ec 20             	sub    $0x20,%esp
  10104e:	e8 17 09 00 00       	call   10196a <__x86.get_pc_thunk.cx>
  101053:	81 c1 fd d8 00 00    	add    $0xd8fd,%ecx
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  101059:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  101060:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101063:	0f b7 00             	movzwl (%eax),%eax
  101066:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  10106a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10106d:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  101072:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101075:	0f b7 00             	movzwl (%eax),%eax
  101078:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10107c:	74 12                	je     101090 <cga_init+0x48>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  10107e:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  101085:	66 c7 81 b6 05 00 00 	movw   $0x3b4,0x5b6(%ecx)
  10108c:	b4 03 
  10108e:	eb 13                	jmp    1010a3 <cga_init+0x5b>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  101090:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101093:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101097:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  10109a:	66 c7 81 b6 05 00 00 	movw   $0x3d4,0x5b6(%ecx)
  1010a1:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  1010a3:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010aa:	0f b7 c0             	movzwl %ax,%eax
  1010ad:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  1010b1:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b5:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1010b9:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1010bd:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  1010be:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010c5:	83 c0 01             	add    $0x1,%eax
  1010c8:	0f b7 c0             	movzwl %ax,%eax
  1010cb:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1010cf:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  1010d3:	89 c2                	mov    %eax,%edx
  1010d5:	ec                   	in     (%dx),%al
  1010d6:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  1010d9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1010dd:	0f b6 c0             	movzbl %al,%eax
  1010e0:	c1 e0 08             	shl    $0x8,%eax
  1010e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  1010e6:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010ed:	0f b7 c0             	movzwl %ax,%eax
  1010f0:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1010f4:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010f8:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010fc:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101100:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  101101:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  101108:	83 c0 01             	add    $0x1,%eax
  10110b:	0f b7 c0             	movzwl %ax,%eax
  10110e:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101112:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101116:	89 c2                	mov    %eax,%edx
  101118:	ec                   	in     (%dx),%al
  101119:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  10111c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101120:	0f b6 c0             	movzbl %al,%eax
  101123:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  101126:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101129:	89 81 b0 05 00 00    	mov    %eax,0x5b0(%ecx)
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  10112f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101132:	66 89 81 b4 05 00 00 	mov    %ax,0x5b4(%ecx)
}
  101139:	90                   	nop
  10113a:	c9                   	leave  
  10113b:	c3                   	ret    

0010113c <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  10113c:	55                   	push   %ebp
  10113d:	89 e5                	mov    %esp,%ebp
  10113f:	53                   	push   %ebx
  101140:	83 ec 34             	sub    $0x34,%esp
  101143:	e8 22 08 00 00       	call   10196a <__x86.get_pc_thunk.cx>
  101148:	81 c1 08 d8 00 00    	add    $0xd808,%ecx
  10114e:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  101154:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101158:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  10115c:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101160:	ee                   	out    %al,(%dx)
  101161:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  101167:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  10116b:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  10116f:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101173:	ee                   	out    %al,(%dx)
  101174:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  10117a:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  10117e:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101182:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101186:	ee                   	out    %al,(%dx)
  101187:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  10118d:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  101191:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101195:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101199:	ee                   	out    %al,(%dx)
  10119a:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  1011a0:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  1011a4:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  1011a8:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  1011ac:	ee                   	out    %al,(%dx)
  1011ad:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  1011b3:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  1011b7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1011bb:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1011bf:	ee                   	out    %al,(%dx)
  1011c0:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  1011c6:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  1011ca:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1011ce:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1011d2:	ee                   	out    %al,(%dx)
  1011d3:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011d9:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  1011dd:	89 c2                	mov    %eax,%edx
  1011df:	ec                   	in     (%dx),%al
  1011e0:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  1011e3:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  1011e7:	3c ff                	cmp    $0xff,%al
  1011e9:	0f 95 c0             	setne  %al
  1011ec:	0f b6 c0             	movzbl %al,%eax
  1011ef:	89 81 b8 05 00 00    	mov    %eax,0x5b8(%ecx)
  1011f5:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011fb:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1011ff:	89 c2                	mov    %eax,%edx
  101201:	ec                   	in     (%dx),%al
  101202:	88 45 f1             	mov    %al,-0xf(%ebp)
  101205:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10120b:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10120f:	89 c2                	mov    %eax,%edx
  101211:	ec                   	in     (%dx),%al
  101212:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101215:	8b 81 b8 05 00 00    	mov    0x5b8(%ecx),%eax
  10121b:	85 c0                	test   %eax,%eax
  10121d:	74 0f                	je     10122e <serial_init+0xf2>
        pic_enable(IRQ_COM1);
  10121f:	83 ec 0c             	sub    $0xc,%esp
  101222:	6a 04                	push   $0x4
  101224:	89 cb                	mov    %ecx,%ebx
  101226:	e8 a8 07 00 00       	call   1019d3 <pic_enable>
  10122b:	83 c4 10             	add    $0x10,%esp
    }
}
  10122e:	90                   	nop
  10122f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101232:	c9                   	leave  
  101233:	c3                   	ret    

00101234 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101234:	55                   	push   %ebp
  101235:	89 e5                	mov    %esp,%ebp
  101237:	83 ec 20             	sub    $0x20,%esp
  10123a:	e8 73 f0 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  10123f:	05 11 d7 00 00       	add    $0xd711,%eax
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101244:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10124b:	eb 09                	jmp    101256 <lpt_putc_sub+0x22>
        delay();
  10124d:	e8 a3 fd ff ff       	call   100ff5 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101252:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101256:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10125c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101260:	89 c2                	mov    %eax,%edx
  101262:	ec                   	in     (%dx),%al
  101263:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101266:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10126a:	84 c0                	test   %al,%al
  10126c:	78 09                	js     101277 <lpt_putc_sub+0x43>
  10126e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101275:	7e d6                	jle    10124d <lpt_putc_sub+0x19>
    }
    outb(LPTPORT + 0, c);
  101277:	8b 45 08             	mov    0x8(%ebp),%eax
  10127a:	0f b6 c0             	movzbl %al,%eax
  10127d:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101283:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101286:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10128a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10128e:	ee                   	out    %al,(%dx)
  10128f:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101295:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101299:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10129d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012a1:	ee                   	out    %al,(%dx)
  1012a2:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1012a8:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  1012ac:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012b0:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012b4:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1012b5:	90                   	nop
  1012b6:	c9                   	leave  
  1012b7:	c3                   	ret    

001012b8 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1012b8:	55                   	push   %ebp
  1012b9:	89 e5                	mov    %esp,%ebp
  1012bb:	e8 f2 ef ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1012c0:	05 90 d6 00 00       	add    $0xd690,%eax
    if (c != '\b') {
  1012c5:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012c9:	74 0d                	je     1012d8 <lpt_putc+0x20>
        lpt_putc_sub(c);
  1012cb:	ff 75 08             	pushl  0x8(%ebp)
  1012ce:	e8 61 ff ff ff       	call   101234 <lpt_putc_sub>
  1012d3:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1012d6:	eb 1e                	jmp    1012f6 <lpt_putc+0x3e>
        lpt_putc_sub('\b');
  1012d8:	6a 08                	push   $0x8
  1012da:	e8 55 ff ff ff       	call   101234 <lpt_putc_sub>
  1012df:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1012e2:	6a 20                	push   $0x20
  1012e4:	e8 4b ff ff ff       	call   101234 <lpt_putc_sub>
  1012e9:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  1012ec:	6a 08                	push   $0x8
  1012ee:	e8 41 ff ff ff       	call   101234 <lpt_putc_sub>
  1012f3:	83 c4 04             	add    $0x4,%esp
}
  1012f6:	90                   	nop
  1012f7:	c9                   	leave  
  1012f8:	c3                   	ret    

001012f9 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1012f9:	55                   	push   %ebp
  1012fa:	89 e5                	mov    %esp,%ebp
  1012fc:	56                   	push   %esi
  1012fd:	53                   	push   %ebx
  1012fe:	83 ec 20             	sub    $0x20,%esp
  101301:	e8 b0 ef ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101306:	81 c3 4a d6 00 00    	add    $0xd64a,%ebx
    // set black on white
    if (!(c & ~0xFF)) {
  10130c:	8b 45 08             	mov    0x8(%ebp),%eax
  10130f:	b0 00                	mov    $0x0,%al
  101311:	85 c0                	test   %eax,%eax
  101313:	75 07                	jne    10131c <cga_putc+0x23>
        c |= 0x0700;
  101315:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10131c:	8b 45 08             	mov    0x8(%ebp),%eax
  10131f:	0f b6 c0             	movzbl %al,%eax
  101322:	83 f8 0a             	cmp    $0xa,%eax
  101325:	74 54                	je     10137b <cga_putc+0x82>
  101327:	83 f8 0d             	cmp    $0xd,%eax
  10132a:	74 60                	je     10138c <cga_putc+0x93>
  10132c:	83 f8 08             	cmp    $0x8,%eax
  10132f:	0f 85 92 00 00 00    	jne    1013c7 <cga_putc+0xce>
    case '\b':
        if (crt_pos > 0) {
  101335:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10133c:	66 85 c0             	test   %ax,%ax
  10133f:	0f 84 a8 00 00 00    	je     1013ed <cga_putc+0xf4>
            crt_pos --;
  101345:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10134c:	83 e8 01             	sub    $0x1,%eax
  10134f:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101356:	8b 45 08             	mov    0x8(%ebp),%eax
  101359:	b0 00                	mov    $0x0,%al
  10135b:	83 c8 20             	or     $0x20,%eax
  10135e:	89 c1                	mov    %eax,%ecx
  101360:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  101366:	0f b7 93 b4 05 00 00 	movzwl 0x5b4(%ebx),%edx
  10136d:	0f b7 d2             	movzwl %dx,%edx
  101370:	01 d2                	add    %edx,%edx
  101372:	01 d0                	add    %edx,%eax
  101374:	89 ca                	mov    %ecx,%edx
  101376:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101379:	eb 72                	jmp    1013ed <cga_putc+0xf4>
    case '\n':
        crt_pos += CRT_COLS;
  10137b:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101382:	83 c0 50             	add    $0x50,%eax
  101385:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  10138c:	0f b7 b3 b4 05 00 00 	movzwl 0x5b4(%ebx),%esi
  101393:	0f b7 8b b4 05 00 00 	movzwl 0x5b4(%ebx),%ecx
  10139a:	0f b7 c1             	movzwl %cx,%eax
  10139d:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1013a3:	c1 e8 10             	shr    $0x10,%eax
  1013a6:	89 c2                	mov    %eax,%edx
  1013a8:	66 c1 ea 06          	shr    $0x6,%dx
  1013ac:	89 d0                	mov    %edx,%eax
  1013ae:	c1 e0 02             	shl    $0x2,%eax
  1013b1:	01 d0                	add    %edx,%eax
  1013b3:	c1 e0 04             	shl    $0x4,%eax
  1013b6:	29 c1                	sub    %eax,%ecx
  1013b8:	89 ca                	mov    %ecx,%edx
  1013ba:	89 f0                	mov    %esi,%eax
  1013bc:	29 d0                	sub    %edx,%eax
  1013be:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
        break;
  1013c5:	eb 27                	jmp    1013ee <cga_putc+0xf5>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1013c7:	8b 8b b0 05 00 00    	mov    0x5b0(%ebx),%ecx
  1013cd:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013d4:	8d 50 01             	lea    0x1(%eax),%edx
  1013d7:	66 89 93 b4 05 00 00 	mov    %dx,0x5b4(%ebx)
  1013de:	0f b7 c0             	movzwl %ax,%eax
  1013e1:	01 c0                	add    %eax,%eax
  1013e3:	01 c8                	add    %ecx,%eax
  1013e5:	8b 55 08             	mov    0x8(%ebp),%edx
  1013e8:	66 89 10             	mov    %dx,(%eax)
        break;
  1013eb:	eb 01                	jmp    1013ee <cga_putc+0xf5>
        break;
  1013ed:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1013ee:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013f5:	66 3d cf 07          	cmp    $0x7cf,%ax
  1013f9:	76 5d                	jbe    101458 <cga_putc+0x15f>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1013fb:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  101401:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101407:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  10140d:	83 ec 04             	sub    $0x4,%esp
  101410:	68 00 0f 00 00       	push   $0xf00
  101415:	52                   	push   %edx
  101416:	50                   	push   %eax
  101417:	e8 99 1d 00 00       	call   1031b5 <memmove>
  10141c:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10141f:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101426:	eb 16                	jmp    10143e <cga_putc+0x145>
            crt_buf[i] = 0x0700 | ' ';
  101428:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  10142e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101431:	01 d2                	add    %edx,%edx
  101433:	01 d0                	add    %edx,%eax
  101435:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10143a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10143e:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101445:	7e e1                	jle    101428 <cga_putc+0x12f>
        }
        crt_pos -= CRT_COLS;
  101447:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10144e:	83 e8 50             	sub    $0x50,%eax
  101451:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101458:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  10145f:	0f b7 c0             	movzwl %ax,%eax
  101462:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101466:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  10146a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10146e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101472:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101473:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10147a:	66 c1 e8 08          	shr    $0x8,%ax
  10147e:	0f b6 c0             	movzbl %al,%eax
  101481:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  101488:	83 c2 01             	add    $0x1,%edx
  10148b:	0f b7 d2             	movzwl %dx,%edx
  10148e:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101492:	88 45 e9             	mov    %al,-0x17(%ebp)
  101495:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101499:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10149d:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  10149e:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  1014a5:	0f b7 c0             	movzwl %ax,%eax
  1014a8:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1014ac:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  1014b0:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1014b4:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1014b8:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  1014b9:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1014c0:	0f b6 c0             	movzbl %al,%eax
  1014c3:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  1014ca:	83 c2 01             	add    $0x1,%edx
  1014cd:	0f b7 d2             	movzwl %dx,%edx
  1014d0:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1014d4:	88 45 f1             	mov    %al,-0xf(%ebp)
  1014d7:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1014db:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1014df:	ee                   	out    %al,(%dx)
}
  1014e0:	90                   	nop
  1014e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1014e4:	5b                   	pop    %ebx
  1014e5:	5e                   	pop    %esi
  1014e6:	5d                   	pop    %ebp
  1014e7:	c3                   	ret    

001014e8 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1014e8:	55                   	push   %ebp
  1014e9:	89 e5                	mov    %esp,%ebp
  1014eb:	83 ec 10             	sub    $0x10,%esp
  1014ee:	e8 bf ed ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1014f3:	05 5d d4 00 00       	add    $0xd45d,%eax
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1014ff:	eb 09                	jmp    10150a <serial_putc_sub+0x22>
        delay();
  101501:	e8 ef fa ff ff       	call   100ff5 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101506:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10150a:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101510:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101514:	89 c2                	mov    %eax,%edx
  101516:	ec                   	in     (%dx),%al
  101517:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10151a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10151e:	0f b6 c0             	movzbl %al,%eax
  101521:	83 e0 20             	and    $0x20,%eax
  101524:	85 c0                	test   %eax,%eax
  101526:	75 09                	jne    101531 <serial_putc_sub+0x49>
  101528:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10152f:	7e d0                	jle    101501 <serial_putc_sub+0x19>
    }
    outb(COM1 + COM_TX, c);
  101531:	8b 45 08             	mov    0x8(%ebp),%eax
  101534:	0f b6 c0             	movzbl %al,%eax
  101537:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10153d:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101540:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101544:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101548:	ee                   	out    %al,(%dx)
}
  101549:	90                   	nop
  10154a:	c9                   	leave  
  10154b:	c3                   	ret    

0010154c <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10154c:	55                   	push   %ebp
  10154d:	89 e5                	mov    %esp,%ebp
  10154f:	e8 5e ed ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101554:	05 fc d3 00 00       	add    $0xd3fc,%eax
    if (c != '\b') {
  101559:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10155d:	74 0d                	je     10156c <serial_putc+0x20>
        serial_putc_sub(c);
  10155f:	ff 75 08             	pushl  0x8(%ebp)
  101562:	e8 81 ff ff ff       	call   1014e8 <serial_putc_sub>
  101567:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10156a:	eb 1e                	jmp    10158a <serial_putc+0x3e>
        serial_putc_sub('\b');
  10156c:	6a 08                	push   $0x8
  10156e:	e8 75 ff ff ff       	call   1014e8 <serial_putc_sub>
  101573:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101576:	6a 20                	push   $0x20
  101578:	e8 6b ff ff ff       	call   1014e8 <serial_putc_sub>
  10157d:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  101580:	6a 08                	push   $0x8
  101582:	e8 61 ff ff ff       	call   1014e8 <serial_putc_sub>
  101587:	83 c4 04             	add    $0x4,%esp
}
  10158a:	90                   	nop
  10158b:	c9                   	leave  
  10158c:	c3                   	ret    

0010158d <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10158d:	55                   	push   %ebp
  10158e:	89 e5                	mov    %esp,%ebp
  101590:	53                   	push   %ebx
  101591:	83 ec 14             	sub    $0x14,%esp
  101594:	e8 1d ed ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101599:	81 c3 b7 d3 00 00    	add    $0xd3b7,%ebx
    int c;
    while ((c = (*proc)()) != -1) {
  10159f:	eb 36                	jmp    1015d7 <cons_intr+0x4a>
        if (c != 0) {
  1015a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1015a5:	74 30                	je     1015d7 <cons_intr+0x4a>
            cons.buf[cons.wpos ++] = c;
  1015a7:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1015ad:	8d 50 01             	lea    0x1(%eax),%edx
  1015b0:	89 93 d4 07 00 00    	mov    %edx,0x7d4(%ebx)
  1015b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1015b9:	88 94 03 d0 05 00 00 	mov    %dl,0x5d0(%ebx,%eax,1)
            if (cons.wpos == CONSBUFSIZE) {
  1015c0:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1015c6:	3d 00 02 00 00       	cmp    $0x200,%eax
  1015cb:	75 0a                	jne    1015d7 <cons_intr+0x4a>
                cons.wpos = 0;
  1015cd:	c7 83 d4 07 00 00 00 	movl   $0x0,0x7d4(%ebx)
  1015d4:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1015da:	ff d0                	call   *%eax
  1015dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1015df:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1015e3:	75 bc                	jne    1015a1 <cons_intr+0x14>
            }
        }
    }
}
  1015e5:	90                   	nop
  1015e6:	83 c4 14             	add    $0x14,%esp
  1015e9:	5b                   	pop    %ebx
  1015ea:	5d                   	pop    %ebp
  1015eb:	c3                   	ret    

001015ec <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1015ec:	55                   	push   %ebp
  1015ed:	89 e5                	mov    %esp,%ebp
  1015ef:	83 ec 10             	sub    $0x10,%esp
  1015f2:	e8 bb ec ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1015f7:	05 59 d3 00 00       	add    $0xd359,%eax
  1015fc:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101602:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101606:	89 c2                	mov    %eax,%edx
  101608:	ec                   	in     (%dx),%al
  101609:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10160c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101610:	0f b6 c0             	movzbl %al,%eax
  101613:	83 e0 01             	and    $0x1,%eax
  101616:	85 c0                	test   %eax,%eax
  101618:	75 07                	jne    101621 <serial_proc_data+0x35>
        return -1;
  10161a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10161f:	eb 2a                	jmp    10164b <serial_proc_data+0x5f>
  101621:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101627:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10162b:	89 c2                	mov    %eax,%edx
  10162d:	ec                   	in     (%dx),%al
  10162e:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101631:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101635:	0f b6 c0             	movzbl %al,%eax
  101638:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  10163b:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10163f:	75 07                	jne    101648 <serial_proc_data+0x5c>
        c = '\b';
  101641:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101648:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10164b:	c9                   	leave  
  10164c:	c3                   	ret    

0010164d <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10164d:	55                   	push   %ebp
  10164e:	89 e5                	mov    %esp,%ebp
  101650:	83 ec 08             	sub    $0x8,%esp
  101653:	e8 5a ec ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101658:	05 f8 d2 00 00       	add    $0xd2f8,%eax
    if (serial_exists) {
  10165d:	8b 90 b8 05 00 00    	mov    0x5b8(%eax),%edx
  101663:	85 d2                	test   %edx,%edx
  101665:	74 12                	je     101679 <serial_intr+0x2c>
        cons_intr(serial_proc_data);
  101667:	83 ec 0c             	sub    $0xc,%esp
  10166a:	8d 80 9c 2c ff ff    	lea    -0xd364(%eax),%eax
  101670:	50                   	push   %eax
  101671:	e8 17 ff ff ff       	call   10158d <cons_intr>
  101676:	83 c4 10             	add    $0x10,%esp
    }
}
  101679:	90                   	nop
  10167a:	c9                   	leave  
  10167b:	c3                   	ret    

0010167c <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10167c:	55                   	push   %ebp
  10167d:	89 e5                	mov    %esp,%ebp
  10167f:	53                   	push   %ebx
  101680:	83 ec 24             	sub    $0x24,%esp
  101683:	e8 e2 02 00 00       	call   10196a <__x86.get_pc_thunk.cx>
  101688:	81 c1 c8 d2 00 00    	add    $0xd2c8,%ecx
  10168e:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101694:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101698:	89 c2                	mov    %eax,%edx
  10169a:	ec                   	in     (%dx),%al
  10169b:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  10169e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1016a2:	0f b6 c0             	movzbl %al,%eax
  1016a5:	83 e0 01             	and    $0x1,%eax
  1016a8:	85 c0                	test   %eax,%eax
  1016aa:	75 0a                	jne    1016b6 <kbd_proc_data+0x3a>
        return -1;
  1016ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1016b1:	e9 73 01 00 00       	jmp    101829 <kbd_proc_data+0x1ad>
  1016b6:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1016bc:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016c0:	89 c2                	mov    %eax,%edx
  1016c2:	ec                   	in     (%dx),%al
  1016c3:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1016c6:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1016ca:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1016cd:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1016d1:	75 19                	jne    1016ec <kbd_proc_data+0x70>
        // E0 escape character
        shift |= E0ESC;
  1016d3:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016d9:	83 c8 40             	or     $0x40,%eax
  1016dc:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1016e7:	e9 3d 01 00 00       	jmp    101829 <kbd_proc_data+0x1ad>
    } else if (data & 0x80) {
  1016ec:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016f0:	84 c0                	test   %al,%al
  1016f2:	79 4b                	jns    10173f <kbd_proc_data+0xc3>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1016f4:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016fa:	83 e0 40             	and    $0x40,%eax
  1016fd:	85 c0                	test   %eax,%eax
  1016ff:	75 09                	jne    10170a <kbd_proc_data+0x8e>
  101701:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101705:	83 e0 7f             	and    $0x7f,%eax
  101708:	eb 04                	jmp    10170e <kbd_proc_data+0x92>
  10170a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10170e:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101711:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101715:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  10171c:	ff 
  10171d:	83 c8 40             	or     $0x40,%eax
  101720:	0f b6 c0             	movzbl %al,%eax
  101723:	f7 d0                	not    %eax
  101725:	89 c2                	mov    %eax,%edx
  101727:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10172d:	21 d0                	and    %edx,%eax
  10172f:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  101735:	b8 00 00 00 00       	mov    $0x0,%eax
  10173a:	e9 ea 00 00 00       	jmp    101829 <kbd_proc_data+0x1ad>
    } else if (shift & E0ESC) {
  10173f:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101745:	83 e0 40             	and    $0x40,%eax
  101748:	85 c0                	test   %eax,%eax
  10174a:	74 13                	je     10175f <kbd_proc_data+0xe3>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10174c:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101750:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101756:	83 e0 bf             	and    $0xffffffbf,%eax
  101759:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    }

    shift |= shiftcode[data];
  10175f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101763:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  10176a:	ff 
  10176b:	0f b6 d0             	movzbl %al,%edx
  10176e:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101774:	09 d0                	or     %edx,%eax
  101776:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    shift ^= togglecode[data];
  10177c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101780:	0f b6 84 01 b0 f7 ff 	movzbl -0x850(%ecx,%eax,1),%eax
  101787:	ff 
  101788:	0f b6 d0             	movzbl %al,%edx
  10178b:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101791:	31 d0                	xor    %edx,%eax
  101793:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)

    c = charcode[shift & (CTL | SHIFT)][data];
  101799:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10179f:	83 e0 03             	and    $0x3,%eax
  1017a2:	8b 94 81 34 00 00 00 	mov    0x34(%ecx,%eax,4),%edx
  1017a9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1017ad:	01 d0                	add    %edx,%eax
  1017af:	0f b6 00             	movzbl (%eax),%eax
  1017b2:	0f b6 c0             	movzbl %al,%eax
  1017b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1017b8:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017be:	83 e0 08             	and    $0x8,%eax
  1017c1:	85 c0                	test   %eax,%eax
  1017c3:	74 22                	je     1017e7 <kbd_proc_data+0x16b>
        if ('a' <= c && c <= 'z')
  1017c5:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1017c9:	7e 0c                	jle    1017d7 <kbd_proc_data+0x15b>
  1017cb:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1017cf:	7f 06                	jg     1017d7 <kbd_proc_data+0x15b>
            c += 'A' - 'a';
  1017d1:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1017d5:	eb 10                	jmp    1017e7 <kbd_proc_data+0x16b>
        else if ('A' <= c && c <= 'Z')
  1017d7:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1017db:	7e 0a                	jle    1017e7 <kbd_proc_data+0x16b>
  1017dd:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1017e1:	7f 04                	jg     1017e7 <kbd_proc_data+0x16b>
            c += 'a' - 'A';
  1017e3:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1017e7:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017ed:	f7 d0                	not    %eax
  1017ef:	83 e0 06             	and    $0x6,%eax
  1017f2:	85 c0                	test   %eax,%eax
  1017f4:	75 30                	jne    101826 <kbd_proc_data+0x1aa>
  1017f6:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1017fd:	75 27                	jne    101826 <kbd_proc_data+0x1aa>
        cprintf("Rebooting!\n");
  1017ff:	83 ec 0c             	sub    $0xc,%esp
  101802:	8d 81 95 53 ff ff    	lea    -0xac6b(%ecx),%eax
  101808:	50                   	push   %eax
  101809:	89 cb                	mov    %ecx,%ebx
  10180b:	e8 19 eb ff ff       	call   100329 <cprintf>
  101810:	83 c4 10             	add    $0x10,%esp
  101813:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101819:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10181d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101821:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101825:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101826:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101829:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10182c:	c9                   	leave  
  10182d:	c3                   	ret    

0010182e <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10182e:	55                   	push   %ebp
  10182f:	89 e5                	mov    %esp,%ebp
  101831:	83 ec 08             	sub    $0x8,%esp
  101834:	e8 79 ea ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101839:	05 17 d1 00 00       	add    $0xd117,%eax
    cons_intr(kbd_proc_data);
  10183e:	83 ec 0c             	sub    $0xc,%esp
  101841:	8d 80 2c 2d ff ff    	lea    -0xd2d4(%eax),%eax
  101847:	50                   	push   %eax
  101848:	e8 40 fd ff ff       	call   10158d <cons_intr>
  10184d:	83 c4 10             	add    $0x10,%esp
}
  101850:	90                   	nop
  101851:	c9                   	leave  
  101852:	c3                   	ret    

00101853 <kbd_init>:

static void
kbd_init(void) {
  101853:	55                   	push   %ebp
  101854:	89 e5                	mov    %esp,%ebp
  101856:	53                   	push   %ebx
  101857:	83 ec 04             	sub    $0x4,%esp
  10185a:	e8 57 ea ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  10185f:	81 c3 f1 d0 00 00    	add    $0xd0f1,%ebx
    // drain the kbd buffer
    kbd_intr();
  101865:	e8 c4 ff ff ff       	call   10182e <kbd_intr>
    pic_enable(IRQ_KBD);
  10186a:	83 ec 0c             	sub    $0xc,%esp
  10186d:	6a 01                	push   $0x1
  10186f:	e8 5f 01 00 00       	call   1019d3 <pic_enable>
  101874:	83 c4 10             	add    $0x10,%esp
}
  101877:	90                   	nop
  101878:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10187b:	c9                   	leave  
  10187c:	c3                   	ret    

0010187d <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10187d:	55                   	push   %ebp
  10187e:	89 e5                	mov    %esp,%ebp
  101880:	53                   	push   %ebx
  101881:	83 ec 04             	sub    $0x4,%esp
  101884:	e8 2d ea ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101889:	81 c3 c7 d0 00 00    	add    $0xd0c7,%ebx
    cga_init();
  10188f:	e8 b4 f7 ff ff       	call   101048 <cga_init>
    serial_init();
  101894:	e8 a3 f8 ff ff       	call   10113c <serial_init>
    kbd_init();
  101899:	e8 b5 ff ff ff       	call   101853 <kbd_init>
    if (!serial_exists) {
  10189e:	8b 83 b8 05 00 00    	mov    0x5b8(%ebx),%eax
  1018a4:	85 c0                	test   %eax,%eax
  1018a6:	75 12                	jne    1018ba <cons_init+0x3d>
        cprintf("serial port does not exist!!\n");
  1018a8:	83 ec 0c             	sub    $0xc,%esp
  1018ab:	8d 83 a1 53 ff ff    	lea    -0xac5f(%ebx),%eax
  1018b1:	50                   	push   %eax
  1018b2:	e8 72 ea ff ff       	call   100329 <cprintf>
  1018b7:	83 c4 10             	add    $0x10,%esp
    }
}
  1018ba:	90                   	nop
  1018bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1018be:	c9                   	leave  
  1018bf:	c3                   	ret    

001018c0 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1018c0:	55                   	push   %ebp
  1018c1:	89 e5                	mov    %esp,%ebp
  1018c3:	83 ec 08             	sub    $0x8,%esp
  1018c6:	e8 e7 e9 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1018cb:	05 85 d0 00 00       	add    $0xd085,%eax
    lpt_putc(c);
  1018d0:	ff 75 08             	pushl  0x8(%ebp)
  1018d3:	e8 e0 f9 ff ff       	call   1012b8 <lpt_putc>
  1018d8:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  1018db:	83 ec 0c             	sub    $0xc,%esp
  1018de:	ff 75 08             	pushl  0x8(%ebp)
  1018e1:	e8 13 fa ff ff       	call   1012f9 <cga_putc>
  1018e6:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1018e9:	83 ec 0c             	sub    $0xc,%esp
  1018ec:	ff 75 08             	pushl  0x8(%ebp)
  1018ef:	e8 58 fc ff ff       	call   10154c <serial_putc>
  1018f4:	83 c4 10             	add    $0x10,%esp
}
  1018f7:	90                   	nop
  1018f8:	c9                   	leave  
  1018f9:	c3                   	ret    

001018fa <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1018fa:	55                   	push   %ebp
  1018fb:	89 e5                	mov    %esp,%ebp
  1018fd:	53                   	push   %ebx
  1018fe:	83 ec 14             	sub    $0x14,%esp
  101901:	e8 b0 e9 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101906:	81 c3 4a d0 00 00    	add    $0xd04a,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10190c:	e8 3c fd ff ff       	call   10164d <serial_intr>
    kbd_intr();
  101911:	e8 18 ff ff ff       	call   10182e <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101916:	8b 93 d0 07 00 00    	mov    0x7d0(%ebx),%edx
  10191c:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101922:	39 c2                	cmp    %eax,%edx
  101924:	74 39                	je     10195f <cons_getc+0x65>
        c = cons.buf[cons.rpos ++];
  101926:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  10192c:	8d 50 01             	lea    0x1(%eax),%edx
  10192f:	89 93 d0 07 00 00    	mov    %edx,0x7d0(%ebx)
  101935:	0f b6 84 03 d0 05 00 	movzbl 0x5d0(%ebx,%eax,1),%eax
  10193c:	00 
  10193d:	0f b6 c0             	movzbl %al,%eax
  101940:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101943:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  101949:	3d 00 02 00 00       	cmp    $0x200,%eax
  10194e:	75 0a                	jne    10195a <cons_getc+0x60>
            cons.rpos = 0;
  101950:	c7 83 d0 07 00 00 00 	movl   $0x0,0x7d0(%ebx)
  101957:	00 00 00 
        }
        return c;
  10195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10195d:	eb 05                	jmp    101964 <cons_getc+0x6a>
    }
    return 0;
  10195f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101964:	83 c4 14             	add    $0x14,%esp
  101967:	5b                   	pop    %ebx
  101968:	5d                   	pop    %ebp
  101969:	c3                   	ret    

0010196a <__x86.get_pc_thunk.cx>:
  10196a:	8b 0c 24             	mov    (%esp),%ecx
  10196d:	c3                   	ret    

0010196e <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  10196e:	55                   	push   %ebp
  10196f:	89 e5                	mov    %esp,%ebp
  101971:	83 ec 14             	sub    $0x14,%esp
  101974:	e8 39 e9 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101979:	05 d7 cf 00 00       	add    $0xcfd7,%eax
  10197e:	8b 55 08             	mov    0x8(%ebp),%edx
  101981:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
    irq_mask = mask;
  101985:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  101989:	66 89 90 b0 fb ff ff 	mov    %dx,-0x450(%eax)
    if (did_init) {
  101990:	8b 80 dc 07 00 00    	mov    0x7dc(%eax),%eax
  101996:	85 c0                	test   %eax,%eax
  101998:	74 36                	je     1019d0 <pic_setmask+0x62>
        outb(IO_PIC1 + 1, mask);
  10199a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10199e:	0f b6 c0             	movzbl %al,%eax
  1019a1:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  1019a7:	88 45 f9             	mov    %al,-0x7(%ebp)
  1019aa:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1019ae:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1019b2:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  1019b3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1019b7:	66 c1 e8 08          	shr    $0x8,%ax
  1019bb:	0f b6 c0             	movzbl %al,%eax
  1019be:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  1019c4:	88 45 fd             	mov    %al,-0x3(%ebp)
  1019c7:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1019cb:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1019cf:	ee                   	out    %al,(%dx)
    }
}
  1019d0:	90                   	nop
  1019d1:	c9                   	leave  
  1019d2:	c3                   	ret    

001019d3 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1019d3:	55                   	push   %ebp
  1019d4:	89 e5                	mov    %esp,%ebp
  1019d6:	53                   	push   %ebx
  1019d7:	e8 d6 e8 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1019dc:	05 74 cf 00 00       	add    $0xcf74,%eax
    pic_setmask(irq_mask & ~(1 << irq));
  1019e1:	8b 55 08             	mov    0x8(%ebp),%edx
  1019e4:	bb 01 00 00 00       	mov    $0x1,%ebx
  1019e9:	89 d1                	mov    %edx,%ecx
  1019eb:	d3 e3                	shl    %cl,%ebx
  1019ed:	89 da                	mov    %ebx,%edx
  1019ef:	f7 d2                	not    %edx
  1019f1:	0f b7 80 b0 fb ff ff 	movzwl -0x450(%eax),%eax
  1019f8:	21 d0                	and    %edx,%eax
  1019fa:	0f b7 c0             	movzwl %ax,%eax
  1019fd:	50                   	push   %eax
  1019fe:	e8 6b ff ff ff       	call   10196e <pic_setmask>
  101a03:	83 c4 04             	add    $0x4,%esp
}
  101a06:	90                   	nop
  101a07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101a0a:	c9                   	leave  
  101a0b:	c3                   	ret    

00101a0c <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101a0c:	55                   	push   %ebp
  101a0d:	89 e5                	mov    %esp,%ebp
  101a0f:	83 ec 40             	sub    $0x40,%esp
  101a12:	e8 53 ff ff ff       	call   10196a <__x86.get_pc_thunk.cx>
  101a17:	81 c1 39 cf 00 00    	add    $0xcf39,%ecx
    did_init = 1;
  101a1d:	c7 81 dc 07 00 00 01 	movl   $0x1,0x7dc(%ecx)
  101a24:	00 00 00 
  101a27:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  101a2d:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  101a31:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101a35:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101a39:	ee                   	out    %al,(%dx)
  101a3a:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101a40:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  101a44:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101a48:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101a4c:	ee                   	out    %al,(%dx)
  101a4d:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101a53:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  101a57:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101a5b:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101a5f:	ee                   	out    %al,(%dx)
  101a60:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101a66:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  101a6a:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101a6e:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101a72:	ee                   	out    %al,(%dx)
  101a73:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101a79:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101a7d:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101a81:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101a85:	ee                   	out    %al,(%dx)
  101a86:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101a8c:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  101a90:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101a94:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101a98:	ee                   	out    %al,(%dx)
  101a99:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101a9f:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  101aa3:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101aa7:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101aab:	ee                   	out    %al,(%dx)
  101aac:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101ab2:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101ab6:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101aba:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101abe:	ee                   	out    %al,(%dx)
  101abf:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101ac5:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101ac9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101acd:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101ad1:	ee                   	out    %al,(%dx)
  101ad2:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101ad8:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  101adc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101ae0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101ae4:	ee                   	out    %al,(%dx)
  101ae5:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101aeb:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  101aef:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101af3:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101af7:	ee                   	out    %al,(%dx)
  101af8:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101afe:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  101b02:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101b06:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101b0a:	ee                   	out    %al,(%dx)
  101b0b:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101b11:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  101b15:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101b19:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101b1d:	ee                   	out    %al,(%dx)
  101b1e:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101b24:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  101b28:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101b2c:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101b30:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101b31:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b38:	66 83 f8 ff          	cmp    $0xffff,%ax
  101b3c:	74 13                	je     101b51 <pic_init+0x145>
        pic_setmask(irq_mask);
  101b3e:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b45:	0f b7 c0             	movzwl %ax,%eax
  101b48:	50                   	push   %eax
  101b49:	e8 20 fe ff ff       	call   10196e <pic_setmask>
  101b4e:	83 c4 04             	add    $0x4,%esp
    }
}
  101b51:	90                   	nop
  101b52:	c9                   	leave  
  101b53:	c3                   	ret    

00101b54 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101b54:	55                   	push   %ebp
  101b55:	89 e5                	mov    %esp,%ebp
  101b57:	e8 56 e7 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101b5c:	05 f4 cd 00 00       	add    $0xcdf4,%eax
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101b61:	fb                   	sti    
    sti();
}
  101b62:	90                   	nop
  101b63:	5d                   	pop    %ebp
  101b64:	c3                   	ret    

00101b65 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101b65:	55                   	push   %ebp
  101b66:	89 e5                	mov    %esp,%ebp
  101b68:	e8 45 e7 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101b6d:	05 e3 cd 00 00       	add    $0xcde3,%eax
}

static inline void
cli(void) {
    asm volatile ("cli");
  101b72:	fa                   	cli    
    cli();
}
  101b73:	90                   	nop
  101b74:	5d                   	pop    %ebp
  101b75:	c3                   	ret    

00101b76 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101b76:	55                   	push   %ebp
  101b77:	89 e5                	mov    %esp,%ebp
  101b79:	53                   	push   %ebx
  101b7a:	83 ec 04             	sub    $0x4,%esp
  101b7d:	e8 30 e7 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101b82:	05 ce cd 00 00       	add    $0xcdce,%eax
    cprintf("%d ticks\n",TICK_NUM);
  101b87:	83 ec 08             	sub    $0x8,%esp
  101b8a:	6a 64                	push   $0x64
  101b8c:	8d 90 bf 53 ff ff    	lea    -0xac41(%eax),%edx
  101b92:	52                   	push   %edx
  101b93:	89 c3                	mov    %eax,%ebx
  101b95:	e8 8f e7 ff ff       	call   100329 <cprintf>
  101b9a:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101b9d:	90                   	nop
  101b9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101ba1:	c9                   	leave  
  101ba2:	c3                   	ret    

00101ba3 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101ba3:	55                   	push   %ebp
  101ba4:	89 e5                	mov    %esp,%ebp
  101ba6:	83 ec 10             	sub    $0x10,%esp
  101ba9:	e8 04 e7 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101bae:	05 a2 cd 00 00       	add    $0xcda2,%eax
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for(i = 0; i < 256; i++)
  101bb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101bba:	e9 c7 00 00 00       	jmp    101c86 <idt_init+0xe3>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101bbf:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101bc5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101bc8:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101bcb:	89 d1                	mov    %edx,%ecx
  101bcd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bd0:	66 89 8c d0 f0 07 00 	mov    %cx,0x7f0(%eax,%edx,8)
  101bd7:	00 
  101bd8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bdb:	66 c7 84 d0 f2 07 00 	movw   $0x8,0x7f2(%eax,%edx,8)
  101be2:	00 08 00 
  101be5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101be8:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bef:	00 
  101bf0:	83 e1 e0             	and    $0xffffffe0,%ecx
  101bf3:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bfa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bfd:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101c04:	00 
  101c05:	83 e1 1f             	and    $0x1f,%ecx
  101c08:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101c0f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c12:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c19:	00 
  101c1a:	83 e1 f0             	and    $0xfffffff0,%ecx
  101c1d:	83 c9 0e             	or     $0xe,%ecx
  101c20:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c2a:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c31:	00 
  101c32:	83 e1 ef             	and    $0xffffffef,%ecx
  101c35:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c3c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c3f:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c46:	00 
  101c47:	83 e1 9f             	and    $0xffffff9f,%ecx
  101c4a:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c51:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c54:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c5b:	00 
  101c5c:	83 c9 80             	or     $0xffffff80,%ecx
  101c5f:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c66:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101c6c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101c6f:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101c72:	c1 ea 10             	shr    $0x10,%edx
  101c75:	89 d1                	mov    %edx,%ecx
  101c77:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c7a:	66 89 8c d0 f6 07 00 	mov    %cx,0x7f6(%eax,%edx,8)
  101c81:	00 
    for(i = 0; i < 256; i++)
  101c82:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101c86:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  101c8d:	0f 8e 2c ff ff ff    	jle    101bbf <idt_init+0x1c>
    SETGATE(idt[T_SYSCALL], 1, GD_KTEXT, __vectors[T_SYSCALL], DPL_USER);
  101c93:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101c99:	8b 92 00 02 00 00    	mov    0x200(%edx),%edx
  101c9f:	66 89 90 f0 0b 00 00 	mov    %dx,0xbf0(%eax)
  101ca6:	66 c7 80 f2 0b 00 00 	movw   $0x8,0xbf2(%eax)
  101cad:	08 00 
  101caf:	0f b6 90 f4 0b 00 00 	movzbl 0xbf4(%eax),%edx
  101cb6:	83 e2 e0             	and    $0xffffffe0,%edx
  101cb9:	88 90 f4 0b 00 00    	mov    %dl,0xbf4(%eax)
  101cbf:	0f b6 90 f4 0b 00 00 	movzbl 0xbf4(%eax),%edx
  101cc6:	83 e2 1f             	and    $0x1f,%edx
  101cc9:	88 90 f4 0b 00 00    	mov    %dl,0xbf4(%eax)
  101ccf:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101cd6:	83 ca 0f             	or     $0xf,%edx
  101cd9:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cdf:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101ce6:	83 e2 ef             	and    $0xffffffef,%edx
  101ce9:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cef:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101cf6:	83 ca 60             	or     $0x60,%edx
  101cf9:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cff:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101d06:	83 ca 80             	or     $0xffffff80,%edx
  101d09:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101d0f:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101d15:	8b 92 00 02 00 00    	mov    0x200(%edx),%edx
  101d1b:	c1 ea 10             	shr    $0x10,%edx
  101d1e:	66 89 90 f6 0b 00 00 	mov    %dx,0xbf6(%eax)
  101d25:	8d 80 50 00 00 00    	lea    0x50(%eax),%eax
  101d2b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101d2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101d31:	0f 01 18             	lidtl  (%eax)
    lidt(&idt_pd);
    return;
  101d34:	90                   	nop
}
  101d35:	c9                   	leave  
  101d36:	c3                   	ret    

00101d37 <trapname>:

static const char *
trapname(int trapno) {
  101d37:	55                   	push   %ebp
  101d38:	89 e5                	mov    %esp,%ebp
  101d3a:	e8 73 e5 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101d3f:	05 11 cc 00 00       	add    $0xcc11,%eax
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101d44:	8b 55 08             	mov    0x8(%ebp),%edx
  101d47:	83 fa 13             	cmp    $0x13,%edx
  101d4a:	77 0c                	ja     101d58 <trapname+0x21>
        return excnames[trapno];
  101d4c:	8b 55 08             	mov    0x8(%ebp),%edx
  101d4f:	8b 84 90 f0 00 00 00 	mov    0xf0(%eax,%edx,4),%eax
  101d56:	eb 1a                	jmp    101d72 <trapname+0x3b>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101d58:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101d5c:	7e 0e                	jle    101d6c <trapname+0x35>
  101d5e:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101d62:	7f 08                	jg     101d6c <trapname+0x35>
        return "Hardware Interrupt";
  101d64:	8d 80 c9 53 ff ff    	lea    -0xac37(%eax),%eax
  101d6a:	eb 06                	jmp    101d72 <trapname+0x3b>
    }
    return "(unknown trap)";
  101d6c:	8d 80 dc 53 ff ff    	lea    -0xac24(%eax),%eax
}
  101d72:	5d                   	pop    %ebp
  101d73:	c3                   	ret    

00101d74 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101d74:	55                   	push   %ebp
  101d75:	89 e5                	mov    %esp,%ebp
  101d77:	e8 36 e5 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  101d7c:	05 d4 cb 00 00       	add    $0xcbd4,%eax
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101d81:	8b 45 08             	mov    0x8(%ebp),%eax
  101d84:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d88:	66 83 f8 08          	cmp    $0x8,%ax
  101d8c:	0f 94 c0             	sete   %al
  101d8f:	0f b6 c0             	movzbl %al,%eax
}
  101d92:	5d                   	pop    %ebp
  101d93:	c3                   	ret    

00101d94 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101d94:	55                   	push   %ebp
  101d95:	89 e5                	mov    %esp,%ebp
  101d97:	53                   	push   %ebx
  101d98:	83 ec 14             	sub    $0x14,%esp
  101d9b:	e8 16 e5 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101da0:	81 c3 b0 cb 00 00    	add    $0xcbb0,%ebx
    cprintf("trapframe at %p\n", tf);
  101da6:	83 ec 08             	sub    $0x8,%esp
  101da9:	ff 75 08             	pushl  0x8(%ebp)
  101dac:	8d 83 1d 54 ff ff    	lea    -0xabe3(%ebx),%eax
  101db2:	50                   	push   %eax
  101db3:	e8 71 e5 ff ff       	call   100329 <cprintf>
  101db8:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dbe:	83 ec 0c             	sub    $0xc,%esp
  101dc1:	50                   	push   %eax
  101dc2:	e8 d3 01 00 00       	call   101f9a <print_regs>
  101dc7:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101dca:	8b 45 08             	mov    0x8(%ebp),%eax
  101dcd:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101dd1:	0f b7 c0             	movzwl %ax,%eax
  101dd4:	83 ec 08             	sub    $0x8,%esp
  101dd7:	50                   	push   %eax
  101dd8:	8d 83 2e 54 ff ff    	lea    -0xabd2(%ebx),%eax
  101dde:	50                   	push   %eax
  101ddf:	e8 45 e5 ff ff       	call   100329 <cprintf>
  101de4:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101de7:	8b 45 08             	mov    0x8(%ebp),%eax
  101dea:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101dee:	0f b7 c0             	movzwl %ax,%eax
  101df1:	83 ec 08             	sub    $0x8,%esp
  101df4:	50                   	push   %eax
  101df5:	8d 83 41 54 ff ff    	lea    -0xabbf(%ebx),%eax
  101dfb:	50                   	push   %eax
  101dfc:	e8 28 e5 ff ff       	call   100329 <cprintf>
  101e01:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101e04:	8b 45 08             	mov    0x8(%ebp),%eax
  101e07:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101e0b:	0f b7 c0             	movzwl %ax,%eax
  101e0e:	83 ec 08             	sub    $0x8,%esp
  101e11:	50                   	push   %eax
  101e12:	8d 83 54 54 ff ff    	lea    -0xabac(%ebx),%eax
  101e18:	50                   	push   %eax
  101e19:	e8 0b e5 ff ff       	call   100329 <cprintf>
  101e1e:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101e21:	8b 45 08             	mov    0x8(%ebp),%eax
  101e24:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101e28:	0f b7 c0             	movzwl %ax,%eax
  101e2b:	83 ec 08             	sub    $0x8,%esp
  101e2e:	50                   	push   %eax
  101e2f:	8d 83 67 54 ff ff    	lea    -0xab99(%ebx),%eax
  101e35:	50                   	push   %eax
  101e36:	e8 ee e4 ff ff       	call   100329 <cprintf>
  101e3b:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e41:	8b 40 30             	mov    0x30(%eax),%eax
  101e44:	83 ec 0c             	sub    $0xc,%esp
  101e47:	50                   	push   %eax
  101e48:	e8 ea fe ff ff       	call   101d37 <trapname>
  101e4d:	83 c4 10             	add    $0x10,%esp
  101e50:	89 c2                	mov    %eax,%edx
  101e52:	8b 45 08             	mov    0x8(%ebp),%eax
  101e55:	8b 40 30             	mov    0x30(%eax),%eax
  101e58:	83 ec 04             	sub    $0x4,%esp
  101e5b:	52                   	push   %edx
  101e5c:	50                   	push   %eax
  101e5d:	8d 83 7a 54 ff ff    	lea    -0xab86(%ebx),%eax
  101e63:	50                   	push   %eax
  101e64:	e8 c0 e4 ff ff       	call   100329 <cprintf>
  101e69:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6f:	8b 40 34             	mov    0x34(%eax),%eax
  101e72:	83 ec 08             	sub    $0x8,%esp
  101e75:	50                   	push   %eax
  101e76:	8d 83 8c 54 ff ff    	lea    -0xab74(%ebx),%eax
  101e7c:	50                   	push   %eax
  101e7d:	e8 a7 e4 ff ff       	call   100329 <cprintf>
  101e82:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101e85:	8b 45 08             	mov    0x8(%ebp),%eax
  101e88:	8b 40 38             	mov    0x38(%eax),%eax
  101e8b:	83 ec 08             	sub    $0x8,%esp
  101e8e:	50                   	push   %eax
  101e8f:	8d 83 9b 54 ff ff    	lea    -0xab65(%ebx),%eax
  101e95:	50                   	push   %eax
  101e96:	e8 8e e4 ff ff       	call   100329 <cprintf>
  101e9b:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ea5:	0f b7 c0             	movzwl %ax,%eax
  101ea8:	83 ec 08             	sub    $0x8,%esp
  101eab:	50                   	push   %eax
  101eac:	8d 83 aa 54 ff ff    	lea    -0xab56(%ebx),%eax
  101eb2:	50                   	push   %eax
  101eb3:	e8 71 e4 ff ff       	call   100329 <cprintf>
  101eb8:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebe:	8b 40 40             	mov    0x40(%eax),%eax
  101ec1:	83 ec 08             	sub    $0x8,%esp
  101ec4:	50                   	push   %eax
  101ec5:	8d 83 bd 54 ff ff    	lea    -0xab43(%ebx),%eax
  101ecb:	50                   	push   %eax
  101ecc:	e8 58 e4 ff ff       	call   100329 <cprintf>
  101ed1:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ed4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101edb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ee2:	eb 41                	jmp    101f25 <print_trapframe+0x191>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee7:	8b 50 40             	mov    0x40(%eax),%edx
  101eea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101eed:	21 d0                	and    %edx,%eax
  101eef:	85 c0                	test   %eax,%eax
  101ef1:	74 2b                	je     101f1e <print_trapframe+0x18a>
  101ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ef6:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101efd:	85 c0                	test   %eax,%eax
  101eff:	74 1d                	je     101f1e <print_trapframe+0x18a>
            cprintf("%s,", IA32flags[i]);
  101f01:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f04:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101f0b:	83 ec 08             	sub    $0x8,%esp
  101f0e:	50                   	push   %eax
  101f0f:	8d 83 cc 54 ff ff    	lea    -0xab34(%ebx),%eax
  101f15:	50                   	push   %eax
  101f16:	e8 0e e4 ff ff       	call   100329 <cprintf>
  101f1b:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101f1e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101f22:	d1 65 f0             	shll   -0x10(%ebp)
  101f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f28:	83 f8 17             	cmp    $0x17,%eax
  101f2b:	76 b7                	jbe    101ee4 <print_trapframe+0x150>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f30:	8b 40 40             	mov    0x40(%eax),%eax
  101f33:	c1 e8 0c             	shr    $0xc,%eax
  101f36:	83 e0 03             	and    $0x3,%eax
  101f39:	83 ec 08             	sub    $0x8,%esp
  101f3c:	50                   	push   %eax
  101f3d:	8d 83 d0 54 ff ff    	lea    -0xab30(%ebx),%eax
  101f43:	50                   	push   %eax
  101f44:	e8 e0 e3 ff ff       	call   100329 <cprintf>
  101f49:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101f4c:	83 ec 0c             	sub    $0xc,%esp
  101f4f:	ff 75 08             	pushl  0x8(%ebp)
  101f52:	e8 1d fe ff ff       	call   101d74 <trap_in_kernel>
  101f57:	83 c4 10             	add    $0x10,%esp
  101f5a:	85 c0                	test   %eax,%eax
  101f5c:	75 36                	jne    101f94 <print_trapframe+0x200>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f61:	8b 40 44             	mov    0x44(%eax),%eax
  101f64:	83 ec 08             	sub    $0x8,%esp
  101f67:	50                   	push   %eax
  101f68:	8d 83 d9 54 ff ff    	lea    -0xab27(%ebx),%eax
  101f6e:	50                   	push   %eax
  101f6f:	e8 b5 e3 ff ff       	call   100329 <cprintf>
  101f74:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101f77:	8b 45 08             	mov    0x8(%ebp),%eax
  101f7a:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101f7e:	0f b7 c0             	movzwl %ax,%eax
  101f81:	83 ec 08             	sub    $0x8,%esp
  101f84:	50                   	push   %eax
  101f85:	8d 83 e8 54 ff ff    	lea    -0xab18(%ebx),%eax
  101f8b:	50                   	push   %eax
  101f8c:	e8 98 e3 ff ff       	call   100329 <cprintf>
  101f91:	83 c4 10             	add    $0x10,%esp
    }
}
  101f94:	90                   	nop
  101f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f98:	c9                   	leave  
  101f99:	c3                   	ret    

00101f9a <print_regs>:

void
print_regs(struct pushregs *regs) {
  101f9a:	55                   	push   %ebp
  101f9b:	89 e5                	mov    %esp,%ebp
  101f9d:	53                   	push   %ebx
  101f9e:	83 ec 04             	sub    $0x4,%esp
  101fa1:	e8 10 e3 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  101fa6:	81 c3 aa c9 00 00    	add    $0xc9aa,%ebx
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101fac:	8b 45 08             	mov    0x8(%ebp),%eax
  101faf:	8b 00                	mov    (%eax),%eax
  101fb1:	83 ec 08             	sub    $0x8,%esp
  101fb4:	50                   	push   %eax
  101fb5:	8d 83 fb 54 ff ff    	lea    -0xab05(%ebx),%eax
  101fbb:	50                   	push   %eax
  101fbc:	e8 68 e3 ff ff       	call   100329 <cprintf>
  101fc1:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  101fc7:	8b 40 04             	mov    0x4(%eax),%eax
  101fca:	83 ec 08             	sub    $0x8,%esp
  101fcd:	50                   	push   %eax
  101fce:	8d 83 0a 55 ff ff    	lea    -0xaaf6(%ebx),%eax
  101fd4:	50                   	push   %eax
  101fd5:	e8 4f e3 ff ff       	call   100329 <cprintf>
  101fda:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  101fe0:	8b 40 08             	mov    0x8(%eax),%eax
  101fe3:	83 ec 08             	sub    $0x8,%esp
  101fe6:	50                   	push   %eax
  101fe7:	8d 83 19 55 ff ff    	lea    -0xaae7(%ebx),%eax
  101fed:	50                   	push   %eax
  101fee:	e8 36 e3 ff ff       	call   100329 <cprintf>
  101ff3:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  101ff9:	8b 40 0c             	mov    0xc(%eax),%eax
  101ffc:	83 ec 08             	sub    $0x8,%esp
  101fff:	50                   	push   %eax
  102000:	8d 83 28 55 ff ff    	lea    -0xaad8(%ebx),%eax
  102006:	50                   	push   %eax
  102007:	e8 1d e3 ff ff       	call   100329 <cprintf>
  10200c:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  10200f:	8b 45 08             	mov    0x8(%ebp),%eax
  102012:	8b 40 10             	mov    0x10(%eax),%eax
  102015:	83 ec 08             	sub    $0x8,%esp
  102018:	50                   	push   %eax
  102019:	8d 83 37 55 ff ff    	lea    -0xaac9(%ebx),%eax
  10201f:	50                   	push   %eax
  102020:	e8 04 e3 ff ff       	call   100329 <cprintf>
  102025:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  102028:	8b 45 08             	mov    0x8(%ebp),%eax
  10202b:	8b 40 14             	mov    0x14(%eax),%eax
  10202e:	83 ec 08             	sub    $0x8,%esp
  102031:	50                   	push   %eax
  102032:	8d 83 46 55 ff ff    	lea    -0xaaba(%ebx),%eax
  102038:	50                   	push   %eax
  102039:	e8 eb e2 ff ff       	call   100329 <cprintf>
  10203e:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  102041:	8b 45 08             	mov    0x8(%ebp),%eax
  102044:	8b 40 18             	mov    0x18(%eax),%eax
  102047:	83 ec 08             	sub    $0x8,%esp
  10204a:	50                   	push   %eax
  10204b:	8d 83 55 55 ff ff    	lea    -0xaaab(%ebx),%eax
  102051:	50                   	push   %eax
  102052:	e8 d2 e2 ff ff       	call   100329 <cprintf>
  102057:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  10205a:	8b 45 08             	mov    0x8(%ebp),%eax
  10205d:	8b 40 1c             	mov    0x1c(%eax),%eax
  102060:	83 ec 08             	sub    $0x8,%esp
  102063:	50                   	push   %eax
  102064:	8d 83 64 55 ff ff    	lea    -0xaa9c(%ebx),%eax
  10206a:	50                   	push   %eax
  10206b:	e8 b9 e2 ff ff       	call   100329 <cprintf>
  102070:	83 c4 10             	add    $0x10,%esp
}
  102073:	90                   	nop
  102074:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  102077:	c9                   	leave  
  102078:	c3                   	ret    

00102079 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  102079:	55                   	push   %ebp
  10207a:	89 e5                	mov    %esp,%ebp
  10207c:	53                   	push   %ebx
  10207d:	83 ec 14             	sub    $0x14,%esp
  102080:	e8 31 e2 ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  102085:	81 c3 cb c8 00 00    	add    $0xc8cb,%ebx
    char c;

    switch (tf->tf_trapno) {
  10208b:	8b 45 08             	mov    0x8(%ebp),%eax
  10208e:	8b 40 30             	mov    0x30(%eax),%eax
  102091:	83 f8 2f             	cmp    $0x2f,%eax
  102094:	77 21                	ja     1020b7 <trap_dispatch+0x3e>
  102096:	83 f8 2e             	cmp    $0x2e,%eax
  102099:	0f 83 0c 01 00 00    	jae    1021ab <trap_dispatch+0x132>
  10209f:	83 f8 21             	cmp    $0x21,%eax
  1020a2:	0f 84 88 00 00 00    	je     102130 <trap_dispatch+0xb7>
  1020a8:	83 f8 24             	cmp    $0x24,%eax
  1020ab:	74 5d                	je     10210a <trap_dispatch+0x91>
  1020ad:	83 f8 20             	cmp    $0x20,%eax
  1020b0:	74 16                	je     1020c8 <trap_dispatch+0x4f>
  1020b2:	e9 ba 00 00 00       	jmp    102171 <trap_dispatch+0xf8>
  1020b7:	83 e8 78             	sub    $0x78,%eax
  1020ba:	83 f8 01             	cmp    $0x1,%eax
  1020bd:	0f 87 ae 00 00 00    	ja     102171 <trap_dispatch+0xf8>
  1020c3:	e9 8e 00 00 00       	jmp    102156 <trap_dispatch+0xdd>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  1020c8:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  1020ce:	8b 00                	mov    (%eax),%eax
  1020d0:	8d 50 01             	lea    0x1(%eax),%edx
  1020d3:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  1020d9:	89 10                	mov    %edx,(%eax)
        if(ticks % TICK_NUM == 0)
  1020db:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  1020e1:	8b 08                	mov    (%eax),%ecx
  1020e3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  1020e8:	89 c8                	mov    %ecx,%eax
  1020ea:	f7 e2                	mul    %edx
  1020ec:	89 d0                	mov    %edx,%eax
  1020ee:	c1 e8 05             	shr    $0x5,%eax
  1020f1:	6b c0 64             	imul   $0x64,%eax,%eax
  1020f4:	29 c1                	sub    %eax,%ecx
  1020f6:	89 c8                	mov    %ecx,%eax
  1020f8:	85 c0                	test   %eax,%eax
  1020fa:	0f 85 ae 00 00 00    	jne    1021ae <trap_dispatch+0x135>
        {
            print_ticks();
  102100:	e8 71 fa ff ff       	call   101b76 <print_ticks>
        }

        break;
  102105:	e9 a4 00 00 00       	jmp    1021ae <trap_dispatch+0x135>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  10210a:	e8 eb f7 ff ff       	call   1018fa <cons_getc>
  10210f:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  102112:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  102116:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10211a:	83 ec 04             	sub    $0x4,%esp
  10211d:	52                   	push   %edx
  10211e:	50                   	push   %eax
  10211f:	8d 83 73 55 ff ff    	lea    -0xaa8d(%ebx),%eax
  102125:	50                   	push   %eax
  102126:	e8 fe e1 ff ff       	call   100329 <cprintf>
  10212b:	83 c4 10             	add    $0x10,%esp
        break;
  10212e:	eb 7f                	jmp    1021af <trap_dispatch+0x136>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  102130:	e8 c5 f7 ff ff       	call   1018fa <cons_getc>
  102135:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  102138:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  10213c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  102140:	83 ec 04             	sub    $0x4,%esp
  102143:	52                   	push   %edx
  102144:	50                   	push   %eax
  102145:	8d 83 85 55 ff ff    	lea    -0xaa7b(%ebx),%eax
  10214b:	50                   	push   %eax
  10214c:	e8 d8 e1 ff ff       	call   100329 <cprintf>
  102151:	83 c4 10             	add    $0x10,%esp
        break;
  102154:	eb 59                	jmp    1021af <trap_dispatch+0x136>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  102156:	83 ec 04             	sub    $0x4,%esp
  102159:	8d 83 94 55 ff ff    	lea    -0xaa6c(%ebx),%eax
  10215f:	50                   	push   %eax
  102160:	68 af 00 00 00       	push   $0xaf
  102165:	8d 83 a4 55 ff ff    	lea    -0xaa5c(%ebx),%eax
  10216b:	50                   	push   %eax
  10216c:	e8 68 e3 ff ff       	call   1004d9 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  102171:	8b 45 08             	mov    0x8(%ebp),%eax
  102174:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  102178:	0f b7 c0             	movzwl %ax,%eax
  10217b:	83 e0 03             	and    $0x3,%eax
  10217e:	85 c0                	test   %eax,%eax
  102180:	75 2d                	jne    1021af <trap_dispatch+0x136>
            print_trapframe(tf);
  102182:	83 ec 0c             	sub    $0xc,%esp
  102185:	ff 75 08             	pushl  0x8(%ebp)
  102188:	e8 07 fc ff ff       	call   101d94 <print_trapframe>
  10218d:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  102190:	83 ec 04             	sub    $0x4,%esp
  102193:	8d 83 b5 55 ff ff    	lea    -0xaa4b(%ebx),%eax
  102199:	50                   	push   %eax
  10219a:	68 b9 00 00 00       	push   $0xb9
  10219f:	8d 83 a4 55 ff ff    	lea    -0xaa5c(%ebx),%eax
  1021a5:	50                   	push   %eax
  1021a6:	e8 2e e3 ff ff       	call   1004d9 <__panic>
        break;
  1021ab:	90                   	nop
  1021ac:	eb 01                	jmp    1021af <trap_dispatch+0x136>
        break;
  1021ae:	90                   	nop
        }
    }
}
  1021af:	90                   	nop
  1021b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1021b3:	c9                   	leave  
  1021b4:	c3                   	ret    

001021b5 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  1021b5:	55                   	push   %ebp
  1021b6:	89 e5                	mov    %esp,%ebp
  1021b8:	83 ec 08             	sub    $0x8,%esp
  1021bb:	e8 f2 e0 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1021c0:	05 90 c7 00 00       	add    $0xc790,%eax
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  1021c5:	83 ec 0c             	sub    $0xc,%esp
  1021c8:	ff 75 08             	pushl  0x8(%ebp)
  1021cb:	e8 a9 fe ff ff       	call   102079 <trap_dispatch>
  1021d0:	83 c4 10             	add    $0x10,%esp
}
  1021d3:	90                   	nop
  1021d4:	c9                   	leave  
  1021d5:	c3                   	ret    

001021d6 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  1021d6:	6a 00                	push   $0x0
  pushl $0
  1021d8:	6a 00                	push   $0x0
  jmp __alltraps
  1021da:	e9 69 0a 00 00       	jmp    102c48 <__alltraps>

001021df <vector1>:
.globl vector1
vector1:
  pushl $0
  1021df:	6a 00                	push   $0x0
  pushl $1
  1021e1:	6a 01                	push   $0x1
  jmp __alltraps
  1021e3:	e9 60 0a 00 00       	jmp    102c48 <__alltraps>

001021e8 <vector2>:
.globl vector2
vector2:
  pushl $0
  1021e8:	6a 00                	push   $0x0
  pushl $2
  1021ea:	6a 02                	push   $0x2
  jmp __alltraps
  1021ec:	e9 57 0a 00 00       	jmp    102c48 <__alltraps>

001021f1 <vector3>:
.globl vector3
vector3:
  pushl $0
  1021f1:	6a 00                	push   $0x0
  pushl $3
  1021f3:	6a 03                	push   $0x3
  jmp __alltraps
  1021f5:	e9 4e 0a 00 00       	jmp    102c48 <__alltraps>

001021fa <vector4>:
.globl vector4
vector4:
  pushl $0
  1021fa:	6a 00                	push   $0x0
  pushl $4
  1021fc:	6a 04                	push   $0x4
  jmp __alltraps
  1021fe:	e9 45 0a 00 00       	jmp    102c48 <__alltraps>

00102203 <vector5>:
.globl vector5
vector5:
  pushl $0
  102203:	6a 00                	push   $0x0
  pushl $5
  102205:	6a 05                	push   $0x5
  jmp __alltraps
  102207:	e9 3c 0a 00 00       	jmp    102c48 <__alltraps>

0010220c <vector6>:
.globl vector6
vector6:
  pushl $0
  10220c:	6a 00                	push   $0x0
  pushl $6
  10220e:	6a 06                	push   $0x6
  jmp __alltraps
  102210:	e9 33 0a 00 00       	jmp    102c48 <__alltraps>

00102215 <vector7>:
.globl vector7
vector7:
  pushl $0
  102215:	6a 00                	push   $0x0
  pushl $7
  102217:	6a 07                	push   $0x7
  jmp __alltraps
  102219:	e9 2a 0a 00 00       	jmp    102c48 <__alltraps>

0010221e <vector8>:
.globl vector8
vector8:
  pushl $8
  10221e:	6a 08                	push   $0x8
  jmp __alltraps
  102220:	e9 23 0a 00 00       	jmp    102c48 <__alltraps>

00102225 <vector9>:
.globl vector9
vector9:
  pushl $0
  102225:	6a 00                	push   $0x0
  pushl $9
  102227:	6a 09                	push   $0x9
  jmp __alltraps
  102229:	e9 1a 0a 00 00       	jmp    102c48 <__alltraps>

0010222e <vector10>:
.globl vector10
vector10:
  pushl $10
  10222e:	6a 0a                	push   $0xa
  jmp __alltraps
  102230:	e9 13 0a 00 00       	jmp    102c48 <__alltraps>

00102235 <vector11>:
.globl vector11
vector11:
  pushl $11
  102235:	6a 0b                	push   $0xb
  jmp __alltraps
  102237:	e9 0c 0a 00 00       	jmp    102c48 <__alltraps>

0010223c <vector12>:
.globl vector12
vector12:
  pushl $12
  10223c:	6a 0c                	push   $0xc
  jmp __alltraps
  10223e:	e9 05 0a 00 00       	jmp    102c48 <__alltraps>

00102243 <vector13>:
.globl vector13
vector13:
  pushl $13
  102243:	6a 0d                	push   $0xd
  jmp __alltraps
  102245:	e9 fe 09 00 00       	jmp    102c48 <__alltraps>

0010224a <vector14>:
.globl vector14
vector14:
  pushl $14
  10224a:	6a 0e                	push   $0xe
  jmp __alltraps
  10224c:	e9 f7 09 00 00       	jmp    102c48 <__alltraps>

00102251 <vector15>:
.globl vector15
vector15:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $15
  102253:	6a 0f                	push   $0xf
  jmp __alltraps
  102255:	e9 ee 09 00 00       	jmp    102c48 <__alltraps>

0010225a <vector16>:
.globl vector16
vector16:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $16
  10225c:	6a 10                	push   $0x10
  jmp __alltraps
  10225e:	e9 e5 09 00 00       	jmp    102c48 <__alltraps>

00102263 <vector17>:
.globl vector17
vector17:
  pushl $17
  102263:	6a 11                	push   $0x11
  jmp __alltraps
  102265:	e9 de 09 00 00       	jmp    102c48 <__alltraps>

0010226a <vector18>:
.globl vector18
vector18:
  pushl $0
  10226a:	6a 00                	push   $0x0
  pushl $18
  10226c:	6a 12                	push   $0x12
  jmp __alltraps
  10226e:	e9 d5 09 00 00       	jmp    102c48 <__alltraps>

00102273 <vector19>:
.globl vector19
vector19:
  pushl $0
  102273:	6a 00                	push   $0x0
  pushl $19
  102275:	6a 13                	push   $0x13
  jmp __alltraps
  102277:	e9 cc 09 00 00       	jmp    102c48 <__alltraps>

0010227c <vector20>:
.globl vector20
vector20:
  pushl $0
  10227c:	6a 00                	push   $0x0
  pushl $20
  10227e:	6a 14                	push   $0x14
  jmp __alltraps
  102280:	e9 c3 09 00 00       	jmp    102c48 <__alltraps>

00102285 <vector21>:
.globl vector21
vector21:
  pushl $0
  102285:	6a 00                	push   $0x0
  pushl $21
  102287:	6a 15                	push   $0x15
  jmp __alltraps
  102289:	e9 ba 09 00 00       	jmp    102c48 <__alltraps>

0010228e <vector22>:
.globl vector22
vector22:
  pushl $0
  10228e:	6a 00                	push   $0x0
  pushl $22
  102290:	6a 16                	push   $0x16
  jmp __alltraps
  102292:	e9 b1 09 00 00       	jmp    102c48 <__alltraps>

00102297 <vector23>:
.globl vector23
vector23:
  pushl $0
  102297:	6a 00                	push   $0x0
  pushl $23
  102299:	6a 17                	push   $0x17
  jmp __alltraps
  10229b:	e9 a8 09 00 00       	jmp    102c48 <__alltraps>

001022a0 <vector24>:
.globl vector24
vector24:
  pushl $0
  1022a0:	6a 00                	push   $0x0
  pushl $24
  1022a2:	6a 18                	push   $0x18
  jmp __alltraps
  1022a4:	e9 9f 09 00 00       	jmp    102c48 <__alltraps>

001022a9 <vector25>:
.globl vector25
vector25:
  pushl $0
  1022a9:	6a 00                	push   $0x0
  pushl $25
  1022ab:	6a 19                	push   $0x19
  jmp __alltraps
  1022ad:	e9 96 09 00 00       	jmp    102c48 <__alltraps>

001022b2 <vector26>:
.globl vector26
vector26:
  pushl $0
  1022b2:	6a 00                	push   $0x0
  pushl $26
  1022b4:	6a 1a                	push   $0x1a
  jmp __alltraps
  1022b6:	e9 8d 09 00 00       	jmp    102c48 <__alltraps>

001022bb <vector27>:
.globl vector27
vector27:
  pushl $0
  1022bb:	6a 00                	push   $0x0
  pushl $27
  1022bd:	6a 1b                	push   $0x1b
  jmp __alltraps
  1022bf:	e9 84 09 00 00       	jmp    102c48 <__alltraps>

001022c4 <vector28>:
.globl vector28
vector28:
  pushl $0
  1022c4:	6a 00                	push   $0x0
  pushl $28
  1022c6:	6a 1c                	push   $0x1c
  jmp __alltraps
  1022c8:	e9 7b 09 00 00       	jmp    102c48 <__alltraps>

001022cd <vector29>:
.globl vector29
vector29:
  pushl $0
  1022cd:	6a 00                	push   $0x0
  pushl $29
  1022cf:	6a 1d                	push   $0x1d
  jmp __alltraps
  1022d1:	e9 72 09 00 00       	jmp    102c48 <__alltraps>

001022d6 <vector30>:
.globl vector30
vector30:
  pushl $0
  1022d6:	6a 00                	push   $0x0
  pushl $30
  1022d8:	6a 1e                	push   $0x1e
  jmp __alltraps
  1022da:	e9 69 09 00 00       	jmp    102c48 <__alltraps>

001022df <vector31>:
.globl vector31
vector31:
  pushl $0
  1022df:	6a 00                	push   $0x0
  pushl $31
  1022e1:	6a 1f                	push   $0x1f
  jmp __alltraps
  1022e3:	e9 60 09 00 00       	jmp    102c48 <__alltraps>

001022e8 <vector32>:
.globl vector32
vector32:
  pushl $0
  1022e8:	6a 00                	push   $0x0
  pushl $32
  1022ea:	6a 20                	push   $0x20
  jmp __alltraps
  1022ec:	e9 57 09 00 00       	jmp    102c48 <__alltraps>

001022f1 <vector33>:
.globl vector33
vector33:
  pushl $0
  1022f1:	6a 00                	push   $0x0
  pushl $33
  1022f3:	6a 21                	push   $0x21
  jmp __alltraps
  1022f5:	e9 4e 09 00 00       	jmp    102c48 <__alltraps>

001022fa <vector34>:
.globl vector34
vector34:
  pushl $0
  1022fa:	6a 00                	push   $0x0
  pushl $34
  1022fc:	6a 22                	push   $0x22
  jmp __alltraps
  1022fe:	e9 45 09 00 00       	jmp    102c48 <__alltraps>

00102303 <vector35>:
.globl vector35
vector35:
  pushl $0
  102303:	6a 00                	push   $0x0
  pushl $35
  102305:	6a 23                	push   $0x23
  jmp __alltraps
  102307:	e9 3c 09 00 00       	jmp    102c48 <__alltraps>

0010230c <vector36>:
.globl vector36
vector36:
  pushl $0
  10230c:	6a 00                	push   $0x0
  pushl $36
  10230e:	6a 24                	push   $0x24
  jmp __alltraps
  102310:	e9 33 09 00 00       	jmp    102c48 <__alltraps>

00102315 <vector37>:
.globl vector37
vector37:
  pushl $0
  102315:	6a 00                	push   $0x0
  pushl $37
  102317:	6a 25                	push   $0x25
  jmp __alltraps
  102319:	e9 2a 09 00 00       	jmp    102c48 <__alltraps>

0010231e <vector38>:
.globl vector38
vector38:
  pushl $0
  10231e:	6a 00                	push   $0x0
  pushl $38
  102320:	6a 26                	push   $0x26
  jmp __alltraps
  102322:	e9 21 09 00 00       	jmp    102c48 <__alltraps>

00102327 <vector39>:
.globl vector39
vector39:
  pushl $0
  102327:	6a 00                	push   $0x0
  pushl $39
  102329:	6a 27                	push   $0x27
  jmp __alltraps
  10232b:	e9 18 09 00 00       	jmp    102c48 <__alltraps>

00102330 <vector40>:
.globl vector40
vector40:
  pushl $0
  102330:	6a 00                	push   $0x0
  pushl $40
  102332:	6a 28                	push   $0x28
  jmp __alltraps
  102334:	e9 0f 09 00 00       	jmp    102c48 <__alltraps>

00102339 <vector41>:
.globl vector41
vector41:
  pushl $0
  102339:	6a 00                	push   $0x0
  pushl $41
  10233b:	6a 29                	push   $0x29
  jmp __alltraps
  10233d:	e9 06 09 00 00       	jmp    102c48 <__alltraps>

00102342 <vector42>:
.globl vector42
vector42:
  pushl $0
  102342:	6a 00                	push   $0x0
  pushl $42
  102344:	6a 2a                	push   $0x2a
  jmp __alltraps
  102346:	e9 fd 08 00 00       	jmp    102c48 <__alltraps>

0010234b <vector43>:
.globl vector43
vector43:
  pushl $0
  10234b:	6a 00                	push   $0x0
  pushl $43
  10234d:	6a 2b                	push   $0x2b
  jmp __alltraps
  10234f:	e9 f4 08 00 00       	jmp    102c48 <__alltraps>

00102354 <vector44>:
.globl vector44
vector44:
  pushl $0
  102354:	6a 00                	push   $0x0
  pushl $44
  102356:	6a 2c                	push   $0x2c
  jmp __alltraps
  102358:	e9 eb 08 00 00       	jmp    102c48 <__alltraps>

0010235d <vector45>:
.globl vector45
vector45:
  pushl $0
  10235d:	6a 00                	push   $0x0
  pushl $45
  10235f:	6a 2d                	push   $0x2d
  jmp __alltraps
  102361:	e9 e2 08 00 00       	jmp    102c48 <__alltraps>

00102366 <vector46>:
.globl vector46
vector46:
  pushl $0
  102366:	6a 00                	push   $0x0
  pushl $46
  102368:	6a 2e                	push   $0x2e
  jmp __alltraps
  10236a:	e9 d9 08 00 00       	jmp    102c48 <__alltraps>

0010236f <vector47>:
.globl vector47
vector47:
  pushl $0
  10236f:	6a 00                	push   $0x0
  pushl $47
  102371:	6a 2f                	push   $0x2f
  jmp __alltraps
  102373:	e9 d0 08 00 00       	jmp    102c48 <__alltraps>

00102378 <vector48>:
.globl vector48
vector48:
  pushl $0
  102378:	6a 00                	push   $0x0
  pushl $48
  10237a:	6a 30                	push   $0x30
  jmp __alltraps
  10237c:	e9 c7 08 00 00       	jmp    102c48 <__alltraps>

00102381 <vector49>:
.globl vector49
vector49:
  pushl $0
  102381:	6a 00                	push   $0x0
  pushl $49
  102383:	6a 31                	push   $0x31
  jmp __alltraps
  102385:	e9 be 08 00 00       	jmp    102c48 <__alltraps>

0010238a <vector50>:
.globl vector50
vector50:
  pushl $0
  10238a:	6a 00                	push   $0x0
  pushl $50
  10238c:	6a 32                	push   $0x32
  jmp __alltraps
  10238e:	e9 b5 08 00 00       	jmp    102c48 <__alltraps>

00102393 <vector51>:
.globl vector51
vector51:
  pushl $0
  102393:	6a 00                	push   $0x0
  pushl $51
  102395:	6a 33                	push   $0x33
  jmp __alltraps
  102397:	e9 ac 08 00 00       	jmp    102c48 <__alltraps>

0010239c <vector52>:
.globl vector52
vector52:
  pushl $0
  10239c:	6a 00                	push   $0x0
  pushl $52
  10239e:	6a 34                	push   $0x34
  jmp __alltraps
  1023a0:	e9 a3 08 00 00       	jmp    102c48 <__alltraps>

001023a5 <vector53>:
.globl vector53
vector53:
  pushl $0
  1023a5:	6a 00                	push   $0x0
  pushl $53
  1023a7:	6a 35                	push   $0x35
  jmp __alltraps
  1023a9:	e9 9a 08 00 00       	jmp    102c48 <__alltraps>

001023ae <vector54>:
.globl vector54
vector54:
  pushl $0
  1023ae:	6a 00                	push   $0x0
  pushl $54
  1023b0:	6a 36                	push   $0x36
  jmp __alltraps
  1023b2:	e9 91 08 00 00       	jmp    102c48 <__alltraps>

001023b7 <vector55>:
.globl vector55
vector55:
  pushl $0
  1023b7:	6a 00                	push   $0x0
  pushl $55
  1023b9:	6a 37                	push   $0x37
  jmp __alltraps
  1023bb:	e9 88 08 00 00       	jmp    102c48 <__alltraps>

001023c0 <vector56>:
.globl vector56
vector56:
  pushl $0
  1023c0:	6a 00                	push   $0x0
  pushl $56
  1023c2:	6a 38                	push   $0x38
  jmp __alltraps
  1023c4:	e9 7f 08 00 00       	jmp    102c48 <__alltraps>

001023c9 <vector57>:
.globl vector57
vector57:
  pushl $0
  1023c9:	6a 00                	push   $0x0
  pushl $57
  1023cb:	6a 39                	push   $0x39
  jmp __alltraps
  1023cd:	e9 76 08 00 00       	jmp    102c48 <__alltraps>

001023d2 <vector58>:
.globl vector58
vector58:
  pushl $0
  1023d2:	6a 00                	push   $0x0
  pushl $58
  1023d4:	6a 3a                	push   $0x3a
  jmp __alltraps
  1023d6:	e9 6d 08 00 00       	jmp    102c48 <__alltraps>

001023db <vector59>:
.globl vector59
vector59:
  pushl $0
  1023db:	6a 00                	push   $0x0
  pushl $59
  1023dd:	6a 3b                	push   $0x3b
  jmp __alltraps
  1023df:	e9 64 08 00 00       	jmp    102c48 <__alltraps>

001023e4 <vector60>:
.globl vector60
vector60:
  pushl $0
  1023e4:	6a 00                	push   $0x0
  pushl $60
  1023e6:	6a 3c                	push   $0x3c
  jmp __alltraps
  1023e8:	e9 5b 08 00 00       	jmp    102c48 <__alltraps>

001023ed <vector61>:
.globl vector61
vector61:
  pushl $0
  1023ed:	6a 00                	push   $0x0
  pushl $61
  1023ef:	6a 3d                	push   $0x3d
  jmp __alltraps
  1023f1:	e9 52 08 00 00       	jmp    102c48 <__alltraps>

001023f6 <vector62>:
.globl vector62
vector62:
  pushl $0
  1023f6:	6a 00                	push   $0x0
  pushl $62
  1023f8:	6a 3e                	push   $0x3e
  jmp __alltraps
  1023fa:	e9 49 08 00 00       	jmp    102c48 <__alltraps>

001023ff <vector63>:
.globl vector63
vector63:
  pushl $0
  1023ff:	6a 00                	push   $0x0
  pushl $63
  102401:	6a 3f                	push   $0x3f
  jmp __alltraps
  102403:	e9 40 08 00 00       	jmp    102c48 <__alltraps>

00102408 <vector64>:
.globl vector64
vector64:
  pushl $0
  102408:	6a 00                	push   $0x0
  pushl $64
  10240a:	6a 40                	push   $0x40
  jmp __alltraps
  10240c:	e9 37 08 00 00       	jmp    102c48 <__alltraps>

00102411 <vector65>:
.globl vector65
vector65:
  pushl $0
  102411:	6a 00                	push   $0x0
  pushl $65
  102413:	6a 41                	push   $0x41
  jmp __alltraps
  102415:	e9 2e 08 00 00       	jmp    102c48 <__alltraps>

0010241a <vector66>:
.globl vector66
vector66:
  pushl $0
  10241a:	6a 00                	push   $0x0
  pushl $66
  10241c:	6a 42                	push   $0x42
  jmp __alltraps
  10241e:	e9 25 08 00 00       	jmp    102c48 <__alltraps>

00102423 <vector67>:
.globl vector67
vector67:
  pushl $0
  102423:	6a 00                	push   $0x0
  pushl $67
  102425:	6a 43                	push   $0x43
  jmp __alltraps
  102427:	e9 1c 08 00 00       	jmp    102c48 <__alltraps>

0010242c <vector68>:
.globl vector68
vector68:
  pushl $0
  10242c:	6a 00                	push   $0x0
  pushl $68
  10242e:	6a 44                	push   $0x44
  jmp __alltraps
  102430:	e9 13 08 00 00       	jmp    102c48 <__alltraps>

00102435 <vector69>:
.globl vector69
vector69:
  pushl $0
  102435:	6a 00                	push   $0x0
  pushl $69
  102437:	6a 45                	push   $0x45
  jmp __alltraps
  102439:	e9 0a 08 00 00       	jmp    102c48 <__alltraps>

0010243e <vector70>:
.globl vector70
vector70:
  pushl $0
  10243e:	6a 00                	push   $0x0
  pushl $70
  102440:	6a 46                	push   $0x46
  jmp __alltraps
  102442:	e9 01 08 00 00       	jmp    102c48 <__alltraps>

00102447 <vector71>:
.globl vector71
vector71:
  pushl $0
  102447:	6a 00                	push   $0x0
  pushl $71
  102449:	6a 47                	push   $0x47
  jmp __alltraps
  10244b:	e9 f8 07 00 00       	jmp    102c48 <__alltraps>

00102450 <vector72>:
.globl vector72
vector72:
  pushl $0
  102450:	6a 00                	push   $0x0
  pushl $72
  102452:	6a 48                	push   $0x48
  jmp __alltraps
  102454:	e9 ef 07 00 00       	jmp    102c48 <__alltraps>

00102459 <vector73>:
.globl vector73
vector73:
  pushl $0
  102459:	6a 00                	push   $0x0
  pushl $73
  10245b:	6a 49                	push   $0x49
  jmp __alltraps
  10245d:	e9 e6 07 00 00       	jmp    102c48 <__alltraps>

00102462 <vector74>:
.globl vector74
vector74:
  pushl $0
  102462:	6a 00                	push   $0x0
  pushl $74
  102464:	6a 4a                	push   $0x4a
  jmp __alltraps
  102466:	e9 dd 07 00 00       	jmp    102c48 <__alltraps>

0010246b <vector75>:
.globl vector75
vector75:
  pushl $0
  10246b:	6a 00                	push   $0x0
  pushl $75
  10246d:	6a 4b                	push   $0x4b
  jmp __alltraps
  10246f:	e9 d4 07 00 00       	jmp    102c48 <__alltraps>

00102474 <vector76>:
.globl vector76
vector76:
  pushl $0
  102474:	6a 00                	push   $0x0
  pushl $76
  102476:	6a 4c                	push   $0x4c
  jmp __alltraps
  102478:	e9 cb 07 00 00       	jmp    102c48 <__alltraps>

0010247d <vector77>:
.globl vector77
vector77:
  pushl $0
  10247d:	6a 00                	push   $0x0
  pushl $77
  10247f:	6a 4d                	push   $0x4d
  jmp __alltraps
  102481:	e9 c2 07 00 00       	jmp    102c48 <__alltraps>

00102486 <vector78>:
.globl vector78
vector78:
  pushl $0
  102486:	6a 00                	push   $0x0
  pushl $78
  102488:	6a 4e                	push   $0x4e
  jmp __alltraps
  10248a:	e9 b9 07 00 00       	jmp    102c48 <__alltraps>

0010248f <vector79>:
.globl vector79
vector79:
  pushl $0
  10248f:	6a 00                	push   $0x0
  pushl $79
  102491:	6a 4f                	push   $0x4f
  jmp __alltraps
  102493:	e9 b0 07 00 00       	jmp    102c48 <__alltraps>

00102498 <vector80>:
.globl vector80
vector80:
  pushl $0
  102498:	6a 00                	push   $0x0
  pushl $80
  10249a:	6a 50                	push   $0x50
  jmp __alltraps
  10249c:	e9 a7 07 00 00       	jmp    102c48 <__alltraps>

001024a1 <vector81>:
.globl vector81
vector81:
  pushl $0
  1024a1:	6a 00                	push   $0x0
  pushl $81
  1024a3:	6a 51                	push   $0x51
  jmp __alltraps
  1024a5:	e9 9e 07 00 00       	jmp    102c48 <__alltraps>

001024aa <vector82>:
.globl vector82
vector82:
  pushl $0
  1024aa:	6a 00                	push   $0x0
  pushl $82
  1024ac:	6a 52                	push   $0x52
  jmp __alltraps
  1024ae:	e9 95 07 00 00       	jmp    102c48 <__alltraps>

001024b3 <vector83>:
.globl vector83
vector83:
  pushl $0
  1024b3:	6a 00                	push   $0x0
  pushl $83
  1024b5:	6a 53                	push   $0x53
  jmp __alltraps
  1024b7:	e9 8c 07 00 00       	jmp    102c48 <__alltraps>

001024bc <vector84>:
.globl vector84
vector84:
  pushl $0
  1024bc:	6a 00                	push   $0x0
  pushl $84
  1024be:	6a 54                	push   $0x54
  jmp __alltraps
  1024c0:	e9 83 07 00 00       	jmp    102c48 <__alltraps>

001024c5 <vector85>:
.globl vector85
vector85:
  pushl $0
  1024c5:	6a 00                	push   $0x0
  pushl $85
  1024c7:	6a 55                	push   $0x55
  jmp __alltraps
  1024c9:	e9 7a 07 00 00       	jmp    102c48 <__alltraps>

001024ce <vector86>:
.globl vector86
vector86:
  pushl $0
  1024ce:	6a 00                	push   $0x0
  pushl $86
  1024d0:	6a 56                	push   $0x56
  jmp __alltraps
  1024d2:	e9 71 07 00 00       	jmp    102c48 <__alltraps>

001024d7 <vector87>:
.globl vector87
vector87:
  pushl $0
  1024d7:	6a 00                	push   $0x0
  pushl $87
  1024d9:	6a 57                	push   $0x57
  jmp __alltraps
  1024db:	e9 68 07 00 00       	jmp    102c48 <__alltraps>

001024e0 <vector88>:
.globl vector88
vector88:
  pushl $0
  1024e0:	6a 00                	push   $0x0
  pushl $88
  1024e2:	6a 58                	push   $0x58
  jmp __alltraps
  1024e4:	e9 5f 07 00 00       	jmp    102c48 <__alltraps>

001024e9 <vector89>:
.globl vector89
vector89:
  pushl $0
  1024e9:	6a 00                	push   $0x0
  pushl $89
  1024eb:	6a 59                	push   $0x59
  jmp __alltraps
  1024ed:	e9 56 07 00 00       	jmp    102c48 <__alltraps>

001024f2 <vector90>:
.globl vector90
vector90:
  pushl $0
  1024f2:	6a 00                	push   $0x0
  pushl $90
  1024f4:	6a 5a                	push   $0x5a
  jmp __alltraps
  1024f6:	e9 4d 07 00 00       	jmp    102c48 <__alltraps>

001024fb <vector91>:
.globl vector91
vector91:
  pushl $0
  1024fb:	6a 00                	push   $0x0
  pushl $91
  1024fd:	6a 5b                	push   $0x5b
  jmp __alltraps
  1024ff:	e9 44 07 00 00       	jmp    102c48 <__alltraps>

00102504 <vector92>:
.globl vector92
vector92:
  pushl $0
  102504:	6a 00                	push   $0x0
  pushl $92
  102506:	6a 5c                	push   $0x5c
  jmp __alltraps
  102508:	e9 3b 07 00 00       	jmp    102c48 <__alltraps>

0010250d <vector93>:
.globl vector93
vector93:
  pushl $0
  10250d:	6a 00                	push   $0x0
  pushl $93
  10250f:	6a 5d                	push   $0x5d
  jmp __alltraps
  102511:	e9 32 07 00 00       	jmp    102c48 <__alltraps>

00102516 <vector94>:
.globl vector94
vector94:
  pushl $0
  102516:	6a 00                	push   $0x0
  pushl $94
  102518:	6a 5e                	push   $0x5e
  jmp __alltraps
  10251a:	e9 29 07 00 00       	jmp    102c48 <__alltraps>

0010251f <vector95>:
.globl vector95
vector95:
  pushl $0
  10251f:	6a 00                	push   $0x0
  pushl $95
  102521:	6a 5f                	push   $0x5f
  jmp __alltraps
  102523:	e9 20 07 00 00       	jmp    102c48 <__alltraps>

00102528 <vector96>:
.globl vector96
vector96:
  pushl $0
  102528:	6a 00                	push   $0x0
  pushl $96
  10252a:	6a 60                	push   $0x60
  jmp __alltraps
  10252c:	e9 17 07 00 00       	jmp    102c48 <__alltraps>

00102531 <vector97>:
.globl vector97
vector97:
  pushl $0
  102531:	6a 00                	push   $0x0
  pushl $97
  102533:	6a 61                	push   $0x61
  jmp __alltraps
  102535:	e9 0e 07 00 00       	jmp    102c48 <__alltraps>

0010253a <vector98>:
.globl vector98
vector98:
  pushl $0
  10253a:	6a 00                	push   $0x0
  pushl $98
  10253c:	6a 62                	push   $0x62
  jmp __alltraps
  10253e:	e9 05 07 00 00       	jmp    102c48 <__alltraps>

00102543 <vector99>:
.globl vector99
vector99:
  pushl $0
  102543:	6a 00                	push   $0x0
  pushl $99
  102545:	6a 63                	push   $0x63
  jmp __alltraps
  102547:	e9 fc 06 00 00       	jmp    102c48 <__alltraps>

0010254c <vector100>:
.globl vector100
vector100:
  pushl $0
  10254c:	6a 00                	push   $0x0
  pushl $100
  10254e:	6a 64                	push   $0x64
  jmp __alltraps
  102550:	e9 f3 06 00 00       	jmp    102c48 <__alltraps>

00102555 <vector101>:
.globl vector101
vector101:
  pushl $0
  102555:	6a 00                	push   $0x0
  pushl $101
  102557:	6a 65                	push   $0x65
  jmp __alltraps
  102559:	e9 ea 06 00 00       	jmp    102c48 <__alltraps>

0010255e <vector102>:
.globl vector102
vector102:
  pushl $0
  10255e:	6a 00                	push   $0x0
  pushl $102
  102560:	6a 66                	push   $0x66
  jmp __alltraps
  102562:	e9 e1 06 00 00       	jmp    102c48 <__alltraps>

00102567 <vector103>:
.globl vector103
vector103:
  pushl $0
  102567:	6a 00                	push   $0x0
  pushl $103
  102569:	6a 67                	push   $0x67
  jmp __alltraps
  10256b:	e9 d8 06 00 00       	jmp    102c48 <__alltraps>

00102570 <vector104>:
.globl vector104
vector104:
  pushl $0
  102570:	6a 00                	push   $0x0
  pushl $104
  102572:	6a 68                	push   $0x68
  jmp __alltraps
  102574:	e9 cf 06 00 00       	jmp    102c48 <__alltraps>

00102579 <vector105>:
.globl vector105
vector105:
  pushl $0
  102579:	6a 00                	push   $0x0
  pushl $105
  10257b:	6a 69                	push   $0x69
  jmp __alltraps
  10257d:	e9 c6 06 00 00       	jmp    102c48 <__alltraps>

00102582 <vector106>:
.globl vector106
vector106:
  pushl $0
  102582:	6a 00                	push   $0x0
  pushl $106
  102584:	6a 6a                	push   $0x6a
  jmp __alltraps
  102586:	e9 bd 06 00 00       	jmp    102c48 <__alltraps>

0010258b <vector107>:
.globl vector107
vector107:
  pushl $0
  10258b:	6a 00                	push   $0x0
  pushl $107
  10258d:	6a 6b                	push   $0x6b
  jmp __alltraps
  10258f:	e9 b4 06 00 00       	jmp    102c48 <__alltraps>

00102594 <vector108>:
.globl vector108
vector108:
  pushl $0
  102594:	6a 00                	push   $0x0
  pushl $108
  102596:	6a 6c                	push   $0x6c
  jmp __alltraps
  102598:	e9 ab 06 00 00       	jmp    102c48 <__alltraps>

0010259d <vector109>:
.globl vector109
vector109:
  pushl $0
  10259d:	6a 00                	push   $0x0
  pushl $109
  10259f:	6a 6d                	push   $0x6d
  jmp __alltraps
  1025a1:	e9 a2 06 00 00       	jmp    102c48 <__alltraps>

001025a6 <vector110>:
.globl vector110
vector110:
  pushl $0
  1025a6:	6a 00                	push   $0x0
  pushl $110
  1025a8:	6a 6e                	push   $0x6e
  jmp __alltraps
  1025aa:	e9 99 06 00 00       	jmp    102c48 <__alltraps>

001025af <vector111>:
.globl vector111
vector111:
  pushl $0
  1025af:	6a 00                	push   $0x0
  pushl $111
  1025b1:	6a 6f                	push   $0x6f
  jmp __alltraps
  1025b3:	e9 90 06 00 00       	jmp    102c48 <__alltraps>

001025b8 <vector112>:
.globl vector112
vector112:
  pushl $0
  1025b8:	6a 00                	push   $0x0
  pushl $112
  1025ba:	6a 70                	push   $0x70
  jmp __alltraps
  1025bc:	e9 87 06 00 00       	jmp    102c48 <__alltraps>

001025c1 <vector113>:
.globl vector113
vector113:
  pushl $0
  1025c1:	6a 00                	push   $0x0
  pushl $113
  1025c3:	6a 71                	push   $0x71
  jmp __alltraps
  1025c5:	e9 7e 06 00 00       	jmp    102c48 <__alltraps>

001025ca <vector114>:
.globl vector114
vector114:
  pushl $0
  1025ca:	6a 00                	push   $0x0
  pushl $114
  1025cc:	6a 72                	push   $0x72
  jmp __alltraps
  1025ce:	e9 75 06 00 00       	jmp    102c48 <__alltraps>

001025d3 <vector115>:
.globl vector115
vector115:
  pushl $0
  1025d3:	6a 00                	push   $0x0
  pushl $115
  1025d5:	6a 73                	push   $0x73
  jmp __alltraps
  1025d7:	e9 6c 06 00 00       	jmp    102c48 <__alltraps>

001025dc <vector116>:
.globl vector116
vector116:
  pushl $0
  1025dc:	6a 00                	push   $0x0
  pushl $116
  1025de:	6a 74                	push   $0x74
  jmp __alltraps
  1025e0:	e9 63 06 00 00       	jmp    102c48 <__alltraps>

001025e5 <vector117>:
.globl vector117
vector117:
  pushl $0
  1025e5:	6a 00                	push   $0x0
  pushl $117
  1025e7:	6a 75                	push   $0x75
  jmp __alltraps
  1025e9:	e9 5a 06 00 00       	jmp    102c48 <__alltraps>

001025ee <vector118>:
.globl vector118
vector118:
  pushl $0
  1025ee:	6a 00                	push   $0x0
  pushl $118
  1025f0:	6a 76                	push   $0x76
  jmp __alltraps
  1025f2:	e9 51 06 00 00       	jmp    102c48 <__alltraps>

001025f7 <vector119>:
.globl vector119
vector119:
  pushl $0
  1025f7:	6a 00                	push   $0x0
  pushl $119
  1025f9:	6a 77                	push   $0x77
  jmp __alltraps
  1025fb:	e9 48 06 00 00       	jmp    102c48 <__alltraps>

00102600 <vector120>:
.globl vector120
vector120:
  pushl $0
  102600:	6a 00                	push   $0x0
  pushl $120
  102602:	6a 78                	push   $0x78
  jmp __alltraps
  102604:	e9 3f 06 00 00       	jmp    102c48 <__alltraps>

00102609 <vector121>:
.globl vector121
vector121:
  pushl $0
  102609:	6a 00                	push   $0x0
  pushl $121
  10260b:	6a 79                	push   $0x79
  jmp __alltraps
  10260d:	e9 36 06 00 00       	jmp    102c48 <__alltraps>

00102612 <vector122>:
.globl vector122
vector122:
  pushl $0
  102612:	6a 00                	push   $0x0
  pushl $122
  102614:	6a 7a                	push   $0x7a
  jmp __alltraps
  102616:	e9 2d 06 00 00       	jmp    102c48 <__alltraps>

0010261b <vector123>:
.globl vector123
vector123:
  pushl $0
  10261b:	6a 00                	push   $0x0
  pushl $123
  10261d:	6a 7b                	push   $0x7b
  jmp __alltraps
  10261f:	e9 24 06 00 00       	jmp    102c48 <__alltraps>

00102624 <vector124>:
.globl vector124
vector124:
  pushl $0
  102624:	6a 00                	push   $0x0
  pushl $124
  102626:	6a 7c                	push   $0x7c
  jmp __alltraps
  102628:	e9 1b 06 00 00       	jmp    102c48 <__alltraps>

0010262d <vector125>:
.globl vector125
vector125:
  pushl $0
  10262d:	6a 00                	push   $0x0
  pushl $125
  10262f:	6a 7d                	push   $0x7d
  jmp __alltraps
  102631:	e9 12 06 00 00       	jmp    102c48 <__alltraps>

00102636 <vector126>:
.globl vector126
vector126:
  pushl $0
  102636:	6a 00                	push   $0x0
  pushl $126
  102638:	6a 7e                	push   $0x7e
  jmp __alltraps
  10263a:	e9 09 06 00 00       	jmp    102c48 <__alltraps>

0010263f <vector127>:
.globl vector127
vector127:
  pushl $0
  10263f:	6a 00                	push   $0x0
  pushl $127
  102641:	6a 7f                	push   $0x7f
  jmp __alltraps
  102643:	e9 00 06 00 00       	jmp    102c48 <__alltraps>

00102648 <vector128>:
.globl vector128
vector128:
  pushl $0
  102648:	6a 00                	push   $0x0
  pushl $128
  10264a:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10264f:	e9 f4 05 00 00       	jmp    102c48 <__alltraps>

00102654 <vector129>:
.globl vector129
vector129:
  pushl $0
  102654:	6a 00                	push   $0x0
  pushl $129
  102656:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10265b:	e9 e8 05 00 00       	jmp    102c48 <__alltraps>

00102660 <vector130>:
.globl vector130
vector130:
  pushl $0
  102660:	6a 00                	push   $0x0
  pushl $130
  102662:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102667:	e9 dc 05 00 00       	jmp    102c48 <__alltraps>

0010266c <vector131>:
.globl vector131
vector131:
  pushl $0
  10266c:	6a 00                	push   $0x0
  pushl $131
  10266e:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102673:	e9 d0 05 00 00       	jmp    102c48 <__alltraps>

00102678 <vector132>:
.globl vector132
vector132:
  pushl $0
  102678:	6a 00                	push   $0x0
  pushl $132
  10267a:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10267f:	e9 c4 05 00 00       	jmp    102c48 <__alltraps>

00102684 <vector133>:
.globl vector133
vector133:
  pushl $0
  102684:	6a 00                	push   $0x0
  pushl $133
  102686:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10268b:	e9 b8 05 00 00       	jmp    102c48 <__alltraps>

00102690 <vector134>:
.globl vector134
vector134:
  pushl $0
  102690:	6a 00                	push   $0x0
  pushl $134
  102692:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102697:	e9 ac 05 00 00       	jmp    102c48 <__alltraps>

0010269c <vector135>:
.globl vector135
vector135:
  pushl $0
  10269c:	6a 00                	push   $0x0
  pushl $135
  10269e:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1026a3:	e9 a0 05 00 00       	jmp    102c48 <__alltraps>

001026a8 <vector136>:
.globl vector136
vector136:
  pushl $0
  1026a8:	6a 00                	push   $0x0
  pushl $136
  1026aa:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1026af:	e9 94 05 00 00       	jmp    102c48 <__alltraps>

001026b4 <vector137>:
.globl vector137
vector137:
  pushl $0
  1026b4:	6a 00                	push   $0x0
  pushl $137
  1026b6:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1026bb:	e9 88 05 00 00       	jmp    102c48 <__alltraps>

001026c0 <vector138>:
.globl vector138
vector138:
  pushl $0
  1026c0:	6a 00                	push   $0x0
  pushl $138
  1026c2:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1026c7:	e9 7c 05 00 00       	jmp    102c48 <__alltraps>

001026cc <vector139>:
.globl vector139
vector139:
  pushl $0
  1026cc:	6a 00                	push   $0x0
  pushl $139
  1026ce:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1026d3:	e9 70 05 00 00       	jmp    102c48 <__alltraps>

001026d8 <vector140>:
.globl vector140
vector140:
  pushl $0
  1026d8:	6a 00                	push   $0x0
  pushl $140
  1026da:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1026df:	e9 64 05 00 00       	jmp    102c48 <__alltraps>

001026e4 <vector141>:
.globl vector141
vector141:
  pushl $0
  1026e4:	6a 00                	push   $0x0
  pushl $141
  1026e6:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1026eb:	e9 58 05 00 00       	jmp    102c48 <__alltraps>

001026f0 <vector142>:
.globl vector142
vector142:
  pushl $0
  1026f0:	6a 00                	push   $0x0
  pushl $142
  1026f2:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1026f7:	e9 4c 05 00 00       	jmp    102c48 <__alltraps>

001026fc <vector143>:
.globl vector143
vector143:
  pushl $0
  1026fc:	6a 00                	push   $0x0
  pushl $143
  1026fe:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102703:	e9 40 05 00 00       	jmp    102c48 <__alltraps>

00102708 <vector144>:
.globl vector144
vector144:
  pushl $0
  102708:	6a 00                	push   $0x0
  pushl $144
  10270a:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10270f:	e9 34 05 00 00       	jmp    102c48 <__alltraps>

00102714 <vector145>:
.globl vector145
vector145:
  pushl $0
  102714:	6a 00                	push   $0x0
  pushl $145
  102716:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10271b:	e9 28 05 00 00       	jmp    102c48 <__alltraps>

00102720 <vector146>:
.globl vector146
vector146:
  pushl $0
  102720:	6a 00                	push   $0x0
  pushl $146
  102722:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102727:	e9 1c 05 00 00       	jmp    102c48 <__alltraps>

0010272c <vector147>:
.globl vector147
vector147:
  pushl $0
  10272c:	6a 00                	push   $0x0
  pushl $147
  10272e:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102733:	e9 10 05 00 00       	jmp    102c48 <__alltraps>

00102738 <vector148>:
.globl vector148
vector148:
  pushl $0
  102738:	6a 00                	push   $0x0
  pushl $148
  10273a:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10273f:	e9 04 05 00 00       	jmp    102c48 <__alltraps>

00102744 <vector149>:
.globl vector149
vector149:
  pushl $0
  102744:	6a 00                	push   $0x0
  pushl $149
  102746:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10274b:	e9 f8 04 00 00       	jmp    102c48 <__alltraps>

00102750 <vector150>:
.globl vector150
vector150:
  pushl $0
  102750:	6a 00                	push   $0x0
  pushl $150
  102752:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102757:	e9 ec 04 00 00       	jmp    102c48 <__alltraps>

0010275c <vector151>:
.globl vector151
vector151:
  pushl $0
  10275c:	6a 00                	push   $0x0
  pushl $151
  10275e:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102763:	e9 e0 04 00 00       	jmp    102c48 <__alltraps>

00102768 <vector152>:
.globl vector152
vector152:
  pushl $0
  102768:	6a 00                	push   $0x0
  pushl $152
  10276a:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10276f:	e9 d4 04 00 00       	jmp    102c48 <__alltraps>

00102774 <vector153>:
.globl vector153
vector153:
  pushl $0
  102774:	6a 00                	push   $0x0
  pushl $153
  102776:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10277b:	e9 c8 04 00 00       	jmp    102c48 <__alltraps>

00102780 <vector154>:
.globl vector154
vector154:
  pushl $0
  102780:	6a 00                	push   $0x0
  pushl $154
  102782:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102787:	e9 bc 04 00 00       	jmp    102c48 <__alltraps>

0010278c <vector155>:
.globl vector155
vector155:
  pushl $0
  10278c:	6a 00                	push   $0x0
  pushl $155
  10278e:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102793:	e9 b0 04 00 00       	jmp    102c48 <__alltraps>

00102798 <vector156>:
.globl vector156
vector156:
  pushl $0
  102798:	6a 00                	push   $0x0
  pushl $156
  10279a:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10279f:	e9 a4 04 00 00       	jmp    102c48 <__alltraps>

001027a4 <vector157>:
.globl vector157
vector157:
  pushl $0
  1027a4:	6a 00                	push   $0x0
  pushl $157
  1027a6:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1027ab:	e9 98 04 00 00       	jmp    102c48 <__alltraps>

001027b0 <vector158>:
.globl vector158
vector158:
  pushl $0
  1027b0:	6a 00                	push   $0x0
  pushl $158
  1027b2:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1027b7:	e9 8c 04 00 00       	jmp    102c48 <__alltraps>

001027bc <vector159>:
.globl vector159
vector159:
  pushl $0
  1027bc:	6a 00                	push   $0x0
  pushl $159
  1027be:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1027c3:	e9 80 04 00 00       	jmp    102c48 <__alltraps>

001027c8 <vector160>:
.globl vector160
vector160:
  pushl $0
  1027c8:	6a 00                	push   $0x0
  pushl $160
  1027ca:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1027cf:	e9 74 04 00 00       	jmp    102c48 <__alltraps>

001027d4 <vector161>:
.globl vector161
vector161:
  pushl $0
  1027d4:	6a 00                	push   $0x0
  pushl $161
  1027d6:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1027db:	e9 68 04 00 00       	jmp    102c48 <__alltraps>

001027e0 <vector162>:
.globl vector162
vector162:
  pushl $0
  1027e0:	6a 00                	push   $0x0
  pushl $162
  1027e2:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1027e7:	e9 5c 04 00 00       	jmp    102c48 <__alltraps>

001027ec <vector163>:
.globl vector163
vector163:
  pushl $0
  1027ec:	6a 00                	push   $0x0
  pushl $163
  1027ee:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1027f3:	e9 50 04 00 00       	jmp    102c48 <__alltraps>

001027f8 <vector164>:
.globl vector164
vector164:
  pushl $0
  1027f8:	6a 00                	push   $0x0
  pushl $164
  1027fa:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1027ff:	e9 44 04 00 00       	jmp    102c48 <__alltraps>

00102804 <vector165>:
.globl vector165
vector165:
  pushl $0
  102804:	6a 00                	push   $0x0
  pushl $165
  102806:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10280b:	e9 38 04 00 00       	jmp    102c48 <__alltraps>

00102810 <vector166>:
.globl vector166
vector166:
  pushl $0
  102810:	6a 00                	push   $0x0
  pushl $166
  102812:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102817:	e9 2c 04 00 00       	jmp    102c48 <__alltraps>

0010281c <vector167>:
.globl vector167
vector167:
  pushl $0
  10281c:	6a 00                	push   $0x0
  pushl $167
  10281e:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102823:	e9 20 04 00 00       	jmp    102c48 <__alltraps>

00102828 <vector168>:
.globl vector168
vector168:
  pushl $0
  102828:	6a 00                	push   $0x0
  pushl $168
  10282a:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10282f:	e9 14 04 00 00       	jmp    102c48 <__alltraps>

00102834 <vector169>:
.globl vector169
vector169:
  pushl $0
  102834:	6a 00                	push   $0x0
  pushl $169
  102836:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10283b:	e9 08 04 00 00       	jmp    102c48 <__alltraps>

00102840 <vector170>:
.globl vector170
vector170:
  pushl $0
  102840:	6a 00                	push   $0x0
  pushl $170
  102842:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102847:	e9 fc 03 00 00       	jmp    102c48 <__alltraps>

0010284c <vector171>:
.globl vector171
vector171:
  pushl $0
  10284c:	6a 00                	push   $0x0
  pushl $171
  10284e:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102853:	e9 f0 03 00 00       	jmp    102c48 <__alltraps>

00102858 <vector172>:
.globl vector172
vector172:
  pushl $0
  102858:	6a 00                	push   $0x0
  pushl $172
  10285a:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10285f:	e9 e4 03 00 00       	jmp    102c48 <__alltraps>

00102864 <vector173>:
.globl vector173
vector173:
  pushl $0
  102864:	6a 00                	push   $0x0
  pushl $173
  102866:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10286b:	e9 d8 03 00 00       	jmp    102c48 <__alltraps>

00102870 <vector174>:
.globl vector174
vector174:
  pushl $0
  102870:	6a 00                	push   $0x0
  pushl $174
  102872:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102877:	e9 cc 03 00 00       	jmp    102c48 <__alltraps>

0010287c <vector175>:
.globl vector175
vector175:
  pushl $0
  10287c:	6a 00                	push   $0x0
  pushl $175
  10287e:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102883:	e9 c0 03 00 00       	jmp    102c48 <__alltraps>

00102888 <vector176>:
.globl vector176
vector176:
  pushl $0
  102888:	6a 00                	push   $0x0
  pushl $176
  10288a:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10288f:	e9 b4 03 00 00       	jmp    102c48 <__alltraps>

00102894 <vector177>:
.globl vector177
vector177:
  pushl $0
  102894:	6a 00                	push   $0x0
  pushl $177
  102896:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10289b:	e9 a8 03 00 00       	jmp    102c48 <__alltraps>

001028a0 <vector178>:
.globl vector178
vector178:
  pushl $0
  1028a0:	6a 00                	push   $0x0
  pushl $178
  1028a2:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1028a7:	e9 9c 03 00 00       	jmp    102c48 <__alltraps>

001028ac <vector179>:
.globl vector179
vector179:
  pushl $0
  1028ac:	6a 00                	push   $0x0
  pushl $179
  1028ae:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1028b3:	e9 90 03 00 00       	jmp    102c48 <__alltraps>

001028b8 <vector180>:
.globl vector180
vector180:
  pushl $0
  1028b8:	6a 00                	push   $0x0
  pushl $180
  1028ba:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1028bf:	e9 84 03 00 00       	jmp    102c48 <__alltraps>

001028c4 <vector181>:
.globl vector181
vector181:
  pushl $0
  1028c4:	6a 00                	push   $0x0
  pushl $181
  1028c6:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1028cb:	e9 78 03 00 00       	jmp    102c48 <__alltraps>

001028d0 <vector182>:
.globl vector182
vector182:
  pushl $0
  1028d0:	6a 00                	push   $0x0
  pushl $182
  1028d2:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1028d7:	e9 6c 03 00 00       	jmp    102c48 <__alltraps>

001028dc <vector183>:
.globl vector183
vector183:
  pushl $0
  1028dc:	6a 00                	push   $0x0
  pushl $183
  1028de:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1028e3:	e9 60 03 00 00       	jmp    102c48 <__alltraps>

001028e8 <vector184>:
.globl vector184
vector184:
  pushl $0
  1028e8:	6a 00                	push   $0x0
  pushl $184
  1028ea:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1028ef:	e9 54 03 00 00       	jmp    102c48 <__alltraps>

001028f4 <vector185>:
.globl vector185
vector185:
  pushl $0
  1028f4:	6a 00                	push   $0x0
  pushl $185
  1028f6:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1028fb:	e9 48 03 00 00       	jmp    102c48 <__alltraps>

00102900 <vector186>:
.globl vector186
vector186:
  pushl $0
  102900:	6a 00                	push   $0x0
  pushl $186
  102902:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102907:	e9 3c 03 00 00       	jmp    102c48 <__alltraps>

0010290c <vector187>:
.globl vector187
vector187:
  pushl $0
  10290c:	6a 00                	push   $0x0
  pushl $187
  10290e:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102913:	e9 30 03 00 00       	jmp    102c48 <__alltraps>

00102918 <vector188>:
.globl vector188
vector188:
  pushl $0
  102918:	6a 00                	push   $0x0
  pushl $188
  10291a:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10291f:	e9 24 03 00 00       	jmp    102c48 <__alltraps>

00102924 <vector189>:
.globl vector189
vector189:
  pushl $0
  102924:	6a 00                	push   $0x0
  pushl $189
  102926:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10292b:	e9 18 03 00 00       	jmp    102c48 <__alltraps>

00102930 <vector190>:
.globl vector190
vector190:
  pushl $0
  102930:	6a 00                	push   $0x0
  pushl $190
  102932:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102937:	e9 0c 03 00 00       	jmp    102c48 <__alltraps>

0010293c <vector191>:
.globl vector191
vector191:
  pushl $0
  10293c:	6a 00                	push   $0x0
  pushl $191
  10293e:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102943:	e9 00 03 00 00       	jmp    102c48 <__alltraps>

00102948 <vector192>:
.globl vector192
vector192:
  pushl $0
  102948:	6a 00                	push   $0x0
  pushl $192
  10294a:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10294f:	e9 f4 02 00 00       	jmp    102c48 <__alltraps>

00102954 <vector193>:
.globl vector193
vector193:
  pushl $0
  102954:	6a 00                	push   $0x0
  pushl $193
  102956:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10295b:	e9 e8 02 00 00       	jmp    102c48 <__alltraps>

00102960 <vector194>:
.globl vector194
vector194:
  pushl $0
  102960:	6a 00                	push   $0x0
  pushl $194
  102962:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102967:	e9 dc 02 00 00       	jmp    102c48 <__alltraps>

0010296c <vector195>:
.globl vector195
vector195:
  pushl $0
  10296c:	6a 00                	push   $0x0
  pushl $195
  10296e:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102973:	e9 d0 02 00 00       	jmp    102c48 <__alltraps>

00102978 <vector196>:
.globl vector196
vector196:
  pushl $0
  102978:	6a 00                	push   $0x0
  pushl $196
  10297a:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10297f:	e9 c4 02 00 00       	jmp    102c48 <__alltraps>

00102984 <vector197>:
.globl vector197
vector197:
  pushl $0
  102984:	6a 00                	push   $0x0
  pushl $197
  102986:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10298b:	e9 b8 02 00 00       	jmp    102c48 <__alltraps>

00102990 <vector198>:
.globl vector198
vector198:
  pushl $0
  102990:	6a 00                	push   $0x0
  pushl $198
  102992:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102997:	e9 ac 02 00 00       	jmp    102c48 <__alltraps>

0010299c <vector199>:
.globl vector199
vector199:
  pushl $0
  10299c:	6a 00                	push   $0x0
  pushl $199
  10299e:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1029a3:	e9 a0 02 00 00       	jmp    102c48 <__alltraps>

001029a8 <vector200>:
.globl vector200
vector200:
  pushl $0
  1029a8:	6a 00                	push   $0x0
  pushl $200
  1029aa:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1029af:	e9 94 02 00 00       	jmp    102c48 <__alltraps>

001029b4 <vector201>:
.globl vector201
vector201:
  pushl $0
  1029b4:	6a 00                	push   $0x0
  pushl $201
  1029b6:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1029bb:	e9 88 02 00 00       	jmp    102c48 <__alltraps>

001029c0 <vector202>:
.globl vector202
vector202:
  pushl $0
  1029c0:	6a 00                	push   $0x0
  pushl $202
  1029c2:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1029c7:	e9 7c 02 00 00       	jmp    102c48 <__alltraps>

001029cc <vector203>:
.globl vector203
vector203:
  pushl $0
  1029cc:	6a 00                	push   $0x0
  pushl $203
  1029ce:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1029d3:	e9 70 02 00 00       	jmp    102c48 <__alltraps>

001029d8 <vector204>:
.globl vector204
vector204:
  pushl $0
  1029d8:	6a 00                	push   $0x0
  pushl $204
  1029da:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1029df:	e9 64 02 00 00       	jmp    102c48 <__alltraps>

001029e4 <vector205>:
.globl vector205
vector205:
  pushl $0
  1029e4:	6a 00                	push   $0x0
  pushl $205
  1029e6:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1029eb:	e9 58 02 00 00       	jmp    102c48 <__alltraps>

001029f0 <vector206>:
.globl vector206
vector206:
  pushl $0
  1029f0:	6a 00                	push   $0x0
  pushl $206
  1029f2:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1029f7:	e9 4c 02 00 00       	jmp    102c48 <__alltraps>

001029fc <vector207>:
.globl vector207
vector207:
  pushl $0
  1029fc:	6a 00                	push   $0x0
  pushl $207
  1029fe:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102a03:	e9 40 02 00 00       	jmp    102c48 <__alltraps>

00102a08 <vector208>:
.globl vector208
vector208:
  pushl $0
  102a08:	6a 00                	push   $0x0
  pushl $208
  102a0a:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102a0f:	e9 34 02 00 00       	jmp    102c48 <__alltraps>

00102a14 <vector209>:
.globl vector209
vector209:
  pushl $0
  102a14:	6a 00                	push   $0x0
  pushl $209
  102a16:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102a1b:	e9 28 02 00 00       	jmp    102c48 <__alltraps>

00102a20 <vector210>:
.globl vector210
vector210:
  pushl $0
  102a20:	6a 00                	push   $0x0
  pushl $210
  102a22:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102a27:	e9 1c 02 00 00       	jmp    102c48 <__alltraps>

00102a2c <vector211>:
.globl vector211
vector211:
  pushl $0
  102a2c:	6a 00                	push   $0x0
  pushl $211
  102a2e:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102a33:	e9 10 02 00 00       	jmp    102c48 <__alltraps>

00102a38 <vector212>:
.globl vector212
vector212:
  pushl $0
  102a38:	6a 00                	push   $0x0
  pushl $212
  102a3a:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102a3f:	e9 04 02 00 00       	jmp    102c48 <__alltraps>

00102a44 <vector213>:
.globl vector213
vector213:
  pushl $0
  102a44:	6a 00                	push   $0x0
  pushl $213
  102a46:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102a4b:	e9 f8 01 00 00       	jmp    102c48 <__alltraps>

00102a50 <vector214>:
.globl vector214
vector214:
  pushl $0
  102a50:	6a 00                	push   $0x0
  pushl $214
  102a52:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102a57:	e9 ec 01 00 00       	jmp    102c48 <__alltraps>

00102a5c <vector215>:
.globl vector215
vector215:
  pushl $0
  102a5c:	6a 00                	push   $0x0
  pushl $215
  102a5e:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102a63:	e9 e0 01 00 00       	jmp    102c48 <__alltraps>

00102a68 <vector216>:
.globl vector216
vector216:
  pushl $0
  102a68:	6a 00                	push   $0x0
  pushl $216
  102a6a:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102a6f:	e9 d4 01 00 00       	jmp    102c48 <__alltraps>

00102a74 <vector217>:
.globl vector217
vector217:
  pushl $0
  102a74:	6a 00                	push   $0x0
  pushl $217
  102a76:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102a7b:	e9 c8 01 00 00       	jmp    102c48 <__alltraps>

00102a80 <vector218>:
.globl vector218
vector218:
  pushl $0
  102a80:	6a 00                	push   $0x0
  pushl $218
  102a82:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102a87:	e9 bc 01 00 00       	jmp    102c48 <__alltraps>

00102a8c <vector219>:
.globl vector219
vector219:
  pushl $0
  102a8c:	6a 00                	push   $0x0
  pushl $219
  102a8e:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102a93:	e9 b0 01 00 00       	jmp    102c48 <__alltraps>

00102a98 <vector220>:
.globl vector220
vector220:
  pushl $0
  102a98:	6a 00                	push   $0x0
  pushl $220
  102a9a:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102a9f:	e9 a4 01 00 00       	jmp    102c48 <__alltraps>

00102aa4 <vector221>:
.globl vector221
vector221:
  pushl $0
  102aa4:	6a 00                	push   $0x0
  pushl $221
  102aa6:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102aab:	e9 98 01 00 00       	jmp    102c48 <__alltraps>

00102ab0 <vector222>:
.globl vector222
vector222:
  pushl $0
  102ab0:	6a 00                	push   $0x0
  pushl $222
  102ab2:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102ab7:	e9 8c 01 00 00       	jmp    102c48 <__alltraps>

00102abc <vector223>:
.globl vector223
vector223:
  pushl $0
  102abc:	6a 00                	push   $0x0
  pushl $223
  102abe:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102ac3:	e9 80 01 00 00       	jmp    102c48 <__alltraps>

00102ac8 <vector224>:
.globl vector224
vector224:
  pushl $0
  102ac8:	6a 00                	push   $0x0
  pushl $224
  102aca:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102acf:	e9 74 01 00 00       	jmp    102c48 <__alltraps>

00102ad4 <vector225>:
.globl vector225
vector225:
  pushl $0
  102ad4:	6a 00                	push   $0x0
  pushl $225
  102ad6:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102adb:	e9 68 01 00 00       	jmp    102c48 <__alltraps>

00102ae0 <vector226>:
.globl vector226
vector226:
  pushl $0
  102ae0:	6a 00                	push   $0x0
  pushl $226
  102ae2:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102ae7:	e9 5c 01 00 00       	jmp    102c48 <__alltraps>

00102aec <vector227>:
.globl vector227
vector227:
  pushl $0
  102aec:	6a 00                	push   $0x0
  pushl $227
  102aee:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102af3:	e9 50 01 00 00       	jmp    102c48 <__alltraps>

00102af8 <vector228>:
.globl vector228
vector228:
  pushl $0
  102af8:	6a 00                	push   $0x0
  pushl $228
  102afa:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102aff:	e9 44 01 00 00       	jmp    102c48 <__alltraps>

00102b04 <vector229>:
.globl vector229
vector229:
  pushl $0
  102b04:	6a 00                	push   $0x0
  pushl $229
  102b06:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102b0b:	e9 38 01 00 00       	jmp    102c48 <__alltraps>

00102b10 <vector230>:
.globl vector230
vector230:
  pushl $0
  102b10:	6a 00                	push   $0x0
  pushl $230
  102b12:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102b17:	e9 2c 01 00 00       	jmp    102c48 <__alltraps>

00102b1c <vector231>:
.globl vector231
vector231:
  pushl $0
  102b1c:	6a 00                	push   $0x0
  pushl $231
  102b1e:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102b23:	e9 20 01 00 00       	jmp    102c48 <__alltraps>

00102b28 <vector232>:
.globl vector232
vector232:
  pushl $0
  102b28:	6a 00                	push   $0x0
  pushl $232
  102b2a:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102b2f:	e9 14 01 00 00       	jmp    102c48 <__alltraps>

00102b34 <vector233>:
.globl vector233
vector233:
  pushl $0
  102b34:	6a 00                	push   $0x0
  pushl $233
  102b36:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102b3b:	e9 08 01 00 00       	jmp    102c48 <__alltraps>

00102b40 <vector234>:
.globl vector234
vector234:
  pushl $0
  102b40:	6a 00                	push   $0x0
  pushl $234
  102b42:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102b47:	e9 fc 00 00 00       	jmp    102c48 <__alltraps>

00102b4c <vector235>:
.globl vector235
vector235:
  pushl $0
  102b4c:	6a 00                	push   $0x0
  pushl $235
  102b4e:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102b53:	e9 f0 00 00 00       	jmp    102c48 <__alltraps>

00102b58 <vector236>:
.globl vector236
vector236:
  pushl $0
  102b58:	6a 00                	push   $0x0
  pushl $236
  102b5a:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102b5f:	e9 e4 00 00 00       	jmp    102c48 <__alltraps>

00102b64 <vector237>:
.globl vector237
vector237:
  pushl $0
  102b64:	6a 00                	push   $0x0
  pushl $237
  102b66:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102b6b:	e9 d8 00 00 00       	jmp    102c48 <__alltraps>

00102b70 <vector238>:
.globl vector238
vector238:
  pushl $0
  102b70:	6a 00                	push   $0x0
  pushl $238
  102b72:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102b77:	e9 cc 00 00 00       	jmp    102c48 <__alltraps>

00102b7c <vector239>:
.globl vector239
vector239:
  pushl $0
  102b7c:	6a 00                	push   $0x0
  pushl $239
  102b7e:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102b83:	e9 c0 00 00 00       	jmp    102c48 <__alltraps>

00102b88 <vector240>:
.globl vector240
vector240:
  pushl $0
  102b88:	6a 00                	push   $0x0
  pushl $240
  102b8a:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102b8f:	e9 b4 00 00 00       	jmp    102c48 <__alltraps>

00102b94 <vector241>:
.globl vector241
vector241:
  pushl $0
  102b94:	6a 00                	push   $0x0
  pushl $241
  102b96:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102b9b:	e9 a8 00 00 00       	jmp    102c48 <__alltraps>

00102ba0 <vector242>:
.globl vector242
vector242:
  pushl $0
  102ba0:	6a 00                	push   $0x0
  pushl $242
  102ba2:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102ba7:	e9 9c 00 00 00       	jmp    102c48 <__alltraps>

00102bac <vector243>:
.globl vector243
vector243:
  pushl $0
  102bac:	6a 00                	push   $0x0
  pushl $243
  102bae:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102bb3:	e9 90 00 00 00       	jmp    102c48 <__alltraps>

00102bb8 <vector244>:
.globl vector244
vector244:
  pushl $0
  102bb8:	6a 00                	push   $0x0
  pushl $244
  102bba:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102bbf:	e9 84 00 00 00       	jmp    102c48 <__alltraps>

00102bc4 <vector245>:
.globl vector245
vector245:
  pushl $0
  102bc4:	6a 00                	push   $0x0
  pushl $245
  102bc6:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102bcb:	e9 78 00 00 00       	jmp    102c48 <__alltraps>

00102bd0 <vector246>:
.globl vector246
vector246:
  pushl $0
  102bd0:	6a 00                	push   $0x0
  pushl $246
  102bd2:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102bd7:	e9 6c 00 00 00       	jmp    102c48 <__alltraps>

00102bdc <vector247>:
.globl vector247
vector247:
  pushl $0
  102bdc:	6a 00                	push   $0x0
  pushl $247
  102bde:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102be3:	e9 60 00 00 00       	jmp    102c48 <__alltraps>

00102be8 <vector248>:
.globl vector248
vector248:
  pushl $0
  102be8:	6a 00                	push   $0x0
  pushl $248
  102bea:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102bef:	e9 54 00 00 00       	jmp    102c48 <__alltraps>

00102bf4 <vector249>:
.globl vector249
vector249:
  pushl $0
  102bf4:	6a 00                	push   $0x0
  pushl $249
  102bf6:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102bfb:	e9 48 00 00 00       	jmp    102c48 <__alltraps>

00102c00 <vector250>:
.globl vector250
vector250:
  pushl $0
  102c00:	6a 00                	push   $0x0
  pushl $250
  102c02:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102c07:	e9 3c 00 00 00       	jmp    102c48 <__alltraps>

00102c0c <vector251>:
.globl vector251
vector251:
  pushl $0
  102c0c:	6a 00                	push   $0x0
  pushl $251
  102c0e:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102c13:	e9 30 00 00 00       	jmp    102c48 <__alltraps>

00102c18 <vector252>:
.globl vector252
vector252:
  pushl $0
  102c18:	6a 00                	push   $0x0
  pushl $252
  102c1a:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102c1f:	e9 24 00 00 00       	jmp    102c48 <__alltraps>

00102c24 <vector253>:
.globl vector253
vector253:
  pushl $0
  102c24:	6a 00                	push   $0x0
  pushl $253
  102c26:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102c2b:	e9 18 00 00 00       	jmp    102c48 <__alltraps>

00102c30 <vector254>:
.globl vector254
vector254:
  pushl $0
  102c30:	6a 00                	push   $0x0
  pushl $254
  102c32:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102c37:	e9 0c 00 00 00       	jmp    102c48 <__alltraps>

00102c3c <vector255>:
.globl vector255
vector255:
  pushl $0
  102c3c:	6a 00                	push   $0x0
  pushl $255
  102c3e:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102c43:	e9 00 00 00 00       	jmp    102c48 <__alltraps>

00102c48 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102c48:	1e                   	push   %ds
    pushl %es
  102c49:	06                   	push   %es
    pushl %fs
  102c4a:	0f a0                	push   %fs
    pushl %gs
  102c4c:	0f a8                	push   %gs
    pushal
  102c4e:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102c4f:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102c54:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102c56:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102c58:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102c59:	e8 57 f5 ff ff       	call   1021b5 <trap>

    # pop the pushed stack pointer
    popl %esp
  102c5e:	5c                   	pop    %esp

00102c5f <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102c5f:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102c60:	0f a9                	pop    %gs
    popl %fs
  102c62:	0f a1                	pop    %fs
    popl %es
  102c64:	07                   	pop    %es
    popl %ds
  102c65:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102c66:	83 c4 08             	add    $0x8,%esp
    iret
  102c69:	cf                   	iret   

00102c6a <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102c6a:	55                   	push   %ebp
  102c6b:	89 e5                	mov    %esp,%ebp
  102c6d:	e8 40 d6 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102c72:	05 de bc 00 00       	add    $0xbcde,%eax
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102c77:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7a:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102c7d:	b8 23 00 00 00       	mov    $0x23,%eax
  102c82:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102c84:	b8 23 00 00 00       	mov    $0x23,%eax
  102c89:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102c8b:	b8 10 00 00 00       	mov    $0x10,%eax
  102c90:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102c92:	b8 10 00 00 00       	mov    $0x10,%eax
  102c97:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102c99:	b8 10 00 00 00       	mov    $0x10,%eax
  102c9e:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102ca0:	ea a7 2c 10 00 08 00 	ljmp   $0x8,$0x102ca7
}
  102ca7:	90                   	nop
  102ca8:	5d                   	pop    %ebp
  102ca9:	c3                   	ret    

00102caa <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102caa:	55                   	push   %ebp
  102cab:	89 e5                	mov    %esp,%ebp
  102cad:	83 ec 10             	sub    $0x10,%esp
  102cb0:	e8 fd d5 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102cb5:	05 9b bc 00 00       	add    $0xbc9b,%eax
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102cba:	c7 c2 c0 f9 10 00    	mov    $0x10f9c0,%edx
  102cc0:	81 c2 00 04 00 00    	add    $0x400,%edx
  102cc6:	89 90 f4 0f 00 00    	mov    %edx,0xff4(%eax)
    ts.ts_ss0 = KERNEL_DS;
  102ccc:	66 c7 80 f8 0f 00 00 	movw   $0x10,0xff8(%eax)
  102cd3:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102cd5:	66 c7 80 f8 ff ff ff 	movw   $0x68,-0x8(%eax)
  102cdc:	68 00 
  102cde:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102ce4:	66 89 90 fa ff ff ff 	mov    %dx,-0x6(%eax)
  102ceb:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102cf1:	c1 ea 10             	shr    $0x10,%edx
  102cf4:	88 90 fc ff ff ff    	mov    %dl,-0x4(%eax)
  102cfa:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d01:	83 e2 f0             	and    $0xfffffff0,%edx
  102d04:	83 ca 09             	or     $0x9,%edx
  102d07:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102d0d:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d14:	83 ca 10             	or     $0x10,%edx
  102d17:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102d1d:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d24:	83 e2 9f             	and    $0xffffff9f,%edx
  102d27:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102d2d:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d34:	83 ca 80             	or     $0xffffff80,%edx
  102d37:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102d3d:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d44:	83 e2 f0             	and    $0xfffffff0,%edx
  102d47:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d4d:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d54:	83 e2 ef             	and    $0xffffffef,%edx
  102d57:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d5d:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d64:	83 e2 df             	and    $0xffffffdf,%edx
  102d67:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d6d:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d74:	83 ca 40             	or     $0x40,%edx
  102d77:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d7d:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d84:	83 e2 7f             	and    $0x7f,%edx
  102d87:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d8d:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102d93:	c1 ea 18             	shr    $0x18,%edx
  102d96:	88 90 ff ff ff ff    	mov    %dl,-0x1(%eax)
    gdt[SEG_TSS].sd_s = 0;
  102d9c:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102da3:	83 e2 ef             	and    $0xffffffef,%edx
  102da6:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)

    // reload all segment registers
    lgdt(&gdt_pd);
  102dac:	8d 80 d0 00 00 00    	lea    0xd0(%eax),%eax
  102db2:	50                   	push   %eax
  102db3:	e8 b2 fe ff ff       	call   102c6a <lgdt>
  102db8:	83 c4 04             	add    $0x4,%esp
  102dbb:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102dc1:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102dc5:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102dc8:	90                   	nop
  102dc9:	c9                   	leave  
  102dca:	c3                   	ret    

00102dcb <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102dcb:	55                   	push   %ebp
  102dcc:	89 e5                	mov    %esp,%ebp
  102dce:	e8 df d4 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102dd3:	05 7d bb 00 00       	add    $0xbb7d,%eax
    gdt_init();
  102dd8:	e8 cd fe ff ff       	call   102caa <gdt_init>
}
  102ddd:	90                   	nop
  102dde:	5d                   	pop    %ebp
  102ddf:	c3                   	ret    

00102de0 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102de0:	55                   	push   %ebp
  102de1:	89 e5                	mov    %esp,%ebp
  102de3:	83 ec 10             	sub    $0x10,%esp
  102de6:	e8 c7 d4 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102deb:	05 65 bb 00 00       	add    $0xbb65,%eax
    size_t cnt = 0;
  102df0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102df7:	eb 04                	jmp    102dfd <strlen+0x1d>
        cnt ++;
  102df9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  102e00:	8d 50 01             	lea    0x1(%eax),%edx
  102e03:	89 55 08             	mov    %edx,0x8(%ebp)
  102e06:	0f b6 00             	movzbl (%eax),%eax
  102e09:	84 c0                	test   %al,%al
  102e0b:	75 ec                	jne    102df9 <strlen+0x19>
    }
    return cnt;
  102e0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102e10:	c9                   	leave  
  102e11:	c3                   	ret    

00102e12 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102e12:	55                   	push   %ebp
  102e13:	89 e5                	mov    %esp,%ebp
  102e15:	83 ec 10             	sub    $0x10,%esp
  102e18:	e8 95 d4 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102e1d:	05 33 bb 00 00       	add    $0xbb33,%eax
    size_t cnt = 0;
  102e22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102e29:	eb 04                	jmp    102e2f <strnlen+0x1d>
        cnt ++;
  102e2b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102e2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e32:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102e35:	73 10                	jae    102e47 <strnlen+0x35>
  102e37:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3a:	8d 50 01             	lea    0x1(%eax),%edx
  102e3d:	89 55 08             	mov    %edx,0x8(%ebp)
  102e40:	0f b6 00             	movzbl (%eax),%eax
  102e43:	84 c0                	test   %al,%al
  102e45:	75 e4                	jne    102e2b <strnlen+0x19>
    }
    return cnt;
  102e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102e4a:	c9                   	leave  
  102e4b:	c3                   	ret    

00102e4c <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102e4c:	55                   	push   %ebp
  102e4d:	89 e5                	mov    %esp,%ebp
  102e4f:	57                   	push   %edi
  102e50:	56                   	push   %esi
  102e51:	83 ec 20             	sub    $0x20,%esp
  102e54:	e8 59 d4 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102e59:	05 f7 ba 00 00       	add    $0xbaf7,%eax
  102e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  102e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102e6a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102e6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e70:	89 d1                	mov    %edx,%ecx
  102e72:	89 c2                	mov    %eax,%edx
  102e74:	89 ce                	mov    %ecx,%esi
  102e76:	89 d7                	mov    %edx,%edi
  102e78:	ac                   	lods   %ds:(%esi),%al
  102e79:	aa                   	stos   %al,%es:(%edi)
  102e7a:	84 c0                	test   %al,%al
  102e7c:	75 fa                	jne    102e78 <strcpy+0x2c>
  102e7e:	89 fa                	mov    %edi,%edx
  102e80:	89 f1                	mov    %esi,%ecx
  102e82:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e85:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102e88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102e8e:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102e8f:	83 c4 20             	add    $0x20,%esp
  102e92:	5e                   	pop    %esi
  102e93:	5f                   	pop    %edi
  102e94:	5d                   	pop    %ebp
  102e95:	c3                   	ret    

00102e96 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102e96:	55                   	push   %ebp
  102e97:	89 e5                	mov    %esp,%ebp
  102e99:	83 ec 10             	sub    $0x10,%esp
  102e9c:	e8 11 d4 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102ea1:	05 af ba 00 00       	add    $0xbaaf,%eax
    char *p = dst;
  102ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102eac:	eb 21                	jmp    102ecf <strncpy+0x39>
        if ((*p = *src) != '\0') {
  102eae:	8b 45 0c             	mov    0xc(%ebp),%eax
  102eb1:	0f b6 10             	movzbl (%eax),%edx
  102eb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102eb7:	88 10                	mov    %dl,(%eax)
  102eb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ebc:	0f b6 00             	movzbl (%eax),%eax
  102ebf:	84 c0                	test   %al,%al
  102ec1:	74 04                	je     102ec7 <strncpy+0x31>
            src ++;
  102ec3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102ec7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102ecb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102ecf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ed3:	75 d9                	jne    102eae <strncpy+0x18>
    }
    return dst;
  102ed5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102ed8:	c9                   	leave  
  102ed9:	c3                   	ret    

00102eda <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102eda:	55                   	push   %ebp
  102edb:	89 e5                	mov    %esp,%ebp
  102edd:	57                   	push   %edi
  102ede:	56                   	push   %esi
  102edf:	83 ec 20             	sub    $0x20,%esp
  102ee2:	e8 cb d3 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102ee7:	05 69 ba 00 00       	add    $0xba69,%eax
  102eec:	8b 45 08             	mov    0x8(%ebp),%eax
  102eef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ef8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102efb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102efe:	89 d1                	mov    %edx,%ecx
  102f00:	89 c2                	mov    %eax,%edx
  102f02:	89 ce                	mov    %ecx,%esi
  102f04:	89 d7                	mov    %edx,%edi
  102f06:	ac                   	lods   %ds:(%esi),%al
  102f07:	ae                   	scas   %es:(%edi),%al
  102f08:	75 08                	jne    102f12 <strcmp+0x38>
  102f0a:	84 c0                	test   %al,%al
  102f0c:	75 f8                	jne    102f06 <strcmp+0x2c>
  102f0e:	31 c0                	xor    %eax,%eax
  102f10:	eb 04                	jmp    102f16 <strcmp+0x3c>
  102f12:	19 c0                	sbb    %eax,%eax
  102f14:	0c 01                	or     $0x1,%al
  102f16:	89 fa                	mov    %edi,%edx
  102f18:	89 f1                	mov    %esi,%ecx
  102f1a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102f1d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102f20:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102f23:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  102f26:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102f27:	83 c4 20             	add    $0x20,%esp
  102f2a:	5e                   	pop    %esi
  102f2b:	5f                   	pop    %edi
  102f2c:	5d                   	pop    %ebp
  102f2d:	c3                   	ret    

00102f2e <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102f2e:	55                   	push   %ebp
  102f2f:	89 e5                	mov    %esp,%ebp
  102f31:	e8 7c d3 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102f36:	05 1a ba 00 00       	add    $0xba1a,%eax
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f3b:	eb 0c                	jmp    102f49 <strncmp+0x1b>
        n --, s1 ++, s2 ++;
  102f3d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102f41:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102f45:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f4d:	74 1a                	je     102f69 <strncmp+0x3b>
  102f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  102f52:	0f b6 00             	movzbl (%eax),%eax
  102f55:	84 c0                	test   %al,%al
  102f57:	74 10                	je     102f69 <strncmp+0x3b>
  102f59:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5c:	0f b6 10             	movzbl (%eax),%edx
  102f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f62:	0f b6 00             	movzbl (%eax),%eax
  102f65:	38 c2                	cmp    %al,%dl
  102f67:	74 d4                	je     102f3d <strncmp+0xf>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f6d:	74 18                	je     102f87 <strncmp+0x59>
  102f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  102f72:	0f b6 00             	movzbl (%eax),%eax
  102f75:	0f b6 d0             	movzbl %al,%edx
  102f78:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f7b:	0f b6 00             	movzbl (%eax),%eax
  102f7e:	0f b6 c0             	movzbl %al,%eax
  102f81:	29 c2                	sub    %eax,%edx
  102f83:	89 d0                	mov    %edx,%eax
  102f85:	eb 05                	jmp    102f8c <strncmp+0x5e>
  102f87:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f8c:	5d                   	pop    %ebp
  102f8d:	c3                   	ret    

00102f8e <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102f8e:	55                   	push   %ebp
  102f8f:	89 e5                	mov    %esp,%ebp
  102f91:	83 ec 04             	sub    $0x4,%esp
  102f94:	e8 19 d3 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102f99:	05 b7 b9 00 00       	add    $0xb9b7,%eax
  102f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fa1:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102fa4:	eb 14                	jmp    102fba <strchr+0x2c>
        if (*s == c) {
  102fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  102fa9:	0f b6 00             	movzbl (%eax),%eax
  102fac:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102faf:	75 05                	jne    102fb6 <strchr+0x28>
            return (char *)s;
  102fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fb4:	eb 13                	jmp    102fc9 <strchr+0x3b>
        }
        s ++;
  102fb6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102fba:	8b 45 08             	mov    0x8(%ebp),%eax
  102fbd:	0f b6 00             	movzbl (%eax),%eax
  102fc0:	84 c0                	test   %al,%al
  102fc2:	75 e2                	jne    102fa6 <strchr+0x18>
    }
    return NULL;
  102fc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102fc9:	c9                   	leave  
  102fca:	c3                   	ret    

00102fcb <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102fcb:	55                   	push   %ebp
  102fcc:	89 e5                	mov    %esp,%ebp
  102fce:	83 ec 04             	sub    $0x4,%esp
  102fd1:	e8 dc d2 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  102fd6:	05 7a b9 00 00       	add    $0xb97a,%eax
  102fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fde:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102fe1:	eb 0f                	jmp    102ff2 <strfind+0x27>
        if (*s == c) {
  102fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  102fe6:	0f b6 00             	movzbl (%eax),%eax
  102fe9:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102fec:	74 10                	je     102ffe <strfind+0x33>
            break;
        }
        s ++;
  102fee:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  102ff5:	0f b6 00             	movzbl (%eax),%eax
  102ff8:	84 c0                	test   %al,%al
  102ffa:	75 e7                	jne    102fe3 <strfind+0x18>
  102ffc:	eb 01                	jmp    102fff <strfind+0x34>
            break;
  102ffe:	90                   	nop
    }
    return (char *)s;
  102fff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103002:	c9                   	leave  
  103003:	c3                   	ret    

00103004 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  103004:	55                   	push   %ebp
  103005:	89 e5                	mov    %esp,%ebp
  103007:	83 ec 10             	sub    $0x10,%esp
  10300a:	e8 a3 d2 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  10300f:	05 41 b9 00 00       	add    $0xb941,%eax
    int neg = 0;
  103014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  10301b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103022:	eb 04                	jmp    103028 <strtol+0x24>
        s ++;
  103024:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  103028:	8b 45 08             	mov    0x8(%ebp),%eax
  10302b:	0f b6 00             	movzbl (%eax),%eax
  10302e:	3c 20                	cmp    $0x20,%al
  103030:	74 f2                	je     103024 <strtol+0x20>
  103032:	8b 45 08             	mov    0x8(%ebp),%eax
  103035:	0f b6 00             	movzbl (%eax),%eax
  103038:	3c 09                	cmp    $0x9,%al
  10303a:	74 e8                	je     103024 <strtol+0x20>
    }

    // plus/minus sign
    if (*s == '+') {
  10303c:	8b 45 08             	mov    0x8(%ebp),%eax
  10303f:	0f b6 00             	movzbl (%eax),%eax
  103042:	3c 2b                	cmp    $0x2b,%al
  103044:	75 06                	jne    10304c <strtol+0x48>
        s ++;
  103046:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10304a:	eb 15                	jmp    103061 <strtol+0x5d>
    }
    else if (*s == '-') {
  10304c:	8b 45 08             	mov    0x8(%ebp),%eax
  10304f:	0f b6 00             	movzbl (%eax),%eax
  103052:	3c 2d                	cmp    $0x2d,%al
  103054:	75 0b                	jne    103061 <strtol+0x5d>
        s ++, neg = 1;
  103056:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10305a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103061:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103065:	74 06                	je     10306d <strtol+0x69>
  103067:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10306b:	75 24                	jne    103091 <strtol+0x8d>
  10306d:	8b 45 08             	mov    0x8(%ebp),%eax
  103070:	0f b6 00             	movzbl (%eax),%eax
  103073:	3c 30                	cmp    $0x30,%al
  103075:	75 1a                	jne    103091 <strtol+0x8d>
  103077:	8b 45 08             	mov    0x8(%ebp),%eax
  10307a:	83 c0 01             	add    $0x1,%eax
  10307d:	0f b6 00             	movzbl (%eax),%eax
  103080:	3c 78                	cmp    $0x78,%al
  103082:	75 0d                	jne    103091 <strtol+0x8d>
        s += 2, base = 16;
  103084:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103088:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10308f:	eb 2a                	jmp    1030bb <strtol+0xb7>
    }
    else if (base == 0 && s[0] == '0') {
  103091:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103095:	75 17                	jne    1030ae <strtol+0xaa>
  103097:	8b 45 08             	mov    0x8(%ebp),%eax
  10309a:	0f b6 00             	movzbl (%eax),%eax
  10309d:	3c 30                	cmp    $0x30,%al
  10309f:	75 0d                	jne    1030ae <strtol+0xaa>
        s ++, base = 8;
  1030a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030a5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  1030ac:	eb 0d                	jmp    1030bb <strtol+0xb7>
    }
    else if (base == 0) {
  1030ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1030b2:	75 07                	jne    1030bb <strtol+0xb7>
        base = 10;
  1030b4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  1030bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1030be:	0f b6 00             	movzbl (%eax),%eax
  1030c1:	3c 2f                	cmp    $0x2f,%al
  1030c3:	7e 1b                	jle    1030e0 <strtol+0xdc>
  1030c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c8:	0f b6 00             	movzbl (%eax),%eax
  1030cb:	3c 39                	cmp    $0x39,%al
  1030cd:	7f 11                	jg     1030e0 <strtol+0xdc>
            dig = *s - '0';
  1030cf:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d2:	0f b6 00             	movzbl (%eax),%eax
  1030d5:	0f be c0             	movsbl %al,%eax
  1030d8:	83 e8 30             	sub    $0x30,%eax
  1030db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030de:	eb 48                	jmp    103128 <strtol+0x124>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1030e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e3:	0f b6 00             	movzbl (%eax),%eax
  1030e6:	3c 60                	cmp    $0x60,%al
  1030e8:	7e 1b                	jle    103105 <strtol+0x101>
  1030ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ed:	0f b6 00             	movzbl (%eax),%eax
  1030f0:	3c 7a                	cmp    $0x7a,%al
  1030f2:	7f 11                	jg     103105 <strtol+0x101>
            dig = *s - 'a' + 10;
  1030f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f7:	0f b6 00             	movzbl (%eax),%eax
  1030fa:	0f be c0             	movsbl %al,%eax
  1030fd:	83 e8 57             	sub    $0x57,%eax
  103100:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103103:	eb 23                	jmp    103128 <strtol+0x124>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103105:	8b 45 08             	mov    0x8(%ebp),%eax
  103108:	0f b6 00             	movzbl (%eax),%eax
  10310b:	3c 40                	cmp    $0x40,%al
  10310d:	7e 3c                	jle    10314b <strtol+0x147>
  10310f:	8b 45 08             	mov    0x8(%ebp),%eax
  103112:	0f b6 00             	movzbl (%eax),%eax
  103115:	3c 5a                	cmp    $0x5a,%al
  103117:	7f 32                	jg     10314b <strtol+0x147>
            dig = *s - 'A' + 10;
  103119:	8b 45 08             	mov    0x8(%ebp),%eax
  10311c:	0f b6 00             	movzbl (%eax),%eax
  10311f:	0f be c0             	movsbl %al,%eax
  103122:	83 e8 37             	sub    $0x37,%eax
  103125:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  103128:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10312b:	3b 45 10             	cmp    0x10(%ebp),%eax
  10312e:	7d 1a                	jge    10314a <strtol+0x146>
            break;
        }
        s ++, val = (val * base) + dig;
  103130:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103134:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103137:	0f af 45 10          	imul   0x10(%ebp),%eax
  10313b:	89 c2                	mov    %eax,%edx
  10313d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103140:	01 d0                	add    %edx,%eax
  103142:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  103145:	e9 71 ff ff ff       	jmp    1030bb <strtol+0xb7>
            break;
  10314a:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  10314b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10314f:	74 08                	je     103159 <strtol+0x155>
        *endptr = (char *) s;
  103151:	8b 45 0c             	mov    0xc(%ebp),%eax
  103154:	8b 55 08             	mov    0x8(%ebp),%edx
  103157:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103159:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  10315d:	74 07                	je     103166 <strtol+0x162>
  10315f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103162:	f7 d8                	neg    %eax
  103164:	eb 03                	jmp    103169 <strtol+0x165>
  103166:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103169:	c9                   	leave  
  10316a:	c3                   	ret    

0010316b <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  10316b:	55                   	push   %ebp
  10316c:	89 e5                	mov    %esp,%ebp
  10316e:	57                   	push   %edi
  10316f:	83 ec 24             	sub    $0x24,%esp
  103172:	e8 3b d1 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  103177:	05 d9 b7 00 00       	add    $0xb7d9,%eax
  10317c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10317f:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103182:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103186:	8b 55 08             	mov    0x8(%ebp),%edx
  103189:	89 55 f8             	mov    %edx,-0x8(%ebp)
  10318c:	88 45 f7             	mov    %al,-0x9(%ebp)
  10318f:	8b 45 10             	mov    0x10(%ebp),%eax
  103192:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103195:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103198:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10319c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  10319f:	89 d7                	mov    %edx,%edi
  1031a1:	f3 aa                	rep stos %al,%es:(%edi)
  1031a3:	89 fa                	mov    %edi,%edx
  1031a5:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1031a8:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  1031ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1031ae:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1031af:	83 c4 24             	add    $0x24,%esp
  1031b2:	5f                   	pop    %edi
  1031b3:	5d                   	pop    %ebp
  1031b4:	c3                   	ret    

001031b5 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  1031b5:	55                   	push   %ebp
  1031b6:	89 e5                	mov    %esp,%ebp
  1031b8:	57                   	push   %edi
  1031b9:	56                   	push   %esi
  1031ba:	53                   	push   %ebx
  1031bb:	83 ec 30             	sub    $0x30,%esp
  1031be:	e8 ef d0 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1031c3:	05 8d b7 00 00       	add    $0xb78d,%eax
  1031c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1031cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031d4:	8b 45 10             	mov    0x10(%ebp),%eax
  1031d7:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  1031da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031dd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1031e0:	73 42                	jae    103224 <memmove+0x6f>
  1031e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1031e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1031ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1031f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1031f7:	c1 e8 02             	shr    $0x2,%eax
  1031fa:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1031fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103202:	89 d7                	mov    %edx,%edi
  103204:	89 c6                	mov    %eax,%esi
  103206:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103208:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10320b:	83 e1 03             	and    $0x3,%ecx
  10320e:	74 02                	je     103212 <memmove+0x5d>
  103210:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103212:	89 f0                	mov    %esi,%eax
  103214:	89 fa                	mov    %edi,%edx
  103216:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103219:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10321c:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  10321f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  103222:	eb 36                	jmp    10325a <memmove+0xa5>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  103224:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103227:	8d 50 ff             	lea    -0x1(%eax),%edx
  10322a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10322d:	01 c2                	add    %eax,%edx
  10322f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103232:	8d 48 ff             	lea    -0x1(%eax),%ecx
  103235:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103238:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  10323b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10323e:	89 c1                	mov    %eax,%ecx
  103240:	89 d8                	mov    %ebx,%eax
  103242:	89 d6                	mov    %edx,%esi
  103244:	89 c7                	mov    %eax,%edi
  103246:	fd                   	std    
  103247:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103249:	fc                   	cld    
  10324a:	89 f8                	mov    %edi,%eax
  10324c:	89 f2                	mov    %esi,%edx
  10324e:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103251:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103254:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103257:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10325a:	83 c4 30             	add    $0x30,%esp
  10325d:	5b                   	pop    %ebx
  10325e:	5e                   	pop    %esi
  10325f:	5f                   	pop    %edi
  103260:	5d                   	pop    %ebp
  103261:	c3                   	ret    

00103262 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103262:	55                   	push   %ebp
  103263:	89 e5                	mov    %esp,%ebp
  103265:	57                   	push   %edi
  103266:	56                   	push   %esi
  103267:	83 ec 20             	sub    $0x20,%esp
  10326a:	e8 43 d0 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  10326f:	05 e1 b6 00 00       	add    $0xb6e1,%eax
  103274:	8b 45 08             	mov    0x8(%ebp),%eax
  103277:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10327a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10327d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103280:	8b 45 10             	mov    0x10(%ebp),%eax
  103283:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103286:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103289:	c1 e8 02             	shr    $0x2,%eax
  10328c:	89 c1                	mov    %eax,%ecx
    asm volatile (
  10328e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103291:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103294:	89 d7                	mov    %edx,%edi
  103296:	89 c6                	mov    %eax,%esi
  103298:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10329a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10329d:	83 e1 03             	and    $0x3,%ecx
  1032a0:	74 02                	je     1032a4 <memcpy+0x42>
  1032a2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1032a4:	89 f0                	mov    %esi,%eax
  1032a6:	89 fa                	mov    %edi,%edx
  1032a8:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1032ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1032ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  1032b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  1032b4:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1032b5:	83 c4 20             	add    $0x20,%esp
  1032b8:	5e                   	pop    %esi
  1032b9:	5f                   	pop    %edi
  1032ba:	5d                   	pop    %ebp
  1032bb:	c3                   	ret    

001032bc <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1032bc:	55                   	push   %ebp
  1032bd:	89 e5                	mov    %esp,%ebp
  1032bf:	83 ec 10             	sub    $0x10,%esp
  1032c2:	e8 eb cf ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1032c7:	05 89 b6 00 00       	add    $0xb689,%eax
    const char *s1 = (const char *)v1;
  1032cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1032cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1032d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  1032d8:	eb 30                	jmp    10330a <memcmp+0x4e>
        if (*s1 != *s2) {
  1032da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032dd:	0f b6 10             	movzbl (%eax),%edx
  1032e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032e3:	0f b6 00             	movzbl (%eax),%eax
  1032e6:	38 c2                	cmp    %al,%dl
  1032e8:	74 18                	je     103302 <memcmp+0x46>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1032ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032ed:	0f b6 00             	movzbl (%eax),%eax
  1032f0:	0f b6 d0             	movzbl %al,%edx
  1032f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032f6:	0f b6 00             	movzbl (%eax),%eax
  1032f9:	0f b6 c0             	movzbl %al,%eax
  1032fc:	29 c2                	sub    %eax,%edx
  1032fe:	89 d0                	mov    %edx,%eax
  103300:	eb 1a                	jmp    10331c <memcmp+0x60>
        }
        s1 ++, s2 ++;
  103302:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  103306:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  10330a:	8b 45 10             	mov    0x10(%ebp),%eax
  10330d:	8d 50 ff             	lea    -0x1(%eax),%edx
  103310:	89 55 10             	mov    %edx,0x10(%ebp)
  103313:	85 c0                	test   %eax,%eax
  103315:	75 c3                	jne    1032da <memcmp+0x1e>
    }
    return 0;
  103317:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10331c:	c9                   	leave  
  10331d:	c3                   	ret    

0010331e <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10331e:	55                   	push   %ebp
  10331f:	89 e5                	mov    %esp,%ebp
  103321:	53                   	push   %ebx
  103322:	83 ec 34             	sub    $0x34,%esp
  103325:	e8 8c cf ff ff       	call   1002b6 <__x86.get_pc_thunk.bx>
  10332a:	81 c3 26 b6 00 00    	add    $0xb626,%ebx
  103330:	8b 45 10             	mov    0x10(%ebp),%eax
  103333:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103336:	8b 45 14             	mov    0x14(%ebp),%eax
  103339:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10333c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10333f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103342:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103345:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103348:	8b 45 18             	mov    0x18(%ebp),%eax
  10334b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10334e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103351:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103354:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103357:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10335a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10335d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103360:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103364:	74 1c                	je     103382 <printnum+0x64>
  103366:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103369:	ba 00 00 00 00       	mov    $0x0,%edx
  10336e:	f7 75 e4             	divl   -0x1c(%ebp)
  103371:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103374:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103377:	ba 00 00 00 00       	mov    $0x0,%edx
  10337c:	f7 75 e4             	divl   -0x1c(%ebp)
  10337f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103382:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103385:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103388:	f7 75 e4             	divl   -0x1c(%ebp)
  10338b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10338e:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103391:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103394:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103397:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10339a:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10339d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1033a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1033a3:	8b 45 18             	mov    0x18(%ebp),%eax
  1033a6:	ba 00 00 00 00       	mov    $0x0,%edx
  1033ab:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1033ae:	72 41                	jb     1033f1 <printnum+0xd3>
  1033b0:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1033b3:	77 05                	ja     1033ba <printnum+0x9c>
  1033b5:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1033b8:	72 37                	jb     1033f1 <printnum+0xd3>
        printnum(putch, putdat, result, base, width - 1, padc);
  1033ba:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1033bd:	83 e8 01             	sub    $0x1,%eax
  1033c0:	83 ec 04             	sub    $0x4,%esp
  1033c3:	ff 75 20             	pushl  0x20(%ebp)
  1033c6:	50                   	push   %eax
  1033c7:	ff 75 18             	pushl  0x18(%ebp)
  1033ca:	ff 75 ec             	pushl  -0x14(%ebp)
  1033cd:	ff 75 e8             	pushl  -0x18(%ebp)
  1033d0:	ff 75 0c             	pushl  0xc(%ebp)
  1033d3:	ff 75 08             	pushl  0x8(%ebp)
  1033d6:	e8 43 ff ff ff       	call   10331e <printnum>
  1033db:	83 c4 20             	add    $0x20,%esp
  1033de:	eb 1b                	jmp    1033fb <printnum+0xdd>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1033e0:	83 ec 08             	sub    $0x8,%esp
  1033e3:	ff 75 0c             	pushl  0xc(%ebp)
  1033e6:	ff 75 20             	pushl  0x20(%ebp)
  1033e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ec:	ff d0                	call   *%eax
  1033ee:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  1033f1:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  1033f5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1033f9:	7f e5                	jg     1033e0 <printnum+0xc2>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1033fb:	8d 93 76 57 ff ff    	lea    -0xa88a(%ebx),%edx
  103401:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103404:	01 d0                	add    %edx,%eax
  103406:	0f b6 00             	movzbl (%eax),%eax
  103409:	0f be c0             	movsbl %al,%eax
  10340c:	83 ec 08             	sub    $0x8,%esp
  10340f:	ff 75 0c             	pushl  0xc(%ebp)
  103412:	50                   	push   %eax
  103413:	8b 45 08             	mov    0x8(%ebp),%eax
  103416:	ff d0                	call   *%eax
  103418:	83 c4 10             	add    $0x10,%esp
}
  10341b:	90                   	nop
  10341c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10341f:	c9                   	leave  
  103420:	c3                   	ret    

00103421 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103421:	55                   	push   %ebp
  103422:	89 e5                	mov    %esp,%ebp
  103424:	e8 89 ce ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  103429:	05 27 b5 00 00       	add    $0xb527,%eax
    if (lflag >= 2) {
  10342e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103432:	7e 14                	jle    103448 <getuint+0x27>
        return va_arg(*ap, unsigned long long);
  103434:	8b 45 08             	mov    0x8(%ebp),%eax
  103437:	8b 00                	mov    (%eax),%eax
  103439:	8d 48 08             	lea    0x8(%eax),%ecx
  10343c:	8b 55 08             	mov    0x8(%ebp),%edx
  10343f:	89 0a                	mov    %ecx,(%edx)
  103441:	8b 50 04             	mov    0x4(%eax),%edx
  103444:	8b 00                	mov    (%eax),%eax
  103446:	eb 30                	jmp    103478 <getuint+0x57>
    }
    else if (lflag) {
  103448:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10344c:	74 16                	je     103464 <getuint+0x43>
        return va_arg(*ap, unsigned long);
  10344e:	8b 45 08             	mov    0x8(%ebp),%eax
  103451:	8b 00                	mov    (%eax),%eax
  103453:	8d 48 04             	lea    0x4(%eax),%ecx
  103456:	8b 55 08             	mov    0x8(%ebp),%edx
  103459:	89 0a                	mov    %ecx,(%edx)
  10345b:	8b 00                	mov    (%eax),%eax
  10345d:	ba 00 00 00 00       	mov    $0x0,%edx
  103462:	eb 14                	jmp    103478 <getuint+0x57>
    }
    else {
        return va_arg(*ap, unsigned int);
  103464:	8b 45 08             	mov    0x8(%ebp),%eax
  103467:	8b 00                	mov    (%eax),%eax
  103469:	8d 48 04             	lea    0x4(%eax),%ecx
  10346c:	8b 55 08             	mov    0x8(%ebp),%edx
  10346f:	89 0a                	mov    %ecx,(%edx)
  103471:	8b 00                	mov    (%eax),%eax
  103473:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103478:	5d                   	pop    %ebp
  103479:	c3                   	ret    

0010347a <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  10347a:	55                   	push   %ebp
  10347b:	89 e5                	mov    %esp,%ebp
  10347d:	e8 30 ce ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  103482:	05 ce b4 00 00       	add    $0xb4ce,%eax
    if (lflag >= 2) {
  103487:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10348b:	7e 14                	jle    1034a1 <getint+0x27>
        return va_arg(*ap, long long);
  10348d:	8b 45 08             	mov    0x8(%ebp),%eax
  103490:	8b 00                	mov    (%eax),%eax
  103492:	8d 48 08             	lea    0x8(%eax),%ecx
  103495:	8b 55 08             	mov    0x8(%ebp),%edx
  103498:	89 0a                	mov    %ecx,(%edx)
  10349a:	8b 50 04             	mov    0x4(%eax),%edx
  10349d:	8b 00                	mov    (%eax),%eax
  10349f:	eb 28                	jmp    1034c9 <getint+0x4f>
    }
    else if (lflag) {
  1034a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1034a5:	74 12                	je     1034b9 <getint+0x3f>
        return va_arg(*ap, long);
  1034a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1034aa:	8b 00                	mov    (%eax),%eax
  1034ac:	8d 48 04             	lea    0x4(%eax),%ecx
  1034af:	8b 55 08             	mov    0x8(%ebp),%edx
  1034b2:	89 0a                	mov    %ecx,(%edx)
  1034b4:	8b 00                	mov    (%eax),%eax
  1034b6:	99                   	cltd   
  1034b7:	eb 10                	jmp    1034c9 <getint+0x4f>
    }
    else {
        return va_arg(*ap, int);
  1034b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1034bc:	8b 00                	mov    (%eax),%eax
  1034be:	8d 48 04             	lea    0x4(%eax),%ecx
  1034c1:	8b 55 08             	mov    0x8(%ebp),%edx
  1034c4:	89 0a                	mov    %ecx,(%edx)
  1034c6:	8b 00                	mov    (%eax),%eax
  1034c8:	99                   	cltd   
    }
}
  1034c9:	5d                   	pop    %ebp
  1034ca:	c3                   	ret    

001034cb <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1034cb:	55                   	push   %ebp
  1034cc:	89 e5                	mov    %esp,%ebp
  1034ce:	83 ec 18             	sub    $0x18,%esp
  1034d1:	e8 dc cd ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1034d6:	05 7a b4 00 00       	add    $0xb47a,%eax
    va_list ap;

    va_start(ap, fmt);
  1034db:	8d 45 14             	lea    0x14(%ebp),%eax
  1034de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1034e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034e4:	50                   	push   %eax
  1034e5:	ff 75 10             	pushl  0x10(%ebp)
  1034e8:	ff 75 0c             	pushl  0xc(%ebp)
  1034eb:	ff 75 08             	pushl  0x8(%ebp)
  1034ee:	e8 06 00 00 00       	call   1034f9 <vprintfmt>
  1034f3:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1034f6:	90                   	nop
  1034f7:	c9                   	leave  
  1034f8:	c3                   	ret    

001034f9 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1034f9:	55                   	push   %ebp
  1034fa:	89 e5                	mov    %esp,%ebp
  1034fc:	57                   	push   %edi
  1034fd:	56                   	push   %esi
  1034fe:	53                   	push   %ebx
  1034ff:	83 ec 2c             	sub    $0x2c,%esp
  103502:	e8 8c 04 00 00       	call   103993 <__x86.get_pc_thunk.di>
  103507:	81 c7 49 b4 00 00    	add    $0xb449,%edi
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10350d:	eb 17                	jmp    103526 <vprintfmt+0x2d>
            if (ch == '\0') {
  10350f:	85 db                	test   %ebx,%ebx
  103511:	0f 84 9a 03 00 00    	je     1038b1 <.L24+0x2d>
                return;
            }
            putch(ch, putdat);
  103517:	83 ec 08             	sub    $0x8,%esp
  10351a:	ff 75 0c             	pushl  0xc(%ebp)
  10351d:	53                   	push   %ebx
  10351e:	8b 45 08             	mov    0x8(%ebp),%eax
  103521:	ff d0                	call   *%eax
  103523:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103526:	8b 45 10             	mov    0x10(%ebp),%eax
  103529:	8d 50 01             	lea    0x1(%eax),%edx
  10352c:	89 55 10             	mov    %edx,0x10(%ebp)
  10352f:	0f b6 00             	movzbl (%eax),%eax
  103532:	0f b6 d8             	movzbl %al,%ebx
  103535:	83 fb 25             	cmp    $0x25,%ebx
  103538:	75 d5                	jne    10350f <vprintfmt+0x16>
        }

        // Process a %-escape sequence
        char padc = ' ';
  10353a:	c6 45 cb 20          	movb   $0x20,-0x35(%ebp)
        width = precision = -1;
  10353e:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  103545:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103548:	89 45 d8             	mov    %eax,-0x28(%ebp)
        lflag = altflag = 0;
  10354b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  103552:	8b 45 cc             	mov    -0x34(%ebp),%eax
  103555:	89 45 d0             	mov    %eax,-0x30(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103558:	8b 45 10             	mov    0x10(%ebp),%eax
  10355b:	8d 50 01             	lea    0x1(%eax),%edx
  10355e:	89 55 10             	mov    %edx,0x10(%ebp)
  103561:	0f b6 00             	movzbl (%eax),%eax
  103564:	0f b6 d8             	movzbl %al,%ebx
  103567:	8d 43 dd             	lea    -0x23(%ebx),%eax
  10356a:	83 f8 55             	cmp    $0x55,%eax
  10356d:	0f 87 11 03 00 00    	ja     103884 <.L24>
  103573:	c1 e0 02             	shl    $0x2,%eax
  103576:	8b 84 38 9c 57 ff ff 	mov    -0xa864(%eax,%edi,1),%eax
  10357d:	01 f8                	add    %edi,%eax
  10357f:	ff e0                	jmp    *%eax

00103581 <.L29>:

        // flag to pad on the right
        case '-':
            padc = '-';
  103581:	c6 45 cb 2d          	movb   $0x2d,-0x35(%ebp)
            goto reswitch;
  103585:	eb d1                	jmp    103558 <vprintfmt+0x5f>

00103587 <.L31>:

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  103587:	c6 45 cb 30          	movb   $0x30,-0x35(%ebp)
            goto reswitch;
  10358b:	eb cb                	jmp    103558 <vprintfmt+0x5f>

0010358d <.L32>:

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  10358d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
                precision = precision * 10 + ch - '0';
  103594:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103597:	89 d0                	mov    %edx,%eax
  103599:	c1 e0 02             	shl    $0x2,%eax
  10359c:	01 d0                	add    %edx,%eax
  10359e:	01 c0                	add    %eax,%eax
  1035a0:	01 d8                	add    %ebx,%eax
  1035a2:	83 e8 30             	sub    $0x30,%eax
  1035a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                ch = *fmt;
  1035a8:	8b 45 10             	mov    0x10(%ebp),%eax
  1035ab:	0f b6 00             	movzbl (%eax),%eax
  1035ae:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1035b1:	83 fb 2f             	cmp    $0x2f,%ebx
  1035b4:	7e 39                	jle    1035ef <.L25+0xc>
  1035b6:	83 fb 39             	cmp    $0x39,%ebx
  1035b9:	7f 34                	jg     1035ef <.L25+0xc>
            for (precision = 0; ; ++ fmt) {
  1035bb:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1035bf:	eb d3                	jmp    103594 <.L32+0x7>

001035c1 <.L28>:
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1035c1:	8b 45 14             	mov    0x14(%ebp),%eax
  1035c4:	8d 50 04             	lea    0x4(%eax),%edx
  1035c7:	89 55 14             	mov    %edx,0x14(%ebp)
  1035ca:	8b 00                	mov    (%eax),%eax
  1035cc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            goto process_precision;
  1035cf:	eb 1f                	jmp    1035f0 <.L25+0xd>

001035d1 <.L30>:

        case '.':
            if (width < 0)
  1035d1:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1035d5:	79 81                	jns    103558 <vprintfmt+0x5f>
                width = 0;
  1035d7:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
            goto reswitch;
  1035de:	e9 75 ff ff ff       	jmp    103558 <vprintfmt+0x5f>

001035e3 <.L25>:

        case '#':
            altflag = 1;
  1035e3:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
            goto reswitch;
  1035ea:	e9 69 ff ff ff       	jmp    103558 <vprintfmt+0x5f>
            goto process_precision;
  1035ef:	90                   	nop

        process_precision:
            if (width < 0)
  1035f0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1035f4:	0f 89 5e ff ff ff    	jns    103558 <vprintfmt+0x5f>
                width = precision, precision = -1;
  1035fa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1035fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
  103600:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
            goto reswitch;
  103607:	e9 4c ff ff ff       	jmp    103558 <vprintfmt+0x5f>

0010360c <.L36>:

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10360c:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
            goto reswitch;
  103610:	e9 43 ff ff ff       	jmp    103558 <vprintfmt+0x5f>

00103615 <.L33>:

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103615:	8b 45 14             	mov    0x14(%ebp),%eax
  103618:	8d 50 04             	lea    0x4(%eax),%edx
  10361b:	89 55 14             	mov    %edx,0x14(%ebp)
  10361e:	8b 00                	mov    (%eax),%eax
  103620:	83 ec 08             	sub    $0x8,%esp
  103623:	ff 75 0c             	pushl  0xc(%ebp)
  103626:	50                   	push   %eax
  103627:	8b 45 08             	mov    0x8(%ebp),%eax
  10362a:	ff d0                	call   *%eax
  10362c:	83 c4 10             	add    $0x10,%esp
            break;
  10362f:	e9 78 02 00 00       	jmp    1038ac <.L24+0x28>

00103634 <.L35>:

        // error message
        case 'e':
            err = va_arg(ap, int);
  103634:	8b 45 14             	mov    0x14(%ebp),%eax
  103637:	8d 50 04             	lea    0x4(%eax),%edx
  10363a:	89 55 14             	mov    %edx,0x14(%ebp)
  10363d:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  10363f:	85 db                	test   %ebx,%ebx
  103641:	79 02                	jns    103645 <.L35+0x11>
                err = -err;
  103643:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103645:	83 fb 06             	cmp    $0x6,%ebx
  103648:	7f 0b                	jg     103655 <.L35+0x21>
  10364a:	8b b4 9f 40 01 00 00 	mov    0x140(%edi,%ebx,4),%esi
  103651:	85 f6                	test   %esi,%esi
  103653:	75 1b                	jne    103670 <.L35+0x3c>
                printfmt(putch, putdat, "error %d", err);
  103655:	53                   	push   %ebx
  103656:	8d 87 87 57 ff ff    	lea    -0xa879(%edi),%eax
  10365c:	50                   	push   %eax
  10365d:	ff 75 0c             	pushl  0xc(%ebp)
  103660:	ff 75 08             	pushl  0x8(%ebp)
  103663:	e8 63 fe ff ff       	call   1034cb <printfmt>
  103668:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  10366b:	e9 3c 02 00 00       	jmp    1038ac <.L24+0x28>
                printfmt(putch, putdat, "%s", p);
  103670:	56                   	push   %esi
  103671:	8d 87 90 57 ff ff    	lea    -0xa870(%edi),%eax
  103677:	50                   	push   %eax
  103678:	ff 75 0c             	pushl  0xc(%ebp)
  10367b:	ff 75 08             	pushl  0x8(%ebp)
  10367e:	e8 48 fe ff ff       	call   1034cb <printfmt>
  103683:	83 c4 10             	add    $0x10,%esp
            break;
  103686:	e9 21 02 00 00       	jmp    1038ac <.L24+0x28>

0010368b <.L39>:

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  10368b:	8b 45 14             	mov    0x14(%ebp),%eax
  10368e:	8d 50 04             	lea    0x4(%eax),%edx
  103691:	89 55 14             	mov    %edx,0x14(%ebp)
  103694:	8b 30                	mov    (%eax),%esi
  103696:	85 f6                	test   %esi,%esi
  103698:	75 06                	jne    1036a0 <.L39+0x15>
                p = "(null)";
  10369a:	8d b7 93 57 ff ff    	lea    -0xa86d(%edi),%esi
            }
            if (width > 0 && padc != '-') {
  1036a0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036a4:	7e 78                	jle    10371e <.L39+0x93>
  1036a6:	80 7d cb 2d          	cmpb   $0x2d,-0x35(%ebp)
  1036aa:	74 72                	je     10371e <.L39+0x93>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1036ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1036af:	83 ec 08             	sub    $0x8,%esp
  1036b2:	50                   	push   %eax
  1036b3:	56                   	push   %esi
  1036b4:	89 fb                	mov    %edi,%ebx
  1036b6:	e8 57 f7 ff ff       	call   102e12 <strnlen>
  1036bb:	83 c4 10             	add    $0x10,%esp
  1036be:	89 c2                	mov    %eax,%edx
  1036c0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1036c3:	29 d0                	sub    %edx,%eax
  1036c5:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1036c8:	eb 17                	jmp    1036e1 <.L39+0x56>
                    putch(padc, putdat);
  1036ca:	0f be 45 cb          	movsbl -0x35(%ebp),%eax
  1036ce:	83 ec 08             	sub    $0x8,%esp
  1036d1:	ff 75 0c             	pushl  0xc(%ebp)
  1036d4:	50                   	push   %eax
  1036d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1036d8:	ff d0                	call   *%eax
  1036da:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  1036dd:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1036e1:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036e5:	7f e3                	jg     1036ca <.L39+0x3f>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1036e7:	eb 35                	jmp    10371e <.L39+0x93>
                if (altflag && (ch < ' ' || ch > '~')) {
  1036e9:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1036ed:	74 1c                	je     10370b <.L39+0x80>
  1036ef:	83 fb 1f             	cmp    $0x1f,%ebx
  1036f2:	7e 05                	jle    1036f9 <.L39+0x6e>
  1036f4:	83 fb 7e             	cmp    $0x7e,%ebx
  1036f7:	7e 12                	jle    10370b <.L39+0x80>
                    putch('?', putdat);
  1036f9:	83 ec 08             	sub    $0x8,%esp
  1036fc:	ff 75 0c             	pushl  0xc(%ebp)
  1036ff:	6a 3f                	push   $0x3f
  103701:	8b 45 08             	mov    0x8(%ebp),%eax
  103704:	ff d0                	call   *%eax
  103706:	83 c4 10             	add    $0x10,%esp
  103709:	eb 0f                	jmp    10371a <.L39+0x8f>
                }
                else {
                    putch(ch, putdat);
  10370b:	83 ec 08             	sub    $0x8,%esp
  10370e:	ff 75 0c             	pushl  0xc(%ebp)
  103711:	53                   	push   %ebx
  103712:	8b 45 08             	mov    0x8(%ebp),%eax
  103715:	ff d0                	call   *%eax
  103717:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10371a:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10371e:	89 f0                	mov    %esi,%eax
  103720:	8d 70 01             	lea    0x1(%eax),%esi
  103723:	0f b6 00             	movzbl (%eax),%eax
  103726:	0f be d8             	movsbl %al,%ebx
  103729:	85 db                	test   %ebx,%ebx
  10372b:	74 26                	je     103753 <.L39+0xc8>
  10372d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  103731:	78 b6                	js     1036e9 <.L39+0x5e>
  103733:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
  103737:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  10373b:	79 ac                	jns    1036e9 <.L39+0x5e>
                }
            }
            for (; width > 0; width --) {
  10373d:	eb 14                	jmp    103753 <.L39+0xc8>
                putch(' ', putdat);
  10373f:	83 ec 08             	sub    $0x8,%esp
  103742:	ff 75 0c             	pushl  0xc(%ebp)
  103745:	6a 20                	push   $0x20
  103747:	8b 45 08             	mov    0x8(%ebp),%eax
  10374a:	ff d0                	call   *%eax
  10374c:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  10374f:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  103753:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103757:	7f e6                	jg     10373f <.L39+0xb4>
            }
            break;
  103759:	e9 4e 01 00 00       	jmp    1038ac <.L24+0x28>

0010375e <.L34>:

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10375e:	83 ec 08             	sub    $0x8,%esp
  103761:	ff 75 d0             	pushl  -0x30(%ebp)
  103764:	8d 45 14             	lea    0x14(%ebp),%eax
  103767:	50                   	push   %eax
  103768:	e8 0d fd ff ff       	call   10347a <getint>
  10376d:	83 c4 10             	add    $0x10,%esp
  103770:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103773:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            if ((long long)num < 0) {
  103776:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103779:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10377c:	85 d2                	test   %edx,%edx
  10377e:	79 23                	jns    1037a3 <.L34+0x45>
                putch('-', putdat);
  103780:	83 ec 08             	sub    $0x8,%esp
  103783:	ff 75 0c             	pushl  0xc(%ebp)
  103786:	6a 2d                	push   $0x2d
  103788:	8b 45 08             	mov    0x8(%ebp),%eax
  10378b:	ff d0                	call   *%eax
  10378d:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  103790:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103793:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103796:	f7 d8                	neg    %eax
  103798:	83 d2 00             	adc    $0x0,%edx
  10379b:	f7 da                	neg    %edx
  10379d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037a0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            }
            base = 10;
  1037a3:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1037aa:	e9 9f 00 00 00       	jmp    10384e <.L41+0x1f>

001037af <.L40>:

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1037af:	83 ec 08             	sub    $0x8,%esp
  1037b2:	ff 75 d0             	pushl  -0x30(%ebp)
  1037b5:	8d 45 14             	lea    0x14(%ebp),%eax
  1037b8:	50                   	push   %eax
  1037b9:	e8 63 fc ff ff       	call   103421 <getuint>
  1037be:	83 c4 10             	add    $0x10,%esp
  1037c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037c4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 10;
  1037c7:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1037ce:	eb 7e                	jmp    10384e <.L41+0x1f>

001037d0 <.L37>:

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1037d0:	83 ec 08             	sub    $0x8,%esp
  1037d3:	ff 75 d0             	pushl  -0x30(%ebp)
  1037d6:	8d 45 14             	lea    0x14(%ebp),%eax
  1037d9:	50                   	push   %eax
  1037da:	e8 42 fc ff ff       	call   103421 <getuint>
  1037df:	83 c4 10             	add    $0x10,%esp
  1037e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037e5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 8;
  1037e8:	c7 45 dc 08 00 00 00 	movl   $0x8,-0x24(%ebp)
            goto number;
  1037ef:	eb 5d                	jmp    10384e <.L41+0x1f>

001037f1 <.L38>:

        // pointer
        case 'p':
            putch('0', putdat);
  1037f1:	83 ec 08             	sub    $0x8,%esp
  1037f4:	ff 75 0c             	pushl  0xc(%ebp)
  1037f7:	6a 30                	push   $0x30
  1037f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1037fc:	ff d0                	call   *%eax
  1037fe:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  103801:	83 ec 08             	sub    $0x8,%esp
  103804:	ff 75 0c             	pushl  0xc(%ebp)
  103807:	6a 78                	push   $0x78
  103809:	8b 45 08             	mov    0x8(%ebp),%eax
  10380c:	ff d0                	call   *%eax
  10380e:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103811:	8b 45 14             	mov    0x14(%ebp),%eax
  103814:	8d 50 04             	lea    0x4(%eax),%edx
  103817:	89 55 14             	mov    %edx,0x14(%ebp)
  10381a:	8b 00                	mov    (%eax),%eax
  10381c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10381f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            base = 16;
  103826:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
            goto number;
  10382d:	eb 1f                	jmp    10384e <.L41+0x1f>

0010382f <.L41>:

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10382f:	83 ec 08             	sub    $0x8,%esp
  103832:	ff 75 d0             	pushl  -0x30(%ebp)
  103835:	8d 45 14             	lea    0x14(%ebp),%eax
  103838:	50                   	push   %eax
  103839:	e8 e3 fb ff ff       	call   103421 <getuint>
  10383e:	83 c4 10             	add    $0x10,%esp
  103841:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103844:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 16;
  103847:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10384e:	0f be 55 cb          	movsbl -0x35(%ebp),%edx
  103852:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103855:	83 ec 04             	sub    $0x4,%esp
  103858:	52                   	push   %edx
  103859:	ff 75 d8             	pushl  -0x28(%ebp)
  10385c:	50                   	push   %eax
  10385d:	ff 75 e4             	pushl  -0x1c(%ebp)
  103860:	ff 75 e0             	pushl  -0x20(%ebp)
  103863:	ff 75 0c             	pushl  0xc(%ebp)
  103866:	ff 75 08             	pushl  0x8(%ebp)
  103869:	e8 b0 fa ff ff       	call   10331e <printnum>
  10386e:	83 c4 20             	add    $0x20,%esp
            break;
  103871:	eb 39                	jmp    1038ac <.L24+0x28>

00103873 <.L27>:

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103873:	83 ec 08             	sub    $0x8,%esp
  103876:	ff 75 0c             	pushl  0xc(%ebp)
  103879:	53                   	push   %ebx
  10387a:	8b 45 08             	mov    0x8(%ebp),%eax
  10387d:	ff d0                	call   *%eax
  10387f:	83 c4 10             	add    $0x10,%esp
            break;
  103882:	eb 28                	jmp    1038ac <.L24+0x28>

00103884 <.L24>:

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103884:	83 ec 08             	sub    $0x8,%esp
  103887:	ff 75 0c             	pushl  0xc(%ebp)
  10388a:	6a 25                	push   $0x25
  10388c:	8b 45 08             	mov    0x8(%ebp),%eax
  10388f:	ff d0                	call   *%eax
  103891:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  103894:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103898:	eb 04                	jmp    10389e <.L24+0x1a>
  10389a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10389e:	8b 45 10             	mov    0x10(%ebp),%eax
  1038a1:	83 e8 01             	sub    $0x1,%eax
  1038a4:	0f b6 00             	movzbl (%eax),%eax
  1038a7:	3c 25                	cmp    $0x25,%al
  1038a9:	75 ef                	jne    10389a <.L24+0x16>
                /* do nothing */;
            break;
  1038ab:	90                   	nop
    while (1) {
  1038ac:	e9 5c fc ff ff       	jmp    10350d <vprintfmt+0x14>
                return;
  1038b1:	90                   	nop
        }
    }
}
  1038b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1038b5:	5b                   	pop    %ebx
  1038b6:	5e                   	pop    %esi
  1038b7:	5f                   	pop    %edi
  1038b8:	5d                   	pop    %ebp
  1038b9:	c3                   	ret    

001038ba <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1038ba:	55                   	push   %ebp
  1038bb:	89 e5                	mov    %esp,%ebp
  1038bd:	e8 f0 c9 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  1038c2:	05 8e b0 00 00       	add    $0xb08e,%eax
    b->cnt ++;
  1038c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038ca:	8b 40 08             	mov    0x8(%eax),%eax
  1038cd:	8d 50 01             	lea    0x1(%eax),%edx
  1038d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038d3:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1038d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038d9:	8b 10                	mov    (%eax),%edx
  1038db:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038de:	8b 40 04             	mov    0x4(%eax),%eax
  1038e1:	39 c2                	cmp    %eax,%edx
  1038e3:	73 12                	jae    1038f7 <sprintputch+0x3d>
        *b->buf ++ = ch;
  1038e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038e8:	8b 00                	mov    (%eax),%eax
  1038ea:	8d 48 01             	lea    0x1(%eax),%ecx
  1038ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  1038f0:	89 0a                	mov    %ecx,(%edx)
  1038f2:	8b 55 08             	mov    0x8(%ebp),%edx
  1038f5:	88 10                	mov    %dl,(%eax)
    }
}
  1038f7:	90                   	nop
  1038f8:	5d                   	pop    %ebp
  1038f9:	c3                   	ret    

001038fa <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1038fa:	55                   	push   %ebp
  1038fb:	89 e5                	mov    %esp,%ebp
  1038fd:	83 ec 18             	sub    $0x18,%esp
  103900:	e8 ad c9 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  103905:	05 4b b0 00 00       	add    $0xb04b,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10390a:	8d 45 14             	lea    0x14(%ebp),%eax
  10390d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103910:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103913:	50                   	push   %eax
  103914:	ff 75 10             	pushl  0x10(%ebp)
  103917:	ff 75 0c             	pushl  0xc(%ebp)
  10391a:	ff 75 08             	pushl  0x8(%ebp)
  10391d:	e8 0b 00 00 00       	call   10392d <vsnprintf>
  103922:	83 c4 10             	add    $0x10,%esp
  103925:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103928:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10392b:	c9                   	leave  
  10392c:	c3                   	ret    

0010392d <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10392d:	55                   	push   %ebp
  10392e:	89 e5                	mov    %esp,%ebp
  103930:	83 ec 18             	sub    $0x18,%esp
  103933:	e8 7a c9 ff ff       	call   1002b2 <__x86.get_pc_thunk.ax>
  103938:	05 18 b0 00 00       	add    $0xb018,%eax
    struct sprintbuf b = {str, str + size - 1, 0};
  10393d:	8b 55 08             	mov    0x8(%ebp),%edx
  103940:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103943:	8b 55 0c             	mov    0xc(%ebp),%edx
  103946:	8d 4a ff             	lea    -0x1(%edx),%ecx
  103949:	8b 55 08             	mov    0x8(%ebp),%edx
  10394c:	01 ca                	add    %ecx,%edx
  10394e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103951:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103958:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10395c:	74 0a                	je     103968 <vsnprintf+0x3b>
  10395e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103961:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103964:	39 d1                	cmp    %edx,%ecx
  103966:	76 07                	jbe    10396f <vsnprintf+0x42>
        return -E_INVAL;
  103968:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10396d:	eb 22                	jmp    103991 <vsnprintf+0x64>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10396f:	ff 75 14             	pushl  0x14(%ebp)
  103972:	ff 75 10             	pushl  0x10(%ebp)
  103975:	8d 55 ec             	lea    -0x14(%ebp),%edx
  103978:	52                   	push   %edx
  103979:	8d 80 6a 4f ff ff    	lea    -0xb096(%eax),%eax
  10397f:	50                   	push   %eax
  103980:	e8 74 fb ff ff       	call   1034f9 <vprintfmt>
  103985:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  103988:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10398b:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10398e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103991:	c9                   	leave  
  103992:	c3                   	ret    

00103993 <__x86.get_pc_thunk.di>:
  103993:	8b 3c 24             	mov    (%esp),%edi
  103996:	c3                   	ret    
