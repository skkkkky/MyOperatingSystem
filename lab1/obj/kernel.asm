
bin/kernel：     文件格式 elf32-i386


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
  100007:	e8 74 02 00 00       	call   100280 <__x86.get_pc_thunk.bx>
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
  100031:	e8 fc 30 00 00       	call   103132 <memset>
  100036:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100039:	e8 03 18 00 00       	call   101841 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10003e:	8d 83 10 50 ff ff    	lea    -0xaff0(%ebx),%eax
  100044:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100047:	83 ec 08             	sub    $0x8,%esp
  10004a:	ff 75 f4             	pushl  -0xc(%ebp)
  10004d:	8d 83 2c 50 ff ff    	lea    -0xafd4(%ebx),%eax
  100053:	50                   	push   %eax
  100054:	e8 9a 02 00 00       	call   1002f3 <cprintf>
  100059:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  10005c:	e8 d1 09 00 00       	call   100a32 <print_kerninfo>

    grade_backtrace();
  100061:	e8 98 00 00 00       	call   1000fe <grade_backtrace>

    pmm_init();                 // init physical memory management
  100066:	e8 27 2d 00 00       	call   102d92 <pmm_init>

    pic_init();                 // init interrupt controller
  10006b:	e8 60 19 00 00       	call   1019d0 <pic_init>
    idt_init();                 // init interrupt descriptor table
  100070:	e8 f2 1a 00 00       	call   101b67 <idt_init>

    clock_init();               // init clock interrupt
  100075:	e8 c3 0e 00 00       	call   100f3d <clock_init>
    intr_enable();              // enable irq interrupt
  10007a:	e8 99 1a 00 00       	call   101b18 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  10007f:	eb fe                	jmp    10007f <kern_init+0x7f>

00100081 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100081:	55                   	push   %ebp
  100082:	89 e5                	mov    %esp,%ebp
  100084:	53                   	push   %ebx
  100085:	83 ec 04             	sub    $0x4,%esp
  100088:	e8 ef 01 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  10008d:	05 c3 e8 00 00       	add    $0xe8c3,%eax
    mon_backtrace(0, NULL, NULL);
  100092:	83 ec 04             	sub    $0x4,%esp
  100095:	6a 00                	push   $0x0
  100097:	6a 00                	push   $0x0
  100099:	6a 00                	push   $0x0
  10009b:	89 c3                	mov    %eax,%ebx
  10009d:	e8 78 0e 00 00       	call   100f1a <mon_backtrace>
  1000a2:	83 c4 10             	add    $0x10,%esp
}
  1000a5:	90                   	nop
  1000a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000a9:	c9                   	leave  
  1000aa:	c3                   	ret    

001000ab <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000ab:	55                   	push   %ebp
  1000ac:	89 e5                	mov    %esp,%ebp
  1000ae:	53                   	push   %ebx
  1000af:	83 ec 04             	sub    $0x4,%esp
  1000b2:	e8 c5 01 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  1000b7:	05 99 e8 00 00       	add    $0xe899,%eax
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000bc:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000c2:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1000c8:	51                   	push   %ecx
  1000c9:	52                   	push   %edx
  1000ca:	53                   	push   %ebx
  1000cb:	50                   	push   %eax
  1000cc:	e8 b0 ff ff ff       	call   100081 <grade_backtrace2>
  1000d1:	83 c4 10             	add    $0x10,%esp
}
  1000d4:	90                   	nop
  1000d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000d8:	c9                   	leave  
  1000d9:	c3                   	ret    

001000da <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000da:	55                   	push   %ebp
  1000db:	89 e5                	mov    %esp,%ebp
  1000dd:	83 ec 08             	sub    $0x8,%esp
  1000e0:	e8 97 01 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  1000e5:	05 6b e8 00 00       	add    $0xe86b,%eax
    grade_backtrace1(arg0, arg2);
  1000ea:	83 ec 08             	sub    $0x8,%esp
  1000ed:	ff 75 10             	pushl  0x10(%ebp)
  1000f0:	ff 75 08             	pushl  0x8(%ebp)
  1000f3:	e8 b3 ff ff ff       	call   1000ab <grade_backtrace1>
  1000f8:	83 c4 10             	add    $0x10,%esp
}
  1000fb:	90                   	nop
  1000fc:	c9                   	leave  
  1000fd:	c3                   	ret    

001000fe <grade_backtrace>:

void
grade_backtrace(void) {
  1000fe:	55                   	push   %ebp
  1000ff:	89 e5                	mov    %esp,%ebp
  100101:	83 ec 08             	sub    $0x8,%esp
  100104:	e8 73 01 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  100109:	05 47 e8 00 00       	add    $0xe847,%eax
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  10010e:	8d 80 b0 16 ff ff    	lea    -0xe950(%eax),%eax
  100114:	83 ec 04             	sub    $0x4,%esp
  100117:	68 00 00 ff ff       	push   $0xffff0000
  10011c:	50                   	push   %eax
  10011d:	6a 00                	push   $0x0
  10011f:	e8 b6 ff ff ff       	call   1000da <grade_backtrace0>
  100124:	83 c4 10             	add    $0x10,%esp
}
  100127:	90                   	nop
  100128:	c9                   	leave  
  100129:	c3                   	ret    

0010012a <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10012a:	55                   	push   %ebp
  10012b:	89 e5                	mov    %esp,%ebp
  10012d:	53                   	push   %ebx
  10012e:	83 ec 14             	sub    $0x14,%esp
  100131:	e8 4a 01 00 00       	call   100280 <__x86.get_pc_thunk.bx>
  100136:	81 c3 1a e8 00 00    	add    $0xe81a,%ebx
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10013c:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10013f:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100142:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100145:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100148:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10014c:	0f b7 c0             	movzwl %ax,%eax
  10014f:	83 e0 03             	and    $0x3,%eax
  100152:	89 c2                	mov    %eax,%edx
  100154:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  10015a:	83 ec 04             	sub    $0x4,%esp
  10015d:	52                   	push   %edx
  10015e:	50                   	push   %eax
  10015f:	8d 83 31 50 ff ff    	lea    -0xafcf(%ebx),%eax
  100165:	50                   	push   %eax
  100166:	e8 88 01 00 00       	call   1002f3 <cprintf>
  10016b:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  10016e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100172:	0f b7 d0             	movzwl %ax,%edx
  100175:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  10017b:	83 ec 04             	sub    $0x4,%esp
  10017e:	52                   	push   %edx
  10017f:	50                   	push   %eax
  100180:	8d 83 3f 50 ff ff    	lea    -0xafc1(%ebx),%eax
  100186:	50                   	push   %eax
  100187:	e8 67 01 00 00       	call   1002f3 <cprintf>
  10018c:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  10018f:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100193:	0f b7 d0             	movzwl %ax,%edx
  100196:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  10019c:	83 ec 04             	sub    $0x4,%esp
  10019f:	52                   	push   %edx
  1001a0:	50                   	push   %eax
  1001a1:	8d 83 4d 50 ff ff    	lea    -0xafb3(%ebx),%eax
  1001a7:	50                   	push   %eax
  1001a8:	e8 46 01 00 00       	call   1002f3 <cprintf>
  1001ad:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  1001b0:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001b4:	0f b7 d0             	movzwl %ax,%edx
  1001b7:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001bd:	83 ec 04             	sub    $0x4,%esp
  1001c0:	52                   	push   %edx
  1001c1:	50                   	push   %eax
  1001c2:	8d 83 5b 50 ff ff    	lea    -0xafa5(%ebx),%eax
  1001c8:	50                   	push   %eax
  1001c9:	e8 25 01 00 00       	call   1002f3 <cprintf>
  1001ce:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  1001d1:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001d5:	0f b7 d0             	movzwl %ax,%edx
  1001d8:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001de:	83 ec 04             	sub    $0x4,%esp
  1001e1:	52                   	push   %edx
  1001e2:	50                   	push   %eax
  1001e3:	8d 83 69 50 ff ff    	lea    -0xaf97(%ebx),%eax
  1001e9:	50                   	push   %eax
  1001ea:	e8 04 01 00 00       	call   1002f3 <cprintf>
  1001ef:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001f2:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001f8:	83 c0 01             	add    $0x1,%eax
  1001fb:	89 83 70 01 00 00    	mov    %eax,0x170(%ebx)
}
  100201:	90                   	nop
  100202:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100205:	c9                   	leave  
  100206:	c3                   	ret    

00100207 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  100207:	55                   	push   %ebp
  100208:	89 e5                	mov    %esp,%ebp
  10020a:	e8 6d 00 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  10020f:	05 41 e7 00 00       	add    $0xe741,%eax
    //LAB1 CHALLENGE 1 : TODO
}
  100214:	90                   	nop
  100215:	5d                   	pop    %ebp
  100216:	c3                   	ret    

00100217 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  100217:	55                   	push   %ebp
  100218:	89 e5                	mov    %esp,%ebp
  10021a:	e8 5d 00 00 00       	call   10027c <__x86.get_pc_thunk.ax>
  10021f:	05 31 e7 00 00       	add    $0xe731,%eax
    //LAB1 CHALLENGE 1 :  TODO
}
  100224:	90                   	nop
  100225:	5d                   	pop    %ebp
  100226:	c3                   	ret    

00100227 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  100227:	55                   	push   %ebp
  100228:	89 e5                	mov    %esp,%ebp
  10022a:	53                   	push   %ebx
  10022b:	83 ec 04             	sub    $0x4,%esp
  10022e:	e8 4d 00 00 00       	call   100280 <__x86.get_pc_thunk.bx>
  100233:	81 c3 1d e7 00 00    	add    $0xe71d,%ebx
    lab1_print_cur_status();
  100239:	e8 ec fe ff ff       	call   10012a <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  10023e:	83 ec 0c             	sub    $0xc,%esp
  100241:	8d 83 78 50 ff ff    	lea    -0xaf88(%ebx),%eax
  100247:	50                   	push   %eax
  100248:	e8 a6 00 00 00       	call   1002f3 <cprintf>
  10024d:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100250:	e8 b2 ff ff ff       	call   100207 <lab1_switch_to_user>
    lab1_print_cur_status();
  100255:	e8 d0 fe ff ff       	call   10012a <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10025a:	83 ec 0c             	sub    $0xc,%esp
  10025d:	8d 83 98 50 ff ff    	lea    -0xaf68(%ebx),%eax
  100263:	50                   	push   %eax
  100264:	e8 8a 00 00 00       	call   1002f3 <cprintf>
  100269:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  10026c:	e8 a6 ff ff ff       	call   100217 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100271:	e8 b4 fe ff ff       	call   10012a <lab1_print_cur_status>
}
  100276:	90                   	nop
  100277:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10027a:	c9                   	leave  
  10027b:	c3                   	ret    

0010027c <__x86.get_pc_thunk.ax>:
  10027c:	8b 04 24             	mov    (%esp),%eax
  10027f:	c3                   	ret    

00100280 <__x86.get_pc_thunk.bx>:
  100280:	8b 1c 24             	mov    (%esp),%ebx
  100283:	c3                   	ret    

00100284 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100284:	55                   	push   %ebp
  100285:	89 e5                	mov    %esp,%ebp
  100287:	53                   	push   %ebx
  100288:	83 ec 04             	sub    $0x4,%esp
  10028b:	e8 ec ff ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100290:	05 c0 e6 00 00       	add    $0xe6c0,%eax
    cons_putc(c);
  100295:	83 ec 0c             	sub    $0xc,%esp
  100298:	ff 75 08             	pushl  0x8(%ebp)
  10029b:	89 c3                	mov    %eax,%ebx
  10029d:	e8 e2 15 00 00       	call   101884 <cons_putc>
  1002a2:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  1002a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002a8:	8b 00                	mov    (%eax),%eax
  1002aa:	8d 50 01             	lea    0x1(%eax),%edx
  1002ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002b0:	89 10                	mov    %edx,(%eax)
}
  1002b2:	90                   	nop
  1002b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002b6:	c9                   	leave  
  1002b7:	c3                   	ret    

001002b8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002b8:	55                   	push   %ebp
  1002b9:	89 e5                	mov    %esp,%ebp
  1002bb:	53                   	push   %ebx
  1002bc:	83 ec 14             	sub    $0x14,%esp
  1002bf:	e8 b8 ff ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1002c4:	05 8c e6 00 00       	add    $0xe68c,%eax
    int cnt = 0;
  1002c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002d0:	ff 75 0c             	pushl  0xc(%ebp)
  1002d3:	ff 75 08             	pushl  0x8(%ebp)
  1002d6:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1002d9:	52                   	push   %edx
  1002da:	8d 90 34 19 ff ff    	lea    -0xe6cc(%eax),%edx
  1002e0:	52                   	push   %edx
  1002e1:	89 c3                	mov    %eax,%ebx
  1002e3:	e8 d8 31 00 00       	call   1034c0 <vprintfmt>
  1002e8:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002f1:	c9                   	leave  
  1002f2:	c3                   	ret    

001002f3 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  1002f3:	55                   	push   %ebp
  1002f4:	89 e5                	mov    %esp,%ebp
  1002f6:	83 ec 18             	sub    $0x18,%esp
  1002f9:	e8 7e ff ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1002fe:	05 52 e6 00 00       	add    $0xe652,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100303:	8d 45 0c             	lea    0xc(%ebp),%eax
  100306:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100309:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10030c:	83 ec 08             	sub    $0x8,%esp
  10030f:	50                   	push   %eax
  100310:	ff 75 08             	pushl  0x8(%ebp)
  100313:	e8 a0 ff ff ff       	call   1002b8 <vcprintf>
  100318:	83 c4 10             	add    $0x10,%esp
  10031b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10031e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100321:	c9                   	leave  
  100322:	c3                   	ret    

00100323 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100323:	55                   	push   %ebp
  100324:	89 e5                	mov    %esp,%ebp
  100326:	53                   	push   %ebx
  100327:	83 ec 04             	sub    $0x4,%esp
  10032a:	e8 4d ff ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10032f:	05 21 e6 00 00       	add    $0xe621,%eax
    cons_putc(c);
  100334:	83 ec 0c             	sub    $0xc,%esp
  100337:	ff 75 08             	pushl  0x8(%ebp)
  10033a:	89 c3                	mov    %eax,%ebx
  10033c:	e8 43 15 00 00       	call   101884 <cons_putc>
  100341:	83 c4 10             	add    $0x10,%esp
}
  100344:	90                   	nop
  100345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100348:	c9                   	leave  
  100349:	c3                   	ret    

0010034a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10034a:	55                   	push   %ebp
  10034b:	89 e5                	mov    %esp,%ebp
  10034d:	83 ec 18             	sub    $0x18,%esp
  100350:	e8 27 ff ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100355:	05 fb e5 00 00       	add    $0xe5fb,%eax
    int cnt = 0;
  10035a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100361:	eb 14                	jmp    100377 <cputs+0x2d>
        cputch(c, &cnt);
  100363:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100367:	83 ec 08             	sub    $0x8,%esp
  10036a:	8d 55 f0             	lea    -0x10(%ebp),%edx
  10036d:	52                   	push   %edx
  10036e:	50                   	push   %eax
  10036f:	e8 10 ff ff ff       	call   100284 <cputch>
  100374:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  100377:	8b 45 08             	mov    0x8(%ebp),%eax
  10037a:	8d 50 01             	lea    0x1(%eax),%edx
  10037d:	89 55 08             	mov    %edx,0x8(%ebp)
  100380:	0f b6 00             	movzbl (%eax),%eax
  100383:	88 45 f7             	mov    %al,-0x9(%ebp)
  100386:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10038a:	75 d7                	jne    100363 <cputs+0x19>
    }
    cputch('\n', &cnt);
  10038c:	83 ec 08             	sub    $0x8,%esp
  10038f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100392:	50                   	push   %eax
  100393:	6a 0a                	push   $0xa
  100395:	e8 ea fe ff ff       	call   100284 <cputch>
  10039a:	83 c4 10             	add    $0x10,%esp
    return cnt;
  10039d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003a0:	c9                   	leave  
  1003a1:	c3                   	ret    

001003a2 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003a2:	55                   	push   %ebp
  1003a3:	89 e5                	mov    %esp,%ebp
  1003a5:	53                   	push   %ebx
  1003a6:	83 ec 14             	sub    $0x14,%esp
  1003a9:	e8 d2 fe ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1003ae:	81 c3 a2 e5 00 00    	add    $0xe5a2,%ebx
    int c;
    while ((c = cons_getc()) == 0)
  1003b4:	e8 05 15 00 00       	call   1018be <cons_getc>
  1003b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003c0:	74 f2                	je     1003b4 <getchar+0x12>
        /* do nothing */;
    return c;
  1003c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003c5:	83 c4 14             	add    $0x14,%esp
  1003c8:	5b                   	pop    %ebx
  1003c9:	5d                   	pop    %ebp
  1003ca:	c3                   	ret    

001003cb <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1003cb:	55                   	push   %ebp
  1003cc:	89 e5                	mov    %esp,%ebp
  1003ce:	53                   	push   %ebx
  1003cf:	83 ec 14             	sub    $0x14,%esp
  1003d2:	e8 a9 fe ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1003d7:	81 c3 79 e5 00 00    	add    $0xe579,%ebx
    if (prompt != NULL) {
  1003dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1003e1:	74 15                	je     1003f8 <readline+0x2d>
        cprintf("%s", prompt);
  1003e3:	83 ec 08             	sub    $0x8,%esp
  1003e6:	ff 75 08             	pushl  0x8(%ebp)
  1003e9:	8d 83 b7 50 ff ff    	lea    -0xaf49(%ebx),%eax
  1003ef:	50                   	push   %eax
  1003f0:	e8 fe fe ff ff       	call   1002f3 <cprintf>
  1003f5:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  1003f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  1003ff:	e8 9e ff ff ff       	call   1003a2 <getchar>
  100404:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100407:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10040b:	79 0a                	jns    100417 <readline+0x4c>
            return NULL;
  10040d:	b8 00 00 00 00       	mov    $0x0,%eax
  100412:	e9 87 00 00 00       	jmp    10049e <readline+0xd3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100417:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10041b:	7e 2c                	jle    100449 <readline+0x7e>
  10041d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100424:	7f 23                	jg     100449 <readline+0x7e>
            cputchar(c);
  100426:	83 ec 0c             	sub    $0xc,%esp
  100429:	ff 75 f0             	pushl  -0x10(%ebp)
  10042c:	e8 f2 fe ff ff       	call   100323 <cputchar>
  100431:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100434:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100437:	8d 50 01             	lea    0x1(%eax),%edx
  10043a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10043d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100440:	88 94 03 90 01 00 00 	mov    %dl,0x190(%ebx,%eax,1)
  100447:	eb 50                	jmp    100499 <readline+0xce>
        }
        else if (c == '\b' && i > 0) {
  100449:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10044d:	75 1a                	jne    100469 <readline+0x9e>
  10044f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100453:	7e 14                	jle    100469 <readline+0x9e>
            cputchar(c);
  100455:	83 ec 0c             	sub    $0xc,%esp
  100458:	ff 75 f0             	pushl  -0x10(%ebp)
  10045b:	e8 c3 fe ff ff       	call   100323 <cputchar>
  100460:	83 c4 10             	add    $0x10,%esp
            i --;
  100463:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  100467:	eb 30                	jmp    100499 <readline+0xce>
        }
        else if (c == '\n' || c == '\r') {
  100469:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  10046d:	74 06                	je     100475 <readline+0xaa>
  10046f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100473:	75 8a                	jne    1003ff <readline+0x34>
            cputchar(c);
  100475:	83 ec 0c             	sub    $0xc,%esp
  100478:	ff 75 f0             	pushl  -0x10(%ebp)
  10047b:	e8 a3 fe ff ff       	call   100323 <cputchar>
  100480:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  100483:	8d 93 90 01 00 00    	lea    0x190(%ebx),%edx
  100489:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10048c:	01 d0                	add    %edx,%eax
  10048e:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  100491:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
  100497:	eb 05                	jmp    10049e <readline+0xd3>
        c = getchar();
  100499:	e9 61 ff ff ff       	jmp    1003ff <readline+0x34>
        }
    }
}
  10049e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1004a1:	c9                   	leave  
  1004a2:	c3                   	ret    

001004a3 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1004a3:	55                   	push   %ebp
  1004a4:	89 e5                	mov    %esp,%ebp
  1004a6:	53                   	push   %ebx
  1004a7:	83 ec 14             	sub    $0x14,%esp
  1004aa:	e8 d1 fd ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1004af:	81 c3 a1 e4 00 00    	add    $0xe4a1,%ebx
    if (is_panic) {
  1004b5:	8b 83 90 05 00 00    	mov    0x590(%ebx),%eax
  1004bb:	85 c0                	test   %eax,%eax
  1004bd:	75 65                	jne    100524 <__panic+0x81>
        goto panic_dead;
    }
    is_panic = 1;
  1004bf:	c7 83 90 05 00 00 01 	movl   $0x1,0x590(%ebx)
  1004c6:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1004c9:	8d 45 14             	lea    0x14(%ebp),%eax
  1004cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1004cf:	83 ec 04             	sub    $0x4,%esp
  1004d2:	ff 75 0c             	pushl  0xc(%ebp)
  1004d5:	ff 75 08             	pushl  0x8(%ebp)
  1004d8:	8d 83 ba 50 ff ff    	lea    -0xaf46(%ebx),%eax
  1004de:	50                   	push   %eax
  1004df:	e8 0f fe ff ff       	call   1002f3 <cprintf>
  1004e4:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1004e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004ea:	83 ec 08             	sub    $0x8,%esp
  1004ed:	50                   	push   %eax
  1004ee:	ff 75 10             	pushl  0x10(%ebp)
  1004f1:	e8 c2 fd ff ff       	call   1002b8 <vcprintf>
  1004f6:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1004f9:	83 ec 0c             	sub    $0xc,%esp
  1004fc:	8d 83 d6 50 ff ff    	lea    -0xaf2a(%ebx),%eax
  100502:	50                   	push   %eax
  100503:	e8 eb fd ff ff       	call   1002f3 <cprintf>
  100508:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
  10050b:	83 ec 0c             	sub    $0xc,%esp
  10050e:	8d 83 d8 50 ff ff    	lea    -0xaf28(%ebx),%eax
  100514:	50                   	push   %eax
  100515:	e8 d9 fd ff ff       	call   1002f3 <cprintf>
  10051a:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
  10051d:	e8 9f 06 00 00       	call   100bc1 <print_stackframe>
  100522:	eb 01                	jmp    100525 <__panic+0x82>
        goto panic_dead;
  100524:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100525:	e8 ff 15 00 00       	call   101b29 <intr_disable>
    while (1) {
        kmonitor(NULL);
  10052a:	83 ec 0c             	sub    $0xc,%esp
  10052d:	6a 00                	push   $0x0
  10052f:	e8 cc 08 00 00       	call   100e00 <kmonitor>
  100534:	83 c4 10             	add    $0x10,%esp
  100537:	eb f1                	jmp    10052a <__panic+0x87>

00100539 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100539:	55                   	push   %ebp
  10053a:	89 e5                	mov    %esp,%ebp
  10053c:	53                   	push   %ebx
  10053d:	83 ec 14             	sub    $0x14,%esp
  100540:	e8 3b fd ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100545:	81 c3 0b e4 00 00    	add    $0xe40b,%ebx
    va_list ap;
    va_start(ap, fmt);
  10054b:	8d 45 14             	lea    0x14(%ebp),%eax
  10054e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100551:	83 ec 04             	sub    $0x4,%esp
  100554:	ff 75 0c             	pushl  0xc(%ebp)
  100557:	ff 75 08             	pushl  0x8(%ebp)
  10055a:	8d 83 ea 50 ff ff    	lea    -0xaf16(%ebx),%eax
  100560:	50                   	push   %eax
  100561:	e8 8d fd ff ff       	call   1002f3 <cprintf>
  100566:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100569:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10056c:	83 ec 08             	sub    $0x8,%esp
  10056f:	50                   	push   %eax
  100570:	ff 75 10             	pushl  0x10(%ebp)
  100573:	e8 40 fd ff ff       	call   1002b8 <vcprintf>
  100578:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10057b:	83 ec 0c             	sub    $0xc,%esp
  10057e:	8d 83 d6 50 ff ff    	lea    -0xaf2a(%ebx),%eax
  100584:	50                   	push   %eax
  100585:	e8 69 fd ff ff       	call   1002f3 <cprintf>
  10058a:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10058d:	90                   	nop
  10058e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100591:	c9                   	leave  
  100592:	c3                   	ret    

00100593 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100593:	55                   	push   %ebp
  100594:	89 e5                	mov    %esp,%ebp
  100596:	e8 e1 fc ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10059b:	05 b5 e3 00 00       	add    $0xe3b5,%eax
    return is_panic;
  1005a0:	8b 80 90 05 00 00    	mov    0x590(%eax),%eax
}
  1005a6:	5d                   	pop    %ebp
  1005a7:	c3                   	ret    

001005a8 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1005a8:	55                   	push   %ebp
  1005a9:	89 e5                	mov    %esp,%ebp
  1005ab:	83 ec 20             	sub    $0x20,%esp
  1005ae:	e8 c9 fc ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1005b3:	05 9d e3 00 00       	add    $0xe39d,%eax
    int l = *region_left, r = *region_right, any_matches = 0;
  1005b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005bb:	8b 00                	mov    (%eax),%eax
  1005bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005c0:	8b 45 10             	mov    0x10(%ebp),%eax
  1005c3:	8b 00                	mov    (%eax),%eax
  1005c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1005cf:	e9 d2 00 00 00       	jmp    1006a6 <stab_binsearch+0xfe>
        int true_m = (l + r) / 2, m = true_m;
  1005d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1005da:	01 d0                	add    %edx,%eax
  1005dc:	89 c2                	mov    %eax,%edx
  1005de:	c1 ea 1f             	shr    $0x1f,%edx
  1005e1:	01 d0                	add    %edx,%eax
  1005e3:	d1 f8                	sar    %eax
  1005e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1005e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1005eb:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1005ee:	eb 04                	jmp    1005f4 <stab_binsearch+0x4c>
            m --;
  1005f0:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1005f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005f7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005fa:	7c 1f                	jl     10061b <stab_binsearch+0x73>
  1005fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005ff:	89 d0                	mov    %edx,%eax
  100601:	01 c0                	add    %eax,%eax
  100603:	01 d0                	add    %edx,%eax
  100605:	c1 e0 02             	shl    $0x2,%eax
  100608:	89 c2                	mov    %eax,%edx
  10060a:	8b 45 08             	mov    0x8(%ebp),%eax
  10060d:	01 d0                	add    %edx,%eax
  10060f:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100613:	0f b6 c0             	movzbl %al,%eax
  100616:	39 45 14             	cmp    %eax,0x14(%ebp)
  100619:	75 d5                	jne    1005f0 <stab_binsearch+0x48>
        }
        if (m < l) {    // no match in [l, m]
  10061b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10061e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100621:	7d 0b                	jge    10062e <stab_binsearch+0x86>
            l = true_m + 1;
  100623:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100626:	83 c0 01             	add    $0x1,%eax
  100629:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10062c:	eb 78                	jmp    1006a6 <stab_binsearch+0xfe>
        }

        // actual binary search
        any_matches = 1;
  10062e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100635:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100638:	89 d0                	mov    %edx,%eax
  10063a:	01 c0                	add    %eax,%eax
  10063c:	01 d0                	add    %edx,%eax
  10063e:	c1 e0 02             	shl    $0x2,%eax
  100641:	89 c2                	mov    %eax,%edx
  100643:	8b 45 08             	mov    0x8(%ebp),%eax
  100646:	01 d0                	add    %edx,%eax
  100648:	8b 40 08             	mov    0x8(%eax),%eax
  10064b:	39 45 18             	cmp    %eax,0x18(%ebp)
  10064e:	76 13                	jbe    100663 <stab_binsearch+0xbb>
            *region_left = m;
  100650:	8b 45 0c             	mov    0xc(%ebp),%eax
  100653:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100656:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100658:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10065b:	83 c0 01             	add    $0x1,%eax
  10065e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100661:	eb 43                	jmp    1006a6 <stab_binsearch+0xfe>
        } else if (stabs[m].n_value > addr) {
  100663:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100666:	89 d0                	mov    %edx,%eax
  100668:	01 c0                	add    %eax,%eax
  10066a:	01 d0                	add    %edx,%eax
  10066c:	c1 e0 02             	shl    $0x2,%eax
  10066f:	89 c2                	mov    %eax,%edx
  100671:	8b 45 08             	mov    0x8(%ebp),%eax
  100674:	01 d0                	add    %edx,%eax
  100676:	8b 40 08             	mov    0x8(%eax),%eax
  100679:	39 45 18             	cmp    %eax,0x18(%ebp)
  10067c:	73 16                	jae    100694 <stab_binsearch+0xec>
            *region_right = m - 1;
  10067e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100681:	8d 50 ff             	lea    -0x1(%eax),%edx
  100684:	8b 45 10             	mov    0x10(%ebp),%eax
  100687:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100689:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10068c:	83 e8 01             	sub    $0x1,%eax
  10068f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100692:	eb 12                	jmp    1006a6 <stab_binsearch+0xfe>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100694:	8b 45 0c             	mov    0xc(%ebp),%eax
  100697:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10069a:	89 10                	mov    %edx,(%eax)
            l = m;
  10069c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10069f:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1006a2:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1006a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006a9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1006ac:	0f 8e 22 ff ff ff    	jle    1005d4 <stab_binsearch+0x2c>
        }
    }

    if (!any_matches) {
  1006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1006b6:	75 0f                	jne    1006c7 <stab_binsearch+0x11f>
        *region_right = *region_left - 1;
  1006b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006bb:	8b 00                	mov    (%eax),%eax
  1006bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006c0:	8b 45 10             	mov    0x10(%ebp),%eax
  1006c3:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1006c5:	eb 3f                	jmp    100706 <stab_binsearch+0x15e>
        l = *region_right;
  1006c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1006ca:	8b 00                	mov    (%eax),%eax
  1006cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1006cf:	eb 04                	jmp    1006d5 <stab_binsearch+0x12d>
  1006d1:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1006d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d8:	8b 00                	mov    (%eax),%eax
  1006da:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1006dd:	7e 1f                	jle    1006fe <stab_binsearch+0x156>
  1006df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006e2:	89 d0                	mov    %edx,%eax
  1006e4:	01 c0                	add    %eax,%eax
  1006e6:	01 d0                	add    %edx,%eax
  1006e8:	c1 e0 02             	shl    $0x2,%eax
  1006eb:	89 c2                	mov    %eax,%edx
  1006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1006f0:	01 d0                	add    %edx,%eax
  1006f2:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1006f6:	0f b6 c0             	movzbl %al,%eax
  1006f9:	39 45 14             	cmp    %eax,0x14(%ebp)
  1006fc:	75 d3                	jne    1006d1 <stab_binsearch+0x129>
        *region_left = l;
  1006fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  100701:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100704:	89 10                	mov    %edx,(%eax)
}
  100706:	90                   	nop
  100707:	c9                   	leave  
  100708:	c3                   	ret    

00100709 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100709:	55                   	push   %ebp
  10070a:	89 e5                	mov    %esp,%ebp
  10070c:	53                   	push   %ebx
  10070d:	83 ec 34             	sub    $0x34,%esp
  100710:	e8 6b fb ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100715:	81 c3 3b e2 00 00    	add    $0xe23b,%ebx
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10071b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10071e:	8d 93 08 51 ff ff    	lea    -0xaef8(%ebx),%edx
  100724:	89 10                	mov    %edx,(%eax)
    info->eip_line = 0;
  100726:	8b 45 0c             	mov    0xc(%ebp),%eax
  100729:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100730:	8b 45 0c             	mov    0xc(%ebp),%eax
  100733:	8d 93 08 51 ff ff    	lea    -0xaef8(%ebx),%edx
  100739:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_namelen = 9;
  10073c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10073f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100746:	8b 45 0c             	mov    0xc(%ebp),%eax
  100749:	8b 55 08             	mov    0x8(%ebp),%edx
  10074c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10074f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100752:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100759:	c7 c0 04 42 10 00    	mov    $0x104204,%eax
  10075f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    stab_end = __STAB_END__;
  100762:	c7 c0 78 be 10 00    	mov    $0x10be78,%eax
  100768:	89 45 f0             	mov    %eax,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10076b:	c7 c0 79 be 10 00    	mov    $0x10be79,%eax
  100771:	89 45 ec             	mov    %eax,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100774:	c7 c0 4d df 10 00    	mov    $0x10df4d,%eax
  10077a:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10077d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100780:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100783:	76 0d                	jbe    100792 <debuginfo_eip+0x89>
  100785:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100788:	83 e8 01             	sub    $0x1,%eax
  10078b:	0f b6 00             	movzbl (%eax),%eax
  10078e:	84 c0                	test   %al,%al
  100790:	74 0a                	je     10079c <debuginfo_eip+0x93>
        return -1;
  100792:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100797:	e9 91 02 00 00       	jmp    100a2d <debuginfo_eip+0x324>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  10079c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1007a3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1007a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a9:	29 c2                	sub    %eax,%edx
  1007ab:	89 d0                	mov    %edx,%eax
  1007ad:	c1 f8 02             	sar    $0x2,%eax
  1007b0:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1007b6:	83 e8 01             	sub    $0x1,%eax
  1007b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1007bc:	ff 75 08             	pushl  0x8(%ebp)
  1007bf:	6a 64                	push   $0x64
  1007c1:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1007c4:	50                   	push   %eax
  1007c5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1007c8:	50                   	push   %eax
  1007c9:	ff 75 f4             	pushl  -0xc(%ebp)
  1007cc:	e8 d7 fd ff ff       	call   1005a8 <stab_binsearch>
  1007d1:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1007d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007d7:	85 c0                	test   %eax,%eax
  1007d9:	75 0a                	jne    1007e5 <debuginfo_eip+0xdc>
        return -1;
  1007db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007e0:	e9 48 02 00 00       	jmp    100a2d <debuginfo_eip+0x324>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1007e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007e8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1007eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007ee:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1007f1:	ff 75 08             	pushl  0x8(%ebp)
  1007f4:	6a 24                	push   $0x24
  1007f6:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1007f9:	50                   	push   %eax
  1007fa:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1007fd:	50                   	push   %eax
  1007fe:	ff 75 f4             	pushl  -0xc(%ebp)
  100801:	e8 a2 fd ff ff       	call   1005a8 <stab_binsearch>
  100806:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100809:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10080c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10080f:	39 c2                	cmp    %eax,%edx
  100811:	7f 7c                	jg     10088f <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100813:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100816:	89 c2                	mov    %eax,%edx
  100818:	89 d0                	mov    %edx,%eax
  10081a:	01 c0                	add    %eax,%eax
  10081c:	01 d0                	add    %edx,%eax
  10081e:	c1 e0 02             	shl    $0x2,%eax
  100821:	89 c2                	mov    %eax,%edx
  100823:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100826:	01 d0                	add    %edx,%eax
  100828:	8b 00                	mov    (%eax),%eax
  10082a:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10082d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100830:	29 d1                	sub    %edx,%ecx
  100832:	89 ca                	mov    %ecx,%edx
  100834:	39 d0                	cmp    %edx,%eax
  100836:	73 22                	jae    10085a <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100838:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10083b:	89 c2                	mov    %eax,%edx
  10083d:	89 d0                	mov    %edx,%eax
  10083f:	01 c0                	add    %eax,%eax
  100841:	01 d0                	add    %edx,%eax
  100843:	c1 e0 02             	shl    $0x2,%eax
  100846:	89 c2                	mov    %eax,%edx
  100848:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10084b:	01 d0                	add    %edx,%eax
  10084d:	8b 10                	mov    (%eax),%edx
  10084f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100852:	01 c2                	add    %eax,%edx
  100854:	8b 45 0c             	mov    0xc(%ebp),%eax
  100857:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10085a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10085d:	89 c2                	mov    %eax,%edx
  10085f:	89 d0                	mov    %edx,%eax
  100861:	01 c0                	add    %eax,%eax
  100863:	01 d0                	add    %edx,%eax
  100865:	c1 e0 02             	shl    $0x2,%eax
  100868:	89 c2                	mov    %eax,%edx
  10086a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10086d:	01 d0                	add    %edx,%eax
  10086f:	8b 50 08             	mov    0x8(%eax),%edx
  100872:	8b 45 0c             	mov    0xc(%ebp),%eax
  100875:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100878:	8b 45 0c             	mov    0xc(%ebp),%eax
  10087b:	8b 40 10             	mov    0x10(%eax),%eax
  10087e:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100881:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100884:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100887:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10088a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10088d:	eb 15                	jmp    1008a4 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10088f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100892:	8b 55 08             	mov    0x8(%ebp),%edx
  100895:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100898:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10089b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  10089e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1008a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1008a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008a7:	8b 40 08             	mov    0x8(%eax),%eax
  1008aa:	83 ec 08             	sub    $0x8,%esp
  1008ad:	6a 3a                	push   $0x3a
  1008af:	50                   	push   %eax
  1008b0:	e8 dd 26 00 00       	call   102f92 <strfind>
  1008b5:	83 c4 10             	add    $0x10,%esp
  1008b8:	89 c2                	mov    %eax,%edx
  1008ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008bd:	8b 40 08             	mov    0x8(%eax),%eax
  1008c0:	29 c2                	sub    %eax,%edx
  1008c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008c5:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1008c8:	83 ec 0c             	sub    $0xc,%esp
  1008cb:	ff 75 08             	pushl  0x8(%ebp)
  1008ce:	6a 44                	push   $0x44
  1008d0:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1008d3:	50                   	push   %eax
  1008d4:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1008d7:	50                   	push   %eax
  1008d8:	ff 75 f4             	pushl  -0xc(%ebp)
  1008db:	e8 c8 fc ff ff       	call   1005a8 <stab_binsearch>
  1008e0:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1008e3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008e6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008e9:	39 c2                	cmp    %eax,%edx
  1008eb:	7f 24                	jg     100911 <debuginfo_eip+0x208>
        info->eip_line = stabs[rline].n_desc;
  1008ed:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008f0:	89 c2                	mov    %eax,%edx
  1008f2:	89 d0                	mov    %edx,%eax
  1008f4:	01 c0                	add    %eax,%eax
  1008f6:	01 d0                	add    %edx,%eax
  1008f8:	c1 e0 02             	shl    $0x2,%eax
  1008fb:	89 c2                	mov    %eax,%edx
  1008fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100900:	01 d0                	add    %edx,%eax
  100902:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100906:	0f b7 d0             	movzwl %ax,%edx
  100909:	8b 45 0c             	mov    0xc(%ebp),%eax
  10090c:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10090f:	eb 13                	jmp    100924 <debuginfo_eip+0x21b>
        return -1;
  100911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100916:	e9 12 01 00 00       	jmp    100a2d <debuginfo_eip+0x324>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10091b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10091e:	83 e8 01             	sub    $0x1,%eax
  100921:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100924:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100927:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10092a:	39 c2                	cmp    %eax,%edx
  10092c:	7c 56                	jl     100984 <debuginfo_eip+0x27b>
           && stabs[lline].n_type != N_SOL
  10092e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100931:	89 c2                	mov    %eax,%edx
  100933:	89 d0                	mov    %edx,%eax
  100935:	01 c0                	add    %eax,%eax
  100937:	01 d0                	add    %edx,%eax
  100939:	c1 e0 02             	shl    $0x2,%eax
  10093c:	89 c2                	mov    %eax,%edx
  10093e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100941:	01 d0                	add    %edx,%eax
  100943:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100947:	3c 84                	cmp    $0x84,%al
  100949:	74 39                	je     100984 <debuginfo_eip+0x27b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10094b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10094e:	89 c2                	mov    %eax,%edx
  100950:	89 d0                	mov    %edx,%eax
  100952:	01 c0                	add    %eax,%eax
  100954:	01 d0                	add    %edx,%eax
  100956:	c1 e0 02             	shl    $0x2,%eax
  100959:	89 c2                	mov    %eax,%edx
  10095b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10095e:	01 d0                	add    %edx,%eax
  100960:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100964:	3c 64                	cmp    $0x64,%al
  100966:	75 b3                	jne    10091b <debuginfo_eip+0x212>
  100968:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10096b:	89 c2                	mov    %eax,%edx
  10096d:	89 d0                	mov    %edx,%eax
  10096f:	01 c0                	add    %eax,%eax
  100971:	01 d0                	add    %edx,%eax
  100973:	c1 e0 02             	shl    $0x2,%eax
  100976:	89 c2                	mov    %eax,%edx
  100978:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10097b:	01 d0                	add    %edx,%eax
  10097d:	8b 40 08             	mov    0x8(%eax),%eax
  100980:	85 c0                	test   %eax,%eax
  100982:	74 97                	je     10091b <debuginfo_eip+0x212>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100984:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100987:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10098a:	39 c2                	cmp    %eax,%edx
  10098c:	7c 46                	jl     1009d4 <debuginfo_eip+0x2cb>
  10098e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100991:	89 c2                	mov    %eax,%edx
  100993:	89 d0                	mov    %edx,%eax
  100995:	01 c0                	add    %eax,%eax
  100997:	01 d0                	add    %edx,%eax
  100999:	c1 e0 02             	shl    $0x2,%eax
  10099c:	89 c2                	mov    %eax,%edx
  10099e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009a1:	01 d0                	add    %edx,%eax
  1009a3:	8b 00                	mov    (%eax),%eax
  1009a5:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1009a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1009ab:	29 d1                	sub    %edx,%ecx
  1009ad:	89 ca                	mov    %ecx,%edx
  1009af:	39 d0                	cmp    %edx,%eax
  1009b1:	73 21                	jae    1009d4 <debuginfo_eip+0x2cb>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1009b3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009b6:	89 c2                	mov    %eax,%edx
  1009b8:	89 d0                	mov    %edx,%eax
  1009ba:	01 c0                	add    %eax,%eax
  1009bc:	01 d0                	add    %edx,%eax
  1009be:	c1 e0 02             	shl    $0x2,%eax
  1009c1:	89 c2                	mov    %eax,%edx
  1009c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009c6:	01 d0                	add    %edx,%eax
  1009c8:	8b 10                	mov    (%eax),%edx
  1009ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1009cd:	01 c2                	add    %eax,%edx
  1009cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009d2:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1009d4:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1009d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1009da:	39 c2                	cmp    %eax,%edx
  1009dc:	7d 4a                	jge    100a28 <debuginfo_eip+0x31f>
        for (lline = lfun + 1;
  1009de:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1009e1:	83 c0 01             	add    $0x1,%eax
  1009e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1009e7:	eb 18                	jmp    100a01 <debuginfo_eip+0x2f8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1009e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009ec:	8b 40 14             	mov    0x14(%eax),%eax
  1009ef:	8d 50 01             	lea    0x1(%eax),%edx
  1009f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009f5:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1009f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009fb:	83 c0 01             	add    $0x1,%eax
  1009fe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a01:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100a04:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100a07:	39 c2                	cmp    %eax,%edx
  100a09:	7d 1d                	jge    100a28 <debuginfo_eip+0x31f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a0b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a0e:	89 c2                	mov    %eax,%edx
  100a10:	89 d0                	mov    %edx,%eax
  100a12:	01 c0                	add    %eax,%eax
  100a14:	01 d0                	add    %edx,%eax
  100a16:	c1 e0 02             	shl    $0x2,%eax
  100a19:	89 c2                	mov    %eax,%edx
  100a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a1e:	01 d0                	add    %edx,%eax
  100a20:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100a24:	3c a0                	cmp    $0xa0,%al
  100a26:	74 c1                	je     1009e9 <debuginfo_eip+0x2e0>
        }
    }
    return 0;
  100a28:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100a2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100a30:	c9                   	leave  
  100a31:	c3                   	ret    

00100a32 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100a32:	55                   	push   %ebp
  100a33:	89 e5                	mov    %esp,%ebp
  100a35:	53                   	push   %ebx
  100a36:	83 ec 04             	sub    $0x4,%esp
  100a39:	e8 42 f8 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100a3e:	81 c3 12 df 00 00    	add    $0xdf12,%ebx
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100a44:	83 ec 0c             	sub    $0xc,%esp
  100a47:	8d 83 12 51 ff ff    	lea    -0xaeee(%ebx),%eax
  100a4d:	50                   	push   %eax
  100a4e:	e8 a0 f8 ff ff       	call   1002f3 <cprintf>
  100a53:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100a56:	83 ec 08             	sub    $0x8,%esp
  100a59:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a5f:	50                   	push   %eax
  100a60:	8d 83 2b 51 ff ff    	lea    -0xaed5(%ebx),%eax
  100a66:	50                   	push   %eax
  100a67:	e8 87 f8 ff ff       	call   1002f3 <cprintf>
  100a6c:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100a6f:	83 ec 08             	sub    $0x8,%esp
  100a72:	c7 c0 5e 39 10 00    	mov    $0x10395e,%eax
  100a78:	50                   	push   %eax
  100a79:	8d 83 43 51 ff ff    	lea    -0xaebd(%ebx),%eax
  100a7f:	50                   	push   %eax
  100a80:	e8 6e f8 ff ff       	call   1002f3 <cprintf>
  100a85:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100a88:	83 ec 08             	sub    $0x8,%esp
  100a8b:	c7 c0 50 e9 10 00    	mov    $0x10e950,%eax
  100a91:	50                   	push   %eax
  100a92:	8d 83 5b 51 ff ff    	lea    -0xaea5(%ebx),%eax
  100a98:	50                   	push   %eax
  100a99:	e8 55 f8 ff ff       	call   1002f3 <cprintf>
  100a9e:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100aa1:	83 ec 08             	sub    $0x8,%esp
  100aa4:	c7 c0 c0 fd 10 00    	mov    $0x10fdc0,%eax
  100aaa:	50                   	push   %eax
  100aab:	8d 83 73 51 ff ff    	lea    -0xae8d(%ebx),%eax
  100ab1:	50                   	push   %eax
  100ab2:	e8 3c f8 ff ff       	call   1002f3 <cprintf>
  100ab7:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100aba:	c7 c0 c0 fd 10 00    	mov    $0x10fdc0,%eax
  100ac0:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100ac6:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100acc:	29 c2                	sub    %eax,%edx
  100ace:	89 d0                	mov    %edx,%eax
  100ad0:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100ad6:	85 c0                	test   %eax,%eax
  100ad8:	0f 48 c2             	cmovs  %edx,%eax
  100adb:	c1 f8 0a             	sar    $0xa,%eax
  100ade:	83 ec 08             	sub    $0x8,%esp
  100ae1:	50                   	push   %eax
  100ae2:	8d 83 8c 51 ff ff    	lea    -0xae74(%ebx),%eax
  100ae8:	50                   	push   %eax
  100ae9:	e8 05 f8 ff ff       	call   1002f3 <cprintf>
  100aee:	83 c4 10             	add    $0x10,%esp
}
  100af1:	90                   	nop
  100af2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100af5:	c9                   	leave  
  100af6:	c3                   	ret    

00100af7 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100af7:	55                   	push   %ebp
  100af8:	89 e5                	mov    %esp,%ebp
  100afa:	53                   	push   %ebx
  100afb:	81 ec 24 01 00 00    	sub    $0x124,%esp
  100b01:	e8 7a f7 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100b06:	81 c3 4a de 00 00    	add    $0xde4a,%ebx
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100b0c:	83 ec 08             	sub    $0x8,%esp
  100b0f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100b12:	50                   	push   %eax
  100b13:	ff 75 08             	pushl  0x8(%ebp)
  100b16:	e8 ee fb ff ff       	call   100709 <debuginfo_eip>
  100b1b:	83 c4 10             	add    $0x10,%esp
  100b1e:	85 c0                	test   %eax,%eax
  100b20:	74 17                	je     100b39 <print_debuginfo+0x42>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100b22:	83 ec 08             	sub    $0x8,%esp
  100b25:	ff 75 08             	pushl  0x8(%ebp)
  100b28:	8d 83 b6 51 ff ff    	lea    -0xae4a(%ebx),%eax
  100b2e:	50                   	push   %eax
  100b2f:	e8 bf f7 ff ff       	call   1002f3 <cprintf>
  100b34:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100b37:	eb 67                	jmp    100ba0 <print_debuginfo+0xa9>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b40:	eb 1c                	jmp    100b5e <print_debuginfo+0x67>
            fnname[j] = info.eip_fn_name[j];
  100b42:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b48:	01 d0                	add    %edx,%eax
  100b4a:	0f b6 00             	movzbl (%eax),%eax
  100b4d:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b56:	01 ca                	add    %ecx,%edx
  100b58:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b5a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b61:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100b64:	7c dc                	jl     100b42 <print_debuginfo+0x4b>
        fnname[j] = '\0';
  100b66:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b6f:	01 d0                	add    %edx,%eax
  100b71:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100b74:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100b77:	8b 55 08             	mov    0x8(%ebp),%edx
  100b7a:	89 d1                	mov    %edx,%ecx
  100b7c:	29 c1                	sub    %eax,%ecx
  100b7e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100b81:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100b84:	83 ec 0c             	sub    $0xc,%esp
  100b87:	51                   	push   %ecx
  100b88:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b8e:	51                   	push   %ecx
  100b8f:	52                   	push   %edx
  100b90:	50                   	push   %eax
  100b91:	8d 83 d2 51 ff ff    	lea    -0xae2e(%ebx),%eax
  100b97:	50                   	push   %eax
  100b98:	e8 56 f7 ff ff       	call   1002f3 <cprintf>
  100b9d:	83 c4 20             	add    $0x20,%esp
}
  100ba0:	90                   	nop
  100ba1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100ba4:	c9                   	leave  
  100ba5:	c3                   	ret    

00100ba6 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100ba6:	55                   	push   %ebp
  100ba7:	89 e5                	mov    %esp,%ebp
  100ba9:	83 ec 10             	sub    $0x10,%esp
  100bac:	e8 cb f6 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100bb1:	05 9f dd 00 00       	add    $0xdd9f,%eax
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100bb6:	8b 45 04             	mov    0x4(%ebp),%eax
  100bb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100bbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100bbf:	c9                   	leave  
  100bc0:	c3                   	ret    

00100bc1 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100bc1:	55                   	push   %ebp
  100bc2:	89 e5                	mov    %esp,%ebp
  100bc4:	56                   	push   %esi
  100bc5:	53                   	push   %ebx
  100bc6:	83 ec 20             	sub    $0x20,%esp
  100bc9:	e8 b2 f6 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100bce:	81 c3 82 dd 00 00    	add    $0xdd82,%ebx
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100bd4:	89 e8                	mov    %ebp,%eax
  100bd6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100bd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    uint32_t ebp = read_ebp();
  100bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uint32_t eip = read_eip();
  100bdf:	e8 c2 ff ff ff       	call   100ba6 <read_eip>
  100be4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int i;
    for(i = 0; i < STACKFRAME_DEPTH; i++)
  100be7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100bee:	eb 6b                	jmp    100c5b <print_stackframe+0x9a>
    {
        uint32_t *call_argu = (uint32_t *) ebp + 2;
  100bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bf3:	83 c0 08             	add    $0x8,%eax
  100bf6:	89 45 e8             	mov    %eax,-0x18(%ebp)
        cprintf("ebp:0x%08x eip:0x%08x args:0x%08x 0x%08x 0x%08x 0x%08x 0x%08x\n", ebp, eip, call_argu[0], call_argu[1], call_argu[2], call_argu[3]);
  100bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100bfc:	83 c0 0c             	add    $0xc,%eax
  100bff:	8b 30                	mov    (%eax),%esi
  100c01:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c04:	83 c0 08             	add    $0x8,%eax
  100c07:	8b 08                	mov    (%eax),%ecx
  100c09:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c0c:	83 c0 04             	add    $0x4,%eax
  100c0f:	8b 10                	mov    (%eax),%edx
  100c11:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c14:	8b 00                	mov    (%eax),%eax
  100c16:	83 ec 04             	sub    $0x4,%esp
  100c19:	56                   	push   %esi
  100c1a:	51                   	push   %ecx
  100c1b:	52                   	push   %edx
  100c1c:	50                   	push   %eax
  100c1d:	ff 75 f0             	pushl  -0x10(%ebp)
  100c20:	ff 75 f4             	pushl  -0xc(%ebp)
  100c23:	8d 83 e4 51 ff ff    	lea    -0xae1c(%ebx),%eax
  100c29:	50                   	push   %eax
  100c2a:	e8 c4 f6 ff ff       	call   1002f3 <cprintf>
  100c2f:	83 c4 20             	add    $0x20,%esp
        print_debuginfo(eip - 1);
  100c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100c35:	83 e8 01             	sub    $0x1,%eax
  100c38:	83 ec 0c             	sub    $0xc,%esp
  100c3b:	50                   	push   %eax
  100c3c:	e8 b6 fe ff ff       	call   100af7 <print_debuginfo>
  100c41:	83 c4 10             	add    $0x10,%esp
        eip = *((uint32_t *) ebp + 1);
  100c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c47:	83 c0 04             	add    $0x4,%eax
  100c4a:	8b 00                	mov    (%eax),%eax
  100c4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = *((uint32_t *) ebp);
  100c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c52:	8b 00                	mov    (%eax),%eax
  100c54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(i = 0; i < STACKFRAME_DEPTH; i++)
  100c57:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100c5b:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100c5f:	7e 8f                	jle    100bf0 <print_stackframe+0x2f>
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100c61:	90                   	nop
  100c62:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100c65:	5b                   	pop    %ebx
  100c66:	5e                   	pop    %esi
  100c67:	5d                   	pop    %ebp
  100c68:	c3                   	ret    

00100c69 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100c69:	55                   	push   %ebp
  100c6a:	89 e5                	mov    %esp,%ebp
  100c6c:	53                   	push   %ebx
  100c6d:	83 ec 14             	sub    $0x14,%esp
  100c70:	e8 0b f6 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100c75:	81 c3 db dc 00 00    	add    $0xdcdb,%ebx
    int argc = 0;
  100c7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c82:	eb 0c                	jmp    100c90 <parse+0x27>
            *buf ++ = '\0';
  100c84:	8b 45 08             	mov    0x8(%ebp),%eax
  100c87:	8d 50 01             	lea    0x1(%eax),%edx
  100c8a:	89 55 08             	mov    %edx,0x8(%ebp)
  100c8d:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c90:	8b 45 08             	mov    0x8(%ebp),%eax
  100c93:	0f b6 00             	movzbl (%eax),%eax
  100c96:	84 c0                	test   %al,%al
  100c98:	74 20                	je     100cba <parse+0x51>
  100c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  100c9d:	0f b6 00             	movzbl (%eax),%eax
  100ca0:	0f be c0             	movsbl %al,%eax
  100ca3:	83 ec 08             	sub    $0x8,%esp
  100ca6:	50                   	push   %eax
  100ca7:	8d 83 a4 52 ff ff    	lea    -0xad5c(%ebx),%eax
  100cad:	50                   	push   %eax
  100cae:	e8 a2 22 00 00       	call   102f55 <strchr>
  100cb3:	83 c4 10             	add    $0x10,%esp
  100cb6:	85 c0                	test   %eax,%eax
  100cb8:	75 ca                	jne    100c84 <parse+0x1b>
        }
        if (*buf == '\0') {
  100cba:	8b 45 08             	mov    0x8(%ebp),%eax
  100cbd:	0f b6 00             	movzbl (%eax),%eax
  100cc0:	84 c0                	test   %al,%al
  100cc2:	74 69                	je     100d2d <parse+0xc4>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100cc4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100cc8:	75 14                	jne    100cde <parse+0x75>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100cca:	83 ec 08             	sub    $0x8,%esp
  100ccd:	6a 10                	push   $0x10
  100ccf:	8d 83 a9 52 ff ff    	lea    -0xad57(%ebx),%eax
  100cd5:	50                   	push   %eax
  100cd6:	e8 18 f6 ff ff       	call   1002f3 <cprintf>
  100cdb:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ce1:	8d 50 01             	lea    0x1(%eax),%edx
  100ce4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100ce7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100cee:	8b 45 0c             	mov    0xc(%ebp),%eax
  100cf1:	01 c2                	add    %eax,%edx
  100cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  100cf6:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100cf8:	eb 04                	jmp    100cfe <parse+0x95>
            buf ++;
  100cfa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  100d01:	0f b6 00             	movzbl (%eax),%eax
  100d04:	84 c0                	test   %al,%al
  100d06:	74 88                	je     100c90 <parse+0x27>
  100d08:	8b 45 08             	mov    0x8(%ebp),%eax
  100d0b:	0f b6 00             	movzbl (%eax),%eax
  100d0e:	0f be c0             	movsbl %al,%eax
  100d11:	83 ec 08             	sub    $0x8,%esp
  100d14:	50                   	push   %eax
  100d15:	8d 83 a4 52 ff ff    	lea    -0xad5c(%ebx),%eax
  100d1b:	50                   	push   %eax
  100d1c:	e8 34 22 00 00       	call   102f55 <strchr>
  100d21:	83 c4 10             	add    $0x10,%esp
  100d24:	85 c0                	test   %eax,%eax
  100d26:	74 d2                	je     100cfa <parse+0x91>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d28:	e9 63 ff ff ff       	jmp    100c90 <parse+0x27>
            break;
  100d2d:	90                   	nop
        }
    }
    return argc;
  100d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100d31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100d34:	c9                   	leave  
  100d35:	c3                   	ret    

00100d36 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100d36:	55                   	push   %ebp
  100d37:	89 e5                	mov    %esp,%ebp
  100d39:	56                   	push   %esi
  100d3a:	53                   	push   %ebx
  100d3b:	83 ec 50             	sub    $0x50,%esp
  100d3e:	e8 3d f5 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100d43:	81 c3 0d dc 00 00    	add    $0xdc0d,%ebx
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100d49:	83 ec 08             	sub    $0x8,%esp
  100d4c:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100d4f:	50                   	push   %eax
  100d50:	ff 75 08             	pushl  0x8(%ebp)
  100d53:	e8 11 ff ff ff       	call   100c69 <parse>
  100d58:	83 c4 10             	add    $0x10,%esp
  100d5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100d5e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100d62:	75 0a                	jne    100d6e <runcmd+0x38>
        return 0;
  100d64:	b8 00 00 00 00       	mov    $0x0,%eax
  100d69:	e9 8b 00 00 00       	jmp    100df9 <runcmd+0xc3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d75:	eb 5f                	jmp    100dd6 <runcmd+0xa0>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100d77:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100d7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d7d:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100d83:	89 d0                	mov    %edx,%eax
  100d85:	01 c0                	add    %eax,%eax
  100d87:	01 d0                	add    %edx,%eax
  100d89:	c1 e0 02             	shl    $0x2,%eax
  100d8c:	01 f0                	add    %esi,%eax
  100d8e:	8b 00                	mov    (%eax),%eax
  100d90:	83 ec 08             	sub    $0x8,%esp
  100d93:	51                   	push   %ecx
  100d94:	50                   	push   %eax
  100d95:	e8 07 21 00 00       	call   102ea1 <strcmp>
  100d9a:	83 c4 10             	add    $0x10,%esp
  100d9d:	85 c0                	test   %eax,%eax
  100d9f:	75 31                	jne    100dd2 <runcmd+0x9c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100da1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100da4:	8d 8b 18 00 00 00    	lea    0x18(%ebx),%ecx
  100daa:	89 d0                	mov    %edx,%eax
  100dac:	01 c0                	add    %eax,%eax
  100dae:	01 d0                	add    %edx,%eax
  100db0:	c1 e0 02             	shl    $0x2,%eax
  100db3:	01 c8                	add    %ecx,%eax
  100db5:	8b 10                	mov    (%eax),%edx
  100db7:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100dba:	83 c0 04             	add    $0x4,%eax
  100dbd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100dc0:	83 e9 01             	sub    $0x1,%ecx
  100dc3:	83 ec 04             	sub    $0x4,%esp
  100dc6:	ff 75 0c             	pushl  0xc(%ebp)
  100dc9:	50                   	push   %eax
  100dca:	51                   	push   %ecx
  100dcb:	ff d2                	call   *%edx
  100dcd:	83 c4 10             	add    $0x10,%esp
  100dd0:	eb 27                	jmp    100df9 <runcmd+0xc3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100dd2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dd9:	83 f8 02             	cmp    $0x2,%eax
  100ddc:	76 99                	jbe    100d77 <runcmd+0x41>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100dde:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100de1:	83 ec 08             	sub    $0x8,%esp
  100de4:	50                   	push   %eax
  100de5:	8d 83 c7 52 ff ff    	lea    -0xad39(%ebx),%eax
  100deb:	50                   	push   %eax
  100dec:	e8 02 f5 ff ff       	call   1002f3 <cprintf>
  100df1:	83 c4 10             	add    $0x10,%esp
    return 0;
  100df4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100df9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100dfc:	5b                   	pop    %ebx
  100dfd:	5e                   	pop    %esi
  100dfe:	5d                   	pop    %ebp
  100dff:	c3                   	ret    

00100e00 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100e00:	55                   	push   %ebp
  100e01:	89 e5                	mov    %esp,%ebp
  100e03:	53                   	push   %ebx
  100e04:	83 ec 14             	sub    $0x14,%esp
  100e07:	e8 74 f4 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100e0c:	81 c3 44 db 00 00    	add    $0xdb44,%ebx
    cprintf("Welcome to the kernel debug monitor!!\n");
  100e12:	83 ec 0c             	sub    $0xc,%esp
  100e15:	8d 83 e0 52 ff ff    	lea    -0xad20(%ebx),%eax
  100e1b:	50                   	push   %eax
  100e1c:	e8 d2 f4 ff ff       	call   1002f3 <cprintf>
  100e21:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100e24:	83 ec 0c             	sub    $0xc,%esp
  100e27:	8d 83 08 53 ff ff    	lea    -0xacf8(%ebx),%eax
  100e2d:	50                   	push   %eax
  100e2e:	e8 c0 f4 ff ff       	call   1002f3 <cprintf>
  100e33:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100e36:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e3a:	74 0e                	je     100e4a <kmonitor+0x4a>
        print_trapframe(tf);
  100e3c:	83 ec 0c             	sub    $0xc,%esp
  100e3f:	ff 75 08             	pushl  0x8(%ebp)
  100e42:	e8 14 0f 00 00       	call   101d5b <print_trapframe>
  100e47:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100e4a:	83 ec 0c             	sub    $0xc,%esp
  100e4d:	8d 83 2d 53 ff ff    	lea    -0xacd3(%ebx),%eax
  100e53:	50                   	push   %eax
  100e54:	e8 72 f5 ff ff       	call   1003cb <readline>
  100e59:	83 c4 10             	add    $0x10,%esp
  100e5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100e5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100e63:	74 e5                	je     100e4a <kmonitor+0x4a>
            if (runcmd(buf, tf) < 0) {
  100e65:	83 ec 08             	sub    $0x8,%esp
  100e68:	ff 75 08             	pushl  0x8(%ebp)
  100e6b:	ff 75 f4             	pushl  -0xc(%ebp)
  100e6e:	e8 c3 fe ff ff       	call   100d36 <runcmd>
  100e73:	83 c4 10             	add    $0x10,%esp
  100e76:	85 c0                	test   %eax,%eax
  100e78:	78 02                	js     100e7c <kmonitor+0x7c>
        if ((buf = readline("K> ")) != NULL) {
  100e7a:	eb ce                	jmp    100e4a <kmonitor+0x4a>
                break;
  100e7c:	90                   	nop
            }
        }
    }
}
  100e7d:	90                   	nop
  100e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100e81:	c9                   	leave  
  100e82:	c3                   	ret    

00100e83 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100e83:	55                   	push   %ebp
  100e84:	89 e5                	mov    %esp,%ebp
  100e86:	56                   	push   %esi
  100e87:	53                   	push   %ebx
  100e88:	83 ec 10             	sub    $0x10,%esp
  100e8b:	e8 f0 f3 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100e90:	81 c3 c0 da 00 00    	add    $0xdac0,%ebx
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100e96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100e9d:	eb 44                	jmp    100ee3 <mon_help+0x60>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100e9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ea2:	8d 8b 14 00 00 00    	lea    0x14(%ebx),%ecx
  100ea8:	89 d0                	mov    %edx,%eax
  100eaa:	01 c0                	add    %eax,%eax
  100eac:	01 d0                	add    %edx,%eax
  100eae:	c1 e0 02             	shl    $0x2,%eax
  100eb1:	01 c8                	add    %ecx,%eax
  100eb3:	8b 08                	mov    (%eax),%ecx
  100eb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100eb8:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100ebe:	89 d0                	mov    %edx,%eax
  100ec0:	01 c0                	add    %eax,%eax
  100ec2:	01 d0                	add    %edx,%eax
  100ec4:	c1 e0 02             	shl    $0x2,%eax
  100ec7:	01 f0                	add    %esi,%eax
  100ec9:	8b 00                	mov    (%eax),%eax
  100ecb:	83 ec 04             	sub    $0x4,%esp
  100ece:	51                   	push   %ecx
  100ecf:	50                   	push   %eax
  100ed0:	8d 83 31 53 ff ff    	lea    -0xaccf(%ebx),%eax
  100ed6:	50                   	push   %eax
  100ed7:	e8 17 f4 ff ff       	call   1002f3 <cprintf>
  100edc:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100edf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ee6:	83 f8 02             	cmp    $0x2,%eax
  100ee9:	76 b4                	jbe    100e9f <mon_help+0x1c>
    }
    return 0;
  100eeb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ef0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100ef3:	5b                   	pop    %ebx
  100ef4:	5e                   	pop    %esi
  100ef5:	5d                   	pop    %ebp
  100ef6:	c3                   	ret    

00100ef7 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100ef7:	55                   	push   %ebp
  100ef8:	89 e5                	mov    %esp,%ebp
  100efa:	53                   	push   %ebx
  100efb:	83 ec 04             	sub    $0x4,%esp
  100efe:	e8 79 f3 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100f03:	05 4d da 00 00       	add    $0xda4d,%eax
    print_kerninfo();
  100f08:	89 c3                	mov    %eax,%ebx
  100f0a:	e8 23 fb ff ff       	call   100a32 <print_kerninfo>
    return 0;
  100f0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f14:	83 c4 04             	add    $0x4,%esp
  100f17:	5b                   	pop    %ebx
  100f18:	5d                   	pop    %ebp
  100f19:	c3                   	ret    

00100f1a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100f1a:	55                   	push   %ebp
  100f1b:	89 e5                	mov    %esp,%ebp
  100f1d:	53                   	push   %ebx
  100f1e:	83 ec 04             	sub    $0x4,%esp
  100f21:	e8 56 f3 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100f26:	05 2a da 00 00       	add    $0xda2a,%eax
    print_stackframe();
  100f2b:	89 c3                	mov    %eax,%ebx
  100f2d:	e8 8f fc ff ff       	call   100bc1 <print_stackframe>
    return 0;
  100f32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f37:	83 c4 04             	add    $0x4,%esp
  100f3a:	5b                   	pop    %ebx
  100f3b:	5d                   	pop    %ebp
  100f3c:	c3                   	ret    

00100f3d <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100f3d:	55                   	push   %ebp
  100f3e:	89 e5                	mov    %esp,%ebp
  100f40:	53                   	push   %ebx
  100f41:	83 ec 14             	sub    $0x14,%esp
  100f44:	e8 37 f3 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  100f49:	81 c3 07 da 00 00    	add    $0xda07,%ebx
  100f4f:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100f55:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f59:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f5d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f61:	ee                   	out    %al,(%dx)
  100f62:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100f68:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100f6c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f70:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f74:	ee                   	out    %al,(%dx)
  100f75:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100f7b:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100f7f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f83:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f87:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100f88:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  100f8e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("++ setup timer interrupts\n");
  100f94:	83 ec 0c             	sub    $0xc,%esp
  100f97:	8d 83 3a 53 ff ff    	lea    -0xacc6(%ebx),%eax
  100f9d:	50                   	push   %eax
  100f9e:	e8 50 f3 ff ff       	call   1002f3 <cprintf>
  100fa3:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100fa6:	83 ec 0c             	sub    $0xc,%esp
  100fa9:	6a 00                	push   $0x0
  100fab:	e8 e7 09 00 00       	call   101997 <pic_enable>
  100fb0:	83 c4 10             	add    $0x10,%esp
}
  100fb3:	90                   	nop
  100fb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100fb7:	c9                   	leave  
  100fb8:	c3                   	ret    

00100fb9 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100fb9:	55                   	push   %ebp
  100fba:	89 e5                	mov    %esp,%ebp
  100fbc:	83 ec 10             	sub    $0x10,%esp
  100fbf:	e8 b8 f2 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  100fc4:	05 8c d9 00 00       	add    $0xd98c,%eax
  100fc9:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fcf:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100fd3:	89 c2                	mov    %eax,%edx
  100fd5:	ec                   	in     (%dx),%al
  100fd6:	88 45 f1             	mov    %al,-0xf(%ebp)
  100fd9:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100fdf:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100fe3:	89 c2                	mov    %eax,%edx
  100fe5:	ec                   	in     (%dx),%al
  100fe6:	88 45 f5             	mov    %al,-0xb(%ebp)
  100fe9:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100fef:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100ff3:	89 c2                	mov    %eax,%edx
  100ff5:	ec                   	in     (%dx),%al
  100ff6:	88 45 f9             	mov    %al,-0x7(%ebp)
  100ff9:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100fff:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  101003:	89 c2                	mov    %eax,%edx
  101005:	ec                   	in     (%dx),%al
  101006:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  101009:	90                   	nop
  10100a:	c9                   	leave  
  10100b:	c3                   	ret    

0010100c <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  10100c:	55                   	push   %ebp
  10100d:	89 e5                	mov    %esp,%ebp
  10100f:	83 ec 20             	sub    $0x20,%esp
  101012:	e8 17 09 00 00       	call   10192e <__x86.get_pc_thunk.cx>
  101017:	81 c1 39 d9 00 00    	add    $0xd939,%ecx
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  10101d:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  101024:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101027:	0f b7 00             	movzwl (%eax),%eax
  10102a:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  10102e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101031:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  101036:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101039:	0f b7 00             	movzwl (%eax),%eax
  10103c:	66 3d 5a a5          	cmp    $0xa55a,%ax
  101040:	74 12                	je     101054 <cga_init+0x48>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  101042:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  101049:	66 c7 81 b6 05 00 00 	movw   $0x3b4,0x5b6(%ecx)
  101050:	b4 03 
  101052:	eb 13                	jmp    101067 <cga_init+0x5b>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  101054:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101057:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10105b:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  10105e:	66 c7 81 b6 05 00 00 	movw   $0x3d4,0x5b6(%ecx)
  101065:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  101067:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  10106e:	0f b7 c0             	movzwl %ax,%eax
  101071:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101075:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101079:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10107d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101081:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  101082:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  101089:	83 c0 01             	add    $0x1,%eax
  10108c:	0f b7 c0             	movzwl %ax,%eax
  10108f:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101093:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  101097:	89 c2                	mov    %eax,%edx
  101099:	ec                   	in     (%dx),%al
  10109a:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  10109d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1010a1:	0f b6 c0             	movzbl %al,%eax
  1010a4:	c1 e0 08             	shl    $0x8,%eax
  1010a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  1010aa:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010b1:	0f b7 c0             	movzwl %ax,%eax
  1010b4:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1010b8:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010bc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010c0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010c4:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  1010c5:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010cc:	83 c0 01             	add    $0x1,%eax
  1010cf:	0f b7 c0             	movzwl %ax,%eax
  1010d2:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1010d6:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1010da:	89 c2                	mov    %eax,%edx
  1010dc:	ec                   	in     (%dx),%al
  1010dd:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  1010e0:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010e4:	0f b6 c0             	movzbl %al,%eax
  1010e7:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  1010ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010ed:	89 81 b0 05 00 00    	mov    %eax,0x5b0(%ecx)
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  1010f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1010f6:	66 89 81 b4 05 00 00 	mov    %ax,0x5b4(%ecx)
}
  1010fd:	90                   	nop
  1010fe:	c9                   	leave  
  1010ff:	c3                   	ret    

00101100 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  101100:	55                   	push   %ebp
  101101:	89 e5                	mov    %esp,%ebp
  101103:	53                   	push   %ebx
  101104:	83 ec 34             	sub    $0x34,%esp
  101107:	e8 22 08 00 00       	call   10192e <__x86.get_pc_thunk.cx>
  10110c:	81 c1 44 d8 00 00    	add    $0xd844,%ecx
  101112:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  101118:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10111c:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101120:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101124:	ee                   	out    %al,(%dx)
  101125:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  10112b:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  10112f:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101133:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101137:	ee                   	out    %al,(%dx)
  101138:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  10113e:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  101142:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101146:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10114a:	ee                   	out    %al,(%dx)
  10114b:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  101151:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  101155:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101159:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10115d:	ee                   	out    %al,(%dx)
  10115e:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  101164:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  101168:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10116c:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101170:	ee                   	out    %al,(%dx)
  101171:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  101177:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  10117b:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10117f:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101183:	ee                   	out    %al,(%dx)
  101184:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  10118a:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  10118e:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101192:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101196:	ee                   	out    %al,(%dx)
  101197:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10119d:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  1011a1:	89 c2                	mov    %eax,%edx
  1011a3:	ec                   	in     (%dx),%al
  1011a4:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  1011a7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  1011ab:	3c ff                	cmp    $0xff,%al
  1011ad:	0f 95 c0             	setne  %al
  1011b0:	0f b6 c0             	movzbl %al,%eax
  1011b3:	89 81 b8 05 00 00    	mov    %eax,0x5b8(%ecx)
  1011b9:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011bf:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1011c3:	89 c2                	mov    %eax,%edx
  1011c5:	ec                   	in     (%dx),%al
  1011c6:	88 45 f1             	mov    %al,-0xf(%ebp)
  1011c9:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011cf:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1011d3:	89 c2                	mov    %eax,%edx
  1011d5:	ec                   	in     (%dx),%al
  1011d6:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  1011d9:	8b 81 b8 05 00 00    	mov    0x5b8(%ecx),%eax
  1011df:	85 c0                	test   %eax,%eax
  1011e1:	74 0f                	je     1011f2 <serial_init+0xf2>
        pic_enable(IRQ_COM1);
  1011e3:	83 ec 0c             	sub    $0xc,%esp
  1011e6:	6a 04                	push   $0x4
  1011e8:	89 cb                	mov    %ecx,%ebx
  1011ea:	e8 a8 07 00 00       	call   101997 <pic_enable>
  1011ef:	83 c4 10             	add    $0x10,%esp
    }
}
  1011f2:	90                   	nop
  1011f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1011f6:	c9                   	leave  
  1011f7:	c3                   	ret    

001011f8 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  1011f8:	55                   	push   %ebp
  1011f9:	89 e5                	mov    %esp,%ebp
  1011fb:	83 ec 20             	sub    $0x20,%esp
  1011fe:	e8 79 f0 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101203:	05 4d d7 00 00       	add    $0xd74d,%eax
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101208:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10120f:	eb 09                	jmp    10121a <lpt_putc_sub+0x22>
        delay();
  101211:	e8 a3 fd ff ff       	call   100fb9 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101216:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10121a:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101220:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101224:	89 c2                	mov    %eax,%edx
  101226:	ec                   	in     (%dx),%al
  101227:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10122a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10122e:	84 c0                	test   %al,%al
  101230:	78 09                	js     10123b <lpt_putc_sub+0x43>
  101232:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101239:	7e d6                	jle    101211 <lpt_putc_sub+0x19>
    }
    outb(LPTPORT + 0, c);
  10123b:	8b 45 08             	mov    0x8(%ebp),%eax
  10123e:	0f b6 c0             	movzbl %al,%eax
  101241:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101247:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10124a:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10124e:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101252:	ee                   	out    %al,(%dx)
  101253:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101259:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  10125d:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101261:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101265:	ee                   	out    %al,(%dx)
  101266:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  10126c:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  101270:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101274:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101278:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101279:	90                   	nop
  10127a:	c9                   	leave  
  10127b:	c3                   	ret    

0010127c <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  10127c:	55                   	push   %ebp
  10127d:	89 e5                	mov    %esp,%ebp
  10127f:	e8 f8 ef ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101284:	05 cc d6 00 00       	add    $0xd6cc,%eax
    if (c != '\b') {
  101289:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10128d:	74 0d                	je     10129c <lpt_putc+0x20>
        lpt_putc_sub(c);
  10128f:	ff 75 08             	pushl  0x8(%ebp)
  101292:	e8 61 ff ff ff       	call   1011f8 <lpt_putc_sub>
  101297:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  10129a:	eb 1e                	jmp    1012ba <lpt_putc+0x3e>
        lpt_putc_sub('\b');
  10129c:	6a 08                	push   $0x8
  10129e:	e8 55 ff ff ff       	call   1011f8 <lpt_putc_sub>
  1012a3:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1012a6:	6a 20                	push   $0x20
  1012a8:	e8 4b ff ff ff       	call   1011f8 <lpt_putc_sub>
  1012ad:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  1012b0:	6a 08                	push   $0x8
  1012b2:	e8 41 ff ff ff       	call   1011f8 <lpt_putc_sub>
  1012b7:	83 c4 04             	add    $0x4,%esp
}
  1012ba:	90                   	nop
  1012bb:	c9                   	leave  
  1012bc:	c3                   	ret    

001012bd <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1012bd:	55                   	push   %ebp
  1012be:	89 e5                	mov    %esp,%ebp
  1012c0:	56                   	push   %esi
  1012c1:	53                   	push   %ebx
  1012c2:	83 ec 20             	sub    $0x20,%esp
  1012c5:	e8 b6 ef ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1012ca:	81 c3 86 d6 00 00    	add    $0xd686,%ebx
    // set black on white
    if (!(c & ~0xFF)) {
  1012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1012d3:	b0 00                	mov    $0x0,%al
  1012d5:	85 c0                	test   %eax,%eax
  1012d7:	75 07                	jne    1012e0 <cga_putc+0x23>
        c |= 0x0700;
  1012d9:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1012e3:	0f b6 c0             	movzbl %al,%eax
  1012e6:	83 f8 0a             	cmp    $0xa,%eax
  1012e9:	74 54                	je     10133f <cga_putc+0x82>
  1012eb:	83 f8 0d             	cmp    $0xd,%eax
  1012ee:	74 60                	je     101350 <cga_putc+0x93>
  1012f0:	83 f8 08             	cmp    $0x8,%eax
  1012f3:	0f 85 92 00 00 00    	jne    10138b <cga_putc+0xce>
    case '\b':
        if (crt_pos > 0) {
  1012f9:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101300:	66 85 c0             	test   %ax,%ax
  101303:	0f 84 a8 00 00 00    	je     1013b1 <cga_putc+0xf4>
            crt_pos --;
  101309:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101310:	83 e8 01             	sub    $0x1,%eax
  101313:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10131a:	8b 45 08             	mov    0x8(%ebp),%eax
  10131d:	b0 00                	mov    $0x0,%al
  10131f:	83 c8 20             	or     $0x20,%eax
  101322:	89 c1                	mov    %eax,%ecx
  101324:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  10132a:	0f b7 93 b4 05 00 00 	movzwl 0x5b4(%ebx),%edx
  101331:	0f b7 d2             	movzwl %dx,%edx
  101334:	01 d2                	add    %edx,%edx
  101336:	01 d0                	add    %edx,%eax
  101338:	89 ca                	mov    %ecx,%edx
  10133a:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  10133d:	eb 72                	jmp    1013b1 <cga_putc+0xf4>
    case '\n':
        crt_pos += CRT_COLS;
  10133f:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101346:	83 c0 50             	add    $0x50,%eax
  101349:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101350:	0f b7 b3 b4 05 00 00 	movzwl 0x5b4(%ebx),%esi
  101357:	0f b7 8b b4 05 00 00 	movzwl 0x5b4(%ebx),%ecx
  10135e:	0f b7 c1             	movzwl %cx,%eax
  101361:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101367:	c1 e8 10             	shr    $0x10,%eax
  10136a:	89 c2                	mov    %eax,%edx
  10136c:	66 c1 ea 06          	shr    $0x6,%dx
  101370:	89 d0                	mov    %edx,%eax
  101372:	c1 e0 02             	shl    $0x2,%eax
  101375:	01 d0                	add    %edx,%eax
  101377:	c1 e0 04             	shl    $0x4,%eax
  10137a:	29 c1                	sub    %eax,%ecx
  10137c:	89 ca                	mov    %ecx,%edx
  10137e:	89 f0                	mov    %esi,%eax
  101380:	29 d0                	sub    %edx,%eax
  101382:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
        break;
  101389:	eb 27                	jmp    1013b2 <cga_putc+0xf5>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10138b:	8b 8b b0 05 00 00    	mov    0x5b0(%ebx),%ecx
  101391:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101398:	8d 50 01             	lea    0x1(%eax),%edx
  10139b:	66 89 93 b4 05 00 00 	mov    %dx,0x5b4(%ebx)
  1013a2:	0f b7 c0             	movzwl %ax,%eax
  1013a5:	01 c0                	add    %eax,%eax
  1013a7:	01 c8                	add    %ecx,%eax
  1013a9:	8b 55 08             	mov    0x8(%ebp),%edx
  1013ac:	66 89 10             	mov    %dx,(%eax)
        break;
  1013af:	eb 01                	jmp    1013b2 <cga_putc+0xf5>
        break;
  1013b1:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1013b2:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013b9:	66 3d cf 07          	cmp    $0x7cf,%ax
  1013bd:	76 5d                	jbe    10141c <cga_putc+0x15f>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1013bf:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013c5:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1013cb:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013d1:	83 ec 04             	sub    $0x4,%esp
  1013d4:	68 00 0f 00 00       	push   $0xf00
  1013d9:	52                   	push   %edx
  1013da:	50                   	push   %eax
  1013db:	e8 9c 1d 00 00       	call   10317c <memmove>
  1013e0:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1013e3:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1013ea:	eb 16                	jmp    101402 <cga_putc+0x145>
            crt_buf[i] = 0x0700 | ' ';
  1013ec:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013f5:	01 d2                	add    %edx,%edx
  1013f7:	01 d0                	add    %edx,%eax
  1013f9:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1013fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101402:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101409:	7e e1                	jle    1013ec <cga_putc+0x12f>
        }
        crt_pos -= CRT_COLS;
  10140b:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101412:	83 e8 50             	sub    $0x50,%eax
  101415:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10141c:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101423:	0f b7 c0             	movzwl %ax,%eax
  101426:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10142a:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  10142e:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101432:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101436:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101437:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10143e:	66 c1 e8 08          	shr    $0x8,%ax
  101442:	0f b6 c0             	movzbl %al,%eax
  101445:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  10144c:	83 c2 01             	add    $0x1,%edx
  10144f:	0f b7 d2             	movzwl %dx,%edx
  101452:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101456:	88 45 e9             	mov    %al,-0x17(%ebp)
  101459:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10145d:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101461:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101462:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101469:	0f b7 c0             	movzwl %ax,%eax
  10146c:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  101470:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  101474:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101478:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10147c:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10147d:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101484:	0f b6 c0             	movzbl %al,%eax
  101487:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  10148e:	83 c2 01             	add    $0x1,%edx
  101491:	0f b7 d2             	movzwl %dx,%edx
  101494:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101498:	88 45 f1             	mov    %al,-0xf(%ebp)
  10149b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10149f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1014a3:	ee                   	out    %al,(%dx)
}
  1014a4:	90                   	nop
  1014a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1014a8:	5b                   	pop    %ebx
  1014a9:	5e                   	pop    %esi
  1014aa:	5d                   	pop    %ebp
  1014ab:	c3                   	ret    

001014ac <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1014ac:	55                   	push   %ebp
  1014ad:	89 e5                	mov    %esp,%ebp
  1014af:	83 ec 10             	sub    $0x10,%esp
  1014b2:	e8 c5 ed ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1014b7:	05 99 d4 00 00       	add    $0xd499,%eax
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1014c3:	eb 09                	jmp    1014ce <serial_putc_sub+0x22>
        delay();
  1014c5:	e8 ef fa ff ff       	call   100fb9 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014ca:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1014ce:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014d4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1014d8:	89 c2                	mov    %eax,%edx
  1014da:	ec                   	in     (%dx),%al
  1014db:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1014de:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1014e2:	0f b6 c0             	movzbl %al,%eax
  1014e5:	83 e0 20             	and    $0x20,%eax
  1014e8:	85 c0                	test   %eax,%eax
  1014ea:	75 09                	jne    1014f5 <serial_putc_sub+0x49>
  1014ec:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1014f3:	7e d0                	jle    1014c5 <serial_putc_sub+0x19>
    }
    outb(COM1 + COM_TX, c);
  1014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1014f8:	0f b6 c0             	movzbl %al,%eax
  1014fb:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101501:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101504:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101508:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10150c:	ee                   	out    %al,(%dx)
}
  10150d:	90                   	nop
  10150e:	c9                   	leave  
  10150f:	c3                   	ret    

00101510 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101510:	55                   	push   %ebp
  101511:	89 e5                	mov    %esp,%ebp
  101513:	e8 64 ed ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101518:	05 38 d4 00 00       	add    $0xd438,%eax
    if (c != '\b') {
  10151d:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101521:	74 0d                	je     101530 <serial_putc+0x20>
        serial_putc_sub(c);
  101523:	ff 75 08             	pushl  0x8(%ebp)
  101526:	e8 81 ff ff ff       	call   1014ac <serial_putc_sub>
  10152b:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10152e:	eb 1e                	jmp    10154e <serial_putc+0x3e>
        serial_putc_sub('\b');
  101530:	6a 08                	push   $0x8
  101532:	e8 75 ff ff ff       	call   1014ac <serial_putc_sub>
  101537:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  10153a:	6a 20                	push   $0x20
  10153c:	e8 6b ff ff ff       	call   1014ac <serial_putc_sub>
  101541:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  101544:	6a 08                	push   $0x8
  101546:	e8 61 ff ff ff       	call   1014ac <serial_putc_sub>
  10154b:	83 c4 04             	add    $0x4,%esp
}
  10154e:	90                   	nop
  10154f:	c9                   	leave  
  101550:	c3                   	ret    

00101551 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101551:	55                   	push   %ebp
  101552:	89 e5                	mov    %esp,%ebp
  101554:	53                   	push   %ebx
  101555:	83 ec 14             	sub    $0x14,%esp
  101558:	e8 23 ed ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  10155d:	81 c3 f3 d3 00 00    	add    $0xd3f3,%ebx
    int c;
    while ((c = (*proc)()) != -1) {
  101563:	eb 36                	jmp    10159b <cons_intr+0x4a>
        if (c != 0) {
  101565:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101569:	74 30                	je     10159b <cons_intr+0x4a>
            cons.buf[cons.wpos ++] = c;
  10156b:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101571:	8d 50 01             	lea    0x1(%eax),%edx
  101574:	89 93 d4 07 00 00    	mov    %edx,0x7d4(%ebx)
  10157a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10157d:	88 94 03 d0 05 00 00 	mov    %dl,0x5d0(%ebx,%eax,1)
            if (cons.wpos == CONSBUFSIZE) {
  101584:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  10158a:	3d 00 02 00 00       	cmp    $0x200,%eax
  10158f:	75 0a                	jne    10159b <cons_intr+0x4a>
                cons.wpos = 0;
  101591:	c7 83 d4 07 00 00 00 	movl   $0x0,0x7d4(%ebx)
  101598:	00 00 00 
    while ((c = (*proc)()) != -1) {
  10159b:	8b 45 08             	mov    0x8(%ebp),%eax
  10159e:	ff d0                	call   *%eax
  1015a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1015a3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1015a7:	75 bc                	jne    101565 <cons_intr+0x14>
            }
        }
    }
}
  1015a9:	90                   	nop
  1015aa:	83 c4 14             	add    $0x14,%esp
  1015ad:	5b                   	pop    %ebx
  1015ae:	5d                   	pop    %ebp
  1015af:	c3                   	ret    

001015b0 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1015b0:	55                   	push   %ebp
  1015b1:	89 e5                	mov    %esp,%ebp
  1015b3:	83 ec 10             	sub    $0x10,%esp
  1015b6:	e8 c1 ec ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1015bb:	05 95 d3 00 00       	add    $0xd395,%eax
  1015c0:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015c6:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1015ca:	89 c2                	mov    %eax,%edx
  1015cc:	ec                   	in     (%dx),%al
  1015cd:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1015d0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1015d4:	0f b6 c0             	movzbl %al,%eax
  1015d7:	83 e0 01             	and    $0x1,%eax
  1015da:	85 c0                	test   %eax,%eax
  1015dc:	75 07                	jne    1015e5 <serial_proc_data+0x35>
        return -1;
  1015de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1015e3:	eb 2a                	jmp    10160f <serial_proc_data+0x5f>
  1015e5:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015eb:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1015ef:	89 c2                	mov    %eax,%edx
  1015f1:	ec                   	in     (%dx),%al
  1015f2:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1015f5:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1015f9:	0f b6 c0             	movzbl %al,%eax
  1015fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1015ff:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101603:	75 07                	jne    10160c <serial_proc_data+0x5c>
        c = '\b';
  101605:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10160f:	c9                   	leave  
  101610:	c3                   	ret    

00101611 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101611:	55                   	push   %ebp
  101612:	89 e5                	mov    %esp,%ebp
  101614:	83 ec 08             	sub    $0x8,%esp
  101617:	e8 60 ec ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10161c:	05 34 d3 00 00       	add    $0xd334,%eax
    if (serial_exists) {
  101621:	8b 90 b8 05 00 00    	mov    0x5b8(%eax),%edx
  101627:	85 d2                	test   %edx,%edx
  101629:	74 12                	je     10163d <serial_intr+0x2c>
        cons_intr(serial_proc_data);
  10162b:	83 ec 0c             	sub    $0xc,%esp
  10162e:	8d 80 60 2c ff ff    	lea    -0xd3a0(%eax),%eax
  101634:	50                   	push   %eax
  101635:	e8 17 ff ff ff       	call   101551 <cons_intr>
  10163a:	83 c4 10             	add    $0x10,%esp
    }
}
  10163d:	90                   	nop
  10163e:	c9                   	leave  
  10163f:	c3                   	ret    

00101640 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101640:	55                   	push   %ebp
  101641:	89 e5                	mov    %esp,%ebp
  101643:	53                   	push   %ebx
  101644:	83 ec 24             	sub    $0x24,%esp
  101647:	e8 e2 02 00 00       	call   10192e <__x86.get_pc_thunk.cx>
  10164c:	81 c1 04 d3 00 00    	add    $0xd304,%ecx
  101652:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101658:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10165c:	89 c2                	mov    %eax,%edx
  10165e:	ec                   	in     (%dx),%al
  10165f:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101662:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101666:	0f b6 c0             	movzbl %al,%eax
  101669:	83 e0 01             	and    $0x1,%eax
  10166c:	85 c0                	test   %eax,%eax
  10166e:	75 0a                	jne    10167a <kbd_proc_data+0x3a>
        return -1;
  101670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101675:	e9 73 01 00 00       	jmp    1017ed <kbd_proc_data+0x1ad>
  10167a:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101680:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101684:	89 c2                	mov    %eax,%edx
  101686:	ec                   	in     (%dx),%al
  101687:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10168a:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  10168e:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101691:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101695:	75 19                	jne    1016b0 <kbd_proc_data+0x70>
        // E0 escape character
        shift |= E0ESC;
  101697:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10169d:	83 c8 40             	or     $0x40,%eax
  1016a0:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016a6:	b8 00 00 00 00       	mov    $0x0,%eax
  1016ab:	e9 3d 01 00 00       	jmp    1017ed <kbd_proc_data+0x1ad>
    } else if (data & 0x80) {
  1016b0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016b4:	84 c0                	test   %al,%al
  1016b6:	79 4b                	jns    101703 <kbd_proc_data+0xc3>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1016b8:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016be:	83 e0 40             	and    $0x40,%eax
  1016c1:	85 c0                	test   %eax,%eax
  1016c3:	75 09                	jne    1016ce <kbd_proc_data+0x8e>
  1016c5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016c9:	83 e0 7f             	and    $0x7f,%eax
  1016cc:	eb 04                	jmp    1016d2 <kbd_proc_data+0x92>
  1016ce:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016d2:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1016d5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016d9:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  1016e0:	ff 
  1016e1:	83 c8 40             	or     $0x40,%eax
  1016e4:	0f b6 c0             	movzbl %al,%eax
  1016e7:	f7 d0                	not    %eax
  1016e9:	89 c2                	mov    %eax,%edx
  1016eb:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016f1:	21 d0                	and    %edx,%eax
  1016f3:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016f9:	b8 00 00 00 00       	mov    $0x0,%eax
  1016fe:	e9 ea 00 00 00       	jmp    1017ed <kbd_proc_data+0x1ad>
    } else if (shift & E0ESC) {
  101703:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101709:	83 e0 40             	and    $0x40,%eax
  10170c:	85 c0                	test   %eax,%eax
  10170e:	74 13                	je     101723 <kbd_proc_data+0xe3>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101710:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101714:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10171a:	83 e0 bf             	and    $0xffffffbf,%eax
  10171d:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    }

    shift |= shiftcode[data];
  101723:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101727:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  10172e:	ff 
  10172f:	0f b6 d0             	movzbl %al,%edx
  101732:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101738:	09 d0                	or     %edx,%eax
  10173a:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    shift ^= togglecode[data];
  101740:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101744:	0f b6 84 01 b0 f7 ff 	movzbl -0x850(%ecx,%eax,1),%eax
  10174b:	ff 
  10174c:	0f b6 d0             	movzbl %al,%edx
  10174f:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101755:	31 d0                	xor    %edx,%eax
  101757:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)

    c = charcode[shift & (CTL | SHIFT)][data];
  10175d:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101763:	83 e0 03             	and    $0x3,%eax
  101766:	8b 94 81 34 00 00 00 	mov    0x34(%ecx,%eax,4),%edx
  10176d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101771:	01 d0                	add    %edx,%eax
  101773:	0f b6 00             	movzbl (%eax),%eax
  101776:	0f b6 c0             	movzbl %al,%eax
  101779:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10177c:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101782:	83 e0 08             	and    $0x8,%eax
  101785:	85 c0                	test   %eax,%eax
  101787:	74 22                	je     1017ab <kbd_proc_data+0x16b>
        if ('a' <= c && c <= 'z')
  101789:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10178d:	7e 0c                	jle    10179b <kbd_proc_data+0x15b>
  10178f:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101793:	7f 06                	jg     10179b <kbd_proc_data+0x15b>
            c += 'A' - 'a';
  101795:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101799:	eb 10                	jmp    1017ab <kbd_proc_data+0x16b>
        else if ('A' <= c && c <= 'Z')
  10179b:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  10179f:	7e 0a                	jle    1017ab <kbd_proc_data+0x16b>
  1017a1:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1017a5:	7f 04                	jg     1017ab <kbd_proc_data+0x16b>
            c += 'a' - 'A';
  1017a7:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1017ab:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017b1:	f7 d0                	not    %eax
  1017b3:	83 e0 06             	and    $0x6,%eax
  1017b6:	85 c0                	test   %eax,%eax
  1017b8:	75 30                	jne    1017ea <kbd_proc_data+0x1aa>
  1017ba:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1017c1:	75 27                	jne    1017ea <kbd_proc_data+0x1aa>
        cprintf("Rebooting!\n");
  1017c3:	83 ec 0c             	sub    $0xc,%esp
  1017c6:	8d 81 55 53 ff ff    	lea    -0xacab(%ecx),%eax
  1017cc:	50                   	push   %eax
  1017cd:	89 cb                	mov    %ecx,%ebx
  1017cf:	e8 1f eb ff ff       	call   1002f3 <cprintf>
  1017d4:	83 c4 10             	add    $0x10,%esp
  1017d7:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1017dd:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017e1:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1017e5:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1017e9:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1017ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1017ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1017f0:	c9                   	leave  
  1017f1:	c3                   	ret    

001017f2 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1017f2:	55                   	push   %ebp
  1017f3:	89 e5                	mov    %esp,%ebp
  1017f5:	83 ec 08             	sub    $0x8,%esp
  1017f8:	e8 7f ea ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1017fd:	05 53 d1 00 00       	add    $0xd153,%eax
    cons_intr(kbd_proc_data);
  101802:	83 ec 0c             	sub    $0xc,%esp
  101805:	8d 80 f0 2c ff ff    	lea    -0xd310(%eax),%eax
  10180b:	50                   	push   %eax
  10180c:	e8 40 fd ff ff       	call   101551 <cons_intr>
  101811:	83 c4 10             	add    $0x10,%esp
}
  101814:	90                   	nop
  101815:	c9                   	leave  
  101816:	c3                   	ret    

00101817 <kbd_init>:

static void
kbd_init(void) {
  101817:	55                   	push   %ebp
  101818:	89 e5                	mov    %esp,%ebp
  10181a:	53                   	push   %ebx
  10181b:	83 ec 04             	sub    $0x4,%esp
  10181e:	e8 5d ea ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  101823:	81 c3 2d d1 00 00    	add    $0xd12d,%ebx
    // drain the kbd buffer
    kbd_intr();
  101829:	e8 c4 ff ff ff       	call   1017f2 <kbd_intr>
    pic_enable(IRQ_KBD);
  10182e:	83 ec 0c             	sub    $0xc,%esp
  101831:	6a 01                	push   $0x1
  101833:	e8 5f 01 00 00       	call   101997 <pic_enable>
  101838:	83 c4 10             	add    $0x10,%esp
}
  10183b:	90                   	nop
  10183c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10183f:	c9                   	leave  
  101840:	c3                   	ret    

00101841 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101841:	55                   	push   %ebp
  101842:	89 e5                	mov    %esp,%ebp
  101844:	53                   	push   %ebx
  101845:	83 ec 04             	sub    $0x4,%esp
  101848:	e8 33 ea ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  10184d:	81 c3 03 d1 00 00    	add    $0xd103,%ebx
    cga_init();
  101853:	e8 b4 f7 ff ff       	call   10100c <cga_init>
    serial_init();
  101858:	e8 a3 f8 ff ff       	call   101100 <serial_init>
    kbd_init();
  10185d:	e8 b5 ff ff ff       	call   101817 <kbd_init>
    if (!serial_exists) {
  101862:	8b 83 b8 05 00 00    	mov    0x5b8(%ebx),%eax
  101868:	85 c0                	test   %eax,%eax
  10186a:	75 12                	jne    10187e <cons_init+0x3d>
        cprintf("serial port does not exist!!\n");
  10186c:	83 ec 0c             	sub    $0xc,%esp
  10186f:	8d 83 61 53 ff ff    	lea    -0xac9f(%ebx),%eax
  101875:	50                   	push   %eax
  101876:	e8 78 ea ff ff       	call   1002f3 <cprintf>
  10187b:	83 c4 10             	add    $0x10,%esp
    }
}
  10187e:	90                   	nop
  10187f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101882:	c9                   	leave  
  101883:	c3                   	ret    

00101884 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101884:	55                   	push   %ebp
  101885:	89 e5                	mov    %esp,%ebp
  101887:	83 ec 08             	sub    $0x8,%esp
  10188a:	e8 ed e9 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10188f:	05 c1 d0 00 00       	add    $0xd0c1,%eax
    lpt_putc(c);
  101894:	ff 75 08             	pushl  0x8(%ebp)
  101897:	e8 e0 f9 ff ff       	call   10127c <lpt_putc>
  10189c:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  10189f:	83 ec 0c             	sub    $0xc,%esp
  1018a2:	ff 75 08             	pushl  0x8(%ebp)
  1018a5:	e8 13 fa ff ff       	call   1012bd <cga_putc>
  1018aa:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1018ad:	83 ec 0c             	sub    $0xc,%esp
  1018b0:	ff 75 08             	pushl  0x8(%ebp)
  1018b3:	e8 58 fc ff ff       	call   101510 <serial_putc>
  1018b8:	83 c4 10             	add    $0x10,%esp
}
  1018bb:	90                   	nop
  1018bc:	c9                   	leave  
  1018bd:	c3                   	ret    

001018be <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1018be:	55                   	push   %ebp
  1018bf:	89 e5                	mov    %esp,%ebp
  1018c1:	53                   	push   %ebx
  1018c2:	83 ec 14             	sub    $0x14,%esp
  1018c5:	e8 b6 e9 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1018ca:	81 c3 86 d0 00 00    	add    $0xd086,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1018d0:	e8 3c fd ff ff       	call   101611 <serial_intr>
    kbd_intr();
  1018d5:	e8 18 ff ff ff       	call   1017f2 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1018da:	8b 93 d0 07 00 00    	mov    0x7d0(%ebx),%edx
  1018e0:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1018e6:	39 c2                	cmp    %eax,%edx
  1018e8:	74 39                	je     101923 <cons_getc+0x65>
        c = cons.buf[cons.rpos ++];
  1018ea:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  1018f0:	8d 50 01             	lea    0x1(%eax),%edx
  1018f3:	89 93 d0 07 00 00    	mov    %edx,0x7d0(%ebx)
  1018f9:	0f b6 84 03 d0 05 00 	movzbl 0x5d0(%ebx,%eax,1),%eax
  101900:	00 
  101901:	0f b6 c0             	movzbl %al,%eax
  101904:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101907:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  10190d:	3d 00 02 00 00       	cmp    $0x200,%eax
  101912:	75 0a                	jne    10191e <cons_getc+0x60>
            cons.rpos = 0;
  101914:	c7 83 d0 07 00 00 00 	movl   $0x0,0x7d0(%ebx)
  10191b:	00 00 00 
        }
        return c;
  10191e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101921:	eb 05                	jmp    101928 <cons_getc+0x6a>
    }
    return 0;
  101923:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101928:	83 c4 14             	add    $0x14,%esp
  10192b:	5b                   	pop    %ebx
  10192c:	5d                   	pop    %ebp
  10192d:	c3                   	ret    

0010192e <__x86.get_pc_thunk.cx>:
  10192e:	8b 0c 24             	mov    (%esp),%ecx
  101931:	c3                   	ret    

00101932 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101932:	55                   	push   %ebp
  101933:	89 e5                	mov    %esp,%ebp
  101935:	83 ec 14             	sub    $0x14,%esp
  101938:	e8 3f e9 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10193d:	05 13 d0 00 00       	add    $0xd013,%eax
  101942:	8b 55 08             	mov    0x8(%ebp),%edx
  101945:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
    irq_mask = mask;
  101949:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  10194d:	66 89 90 b0 fb ff ff 	mov    %dx,-0x450(%eax)
    if (did_init) {
  101954:	8b 80 dc 07 00 00    	mov    0x7dc(%eax),%eax
  10195a:	85 c0                	test   %eax,%eax
  10195c:	74 36                	je     101994 <pic_setmask+0x62>
        outb(IO_PIC1 + 1, mask);
  10195e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101962:	0f b6 c0             	movzbl %al,%eax
  101965:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  10196b:	88 45 f9             	mov    %al,-0x7(%ebp)
  10196e:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101972:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101976:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101977:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10197b:	66 c1 e8 08          	shr    $0x8,%ax
  10197f:	0f b6 c0             	movzbl %al,%eax
  101982:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101988:	88 45 fd             	mov    %al,-0x3(%ebp)
  10198b:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10198f:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101993:	ee                   	out    %al,(%dx)
    }
}
  101994:	90                   	nop
  101995:	c9                   	leave  
  101996:	c3                   	ret    

00101997 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101997:	55                   	push   %ebp
  101998:	89 e5                	mov    %esp,%ebp
  10199a:	53                   	push   %ebx
  10199b:	e8 dc e8 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1019a0:	05 b0 cf 00 00       	add    $0xcfb0,%eax
    pic_setmask(irq_mask & ~(1 << irq));
  1019a5:	8b 55 08             	mov    0x8(%ebp),%edx
  1019a8:	bb 01 00 00 00       	mov    $0x1,%ebx
  1019ad:	89 d1                	mov    %edx,%ecx
  1019af:	d3 e3                	shl    %cl,%ebx
  1019b1:	89 da                	mov    %ebx,%edx
  1019b3:	f7 d2                	not    %edx
  1019b5:	0f b7 80 b0 fb ff ff 	movzwl -0x450(%eax),%eax
  1019bc:	21 d0                	and    %edx,%eax
  1019be:	0f b7 c0             	movzwl %ax,%eax
  1019c1:	50                   	push   %eax
  1019c2:	e8 6b ff ff ff       	call   101932 <pic_setmask>
  1019c7:	83 c4 04             	add    $0x4,%esp
}
  1019ca:	90                   	nop
  1019cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1019ce:	c9                   	leave  
  1019cf:	c3                   	ret    

001019d0 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1019d0:	55                   	push   %ebp
  1019d1:	89 e5                	mov    %esp,%ebp
  1019d3:	83 ec 40             	sub    $0x40,%esp
  1019d6:	e8 53 ff ff ff       	call   10192e <__x86.get_pc_thunk.cx>
  1019db:	81 c1 75 cf 00 00    	add    $0xcf75,%ecx
    did_init = 1;
  1019e1:	c7 81 dc 07 00 00 01 	movl   $0x1,0x7dc(%ecx)
  1019e8:	00 00 00 
  1019eb:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1019f1:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  1019f5:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1019f9:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1019fd:	ee                   	out    %al,(%dx)
  1019fe:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101a04:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  101a08:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101a0c:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101a10:	ee                   	out    %al,(%dx)
  101a11:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101a17:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  101a1b:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101a1f:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101a23:	ee                   	out    %al,(%dx)
  101a24:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101a2a:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  101a2e:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101a32:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101a36:	ee                   	out    %al,(%dx)
  101a37:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101a3d:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101a41:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101a45:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101a49:	ee                   	out    %al,(%dx)
  101a4a:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101a50:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  101a54:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101a58:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101a5c:	ee                   	out    %al,(%dx)
  101a5d:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101a63:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  101a67:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101a6b:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101a6f:	ee                   	out    %al,(%dx)
  101a70:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101a76:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101a7a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101a7e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101a82:	ee                   	out    %al,(%dx)
  101a83:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101a89:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101a8d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101a91:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101a95:	ee                   	out    %al,(%dx)
  101a96:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101a9c:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  101aa0:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101aa4:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101aa8:	ee                   	out    %al,(%dx)
  101aa9:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101aaf:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  101ab3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101ab7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101abb:	ee                   	out    %al,(%dx)
  101abc:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101ac2:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  101ac6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101aca:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101ace:	ee                   	out    %al,(%dx)
  101acf:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101ad5:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  101ad9:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101add:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101ae1:	ee                   	out    %al,(%dx)
  101ae2:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101ae8:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  101aec:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101af0:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101af4:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101af5:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101afc:	66 83 f8 ff          	cmp    $0xffff,%ax
  101b00:	74 13                	je     101b15 <pic_init+0x145>
        pic_setmask(irq_mask);
  101b02:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b09:	0f b7 c0             	movzwl %ax,%eax
  101b0c:	50                   	push   %eax
  101b0d:	e8 20 fe ff ff       	call   101932 <pic_setmask>
  101b12:	83 c4 04             	add    $0x4,%esp
    }
}
  101b15:	90                   	nop
  101b16:	c9                   	leave  
  101b17:	c3                   	ret    

00101b18 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101b18:	55                   	push   %ebp
  101b19:	89 e5                	mov    %esp,%ebp
  101b1b:	e8 5c e7 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101b20:	05 30 ce 00 00       	add    $0xce30,%eax
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101b25:	fb                   	sti    
    sti();
}
  101b26:	90                   	nop
  101b27:	5d                   	pop    %ebp
  101b28:	c3                   	ret    

00101b29 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101b29:	55                   	push   %ebp
  101b2a:	89 e5                	mov    %esp,%ebp
  101b2c:	e8 4b e7 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101b31:	05 1f ce 00 00       	add    $0xce1f,%eax
}

static inline void
cli(void) {
    asm volatile ("cli");
  101b36:	fa                   	cli    
    cli();
}
  101b37:	90                   	nop
  101b38:	5d                   	pop    %ebp
  101b39:	c3                   	ret    

00101b3a <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  101b3a:	55                   	push   %ebp
  101b3b:	89 e5                	mov    %esp,%ebp
  101b3d:	53                   	push   %ebx
  101b3e:	83 ec 04             	sub    $0x4,%esp
  101b41:	e8 36 e7 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101b46:	05 0a ce 00 00       	add    $0xce0a,%eax
    cprintf("%d ticks\n",TICK_NUM);
  101b4b:	83 ec 08             	sub    $0x8,%esp
  101b4e:	6a 64                	push   $0x64
  101b50:	8d 90 7f 53 ff ff    	lea    -0xac81(%eax),%edx
  101b56:	52                   	push   %edx
  101b57:	89 c3                	mov    %eax,%ebx
  101b59:	e8 95 e7 ff ff       	call   1002f3 <cprintf>
  101b5e:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101b61:	90                   	nop
  101b62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101b65:	c9                   	leave  
  101b66:	c3                   	ret    

00101b67 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101b67:	55                   	push   %ebp
  101b68:	89 e5                	mov    %esp,%ebp
  101b6a:	83 ec 10             	sub    $0x10,%esp
  101b6d:	e8 0a e7 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101b72:	05 de cd 00 00       	add    $0xcdde,%eax
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101b7e:	e9 c7 00 00 00       	jmp    101c4a <idt_init+0xe3>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101b83:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101b89:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101b8c:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101b8f:	89 d1                	mov    %edx,%ecx
  101b91:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101b94:	66 89 8c d0 f0 07 00 	mov    %cx,0x7f0(%eax,%edx,8)
  101b9b:	00 
  101b9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101b9f:	66 c7 84 d0 f2 07 00 	movw   $0x8,0x7f2(%eax,%edx,8)
  101ba6:	00 08 00 
  101ba9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bac:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bb3:	00 
  101bb4:	83 e1 e0             	and    $0xffffffe0,%ecx
  101bb7:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bbe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bc1:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bc8:	00 
  101bc9:	83 e1 1f             	and    $0x1f,%ecx
  101bcc:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bd3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bd6:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101bdd:	00 
  101bde:	83 e1 f0             	and    $0xfffffff0,%ecx
  101be1:	83 c9 0e             	or     $0xe,%ecx
  101be4:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101beb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bee:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101bf5:	00 
  101bf6:	83 e1 ef             	and    $0xffffffef,%ecx
  101bf9:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c00:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c03:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c0a:	00 
  101c0b:	83 e1 9f             	and    $0xffffff9f,%ecx
  101c0e:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c15:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c18:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c1f:	00 
  101c20:	83 c9 80             	or     $0xffffff80,%ecx
  101c23:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c2a:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101c30:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101c33:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101c36:	c1 ea 10             	shr    $0x10,%edx
  101c39:	89 d1                	mov    %edx,%ecx
  101c3b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c3e:	66 89 8c d0 f6 07 00 	mov    %cx,0x7f6(%eax,%edx,8)
  101c45:	00 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101c46:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101c4a:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  101c51:	0f 8e 2c ff ff ff    	jle    101b83 <idt_init+0x1c>
    }
  101c57:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101c5d:	8b 92 00 02 00 00    	mov    0x200(%edx),%edx
  101c63:	66 89 90 f0 0b 00 00 	mov    %dx,0xbf0(%eax)
  101c6a:	66 c7 80 f2 0b 00 00 	movw   $0x8,0xbf2(%eax)
  101c71:	08 00 
  101c73:	0f b6 90 f4 0b 00 00 	movzbl 0xbf4(%eax),%edx
  101c7a:	83 e2 e0             	and    $0xffffffe0,%edx
  101c7d:	88 90 f4 0b 00 00    	mov    %dl,0xbf4(%eax)
  101c83:	0f b6 90 f4 0b 00 00 	movzbl 0xbf4(%eax),%edx
  101c8a:	83 e2 1f             	and    $0x1f,%edx
  101c8d:	88 90 f4 0b 00 00    	mov    %dl,0xbf4(%eax)
  101c93:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101c9a:	83 e2 f0             	and    $0xfffffff0,%edx
  101c9d:	83 ca 0e             	or     $0xe,%edx
  101ca0:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101ca6:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101cad:	83 e2 ef             	and    $0xffffffef,%edx
  101cb0:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cb6:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101cbd:	83 ca 60             	or     $0x60,%edx
  101cc0:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cc6:	0f b6 90 f5 0b 00 00 	movzbl 0xbf5(%eax),%edx
  101ccd:	83 ca 80             	or     $0xffffff80,%edx
  101cd0:	88 90 f5 0b 00 00    	mov    %dl,0xbf5(%eax)
  101cd6:	c7 c2 02 e5 10 00    	mov    $0x10e502,%edx
  101cdc:	8b 92 00 02 00 00    	mov    0x200(%edx),%edx
  101ce2:	c1 ea 10             	shr    $0x10,%edx
  101ce5:	66 89 90 f6 0b 00 00 	mov    %dx,0xbf6(%eax)
  101cec:	8d 80 50 00 00 00    	lea    0x50(%eax),%eax
  101cf2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101cf5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101cf8:	0f 01 18             	lidtl  (%eax)
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101cfb:	90                   	nop
  101cfc:	c9                   	leave  
  101cfd:	c3                   	ret    

00101cfe <trapname>:
	// load the IDT
    lidt(&idt_pd);
}
  101cfe:	55                   	push   %ebp
  101cff:	89 e5                	mov    %esp,%ebp
  101d01:	e8 76 e5 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101d06:	05 4a cc 00 00       	add    $0xcc4a,%eax
        "Page Fault",
        "(unknown trap)",
        "x87 FPU Floating-Point Error",
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
  101d0b:	8b 55 08             	mov    0x8(%ebp),%edx
  101d0e:	83 fa 13             	cmp    $0x13,%edx
  101d11:	77 0c                	ja     101d1f <trapname+0x21>
    };
  101d13:	8b 55 08             	mov    0x8(%ebp),%edx
  101d16:	8b 84 90 f0 00 00 00 	mov    0xf0(%eax,%edx,4),%eax
  101d1d:	eb 1a                	jmp    101d39 <trapname+0x3b>

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101d1f:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101d23:	7e 0e                	jle    101d33 <trapname+0x35>
  101d25:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101d29:	7f 08                	jg     101d33 <trapname+0x35>
        return excnames[trapno];
  101d2b:	8d 80 89 53 ff ff    	lea    -0xac77(%eax),%eax
  101d31:	eb 06                	jmp    101d39 <trapname+0x3b>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101d33:	8d 80 9c 53 ff ff    	lea    -0xac64(%eax),%eax
        return "Hardware Interrupt";
  101d39:	5d                   	pop    %ebp
  101d3a:	c3                   	ret    

00101d3b <trap_in_kernel>:
    }
    return "(unknown trap)";
}

  101d3b:	55                   	push   %ebp
  101d3c:	89 e5                	mov    %esp,%ebp
  101d3e:	e8 39 e5 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  101d43:	05 0d cc 00 00       	add    $0xcc0d,%eax
/* trap_in_kernel - test if trap happened in kernel */
  101d48:	8b 45 08             	mov    0x8(%ebp),%eax
  101d4b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d4f:	66 83 f8 08          	cmp    $0x8,%ax
  101d53:	0f 94 c0             	sete   %al
  101d56:	0f b6 c0             	movzbl %al,%eax
bool
  101d59:	5d                   	pop    %ebp
  101d5a:	c3                   	ret    

00101d5b <print_trapframe>:

static const char *IA32flags[] = {
    "CF", NULL, "PF", NULL, "AF", NULL, "ZF", "SF",
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};
  101d5b:	55                   	push   %ebp
  101d5c:	89 e5                	mov    %esp,%ebp
  101d5e:	53                   	push   %ebx
  101d5f:	83 ec 14             	sub    $0x14,%esp
  101d62:	e8 19 e5 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  101d67:	81 c3 e9 cb 00 00    	add    $0xcbe9,%ebx

  101d6d:	83 ec 08             	sub    $0x8,%esp
  101d70:	ff 75 08             	pushl  0x8(%ebp)
  101d73:	8d 83 dd 53 ff ff    	lea    -0xac23(%ebx),%eax
  101d79:	50                   	push   %eax
  101d7a:	e8 74 e5 ff ff       	call   1002f3 <cprintf>
  101d7f:	83 c4 10             	add    $0x10,%esp
void
  101d82:	8b 45 08             	mov    0x8(%ebp),%eax
  101d85:	83 ec 0c             	sub    $0xc,%esp
  101d88:	50                   	push   %eax
  101d89:	e8 d3 01 00 00       	call   101f61 <print_regs>
  101d8e:	83 c4 10             	add    $0x10,%esp
print_trapframe(struct trapframe *tf) {
  101d91:	8b 45 08             	mov    0x8(%ebp),%eax
  101d94:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101d98:	0f b7 c0             	movzwl %ax,%eax
  101d9b:	83 ec 08             	sub    $0x8,%esp
  101d9e:	50                   	push   %eax
  101d9f:	8d 83 ee 53 ff ff    	lea    -0xac12(%ebx),%eax
  101da5:	50                   	push   %eax
  101da6:	e8 48 e5 ff ff       	call   1002f3 <cprintf>
  101dab:	83 c4 10             	add    $0x10,%esp
    cprintf("trapframe at %p\n", tf);
  101dae:	8b 45 08             	mov    0x8(%ebp),%eax
  101db1:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101db5:	0f b7 c0             	movzwl %ax,%eax
  101db8:	83 ec 08             	sub    $0x8,%esp
  101dbb:	50                   	push   %eax
  101dbc:	8d 83 01 54 ff ff    	lea    -0xabff(%ebx),%eax
  101dc2:	50                   	push   %eax
  101dc3:	e8 2b e5 ff ff       	call   1002f3 <cprintf>
  101dc8:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dce:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101dd2:	0f b7 c0             	movzwl %ax,%eax
  101dd5:	83 ec 08             	sub    $0x8,%esp
  101dd8:	50                   	push   %eax
  101dd9:	8d 83 14 54 ff ff    	lea    -0xabec(%ebx),%eax
  101ddf:	50                   	push   %eax
  101de0:	e8 0e e5 ff ff       	call   1002f3 <cprintf>
  101de5:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101de8:	8b 45 08             	mov    0x8(%ebp),%eax
  101deb:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101def:	0f b7 c0             	movzwl %ax,%eax
  101df2:	83 ec 08             	sub    $0x8,%esp
  101df5:	50                   	push   %eax
  101df6:	8d 83 27 54 ff ff    	lea    -0xabd9(%ebx),%eax
  101dfc:	50                   	push   %eax
  101dfd:	e8 f1 e4 ff ff       	call   1002f3 <cprintf>
  101e02:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101e05:	8b 45 08             	mov    0x8(%ebp),%eax
  101e08:	8b 40 30             	mov    0x30(%eax),%eax
  101e0b:	83 ec 0c             	sub    $0xc,%esp
  101e0e:	50                   	push   %eax
  101e0f:	e8 ea fe ff ff       	call   101cfe <trapname>
  101e14:	83 c4 10             	add    $0x10,%esp
  101e17:	89 c2                	mov    %eax,%edx
  101e19:	8b 45 08             	mov    0x8(%ebp),%eax
  101e1c:	8b 40 30             	mov    0x30(%eax),%eax
  101e1f:	83 ec 04             	sub    $0x4,%esp
  101e22:	52                   	push   %edx
  101e23:	50                   	push   %eax
  101e24:	8d 83 3a 54 ff ff    	lea    -0xabc6(%ebx),%eax
  101e2a:	50                   	push   %eax
  101e2b:	e8 c3 e4 ff ff       	call   1002f3 <cprintf>
  101e30:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101e33:	8b 45 08             	mov    0x8(%ebp),%eax
  101e36:	8b 40 34             	mov    0x34(%eax),%eax
  101e39:	83 ec 08             	sub    $0x8,%esp
  101e3c:	50                   	push   %eax
  101e3d:	8d 83 4c 54 ff ff    	lea    -0xabb4(%ebx),%eax
  101e43:	50                   	push   %eax
  101e44:	e8 aa e4 ff ff       	call   1002f3 <cprintf>
  101e49:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4f:	8b 40 38             	mov    0x38(%eax),%eax
  101e52:	83 ec 08             	sub    $0x8,%esp
  101e55:	50                   	push   %eax
  101e56:	8d 83 5b 54 ff ff    	lea    -0xaba5(%ebx),%eax
  101e5c:	50                   	push   %eax
  101e5d:	e8 91 e4 ff ff       	call   1002f3 <cprintf>
  101e62:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101e65:	8b 45 08             	mov    0x8(%ebp),%eax
  101e68:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e6c:	0f b7 c0             	movzwl %ax,%eax
  101e6f:	83 ec 08             	sub    $0x8,%esp
  101e72:	50                   	push   %eax
  101e73:	8d 83 6a 54 ff ff    	lea    -0xab96(%ebx),%eax
  101e79:	50                   	push   %eax
  101e7a:	e8 74 e4 ff ff       	call   1002f3 <cprintf>
  101e7f:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101e82:	8b 45 08             	mov    0x8(%ebp),%eax
  101e85:	8b 40 40             	mov    0x40(%eax),%eax
  101e88:	83 ec 08             	sub    $0x8,%esp
  101e8b:	50                   	push   %eax
  101e8c:	8d 83 7d 54 ff ff    	lea    -0xab83(%ebx),%eax
  101e92:	50                   	push   %eax
  101e93:	e8 5b e4 ff ff       	call   1002f3 <cprintf>
  101e98:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101e9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101ea2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ea9:	eb 41                	jmp    101eec <print_trapframe+0x191>

  101eab:	8b 45 08             	mov    0x8(%ebp),%eax
  101eae:	8b 50 40             	mov    0x40(%eax),%edx
  101eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101eb4:	21 d0                	and    %edx,%eax
  101eb6:	85 c0                	test   %eax,%eax
  101eb8:	74 2b                	je     101ee5 <print_trapframe+0x18a>
  101eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ebd:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ec4:	85 c0                	test   %eax,%eax
  101ec6:	74 1d                	je     101ee5 <print_trapframe+0x18a>
    int i, j;
  101ec8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ecb:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ed2:	83 ec 08             	sub    $0x8,%esp
  101ed5:	50                   	push   %eax
  101ed6:	8d 83 8c 54 ff ff    	lea    -0xab74(%ebx),%eax
  101edc:	50                   	push   %eax
  101edd:	e8 11 e4 ff ff       	call   1002f3 <cprintf>
  101ee2:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101ee5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101ee9:	d1 65 f0             	shll   -0x10(%ebp)
  101eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101eef:	83 f8 17             	cmp    $0x17,%eax
  101ef2:	76 b7                	jbe    101eab <print_trapframe+0x150>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
  101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef7:	8b 40 40             	mov    0x40(%eax),%eax
  101efa:	c1 e8 0c             	shr    $0xc,%eax
  101efd:	83 e0 03             	and    $0x3,%eax
  101f00:	83 ec 08             	sub    $0x8,%esp
  101f03:	50                   	push   %eax
  101f04:	8d 83 90 54 ff ff    	lea    -0xab70(%ebx),%eax
  101f0a:	50                   	push   %eax
  101f0b:	e8 e3 e3 ff ff       	call   1002f3 <cprintf>
  101f10:	83 c4 10             	add    $0x10,%esp
        }
    }
  101f13:	83 ec 0c             	sub    $0xc,%esp
  101f16:	ff 75 08             	pushl  0x8(%ebp)
  101f19:	e8 1d fe ff ff       	call   101d3b <trap_in_kernel>
  101f1e:	83 c4 10             	add    $0x10,%esp
  101f21:	85 c0                	test   %eax,%eax
  101f23:	75 36                	jne    101f5b <print_trapframe+0x200>
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101f25:	8b 45 08             	mov    0x8(%ebp),%eax
  101f28:	8b 40 44             	mov    0x44(%eax),%eax
  101f2b:	83 ec 08             	sub    $0x8,%esp
  101f2e:	50                   	push   %eax
  101f2f:	8d 83 99 54 ff ff    	lea    -0xab67(%ebx),%eax
  101f35:	50                   	push   %eax
  101f36:	e8 b8 e3 ff ff       	call   1002f3 <cprintf>
  101f3b:	83 c4 10             	add    $0x10,%esp

  101f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f41:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101f45:	0f b7 c0             	movzwl %ax,%eax
  101f48:	83 ec 08             	sub    $0x8,%esp
  101f4b:	50                   	push   %eax
  101f4c:	8d 83 a8 54 ff ff    	lea    -0xab58(%ebx),%eax
  101f52:	50                   	push   %eax
  101f53:	e8 9b e3 ff ff       	call   1002f3 <cprintf>
  101f58:	83 c4 10             	add    $0x10,%esp
    if (!trap_in_kernel(tf)) {
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101f5b:	90                   	nop
  101f5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f5f:	c9                   	leave  
  101f60:	c3                   	ret    

00101f61 <print_regs>:
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
    }
}
  101f61:	55                   	push   %ebp
  101f62:	89 e5                	mov    %esp,%ebp
  101f64:	53                   	push   %ebx
  101f65:	83 ec 04             	sub    $0x4,%esp
  101f68:	e8 13 e3 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  101f6d:	81 c3 e3 c9 00 00    	add    $0xc9e3,%ebx

  101f73:	8b 45 08             	mov    0x8(%ebp),%eax
  101f76:	8b 00                	mov    (%eax),%eax
  101f78:	83 ec 08             	sub    $0x8,%esp
  101f7b:	50                   	push   %eax
  101f7c:	8d 83 bb 54 ff ff    	lea    -0xab45(%ebx),%eax
  101f82:	50                   	push   %eax
  101f83:	e8 6b e3 ff ff       	call   1002f3 <cprintf>
  101f88:	83 c4 10             	add    $0x10,%esp
void
  101f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f8e:	8b 40 04             	mov    0x4(%eax),%eax
  101f91:	83 ec 08             	sub    $0x8,%esp
  101f94:	50                   	push   %eax
  101f95:	8d 83 ca 54 ff ff    	lea    -0xab36(%ebx),%eax
  101f9b:	50                   	push   %eax
  101f9c:	e8 52 e3 ff ff       	call   1002f3 <cprintf>
  101fa1:	83 c4 10             	add    $0x10,%esp
print_regs(struct pushregs *regs) {
  101fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  101fa7:	8b 40 08             	mov    0x8(%eax),%eax
  101faa:	83 ec 08             	sub    $0x8,%esp
  101fad:	50                   	push   %eax
  101fae:	8d 83 d9 54 ff ff    	lea    -0xab27(%ebx),%eax
  101fb4:	50                   	push   %eax
  101fb5:	e8 39 e3 ff ff       	call   1002f3 <cprintf>
  101fba:	83 c4 10             	add    $0x10,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  101fc0:	8b 40 0c             	mov    0xc(%eax),%eax
  101fc3:	83 ec 08             	sub    $0x8,%esp
  101fc6:	50                   	push   %eax
  101fc7:	8d 83 e8 54 ff ff    	lea    -0xab18(%ebx),%eax
  101fcd:	50                   	push   %eax
  101fce:	e8 20 e3 ff ff       	call   1002f3 <cprintf>
  101fd3:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  101fd9:	8b 40 10             	mov    0x10(%eax),%eax
  101fdc:	83 ec 08             	sub    $0x8,%esp
  101fdf:	50                   	push   %eax
  101fe0:	8d 83 f7 54 ff ff    	lea    -0xab09(%ebx),%eax
  101fe6:	50                   	push   %eax
  101fe7:	e8 07 e3 ff ff       	call   1002f3 <cprintf>
  101fec:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101fef:	8b 45 08             	mov    0x8(%ebp),%eax
  101ff2:	8b 40 14             	mov    0x14(%eax),%eax
  101ff5:	83 ec 08             	sub    $0x8,%esp
  101ff8:	50                   	push   %eax
  101ff9:	8d 83 06 55 ff ff    	lea    -0xaafa(%ebx),%eax
  101fff:	50                   	push   %eax
  102000:	e8 ee e2 ff ff       	call   1002f3 <cprintf>
  102005:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  102008:	8b 45 08             	mov    0x8(%ebp),%eax
  10200b:	8b 40 18             	mov    0x18(%eax),%eax
  10200e:	83 ec 08             	sub    $0x8,%esp
  102011:	50                   	push   %eax
  102012:	8d 83 15 55 ff ff    	lea    -0xaaeb(%ebx),%eax
  102018:	50                   	push   %eax
  102019:	e8 d5 e2 ff ff       	call   1002f3 <cprintf>
  10201e:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  102021:	8b 45 08             	mov    0x8(%ebp),%eax
  102024:	8b 40 1c             	mov    0x1c(%eax),%eax
  102027:	83 ec 08             	sub    $0x8,%esp
  10202a:	50                   	push   %eax
  10202b:	8d 83 24 55 ff ff    	lea    -0xaadc(%ebx),%eax
  102031:	50                   	push   %eax
  102032:	e8 bc e2 ff ff       	call   1002f3 <cprintf>
  102037:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  10203a:	90                   	nop
  10203b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10203e:	c9                   	leave  
  10203f:	c3                   	ret    

00102040 <trap_dispatch>:
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
    cprintf("  eax  0x%08x\n", regs->reg_eax);
}

  102040:	55                   	push   %ebp
  102041:	89 e5                	mov    %esp,%ebp
  102043:	53                   	push   %ebx
  102044:	83 ec 14             	sub    $0x14,%esp
  102047:	e8 34 e2 ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  10204c:	81 c3 04 c9 00 00    	add    $0xc904,%ebx
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

  102052:	8b 45 08             	mov    0x8(%ebp),%eax
  102055:	8b 40 30             	mov    0x30(%eax),%eax
  102058:	83 f8 2f             	cmp    $0x2f,%eax
  10205b:	77 21                	ja     10207e <trap_dispatch+0x3e>
  10205d:	83 f8 2e             	cmp    $0x2e,%eax
  102060:	0f 83 0c 01 00 00    	jae    102172 <trap_dispatch+0x132>
  102066:	83 f8 21             	cmp    $0x21,%eax
  102069:	0f 84 88 00 00 00    	je     1020f7 <trap_dispatch+0xb7>
  10206f:	83 f8 24             	cmp    $0x24,%eax
  102072:	74 5d                	je     1020d1 <trap_dispatch+0x91>
  102074:	83 f8 20             	cmp    $0x20,%eax
  102077:	74 16                	je     10208f <trap_dispatch+0x4f>
  102079:	e9 ba 00 00 00       	jmp    102138 <trap_dispatch+0xf8>
  10207e:	83 e8 78             	sub    $0x78,%eax
  102081:	83 f8 01             	cmp    $0x1,%eax
  102084:	0f 87 ae 00 00 00    	ja     102138 <trap_dispatch+0xf8>
  10208a:	e9 8e 00 00 00       	jmp    10211d <trap_dispatch+0xdd>
trap_dispatch(struct trapframe *tf) {
    char c;

    switch (tf->tf_trapno) {
    case IRQ_OFFSET + IRQ_TIMER:
        /* LAB1 YOUR CODE : STEP 3 */
  10208f:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  102095:	8b 00                	mov    (%eax),%eax
  102097:	8d 50 01             	lea    0x1(%eax),%edx
  10209a:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  1020a0:	89 10                	mov    %edx,(%eax)
        /* handle the timer interrupt */
  1020a2:	c7 c0 a8 f9 10 00    	mov    $0x10f9a8,%eax
  1020a8:	8b 08                	mov    (%eax),%ecx
  1020aa:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  1020af:	89 c8                	mov    %ecx,%eax
  1020b1:	f7 e2                	mul    %edx
  1020b3:	89 d0                	mov    %edx,%eax
  1020b5:	c1 e8 05             	shr    $0x5,%eax
  1020b8:	6b c0 64             	imul   $0x64,%eax,%eax
  1020bb:	29 c1                	sub    %eax,%ecx
  1020bd:	89 c8                	mov    %ecx,%eax
  1020bf:	85 c0                	test   %eax,%eax
  1020c1:	0f 85 ae 00 00 00    	jne    102175 <trap_dispatch+0x135>
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
  1020c7:	e8 6e fa ff ff       	call   101b3a <print_ticks>
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  1020cc:	e9 a4 00 00 00       	jmp    102175 <trap_dispatch+0x135>
        if (ticks % TICK_NUM == 0) {
            print_ticks();
  1020d1:	e8 e8 f7 ff ff       	call   1018be <cons_getc>
  1020d6:	88 45 f7             	mov    %al,-0x9(%ebp)
        }
  1020d9:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  1020dd:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1020e1:	83 ec 04             	sub    $0x4,%esp
  1020e4:	52                   	push   %edx
  1020e5:	50                   	push   %eax
  1020e6:	8d 83 33 55 ff ff    	lea    -0xaacd(%ebx),%eax
  1020ec:	50                   	push   %eax
  1020ed:	e8 01 e2 ff ff       	call   1002f3 <cprintf>
  1020f2:	83 c4 10             	add    $0x10,%esp
        break;
  1020f5:	eb 7f                	jmp    102176 <trap_dispatch+0x136>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  1020f7:	e8 c2 f7 ff ff       	call   1018be <cons_getc>
  1020fc:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  1020ff:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  102103:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  102107:	83 ec 04             	sub    $0x4,%esp
  10210a:	52                   	push   %edx
  10210b:	50                   	push   %eax
  10210c:	8d 83 45 55 ff ff    	lea    -0xaabb(%ebx),%eax
  102112:	50                   	push   %eax
  102113:	e8 db e1 ff ff       	call   1002f3 <cprintf>
  102118:	83 c4 10             	add    $0x10,%esp
        break;
  10211b:	eb 59                	jmp    102176 <trap_dispatch+0x136>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
        cprintf("kbd [%03d] %c\n", c, c);
        break;
  10211d:	83 ec 04             	sub    $0x4,%esp
  102120:	8d 83 54 55 ff ff    	lea    -0xaaac(%ebx),%eax
  102126:	50                   	push   %eax
  102127:	68 ae 00 00 00       	push   $0xae
  10212c:	8d 83 64 55 ff ff    	lea    -0xaa9c(%ebx),%eax
  102132:	50                   	push   %eax
  102133:	e8 6b e3 ff ff       	call   1004a3 <__panic>
        if (tf->tf_cs != USER_CS) {
            switchk2u = *tf;
            switchk2u.tf_cs = USER_CS;
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
		
  102138:	8b 45 08             	mov    0x8(%ebp),%eax
  10213b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10213f:	0f b7 c0             	movzwl %ax,%eax
  102142:	83 e0 03             	and    $0x3,%eax
  102145:	85 c0                	test   %eax,%eax
  102147:	75 2d                	jne    102176 <trap_dispatch+0x136>
            // set eflags, make sure ucore can use io under user mode.
  102149:	83 ec 0c             	sub    $0xc,%esp
  10214c:	ff 75 08             	pushl  0x8(%ebp)
  10214f:	e8 07 fc ff ff       	call   101d5b <print_trapframe>
  102154:	83 c4 10             	add    $0x10,%esp
            // if CPL > IOPL, then cpu will generate a general protection.
  102157:	83 ec 04             	sub    $0x4,%esp
  10215a:	8d 83 75 55 ff ff    	lea    -0xaa8b(%ebx),%eax
  102160:	50                   	push   %eax
  102161:	68 b8 00 00 00       	push   $0xb8
  102166:	8d 83 64 55 ff ff    	lea    -0xaa9c(%ebx),%eax
  10216c:	50                   	push   %eax
  10216d:	e8 31 e3 ff ff       	call   1004a3 <__panic>
            switchk2u.tf_cs = USER_CS;
  102172:	90                   	nop
  102173:	eb 01                	jmp    102176 <trap_dispatch+0x136>
        ticks ++;
  102175:	90                   	nop
            switchk2u.tf_eflags |= FL_IOPL_MASK;
		
            // set temporary stack
  102176:	90                   	nop
  102177:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10217a:	c9                   	leave  
  10217b:	c3                   	ret    

0010217c <trap>:
        }
        break;
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
            tf->tf_cs = KERNEL_CS;
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  10217c:	55                   	push   %ebp
  10217d:	89 e5                	mov    %esp,%ebp
  10217f:	83 ec 08             	sub    $0x8,%esp
  102182:	e8 f5 e0 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102187:	05 c9 c7 00 00       	add    $0xc7c9,%eax
            tf->tf_eflags &= ~FL_IOPL_MASK;
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  10218c:	83 ec 0c             	sub    $0xc,%esp
  10218f:	ff 75 08             	pushl  0x8(%ebp)
  102192:	e8 a9 fe ff ff       	call   102040 <trap_dispatch>
  102197:	83 c4 10             	add    $0x10,%esp
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  10219a:	90                   	nop
  10219b:	c9                   	leave  
  10219c:	c3                   	ret    

0010219d <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $0
  10219f:	6a 00                	push   $0x0
  jmp __alltraps
  1021a1:	e9 69 0a 00 00       	jmp    102c0f <__alltraps>

001021a6 <vector1>:
.globl vector1
vector1:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $1
  1021a8:	6a 01                	push   $0x1
  jmp __alltraps
  1021aa:	e9 60 0a 00 00       	jmp    102c0f <__alltraps>

001021af <vector2>:
.globl vector2
vector2:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $2
  1021b1:	6a 02                	push   $0x2
  jmp __alltraps
  1021b3:	e9 57 0a 00 00       	jmp    102c0f <__alltraps>

001021b8 <vector3>:
.globl vector3
vector3:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $3
  1021ba:	6a 03                	push   $0x3
  jmp __alltraps
  1021bc:	e9 4e 0a 00 00       	jmp    102c0f <__alltraps>

001021c1 <vector4>:
.globl vector4
vector4:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $4
  1021c3:	6a 04                	push   $0x4
  jmp __alltraps
  1021c5:	e9 45 0a 00 00       	jmp    102c0f <__alltraps>

001021ca <vector5>:
.globl vector5
vector5:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $5
  1021cc:	6a 05                	push   $0x5
  jmp __alltraps
  1021ce:	e9 3c 0a 00 00       	jmp    102c0f <__alltraps>

001021d3 <vector6>:
.globl vector6
vector6:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $6
  1021d5:	6a 06                	push   $0x6
  jmp __alltraps
  1021d7:	e9 33 0a 00 00       	jmp    102c0f <__alltraps>

001021dc <vector7>:
.globl vector7
vector7:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $7
  1021de:	6a 07                	push   $0x7
  jmp __alltraps
  1021e0:	e9 2a 0a 00 00       	jmp    102c0f <__alltraps>

001021e5 <vector8>:
.globl vector8
vector8:
  pushl $8
  1021e5:	6a 08                	push   $0x8
  jmp __alltraps
  1021e7:	e9 23 0a 00 00       	jmp    102c0f <__alltraps>

001021ec <vector9>:
.globl vector9
vector9:
  pushl $0
  1021ec:	6a 00                	push   $0x0
  pushl $9
  1021ee:	6a 09                	push   $0x9
  jmp __alltraps
  1021f0:	e9 1a 0a 00 00       	jmp    102c0f <__alltraps>

001021f5 <vector10>:
.globl vector10
vector10:
  pushl $10
  1021f5:	6a 0a                	push   $0xa
  jmp __alltraps
  1021f7:	e9 13 0a 00 00       	jmp    102c0f <__alltraps>

001021fc <vector11>:
.globl vector11
vector11:
  pushl $11
  1021fc:	6a 0b                	push   $0xb
  jmp __alltraps
  1021fe:	e9 0c 0a 00 00       	jmp    102c0f <__alltraps>

00102203 <vector12>:
.globl vector12
vector12:
  pushl $12
  102203:	6a 0c                	push   $0xc
  jmp __alltraps
  102205:	e9 05 0a 00 00       	jmp    102c0f <__alltraps>

0010220a <vector13>:
.globl vector13
vector13:
  pushl $13
  10220a:	6a 0d                	push   $0xd
  jmp __alltraps
  10220c:	e9 fe 09 00 00       	jmp    102c0f <__alltraps>

00102211 <vector14>:
.globl vector14
vector14:
  pushl $14
  102211:	6a 0e                	push   $0xe
  jmp __alltraps
  102213:	e9 f7 09 00 00       	jmp    102c0f <__alltraps>

00102218 <vector15>:
.globl vector15
vector15:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $15
  10221a:	6a 0f                	push   $0xf
  jmp __alltraps
  10221c:	e9 ee 09 00 00       	jmp    102c0f <__alltraps>

00102221 <vector16>:
.globl vector16
vector16:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $16
  102223:	6a 10                	push   $0x10
  jmp __alltraps
  102225:	e9 e5 09 00 00       	jmp    102c0f <__alltraps>

0010222a <vector17>:
.globl vector17
vector17:
  pushl $17
  10222a:	6a 11                	push   $0x11
  jmp __alltraps
  10222c:	e9 de 09 00 00       	jmp    102c0f <__alltraps>

00102231 <vector18>:
.globl vector18
vector18:
  pushl $0
  102231:	6a 00                	push   $0x0
  pushl $18
  102233:	6a 12                	push   $0x12
  jmp __alltraps
  102235:	e9 d5 09 00 00       	jmp    102c0f <__alltraps>

0010223a <vector19>:
.globl vector19
vector19:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $19
  10223c:	6a 13                	push   $0x13
  jmp __alltraps
  10223e:	e9 cc 09 00 00       	jmp    102c0f <__alltraps>

00102243 <vector20>:
.globl vector20
vector20:
  pushl $0
  102243:	6a 00                	push   $0x0
  pushl $20
  102245:	6a 14                	push   $0x14
  jmp __alltraps
  102247:	e9 c3 09 00 00       	jmp    102c0f <__alltraps>

0010224c <vector21>:
.globl vector21
vector21:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $21
  10224e:	6a 15                	push   $0x15
  jmp __alltraps
  102250:	e9 ba 09 00 00       	jmp    102c0f <__alltraps>

00102255 <vector22>:
.globl vector22
vector22:
  pushl $0
  102255:	6a 00                	push   $0x0
  pushl $22
  102257:	6a 16                	push   $0x16
  jmp __alltraps
  102259:	e9 b1 09 00 00       	jmp    102c0f <__alltraps>

0010225e <vector23>:
.globl vector23
vector23:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $23
  102260:	6a 17                	push   $0x17
  jmp __alltraps
  102262:	e9 a8 09 00 00       	jmp    102c0f <__alltraps>

00102267 <vector24>:
.globl vector24
vector24:
  pushl $0
  102267:	6a 00                	push   $0x0
  pushl $24
  102269:	6a 18                	push   $0x18
  jmp __alltraps
  10226b:	e9 9f 09 00 00       	jmp    102c0f <__alltraps>

00102270 <vector25>:
.globl vector25
vector25:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $25
  102272:	6a 19                	push   $0x19
  jmp __alltraps
  102274:	e9 96 09 00 00       	jmp    102c0f <__alltraps>

00102279 <vector26>:
.globl vector26
vector26:
  pushl $0
  102279:	6a 00                	push   $0x0
  pushl $26
  10227b:	6a 1a                	push   $0x1a
  jmp __alltraps
  10227d:	e9 8d 09 00 00       	jmp    102c0f <__alltraps>

00102282 <vector27>:
.globl vector27
vector27:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $27
  102284:	6a 1b                	push   $0x1b
  jmp __alltraps
  102286:	e9 84 09 00 00       	jmp    102c0f <__alltraps>

0010228b <vector28>:
.globl vector28
vector28:
  pushl $0
  10228b:	6a 00                	push   $0x0
  pushl $28
  10228d:	6a 1c                	push   $0x1c
  jmp __alltraps
  10228f:	e9 7b 09 00 00       	jmp    102c0f <__alltraps>

00102294 <vector29>:
.globl vector29
vector29:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $29
  102296:	6a 1d                	push   $0x1d
  jmp __alltraps
  102298:	e9 72 09 00 00       	jmp    102c0f <__alltraps>

0010229d <vector30>:
.globl vector30
vector30:
  pushl $0
  10229d:	6a 00                	push   $0x0
  pushl $30
  10229f:	6a 1e                	push   $0x1e
  jmp __alltraps
  1022a1:	e9 69 09 00 00       	jmp    102c0f <__alltraps>

001022a6 <vector31>:
.globl vector31
vector31:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $31
  1022a8:	6a 1f                	push   $0x1f
  jmp __alltraps
  1022aa:	e9 60 09 00 00       	jmp    102c0f <__alltraps>

001022af <vector32>:
.globl vector32
vector32:
  pushl $0
  1022af:	6a 00                	push   $0x0
  pushl $32
  1022b1:	6a 20                	push   $0x20
  jmp __alltraps
  1022b3:	e9 57 09 00 00       	jmp    102c0f <__alltraps>

001022b8 <vector33>:
.globl vector33
vector33:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $33
  1022ba:	6a 21                	push   $0x21
  jmp __alltraps
  1022bc:	e9 4e 09 00 00       	jmp    102c0f <__alltraps>

001022c1 <vector34>:
.globl vector34
vector34:
  pushl $0
  1022c1:	6a 00                	push   $0x0
  pushl $34
  1022c3:	6a 22                	push   $0x22
  jmp __alltraps
  1022c5:	e9 45 09 00 00       	jmp    102c0f <__alltraps>

001022ca <vector35>:
.globl vector35
vector35:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $35
  1022cc:	6a 23                	push   $0x23
  jmp __alltraps
  1022ce:	e9 3c 09 00 00       	jmp    102c0f <__alltraps>

001022d3 <vector36>:
.globl vector36
vector36:
  pushl $0
  1022d3:	6a 00                	push   $0x0
  pushl $36
  1022d5:	6a 24                	push   $0x24
  jmp __alltraps
  1022d7:	e9 33 09 00 00       	jmp    102c0f <__alltraps>

001022dc <vector37>:
.globl vector37
vector37:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $37
  1022de:	6a 25                	push   $0x25
  jmp __alltraps
  1022e0:	e9 2a 09 00 00       	jmp    102c0f <__alltraps>

001022e5 <vector38>:
.globl vector38
vector38:
  pushl $0
  1022e5:	6a 00                	push   $0x0
  pushl $38
  1022e7:	6a 26                	push   $0x26
  jmp __alltraps
  1022e9:	e9 21 09 00 00       	jmp    102c0f <__alltraps>

001022ee <vector39>:
.globl vector39
vector39:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $39
  1022f0:	6a 27                	push   $0x27
  jmp __alltraps
  1022f2:	e9 18 09 00 00       	jmp    102c0f <__alltraps>

001022f7 <vector40>:
.globl vector40
vector40:
  pushl $0
  1022f7:	6a 00                	push   $0x0
  pushl $40
  1022f9:	6a 28                	push   $0x28
  jmp __alltraps
  1022fb:	e9 0f 09 00 00       	jmp    102c0f <__alltraps>

00102300 <vector41>:
.globl vector41
vector41:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $41
  102302:	6a 29                	push   $0x29
  jmp __alltraps
  102304:	e9 06 09 00 00       	jmp    102c0f <__alltraps>

00102309 <vector42>:
.globl vector42
vector42:
  pushl $0
  102309:	6a 00                	push   $0x0
  pushl $42
  10230b:	6a 2a                	push   $0x2a
  jmp __alltraps
  10230d:	e9 fd 08 00 00       	jmp    102c0f <__alltraps>

00102312 <vector43>:
.globl vector43
vector43:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $43
  102314:	6a 2b                	push   $0x2b
  jmp __alltraps
  102316:	e9 f4 08 00 00       	jmp    102c0f <__alltraps>

0010231b <vector44>:
.globl vector44
vector44:
  pushl $0
  10231b:	6a 00                	push   $0x0
  pushl $44
  10231d:	6a 2c                	push   $0x2c
  jmp __alltraps
  10231f:	e9 eb 08 00 00       	jmp    102c0f <__alltraps>

00102324 <vector45>:
.globl vector45
vector45:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $45
  102326:	6a 2d                	push   $0x2d
  jmp __alltraps
  102328:	e9 e2 08 00 00       	jmp    102c0f <__alltraps>

0010232d <vector46>:
.globl vector46
vector46:
  pushl $0
  10232d:	6a 00                	push   $0x0
  pushl $46
  10232f:	6a 2e                	push   $0x2e
  jmp __alltraps
  102331:	e9 d9 08 00 00       	jmp    102c0f <__alltraps>

00102336 <vector47>:
.globl vector47
vector47:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $47
  102338:	6a 2f                	push   $0x2f
  jmp __alltraps
  10233a:	e9 d0 08 00 00       	jmp    102c0f <__alltraps>

0010233f <vector48>:
.globl vector48
vector48:
  pushl $0
  10233f:	6a 00                	push   $0x0
  pushl $48
  102341:	6a 30                	push   $0x30
  jmp __alltraps
  102343:	e9 c7 08 00 00       	jmp    102c0f <__alltraps>

00102348 <vector49>:
.globl vector49
vector49:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $49
  10234a:	6a 31                	push   $0x31
  jmp __alltraps
  10234c:	e9 be 08 00 00       	jmp    102c0f <__alltraps>

00102351 <vector50>:
.globl vector50
vector50:
  pushl $0
  102351:	6a 00                	push   $0x0
  pushl $50
  102353:	6a 32                	push   $0x32
  jmp __alltraps
  102355:	e9 b5 08 00 00       	jmp    102c0f <__alltraps>

0010235a <vector51>:
.globl vector51
vector51:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $51
  10235c:	6a 33                	push   $0x33
  jmp __alltraps
  10235e:	e9 ac 08 00 00       	jmp    102c0f <__alltraps>

00102363 <vector52>:
.globl vector52
vector52:
  pushl $0
  102363:	6a 00                	push   $0x0
  pushl $52
  102365:	6a 34                	push   $0x34
  jmp __alltraps
  102367:	e9 a3 08 00 00       	jmp    102c0f <__alltraps>

0010236c <vector53>:
.globl vector53
vector53:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $53
  10236e:	6a 35                	push   $0x35
  jmp __alltraps
  102370:	e9 9a 08 00 00       	jmp    102c0f <__alltraps>

00102375 <vector54>:
.globl vector54
vector54:
  pushl $0
  102375:	6a 00                	push   $0x0
  pushl $54
  102377:	6a 36                	push   $0x36
  jmp __alltraps
  102379:	e9 91 08 00 00       	jmp    102c0f <__alltraps>

0010237e <vector55>:
.globl vector55
vector55:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $55
  102380:	6a 37                	push   $0x37
  jmp __alltraps
  102382:	e9 88 08 00 00       	jmp    102c0f <__alltraps>

00102387 <vector56>:
.globl vector56
vector56:
  pushl $0
  102387:	6a 00                	push   $0x0
  pushl $56
  102389:	6a 38                	push   $0x38
  jmp __alltraps
  10238b:	e9 7f 08 00 00       	jmp    102c0f <__alltraps>

00102390 <vector57>:
.globl vector57
vector57:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $57
  102392:	6a 39                	push   $0x39
  jmp __alltraps
  102394:	e9 76 08 00 00       	jmp    102c0f <__alltraps>

00102399 <vector58>:
.globl vector58
vector58:
  pushl $0
  102399:	6a 00                	push   $0x0
  pushl $58
  10239b:	6a 3a                	push   $0x3a
  jmp __alltraps
  10239d:	e9 6d 08 00 00       	jmp    102c0f <__alltraps>

001023a2 <vector59>:
.globl vector59
vector59:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $59
  1023a4:	6a 3b                	push   $0x3b
  jmp __alltraps
  1023a6:	e9 64 08 00 00       	jmp    102c0f <__alltraps>

001023ab <vector60>:
.globl vector60
vector60:
  pushl $0
  1023ab:	6a 00                	push   $0x0
  pushl $60
  1023ad:	6a 3c                	push   $0x3c
  jmp __alltraps
  1023af:	e9 5b 08 00 00       	jmp    102c0f <__alltraps>

001023b4 <vector61>:
.globl vector61
vector61:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $61
  1023b6:	6a 3d                	push   $0x3d
  jmp __alltraps
  1023b8:	e9 52 08 00 00       	jmp    102c0f <__alltraps>

001023bd <vector62>:
.globl vector62
vector62:
  pushl $0
  1023bd:	6a 00                	push   $0x0
  pushl $62
  1023bf:	6a 3e                	push   $0x3e
  jmp __alltraps
  1023c1:	e9 49 08 00 00       	jmp    102c0f <__alltraps>

001023c6 <vector63>:
.globl vector63
vector63:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $63
  1023c8:	6a 3f                	push   $0x3f
  jmp __alltraps
  1023ca:	e9 40 08 00 00       	jmp    102c0f <__alltraps>

001023cf <vector64>:
.globl vector64
vector64:
  pushl $0
  1023cf:	6a 00                	push   $0x0
  pushl $64
  1023d1:	6a 40                	push   $0x40
  jmp __alltraps
  1023d3:	e9 37 08 00 00       	jmp    102c0f <__alltraps>

001023d8 <vector65>:
.globl vector65
vector65:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $65
  1023da:	6a 41                	push   $0x41
  jmp __alltraps
  1023dc:	e9 2e 08 00 00       	jmp    102c0f <__alltraps>

001023e1 <vector66>:
.globl vector66
vector66:
  pushl $0
  1023e1:	6a 00                	push   $0x0
  pushl $66
  1023e3:	6a 42                	push   $0x42
  jmp __alltraps
  1023e5:	e9 25 08 00 00       	jmp    102c0f <__alltraps>

001023ea <vector67>:
.globl vector67
vector67:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $67
  1023ec:	6a 43                	push   $0x43
  jmp __alltraps
  1023ee:	e9 1c 08 00 00       	jmp    102c0f <__alltraps>

001023f3 <vector68>:
.globl vector68
vector68:
  pushl $0
  1023f3:	6a 00                	push   $0x0
  pushl $68
  1023f5:	6a 44                	push   $0x44
  jmp __alltraps
  1023f7:	e9 13 08 00 00       	jmp    102c0f <__alltraps>

001023fc <vector69>:
.globl vector69
vector69:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $69
  1023fe:	6a 45                	push   $0x45
  jmp __alltraps
  102400:	e9 0a 08 00 00       	jmp    102c0f <__alltraps>

00102405 <vector70>:
.globl vector70
vector70:
  pushl $0
  102405:	6a 00                	push   $0x0
  pushl $70
  102407:	6a 46                	push   $0x46
  jmp __alltraps
  102409:	e9 01 08 00 00       	jmp    102c0f <__alltraps>

0010240e <vector71>:
.globl vector71
vector71:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $71
  102410:	6a 47                	push   $0x47
  jmp __alltraps
  102412:	e9 f8 07 00 00       	jmp    102c0f <__alltraps>

00102417 <vector72>:
.globl vector72
vector72:
  pushl $0
  102417:	6a 00                	push   $0x0
  pushl $72
  102419:	6a 48                	push   $0x48
  jmp __alltraps
  10241b:	e9 ef 07 00 00       	jmp    102c0f <__alltraps>

00102420 <vector73>:
.globl vector73
vector73:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $73
  102422:	6a 49                	push   $0x49
  jmp __alltraps
  102424:	e9 e6 07 00 00       	jmp    102c0f <__alltraps>

00102429 <vector74>:
.globl vector74
vector74:
  pushl $0
  102429:	6a 00                	push   $0x0
  pushl $74
  10242b:	6a 4a                	push   $0x4a
  jmp __alltraps
  10242d:	e9 dd 07 00 00       	jmp    102c0f <__alltraps>

00102432 <vector75>:
.globl vector75
vector75:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $75
  102434:	6a 4b                	push   $0x4b
  jmp __alltraps
  102436:	e9 d4 07 00 00       	jmp    102c0f <__alltraps>

0010243b <vector76>:
.globl vector76
vector76:
  pushl $0
  10243b:	6a 00                	push   $0x0
  pushl $76
  10243d:	6a 4c                	push   $0x4c
  jmp __alltraps
  10243f:	e9 cb 07 00 00       	jmp    102c0f <__alltraps>

00102444 <vector77>:
.globl vector77
vector77:
  pushl $0
  102444:	6a 00                	push   $0x0
  pushl $77
  102446:	6a 4d                	push   $0x4d
  jmp __alltraps
  102448:	e9 c2 07 00 00       	jmp    102c0f <__alltraps>

0010244d <vector78>:
.globl vector78
vector78:
  pushl $0
  10244d:	6a 00                	push   $0x0
  pushl $78
  10244f:	6a 4e                	push   $0x4e
  jmp __alltraps
  102451:	e9 b9 07 00 00       	jmp    102c0f <__alltraps>

00102456 <vector79>:
.globl vector79
vector79:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $79
  102458:	6a 4f                	push   $0x4f
  jmp __alltraps
  10245a:	e9 b0 07 00 00       	jmp    102c0f <__alltraps>

0010245f <vector80>:
.globl vector80
vector80:
  pushl $0
  10245f:	6a 00                	push   $0x0
  pushl $80
  102461:	6a 50                	push   $0x50
  jmp __alltraps
  102463:	e9 a7 07 00 00       	jmp    102c0f <__alltraps>

00102468 <vector81>:
.globl vector81
vector81:
  pushl $0
  102468:	6a 00                	push   $0x0
  pushl $81
  10246a:	6a 51                	push   $0x51
  jmp __alltraps
  10246c:	e9 9e 07 00 00       	jmp    102c0f <__alltraps>

00102471 <vector82>:
.globl vector82
vector82:
  pushl $0
  102471:	6a 00                	push   $0x0
  pushl $82
  102473:	6a 52                	push   $0x52
  jmp __alltraps
  102475:	e9 95 07 00 00       	jmp    102c0f <__alltraps>

0010247a <vector83>:
.globl vector83
vector83:
  pushl $0
  10247a:	6a 00                	push   $0x0
  pushl $83
  10247c:	6a 53                	push   $0x53
  jmp __alltraps
  10247e:	e9 8c 07 00 00       	jmp    102c0f <__alltraps>

00102483 <vector84>:
.globl vector84
vector84:
  pushl $0
  102483:	6a 00                	push   $0x0
  pushl $84
  102485:	6a 54                	push   $0x54
  jmp __alltraps
  102487:	e9 83 07 00 00       	jmp    102c0f <__alltraps>

0010248c <vector85>:
.globl vector85
vector85:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $85
  10248e:	6a 55                	push   $0x55
  jmp __alltraps
  102490:	e9 7a 07 00 00       	jmp    102c0f <__alltraps>

00102495 <vector86>:
.globl vector86
vector86:
  pushl $0
  102495:	6a 00                	push   $0x0
  pushl $86
  102497:	6a 56                	push   $0x56
  jmp __alltraps
  102499:	e9 71 07 00 00       	jmp    102c0f <__alltraps>

0010249e <vector87>:
.globl vector87
vector87:
  pushl $0
  10249e:	6a 00                	push   $0x0
  pushl $87
  1024a0:	6a 57                	push   $0x57
  jmp __alltraps
  1024a2:	e9 68 07 00 00       	jmp    102c0f <__alltraps>

001024a7 <vector88>:
.globl vector88
vector88:
  pushl $0
  1024a7:	6a 00                	push   $0x0
  pushl $88
  1024a9:	6a 58                	push   $0x58
  jmp __alltraps
  1024ab:	e9 5f 07 00 00       	jmp    102c0f <__alltraps>

001024b0 <vector89>:
.globl vector89
vector89:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $89
  1024b2:	6a 59                	push   $0x59
  jmp __alltraps
  1024b4:	e9 56 07 00 00       	jmp    102c0f <__alltraps>

001024b9 <vector90>:
.globl vector90
vector90:
  pushl $0
  1024b9:	6a 00                	push   $0x0
  pushl $90
  1024bb:	6a 5a                	push   $0x5a
  jmp __alltraps
  1024bd:	e9 4d 07 00 00       	jmp    102c0f <__alltraps>

001024c2 <vector91>:
.globl vector91
vector91:
  pushl $0
  1024c2:	6a 00                	push   $0x0
  pushl $91
  1024c4:	6a 5b                	push   $0x5b
  jmp __alltraps
  1024c6:	e9 44 07 00 00       	jmp    102c0f <__alltraps>

001024cb <vector92>:
.globl vector92
vector92:
  pushl $0
  1024cb:	6a 00                	push   $0x0
  pushl $92
  1024cd:	6a 5c                	push   $0x5c
  jmp __alltraps
  1024cf:	e9 3b 07 00 00       	jmp    102c0f <__alltraps>

001024d4 <vector93>:
.globl vector93
vector93:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $93
  1024d6:	6a 5d                	push   $0x5d
  jmp __alltraps
  1024d8:	e9 32 07 00 00       	jmp    102c0f <__alltraps>

001024dd <vector94>:
.globl vector94
vector94:
  pushl $0
  1024dd:	6a 00                	push   $0x0
  pushl $94
  1024df:	6a 5e                	push   $0x5e
  jmp __alltraps
  1024e1:	e9 29 07 00 00       	jmp    102c0f <__alltraps>

001024e6 <vector95>:
.globl vector95
vector95:
  pushl $0
  1024e6:	6a 00                	push   $0x0
  pushl $95
  1024e8:	6a 5f                	push   $0x5f
  jmp __alltraps
  1024ea:	e9 20 07 00 00       	jmp    102c0f <__alltraps>

001024ef <vector96>:
.globl vector96
vector96:
  pushl $0
  1024ef:	6a 00                	push   $0x0
  pushl $96
  1024f1:	6a 60                	push   $0x60
  jmp __alltraps
  1024f3:	e9 17 07 00 00       	jmp    102c0f <__alltraps>

001024f8 <vector97>:
.globl vector97
vector97:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $97
  1024fa:	6a 61                	push   $0x61
  jmp __alltraps
  1024fc:	e9 0e 07 00 00       	jmp    102c0f <__alltraps>

00102501 <vector98>:
.globl vector98
vector98:
  pushl $0
  102501:	6a 00                	push   $0x0
  pushl $98
  102503:	6a 62                	push   $0x62
  jmp __alltraps
  102505:	e9 05 07 00 00       	jmp    102c0f <__alltraps>

0010250a <vector99>:
.globl vector99
vector99:
  pushl $0
  10250a:	6a 00                	push   $0x0
  pushl $99
  10250c:	6a 63                	push   $0x63
  jmp __alltraps
  10250e:	e9 fc 06 00 00       	jmp    102c0f <__alltraps>

00102513 <vector100>:
.globl vector100
vector100:
  pushl $0
  102513:	6a 00                	push   $0x0
  pushl $100
  102515:	6a 64                	push   $0x64
  jmp __alltraps
  102517:	e9 f3 06 00 00       	jmp    102c0f <__alltraps>

0010251c <vector101>:
.globl vector101
vector101:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $101
  10251e:	6a 65                	push   $0x65
  jmp __alltraps
  102520:	e9 ea 06 00 00       	jmp    102c0f <__alltraps>

00102525 <vector102>:
.globl vector102
vector102:
  pushl $0
  102525:	6a 00                	push   $0x0
  pushl $102
  102527:	6a 66                	push   $0x66
  jmp __alltraps
  102529:	e9 e1 06 00 00       	jmp    102c0f <__alltraps>

0010252e <vector103>:
.globl vector103
vector103:
  pushl $0
  10252e:	6a 00                	push   $0x0
  pushl $103
  102530:	6a 67                	push   $0x67
  jmp __alltraps
  102532:	e9 d8 06 00 00       	jmp    102c0f <__alltraps>

00102537 <vector104>:
.globl vector104
vector104:
  pushl $0
  102537:	6a 00                	push   $0x0
  pushl $104
  102539:	6a 68                	push   $0x68
  jmp __alltraps
  10253b:	e9 cf 06 00 00       	jmp    102c0f <__alltraps>

00102540 <vector105>:
.globl vector105
vector105:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $105
  102542:	6a 69                	push   $0x69
  jmp __alltraps
  102544:	e9 c6 06 00 00       	jmp    102c0f <__alltraps>

00102549 <vector106>:
.globl vector106
vector106:
  pushl $0
  102549:	6a 00                	push   $0x0
  pushl $106
  10254b:	6a 6a                	push   $0x6a
  jmp __alltraps
  10254d:	e9 bd 06 00 00       	jmp    102c0f <__alltraps>

00102552 <vector107>:
.globl vector107
vector107:
  pushl $0
  102552:	6a 00                	push   $0x0
  pushl $107
  102554:	6a 6b                	push   $0x6b
  jmp __alltraps
  102556:	e9 b4 06 00 00       	jmp    102c0f <__alltraps>

0010255b <vector108>:
.globl vector108
vector108:
  pushl $0
  10255b:	6a 00                	push   $0x0
  pushl $108
  10255d:	6a 6c                	push   $0x6c
  jmp __alltraps
  10255f:	e9 ab 06 00 00       	jmp    102c0f <__alltraps>

00102564 <vector109>:
.globl vector109
vector109:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $109
  102566:	6a 6d                	push   $0x6d
  jmp __alltraps
  102568:	e9 a2 06 00 00       	jmp    102c0f <__alltraps>

0010256d <vector110>:
.globl vector110
vector110:
  pushl $0
  10256d:	6a 00                	push   $0x0
  pushl $110
  10256f:	6a 6e                	push   $0x6e
  jmp __alltraps
  102571:	e9 99 06 00 00       	jmp    102c0f <__alltraps>

00102576 <vector111>:
.globl vector111
vector111:
  pushl $0
  102576:	6a 00                	push   $0x0
  pushl $111
  102578:	6a 6f                	push   $0x6f
  jmp __alltraps
  10257a:	e9 90 06 00 00       	jmp    102c0f <__alltraps>

0010257f <vector112>:
.globl vector112
vector112:
  pushl $0
  10257f:	6a 00                	push   $0x0
  pushl $112
  102581:	6a 70                	push   $0x70
  jmp __alltraps
  102583:	e9 87 06 00 00       	jmp    102c0f <__alltraps>

00102588 <vector113>:
.globl vector113
vector113:
  pushl $0
  102588:	6a 00                	push   $0x0
  pushl $113
  10258a:	6a 71                	push   $0x71
  jmp __alltraps
  10258c:	e9 7e 06 00 00       	jmp    102c0f <__alltraps>

00102591 <vector114>:
.globl vector114
vector114:
  pushl $0
  102591:	6a 00                	push   $0x0
  pushl $114
  102593:	6a 72                	push   $0x72
  jmp __alltraps
  102595:	e9 75 06 00 00       	jmp    102c0f <__alltraps>

0010259a <vector115>:
.globl vector115
vector115:
  pushl $0
  10259a:	6a 00                	push   $0x0
  pushl $115
  10259c:	6a 73                	push   $0x73
  jmp __alltraps
  10259e:	e9 6c 06 00 00       	jmp    102c0f <__alltraps>

001025a3 <vector116>:
.globl vector116
vector116:
  pushl $0
  1025a3:	6a 00                	push   $0x0
  pushl $116
  1025a5:	6a 74                	push   $0x74
  jmp __alltraps
  1025a7:	e9 63 06 00 00       	jmp    102c0f <__alltraps>

001025ac <vector117>:
.globl vector117
vector117:
  pushl $0
  1025ac:	6a 00                	push   $0x0
  pushl $117
  1025ae:	6a 75                	push   $0x75
  jmp __alltraps
  1025b0:	e9 5a 06 00 00       	jmp    102c0f <__alltraps>

001025b5 <vector118>:
.globl vector118
vector118:
  pushl $0
  1025b5:	6a 00                	push   $0x0
  pushl $118
  1025b7:	6a 76                	push   $0x76
  jmp __alltraps
  1025b9:	e9 51 06 00 00       	jmp    102c0f <__alltraps>

001025be <vector119>:
.globl vector119
vector119:
  pushl $0
  1025be:	6a 00                	push   $0x0
  pushl $119
  1025c0:	6a 77                	push   $0x77
  jmp __alltraps
  1025c2:	e9 48 06 00 00       	jmp    102c0f <__alltraps>

001025c7 <vector120>:
.globl vector120
vector120:
  pushl $0
  1025c7:	6a 00                	push   $0x0
  pushl $120
  1025c9:	6a 78                	push   $0x78
  jmp __alltraps
  1025cb:	e9 3f 06 00 00       	jmp    102c0f <__alltraps>

001025d0 <vector121>:
.globl vector121
vector121:
  pushl $0
  1025d0:	6a 00                	push   $0x0
  pushl $121
  1025d2:	6a 79                	push   $0x79
  jmp __alltraps
  1025d4:	e9 36 06 00 00       	jmp    102c0f <__alltraps>

001025d9 <vector122>:
.globl vector122
vector122:
  pushl $0
  1025d9:	6a 00                	push   $0x0
  pushl $122
  1025db:	6a 7a                	push   $0x7a
  jmp __alltraps
  1025dd:	e9 2d 06 00 00       	jmp    102c0f <__alltraps>

001025e2 <vector123>:
.globl vector123
vector123:
  pushl $0
  1025e2:	6a 00                	push   $0x0
  pushl $123
  1025e4:	6a 7b                	push   $0x7b
  jmp __alltraps
  1025e6:	e9 24 06 00 00       	jmp    102c0f <__alltraps>

001025eb <vector124>:
.globl vector124
vector124:
  pushl $0
  1025eb:	6a 00                	push   $0x0
  pushl $124
  1025ed:	6a 7c                	push   $0x7c
  jmp __alltraps
  1025ef:	e9 1b 06 00 00       	jmp    102c0f <__alltraps>

001025f4 <vector125>:
.globl vector125
vector125:
  pushl $0
  1025f4:	6a 00                	push   $0x0
  pushl $125
  1025f6:	6a 7d                	push   $0x7d
  jmp __alltraps
  1025f8:	e9 12 06 00 00       	jmp    102c0f <__alltraps>

001025fd <vector126>:
.globl vector126
vector126:
  pushl $0
  1025fd:	6a 00                	push   $0x0
  pushl $126
  1025ff:	6a 7e                	push   $0x7e
  jmp __alltraps
  102601:	e9 09 06 00 00       	jmp    102c0f <__alltraps>

00102606 <vector127>:
.globl vector127
vector127:
  pushl $0
  102606:	6a 00                	push   $0x0
  pushl $127
  102608:	6a 7f                	push   $0x7f
  jmp __alltraps
  10260a:	e9 00 06 00 00       	jmp    102c0f <__alltraps>

0010260f <vector128>:
.globl vector128
vector128:
  pushl $0
  10260f:	6a 00                	push   $0x0
  pushl $128
  102611:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102616:	e9 f4 05 00 00       	jmp    102c0f <__alltraps>

0010261b <vector129>:
.globl vector129
vector129:
  pushl $0
  10261b:	6a 00                	push   $0x0
  pushl $129
  10261d:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102622:	e9 e8 05 00 00       	jmp    102c0f <__alltraps>

00102627 <vector130>:
.globl vector130
vector130:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $130
  102629:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10262e:	e9 dc 05 00 00       	jmp    102c0f <__alltraps>

00102633 <vector131>:
.globl vector131
vector131:
  pushl $0
  102633:	6a 00                	push   $0x0
  pushl $131
  102635:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10263a:	e9 d0 05 00 00       	jmp    102c0f <__alltraps>

0010263f <vector132>:
.globl vector132
vector132:
  pushl $0
  10263f:	6a 00                	push   $0x0
  pushl $132
  102641:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102646:	e9 c4 05 00 00       	jmp    102c0f <__alltraps>

0010264b <vector133>:
.globl vector133
vector133:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $133
  10264d:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102652:	e9 b8 05 00 00       	jmp    102c0f <__alltraps>

00102657 <vector134>:
.globl vector134
vector134:
  pushl $0
  102657:	6a 00                	push   $0x0
  pushl $134
  102659:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10265e:	e9 ac 05 00 00       	jmp    102c0f <__alltraps>

00102663 <vector135>:
.globl vector135
vector135:
  pushl $0
  102663:	6a 00                	push   $0x0
  pushl $135
  102665:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10266a:	e9 a0 05 00 00       	jmp    102c0f <__alltraps>

0010266f <vector136>:
.globl vector136
vector136:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $136
  102671:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102676:	e9 94 05 00 00       	jmp    102c0f <__alltraps>

0010267b <vector137>:
.globl vector137
vector137:
  pushl $0
  10267b:	6a 00                	push   $0x0
  pushl $137
  10267d:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102682:	e9 88 05 00 00       	jmp    102c0f <__alltraps>

00102687 <vector138>:
.globl vector138
vector138:
  pushl $0
  102687:	6a 00                	push   $0x0
  pushl $138
  102689:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10268e:	e9 7c 05 00 00       	jmp    102c0f <__alltraps>

00102693 <vector139>:
.globl vector139
vector139:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $139
  102695:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  10269a:	e9 70 05 00 00       	jmp    102c0f <__alltraps>

0010269f <vector140>:
.globl vector140
vector140:
  pushl $0
  10269f:	6a 00                	push   $0x0
  pushl $140
  1026a1:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1026a6:	e9 64 05 00 00       	jmp    102c0f <__alltraps>

001026ab <vector141>:
.globl vector141
vector141:
  pushl $0
  1026ab:	6a 00                	push   $0x0
  pushl $141
  1026ad:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1026b2:	e9 58 05 00 00       	jmp    102c0f <__alltraps>

001026b7 <vector142>:
.globl vector142
vector142:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $142
  1026b9:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1026be:	e9 4c 05 00 00       	jmp    102c0f <__alltraps>

001026c3 <vector143>:
.globl vector143
vector143:
  pushl $0
  1026c3:	6a 00                	push   $0x0
  pushl $143
  1026c5:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1026ca:	e9 40 05 00 00       	jmp    102c0f <__alltraps>

001026cf <vector144>:
.globl vector144
vector144:
  pushl $0
  1026cf:	6a 00                	push   $0x0
  pushl $144
  1026d1:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1026d6:	e9 34 05 00 00       	jmp    102c0f <__alltraps>

001026db <vector145>:
.globl vector145
vector145:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $145
  1026dd:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1026e2:	e9 28 05 00 00       	jmp    102c0f <__alltraps>

001026e7 <vector146>:
.globl vector146
vector146:
  pushl $0
  1026e7:	6a 00                	push   $0x0
  pushl $146
  1026e9:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1026ee:	e9 1c 05 00 00       	jmp    102c0f <__alltraps>

001026f3 <vector147>:
.globl vector147
vector147:
  pushl $0
  1026f3:	6a 00                	push   $0x0
  pushl $147
  1026f5:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1026fa:	e9 10 05 00 00       	jmp    102c0f <__alltraps>

001026ff <vector148>:
.globl vector148
vector148:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $148
  102701:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102706:	e9 04 05 00 00       	jmp    102c0f <__alltraps>

0010270b <vector149>:
.globl vector149
vector149:
  pushl $0
  10270b:	6a 00                	push   $0x0
  pushl $149
  10270d:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102712:	e9 f8 04 00 00       	jmp    102c0f <__alltraps>

00102717 <vector150>:
.globl vector150
vector150:
  pushl $0
  102717:	6a 00                	push   $0x0
  pushl $150
  102719:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10271e:	e9 ec 04 00 00       	jmp    102c0f <__alltraps>

00102723 <vector151>:
.globl vector151
vector151:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $151
  102725:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10272a:	e9 e0 04 00 00       	jmp    102c0f <__alltraps>

0010272f <vector152>:
.globl vector152
vector152:
  pushl $0
  10272f:	6a 00                	push   $0x0
  pushl $152
  102731:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102736:	e9 d4 04 00 00       	jmp    102c0f <__alltraps>

0010273b <vector153>:
.globl vector153
vector153:
  pushl $0
  10273b:	6a 00                	push   $0x0
  pushl $153
  10273d:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102742:	e9 c8 04 00 00       	jmp    102c0f <__alltraps>

00102747 <vector154>:
.globl vector154
vector154:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $154
  102749:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10274e:	e9 bc 04 00 00       	jmp    102c0f <__alltraps>

00102753 <vector155>:
.globl vector155
vector155:
  pushl $0
  102753:	6a 00                	push   $0x0
  pushl $155
  102755:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10275a:	e9 b0 04 00 00       	jmp    102c0f <__alltraps>

0010275f <vector156>:
.globl vector156
vector156:
  pushl $0
  10275f:	6a 00                	push   $0x0
  pushl $156
  102761:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102766:	e9 a4 04 00 00       	jmp    102c0f <__alltraps>

0010276b <vector157>:
.globl vector157
vector157:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $157
  10276d:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102772:	e9 98 04 00 00       	jmp    102c0f <__alltraps>

00102777 <vector158>:
.globl vector158
vector158:
  pushl $0
  102777:	6a 00                	push   $0x0
  pushl $158
  102779:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10277e:	e9 8c 04 00 00       	jmp    102c0f <__alltraps>

00102783 <vector159>:
.globl vector159
vector159:
  pushl $0
  102783:	6a 00                	push   $0x0
  pushl $159
  102785:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  10278a:	e9 80 04 00 00       	jmp    102c0f <__alltraps>

0010278f <vector160>:
.globl vector160
vector160:
  pushl $0
  10278f:	6a 00                	push   $0x0
  pushl $160
  102791:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102796:	e9 74 04 00 00       	jmp    102c0f <__alltraps>

0010279b <vector161>:
.globl vector161
vector161:
  pushl $0
  10279b:	6a 00                	push   $0x0
  pushl $161
  10279d:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1027a2:	e9 68 04 00 00       	jmp    102c0f <__alltraps>

001027a7 <vector162>:
.globl vector162
vector162:
  pushl $0
  1027a7:	6a 00                	push   $0x0
  pushl $162
  1027a9:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1027ae:	e9 5c 04 00 00       	jmp    102c0f <__alltraps>

001027b3 <vector163>:
.globl vector163
vector163:
  pushl $0
  1027b3:	6a 00                	push   $0x0
  pushl $163
  1027b5:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1027ba:	e9 50 04 00 00       	jmp    102c0f <__alltraps>

001027bf <vector164>:
.globl vector164
vector164:
  pushl $0
  1027bf:	6a 00                	push   $0x0
  pushl $164
  1027c1:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1027c6:	e9 44 04 00 00       	jmp    102c0f <__alltraps>

001027cb <vector165>:
.globl vector165
vector165:
  pushl $0
  1027cb:	6a 00                	push   $0x0
  pushl $165
  1027cd:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1027d2:	e9 38 04 00 00       	jmp    102c0f <__alltraps>

001027d7 <vector166>:
.globl vector166
vector166:
  pushl $0
  1027d7:	6a 00                	push   $0x0
  pushl $166
  1027d9:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1027de:	e9 2c 04 00 00       	jmp    102c0f <__alltraps>

001027e3 <vector167>:
.globl vector167
vector167:
  pushl $0
  1027e3:	6a 00                	push   $0x0
  pushl $167
  1027e5:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1027ea:	e9 20 04 00 00       	jmp    102c0f <__alltraps>

001027ef <vector168>:
.globl vector168
vector168:
  pushl $0
  1027ef:	6a 00                	push   $0x0
  pushl $168
  1027f1:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1027f6:	e9 14 04 00 00       	jmp    102c0f <__alltraps>

001027fb <vector169>:
.globl vector169
vector169:
  pushl $0
  1027fb:	6a 00                	push   $0x0
  pushl $169
  1027fd:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102802:	e9 08 04 00 00       	jmp    102c0f <__alltraps>

00102807 <vector170>:
.globl vector170
vector170:
  pushl $0
  102807:	6a 00                	push   $0x0
  pushl $170
  102809:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10280e:	e9 fc 03 00 00       	jmp    102c0f <__alltraps>

00102813 <vector171>:
.globl vector171
vector171:
  pushl $0
  102813:	6a 00                	push   $0x0
  pushl $171
  102815:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10281a:	e9 f0 03 00 00       	jmp    102c0f <__alltraps>

0010281f <vector172>:
.globl vector172
vector172:
  pushl $0
  10281f:	6a 00                	push   $0x0
  pushl $172
  102821:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102826:	e9 e4 03 00 00       	jmp    102c0f <__alltraps>

0010282b <vector173>:
.globl vector173
vector173:
  pushl $0
  10282b:	6a 00                	push   $0x0
  pushl $173
  10282d:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102832:	e9 d8 03 00 00       	jmp    102c0f <__alltraps>

00102837 <vector174>:
.globl vector174
vector174:
  pushl $0
  102837:	6a 00                	push   $0x0
  pushl $174
  102839:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10283e:	e9 cc 03 00 00       	jmp    102c0f <__alltraps>

00102843 <vector175>:
.globl vector175
vector175:
  pushl $0
  102843:	6a 00                	push   $0x0
  pushl $175
  102845:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10284a:	e9 c0 03 00 00       	jmp    102c0f <__alltraps>

0010284f <vector176>:
.globl vector176
vector176:
  pushl $0
  10284f:	6a 00                	push   $0x0
  pushl $176
  102851:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102856:	e9 b4 03 00 00       	jmp    102c0f <__alltraps>

0010285b <vector177>:
.globl vector177
vector177:
  pushl $0
  10285b:	6a 00                	push   $0x0
  pushl $177
  10285d:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102862:	e9 a8 03 00 00       	jmp    102c0f <__alltraps>

00102867 <vector178>:
.globl vector178
vector178:
  pushl $0
  102867:	6a 00                	push   $0x0
  pushl $178
  102869:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10286e:	e9 9c 03 00 00       	jmp    102c0f <__alltraps>

00102873 <vector179>:
.globl vector179
vector179:
  pushl $0
  102873:	6a 00                	push   $0x0
  pushl $179
  102875:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10287a:	e9 90 03 00 00       	jmp    102c0f <__alltraps>

0010287f <vector180>:
.globl vector180
vector180:
  pushl $0
  10287f:	6a 00                	push   $0x0
  pushl $180
  102881:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102886:	e9 84 03 00 00       	jmp    102c0f <__alltraps>

0010288b <vector181>:
.globl vector181
vector181:
  pushl $0
  10288b:	6a 00                	push   $0x0
  pushl $181
  10288d:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102892:	e9 78 03 00 00       	jmp    102c0f <__alltraps>

00102897 <vector182>:
.globl vector182
vector182:
  pushl $0
  102897:	6a 00                	push   $0x0
  pushl $182
  102899:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10289e:	e9 6c 03 00 00       	jmp    102c0f <__alltraps>

001028a3 <vector183>:
.globl vector183
vector183:
  pushl $0
  1028a3:	6a 00                	push   $0x0
  pushl $183
  1028a5:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1028aa:	e9 60 03 00 00       	jmp    102c0f <__alltraps>

001028af <vector184>:
.globl vector184
vector184:
  pushl $0
  1028af:	6a 00                	push   $0x0
  pushl $184
  1028b1:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1028b6:	e9 54 03 00 00       	jmp    102c0f <__alltraps>

001028bb <vector185>:
.globl vector185
vector185:
  pushl $0
  1028bb:	6a 00                	push   $0x0
  pushl $185
  1028bd:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1028c2:	e9 48 03 00 00       	jmp    102c0f <__alltraps>

001028c7 <vector186>:
.globl vector186
vector186:
  pushl $0
  1028c7:	6a 00                	push   $0x0
  pushl $186
  1028c9:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1028ce:	e9 3c 03 00 00       	jmp    102c0f <__alltraps>

001028d3 <vector187>:
.globl vector187
vector187:
  pushl $0
  1028d3:	6a 00                	push   $0x0
  pushl $187
  1028d5:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1028da:	e9 30 03 00 00       	jmp    102c0f <__alltraps>

001028df <vector188>:
.globl vector188
vector188:
  pushl $0
  1028df:	6a 00                	push   $0x0
  pushl $188
  1028e1:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1028e6:	e9 24 03 00 00       	jmp    102c0f <__alltraps>

001028eb <vector189>:
.globl vector189
vector189:
  pushl $0
  1028eb:	6a 00                	push   $0x0
  pushl $189
  1028ed:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1028f2:	e9 18 03 00 00       	jmp    102c0f <__alltraps>

001028f7 <vector190>:
.globl vector190
vector190:
  pushl $0
  1028f7:	6a 00                	push   $0x0
  pushl $190
  1028f9:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1028fe:	e9 0c 03 00 00       	jmp    102c0f <__alltraps>

00102903 <vector191>:
.globl vector191
vector191:
  pushl $0
  102903:	6a 00                	push   $0x0
  pushl $191
  102905:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10290a:	e9 00 03 00 00       	jmp    102c0f <__alltraps>

0010290f <vector192>:
.globl vector192
vector192:
  pushl $0
  10290f:	6a 00                	push   $0x0
  pushl $192
  102911:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102916:	e9 f4 02 00 00       	jmp    102c0f <__alltraps>

0010291b <vector193>:
.globl vector193
vector193:
  pushl $0
  10291b:	6a 00                	push   $0x0
  pushl $193
  10291d:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102922:	e9 e8 02 00 00       	jmp    102c0f <__alltraps>

00102927 <vector194>:
.globl vector194
vector194:
  pushl $0
  102927:	6a 00                	push   $0x0
  pushl $194
  102929:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10292e:	e9 dc 02 00 00       	jmp    102c0f <__alltraps>

00102933 <vector195>:
.globl vector195
vector195:
  pushl $0
  102933:	6a 00                	push   $0x0
  pushl $195
  102935:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10293a:	e9 d0 02 00 00       	jmp    102c0f <__alltraps>

0010293f <vector196>:
.globl vector196
vector196:
  pushl $0
  10293f:	6a 00                	push   $0x0
  pushl $196
  102941:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102946:	e9 c4 02 00 00       	jmp    102c0f <__alltraps>

0010294b <vector197>:
.globl vector197
vector197:
  pushl $0
  10294b:	6a 00                	push   $0x0
  pushl $197
  10294d:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102952:	e9 b8 02 00 00       	jmp    102c0f <__alltraps>

00102957 <vector198>:
.globl vector198
vector198:
  pushl $0
  102957:	6a 00                	push   $0x0
  pushl $198
  102959:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10295e:	e9 ac 02 00 00       	jmp    102c0f <__alltraps>

00102963 <vector199>:
.globl vector199
vector199:
  pushl $0
  102963:	6a 00                	push   $0x0
  pushl $199
  102965:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10296a:	e9 a0 02 00 00       	jmp    102c0f <__alltraps>

0010296f <vector200>:
.globl vector200
vector200:
  pushl $0
  10296f:	6a 00                	push   $0x0
  pushl $200
  102971:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102976:	e9 94 02 00 00       	jmp    102c0f <__alltraps>

0010297b <vector201>:
.globl vector201
vector201:
  pushl $0
  10297b:	6a 00                	push   $0x0
  pushl $201
  10297d:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102982:	e9 88 02 00 00       	jmp    102c0f <__alltraps>

00102987 <vector202>:
.globl vector202
vector202:
  pushl $0
  102987:	6a 00                	push   $0x0
  pushl $202
  102989:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10298e:	e9 7c 02 00 00       	jmp    102c0f <__alltraps>

00102993 <vector203>:
.globl vector203
vector203:
  pushl $0
  102993:	6a 00                	push   $0x0
  pushl $203
  102995:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  10299a:	e9 70 02 00 00       	jmp    102c0f <__alltraps>

0010299f <vector204>:
.globl vector204
vector204:
  pushl $0
  10299f:	6a 00                	push   $0x0
  pushl $204
  1029a1:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1029a6:	e9 64 02 00 00       	jmp    102c0f <__alltraps>

001029ab <vector205>:
.globl vector205
vector205:
  pushl $0
  1029ab:	6a 00                	push   $0x0
  pushl $205
  1029ad:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1029b2:	e9 58 02 00 00       	jmp    102c0f <__alltraps>

001029b7 <vector206>:
.globl vector206
vector206:
  pushl $0
  1029b7:	6a 00                	push   $0x0
  pushl $206
  1029b9:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1029be:	e9 4c 02 00 00       	jmp    102c0f <__alltraps>

001029c3 <vector207>:
.globl vector207
vector207:
  pushl $0
  1029c3:	6a 00                	push   $0x0
  pushl $207
  1029c5:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1029ca:	e9 40 02 00 00       	jmp    102c0f <__alltraps>

001029cf <vector208>:
.globl vector208
vector208:
  pushl $0
  1029cf:	6a 00                	push   $0x0
  pushl $208
  1029d1:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1029d6:	e9 34 02 00 00       	jmp    102c0f <__alltraps>

001029db <vector209>:
.globl vector209
vector209:
  pushl $0
  1029db:	6a 00                	push   $0x0
  pushl $209
  1029dd:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1029e2:	e9 28 02 00 00       	jmp    102c0f <__alltraps>

001029e7 <vector210>:
.globl vector210
vector210:
  pushl $0
  1029e7:	6a 00                	push   $0x0
  pushl $210
  1029e9:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1029ee:	e9 1c 02 00 00       	jmp    102c0f <__alltraps>

001029f3 <vector211>:
.globl vector211
vector211:
  pushl $0
  1029f3:	6a 00                	push   $0x0
  pushl $211
  1029f5:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1029fa:	e9 10 02 00 00       	jmp    102c0f <__alltraps>

001029ff <vector212>:
.globl vector212
vector212:
  pushl $0
  1029ff:	6a 00                	push   $0x0
  pushl $212
  102a01:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102a06:	e9 04 02 00 00       	jmp    102c0f <__alltraps>

00102a0b <vector213>:
.globl vector213
vector213:
  pushl $0
  102a0b:	6a 00                	push   $0x0
  pushl $213
  102a0d:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102a12:	e9 f8 01 00 00       	jmp    102c0f <__alltraps>

00102a17 <vector214>:
.globl vector214
vector214:
  pushl $0
  102a17:	6a 00                	push   $0x0
  pushl $214
  102a19:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102a1e:	e9 ec 01 00 00       	jmp    102c0f <__alltraps>

00102a23 <vector215>:
.globl vector215
vector215:
  pushl $0
  102a23:	6a 00                	push   $0x0
  pushl $215
  102a25:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102a2a:	e9 e0 01 00 00       	jmp    102c0f <__alltraps>

00102a2f <vector216>:
.globl vector216
vector216:
  pushl $0
  102a2f:	6a 00                	push   $0x0
  pushl $216
  102a31:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102a36:	e9 d4 01 00 00       	jmp    102c0f <__alltraps>

00102a3b <vector217>:
.globl vector217
vector217:
  pushl $0
  102a3b:	6a 00                	push   $0x0
  pushl $217
  102a3d:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102a42:	e9 c8 01 00 00       	jmp    102c0f <__alltraps>

00102a47 <vector218>:
.globl vector218
vector218:
  pushl $0
  102a47:	6a 00                	push   $0x0
  pushl $218
  102a49:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102a4e:	e9 bc 01 00 00       	jmp    102c0f <__alltraps>

00102a53 <vector219>:
.globl vector219
vector219:
  pushl $0
  102a53:	6a 00                	push   $0x0
  pushl $219
  102a55:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102a5a:	e9 b0 01 00 00       	jmp    102c0f <__alltraps>

00102a5f <vector220>:
.globl vector220
vector220:
  pushl $0
  102a5f:	6a 00                	push   $0x0
  pushl $220
  102a61:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102a66:	e9 a4 01 00 00       	jmp    102c0f <__alltraps>

00102a6b <vector221>:
.globl vector221
vector221:
  pushl $0
  102a6b:	6a 00                	push   $0x0
  pushl $221
  102a6d:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102a72:	e9 98 01 00 00       	jmp    102c0f <__alltraps>

00102a77 <vector222>:
.globl vector222
vector222:
  pushl $0
  102a77:	6a 00                	push   $0x0
  pushl $222
  102a79:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102a7e:	e9 8c 01 00 00       	jmp    102c0f <__alltraps>

00102a83 <vector223>:
.globl vector223
vector223:
  pushl $0
  102a83:	6a 00                	push   $0x0
  pushl $223
  102a85:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102a8a:	e9 80 01 00 00       	jmp    102c0f <__alltraps>

00102a8f <vector224>:
.globl vector224
vector224:
  pushl $0
  102a8f:	6a 00                	push   $0x0
  pushl $224
  102a91:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102a96:	e9 74 01 00 00       	jmp    102c0f <__alltraps>

00102a9b <vector225>:
.globl vector225
vector225:
  pushl $0
  102a9b:	6a 00                	push   $0x0
  pushl $225
  102a9d:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102aa2:	e9 68 01 00 00       	jmp    102c0f <__alltraps>

00102aa7 <vector226>:
.globl vector226
vector226:
  pushl $0
  102aa7:	6a 00                	push   $0x0
  pushl $226
  102aa9:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102aae:	e9 5c 01 00 00       	jmp    102c0f <__alltraps>

00102ab3 <vector227>:
.globl vector227
vector227:
  pushl $0
  102ab3:	6a 00                	push   $0x0
  pushl $227
  102ab5:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102aba:	e9 50 01 00 00       	jmp    102c0f <__alltraps>

00102abf <vector228>:
.globl vector228
vector228:
  pushl $0
  102abf:	6a 00                	push   $0x0
  pushl $228
  102ac1:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102ac6:	e9 44 01 00 00       	jmp    102c0f <__alltraps>

00102acb <vector229>:
.globl vector229
vector229:
  pushl $0
  102acb:	6a 00                	push   $0x0
  pushl $229
  102acd:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102ad2:	e9 38 01 00 00       	jmp    102c0f <__alltraps>

00102ad7 <vector230>:
.globl vector230
vector230:
  pushl $0
  102ad7:	6a 00                	push   $0x0
  pushl $230
  102ad9:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102ade:	e9 2c 01 00 00       	jmp    102c0f <__alltraps>

00102ae3 <vector231>:
.globl vector231
vector231:
  pushl $0
  102ae3:	6a 00                	push   $0x0
  pushl $231
  102ae5:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102aea:	e9 20 01 00 00       	jmp    102c0f <__alltraps>

00102aef <vector232>:
.globl vector232
vector232:
  pushl $0
  102aef:	6a 00                	push   $0x0
  pushl $232
  102af1:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102af6:	e9 14 01 00 00       	jmp    102c0f <__alltraps>

00102afb <vector233>:
.globl vector233
vector233:
  pushl $0
  102afb:	6a 00                	push   $0x0
  pushl $233
  102afd:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102b02:	e9 08 01 00 00       	jmp    102c0f <__alltraps>

00102b07 <vector234>:
.globl vector234
vector234:
  pushl $0
  102b07:	6a 00                	push   $0x0
  pushl $234
  102b09:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102b0e:	e9 fc 00 00 00       	jmp    102c0f <__alltraps>

00102b13 <vector235>:
.globl vector235
vector235:
  pushl $0
  102b13:	6a 00                	push   $0x0
  pushl $235
  102b15:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102b1a:	e9 f0 00 00 00       	jmp    102c0f <__alltraps>

00102b1f <vector236>:
.globl vector236
vector236:
  pushl $0
  102b1f:	6a 00                	push   $0x0
  pushl $236
  102b21:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102b26:	e9 e4 00 00 00       	jmp    102c0f <__alltraps>

00102b2b <vector237>:
.globl vector237
vector237:
  pushl $0
  102b2b:	6a 00                	push   $0x0
  pushl $237
  102b2d:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102b32:	e9 d8 00 00 00       	jmp    102c0f <__alltraps>

00102b37 <vector238>:
.globl vector238
vector238:
  pushl $0
  102b37:	6a 00                	push   $0x0
  pushl $238
  102b39:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102b3e:	e9 cc 00 00 00       	jmp    102c0f <__alltraps>

00102b43 <vector239>:
.globl vector239
vector239:
  pushl $0
  102b43:	6a 00                	push   $0x0
  pushl $239
  102b45:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102b4a:	e9 c0 00 00 00       	jmp    102c0f <__alltraps>

00102b4f <vector240>:
.globl vector240
vector240:
  pushl $0
  102b4f:	6a 00                	push   $0x0
  pushl $240
  102b51:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102b56:	e9 b4 00 00 00       	jmp    102c0f <__alltraps>

00102b5b <vector241>:
.globl vector241
vector241:
  pushl $0
  102b5b:	6a 00                	push   $0x0
  pushl $241
  102b5d:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102b62:	e9 a8 00 00 00       	jmp    102c0f <__alltraps>

00102b67 <vector242>:
.globl vector242
vector242:
  pushl $0
  102b67:	6a 00                	push   $0x0
  pushl $242
  102b69:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102b6e:	e9 9c 00 00 00       	jmp    102c0f <__alltraps>

00102b73 <vector243>:
.globl vector243
vector243:
  pushl $0
  102b73:	6a 00                	push   $0x0
  pushl $243
  102b75:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102b7a:	e9 90 00 00 00       	jmp    102c0f <__alltraps>

00102b7f <vector244>:
.globl vector244
vector244:
  pushl $0
  102b7f:	6a 00                	push   $0x0
  pushl $244
  102b81:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102b86:	e9 84 00 00 00       	jmp    102c0f <__alltraps>

00102b8b <vector245>:
.globl vector245
vector245:
  pushl $0
  102b8b:	6a 00                	push   $0x0
  pushl $245
  102b8d:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102b92:	e9 78 00 00 00       	jmp    102c0f <__alltraps>

00102b97 <vector246>:
.globl vector246
vector246:
  pushl $0
  102b97:	6a 00                	push   $0x0
  pushl $246
  102b99:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102b9e:	e9 6c 00 00 00       	jmp    102c0f <__alltraps>

00102ba3 <vector247>:
.globl vector247
vector247:
  pushl $0
  102ba3:	6a 00                	push   $0x0
  pushl $247
  102ba5:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102baa:	e9 60 00 00 00       	jmp    102c0f <__alltraps>

00102baf <vector248>:
.globl vector248
vector248:
  pushl $0
  102baf:	6a 00                	push   $0x0
  pushl $248
  102bb1:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102bb6:	e9 54 00 00 00       	jmp    102c0f <__alltraps>

00102bbb <vector249>:
.globl vector249
vector249:
  pushl $0
  102bbb:	6a 00                	push   $0x0
  pushl $249
  102bbd:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102bc2:	e9 48 00 00 00       	jmp    102c0f <__alltraps>

00102bc7 <vector250>:
.globl vector250
vector250:
  pushl $0
  102bc7:	6a 00                	push   $0x0
  pushl $250
  102bc9:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102bce:	e9 3c 00 00 00       	jmp    102c0f <__alltraps>

00102bd3 <vector251>:
.globl vector251
vector251:
  pushl $0
  102bd3:	6a 00                	push   $0x0
  pushl $251
  102bd5:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102bda:	e9 30 00 00 00       	jmp    102c0f <__alltraps>

00102bdf <vector252>:
.globl vector252
vector252:
  pushl $0
  102bdf:	6a 00                	push   $0x0
  pushl $252
  102be1:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102be6:	e9 24 00 00 00       	jmp    102c0f <__alltraps>

00102beb <vector253>:
.globl vector253
vector253:
  pushl $0
  102beb:	6a 00                	push   $0x0
  pushl $253
  102bed:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102bf2:	e9 18 00 00 00       	jmp    102c0f <__alltraps>

00102bf7 <vector254>:
.globl vector254
vector254:
  pushl $0
  102bf7:	6a 00                	push   $0x0
  pushl $254
  102bf9:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102bfe:	e9 0c 00 00 00       	jmp    102c0f <__alltraps>

00102c03 <vector255>:
.globl vector255
vector255:
  pushl $0
  102c03:	6a 00                	push   $0x0
  pushl $255
  102c05:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102c0a:	e9 00 00 00 00       	jmp    102c0f <__alltraps>

00102c0f <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102c0f:	1e                   	push   %ds
    pushl %es
  102c10:	06                   	push   %es
    pushl %fs
  102c11:	0f a0                	push   %fs
    pushl %gs
  102c13:	0f a8                	push   %gs
    pushal
  102c15:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102c16:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102c1b:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102c1d:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102c1f:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102c20:	e8 57 f5 ff ff       	call   10217c <trap>

    # pop the pushed stack pointer
    popl %esp
  102c25:	5c                   	pop    %esp

00102c26 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102c26:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102c27:	0f a9                	pop    %gs
    popl %fs
  102c29:	0f a1                	pop    %fs
    popl %es
  102c2b:	07                   	pop    %es
    popl %ds
  102c2c:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102c2d:	83 c4 08             	add    $0x8,%esp
    iret
  102c30:	cf                   	iret   

00102c31 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102c31:	55                   	push   %ebp
  102c32:	89 e5                	mov    %esp,%ebp
  102c34:	e8 43 d6 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102c39:	05 17 bd 00 00       	add    $0xbd17,%eax
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c41:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102c44:	b8 23 00 00 00       	mov    $0x23,%eax
  102c49:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102c4b:	b8 23 00 00 00       	mov    $0x23,%eax
  102c50:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102c52:	b8 10 00 00 00       	mov    $0x10,%eax
  102c57:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102c59:	b8 10 00 00 00       	mov    $0x10,%eax
  102c5e:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102c60:	b8 10 00 00 00       	mov    $0x10,%eax
  102c65:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102c67:	ea 6e 2c 10 00 08 00 	ljmp   $0x8,$0x102c6e
}
  102c6e:	90                   	nop
  102c6f:	5d                   	pop    %ebp
  102c70:	c3                   	ret    

00102c71 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102c71:	55                   	push   %ebp
  102c72:	89 e5                	mov    %esp,%ebp
  102c74:	83 ec 10             	sub    $0x10,%esp
  102c77:	e8 00 d6 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102c7c:	05 d4 bc 00 00       	add    $0xbcd4,%eax
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102c81:	c7 c2 c0 f9 10 00    	mov    $0x10f9c0,%edx
  102c87:	81 c2 00 04 00 00    	add    $0x400,%edx
  102c8d:	89 90 f4 0f 00 00    	mov    %edx,0xff4(%eax)
    ts.ts_ss0 = KERNEL_DS;
  102c93:	66 c7 80 f8 0f 00 00 	movw   $0x10,0xff8(%eax)
  102c9a:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102c9c:	66 c7 80 f8 ff ff ff 	movw   $0x68,-0x8(%eax)
  102ca3:	68 00 
  102ca5:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102cab:	66 89 90 fa ff ff ff 	mov    %dx,-0x6(%eax)
  102cb2:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102cb8:	c1 ea 10             	shr    $0x10,%edx
  102cbb:	88 90 fc ff ff ff    	mov    %dl,-0x4(%eax)
  102cc1:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102cc8:	83 e2 f0             	and    $0xfffffff0,%edx
  102ccb:	83 ca 09             	or     $0x9,%edx
  102cce:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102cd4:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102cdb:	83 ca 10             	or     $0x10,%edx
  102cde:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102ce4:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102ceb:	83 e2 9f             	and    $0xffffff9f,%edx
  102cee:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102cf4:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102cfb:	83 ca 80             	or     $0xffffff80,%edx
  102cfe:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102d04:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d0b:	83 e2 f0             	and    $0xfffffff0,%edx
  102d0e:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d14:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d1b:	83 e2 ef             	and    $0xffffffef,%edx
  102d1e:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d24:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d2b:	83 e2 df             	and    $0xffffffdf,%edx
  102d2e:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d34:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d3b:	83 ca 40             	or     $0x40,%edx
  102d3e:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d44:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102d4b:	83 e2 7f             	and    $0x7f,%edx
  102d4e:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102d54:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102d5a:	c1 ea 18             	shr    $0x18,%edx
  102d5d:	88 90 ff ff ff ff    	mov    %dl,-0x1(%eax)
    gdt[SEG_TSS].sd_s = 0;
  102d63:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102d6a:	83 e2 ef             	and    $0xffffffef,%edx
  102d6d:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)

    // reload all segment registers
    lgdt(&gdt_pd);
  102d73:	8d 80 d0 00 00 00    	lea    0xd0(%eax),%eax
  102d79:	50                   	push   %eax
  102d7a:	e8 b2 fe ff ff       	call   102c31 <lgdt>
  102d7f:	83 c4 04             	add    $0x4,%esp
  102d82:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102d88:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102d8c:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102d8f:	90                   	nop
  102d90:	c9                   	leave  
  102d91:	c3                   	ret    

00102d92 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102d92:	55                   	push   %ebp
  102d93:	89 e5                	mov    %esp,%ebp
  102d95:	e8 e2 d4 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102d9a:	05 b6 bb 00 00       	add    $0xbbb6,%eax
    gdt_init();
  102d9f:	e8 cd fe ff ff       	call   102c71 <gdt_init>
}
  102da4:	90                   	nop
  102da5:	5d                   	pop    %ebp
  102da6:	c3                   	ret    

00102da7 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102da7:	55                   	push   %ebp
  102da8:	89 e5                	mov    %esp,%ebp
  102daa:	83 ec 10             	sub    $0x10,%esp
  102dad:	e8 ca d4 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102db2:	05 9e bb 00 00       	add    $0xbb9e,%eax
    size_t cnt = 0;
  102db7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102dbe:	eb 04                	jmp    102dc4 <strlen+0x1d>
        cnt ++;
  102dc0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc7:	8d 50 01             	lea    0x1(%eax),%edx
  102dca:	89 55 08             	mov    %edx,0x8(%ebp)
  102dcd:	0f b6 00             	movzbl (%eax),%eax
  102dd0:	84 c0                	test   %al,%al
  102dd2:	75 ec                	jne    102dc0 <strlen+0x19>
    }
    return cnt;
  102dd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102dd7:	c9                   	leave  
  102dd8:	c3                   	ret    

00102dd9 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102dd9:	55                   	push   %ebp
  102dda:	89 e5                	mov    %esp,%ebp
  102ddc:	83 ec 10             	sub    $0x10,%esp
  102ddf:	e8 98 d4 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102de4:	05 6c bb 00 00       	add    $0xbb6c,%eax
    size_t cnt = 0;
  102de9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102df0:	eb 04                	jmp    102df6 <strnlen+0x1d>
        cnt ++;
  102df2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102df6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102df9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102dfc:	73 10                	jae    102e0e <strnlen+0x35>
  102dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  102e01:	8d 50 01             	lea    0x1(%eax),%edx
  102e04:	89 55 08             	mov    %edx,0x8(%ebp)
  102e07:	0f b6 00             	movzbl (%eax),%eax
  102e0a:	84 c0                	test   %al,%al
  102e0c:	75 e4                	jne    102df2 <strnlen+0x19>
    }
    return cnt;
  102e0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102e11:	c9                   	leave  
  102e12:	c3                   	ret    

00102e13 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102e13:	55                   	push   %ebp
  102e14:	89 e5                	mov    %esp,%ebp
  102e16:	57                   	push   %edi
  102e17:	56                   	push   %esi
  102e18:	83 ec 20             	sub    $0x20,%esp
  102e1b:	e8 5c d4 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102e20:	05 30 bb 00 00       	add    $0xbb30,%eax
  102e25:	8b 45 08             	mov    0x8(%ebp),%eax
  102e28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102e31:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e37:	89 d1                	mov    %edx,%ecx
  102e39:	89 c2                	mov    %eax,%edx
  102e3b:	89 ce                	mov    %ecx,%esi
  102e3d:	89 d7                	mov    %edx,%edi
  102e3f:	ac                   	lods   %ds:(%esi),%al
  102e40:	aa                   	stos   %al,%es:(%edi)
  102e41:	84 c0                	test   %al,%al
  102e43:	75 fa                	jne    102e3f <strcpy+0x2c>
  102e45:	89 fa                	mov    %edi,%edx
  102e47:	89 f1                	mov    %esi,%ecx
  102e49:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e4c:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102e4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102e55:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102e56:	83 c4 20             	add    $0x20,%esp
  102e59:	5e                   	pop    %esi
  102e5a:	5f                   	pop    %edi
  102e5b:	5d                   	pop    %ebp
  102e5c:	c3                   	ret    

00102e5d <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102e5d:	55                   	push   %ebp
  102e5e:	89 e5                	mov    %esp,%ebp
  102e60:	83 ec 10             	sub    $0x10,%esp
  102e63:	e8 14 d4 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102e68:	05 e8 ba 00 00       	add    $0xbae8,%eax
    char *p = dst;
  102e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e70:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102e73:	eb 21                	jmp    102e96 <strncpy+0x39>
        if ((*p = *src) != '\0') {
  102e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e78:	0f b6 10             	movzbl (%eax),%edx
  102e7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e7e:	88 10                	mov    %dl,(%eax)
  102e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e83:	0f b6 00             	movzbl (%eax),%eax
  102e86:	84 c0                	test   %al,%al
  102e88:	74 04                	je     102e8e <strncpy+0x31>
            src ++;
  102e8a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102e8e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102e92:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102e96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e9a:	75 d9                	jne    102e75 <strncpy+0x18>
    }
    return dst;
  102e9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102e9f:	c9                   	leave  
  102ea0:	c3                   	ret    

00102ea1 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102ea1:	55                   	push   %ebp
  102ea2:	89 e5                	mov    %esp,%ebp
  102ea4:	57                   	push   %edi
  102ea5:	56                   	push   %esi
  102ea6:	83 ec 20             	sub    $0x20,%esp
  102ea9:	e8 ce d3 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102eae:	05 a2 ba 00 00       	add    $0xbaa2,%eax
  102eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  102eb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ebc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ebf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ec2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ec5:	89 d1                	mov    %edx,%ecx
  102ec7:	89 c2                	mov    %eax,%edx
  102ec9:	89 ce                	mov    %ecx,%esi
  102ecb:	89 d7                	mov    %edx,%edi
  102ecd:	ac                   	lods   %ds:(%esi),%al
  102ece:	ae                   	scas   %es:(%edi),%al
  102ecf:	75 08                	jne    102ed9 <strcmp+0x38>
  102ed1:	84 c0                	test   %al,%al
  102ed3:	75 f8                	jne    102ecd <strcmp+0x2c>
  102ed5:	31 c0                	xor    %eax,%eax
  102ed7:	eb 04                	jmp    102edd <strcmp+0x3c>
  102ed9:	19 c0                	sbb    %eax,%eax
  102edb:	0c 01                	or     $0x1,%al
  102edd:	89 fa                	mov    %edi,%edx
  102edf:	89 f1                	mov    %esi,%ecx
  102ee1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102ee4:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102ee7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102eea:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  102eed:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102eee:	83 c4 20             	add    $0x20,%esp
  102ef1:	5e                   	pop    %esi
  102ef2:	5f                   	pop    %edi
  102ef3:	5d                   	pop    %ebp
  102ef4:	c3                   	ret    

00102ef5 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102ef5:	55                   	push   %ebp
  102ef6:	89 e5                	mov    %esp,%ebp
  102ef8:	e8 7f d3 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102efd:	05 53 ba 00 00       	add    $0xba53,%eax
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f02:	eb 0c                	jmp    102f10 <strncmp+0x1b>
        n --, s1 ++, s2 ++;
  102f04:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102f08:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102f0c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f14:	74 1a                	je     102f30 <strncmp+0x3b>
  102f16:	8b 45 08             	mov    0x8(%ebp),%eax
  102f19:	0f b6 00             	movzbl (%eax),%eax
  102f1c:	84 c0                	test   %al,%al
  102f1e:	74 10                	je     102f30 <strncmp+0x3b>
  102f20:	8b 45 08             	mov    0x8(%ebp),%eax
  102f23:	0f b6 10             	movzbl (%eax),%edx
  102f26:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f29:	0f b6 00             	movzbl (%eax),%eax
  102f2c:	38 c2                	cmp    %al,%dl
  102f2e:	74 d4                	je     102f04 <strncmp+0xf>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f30:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f34:	74 18                	je     102f4e <strncmp+0x59>
  102f36:	8b 45 08             	mov    0x8(%ebp),%eax
  102f39:	0f b6 00             	movzbl (%eax),%eax
  102f3c:	0f b6 d0             	movzbl %al,%edx
  102f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f42:	0f b6 00             	movzbl (%eax),%eax
  102f45:	0f b6 c0             	movzbl %al,%eax
  102f48:	29 c2                	sub    %eax,%edx
  102f4a:	89 d0                	mov    %edx,%eax
  102f4c:	eb 05                	jmp    102f53 <strncmp+0x5e>
  102f4e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f53:	5d                   	pop    %ebp
  102f54:	c3                   	ret    

00102f55 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102f55:	55                   	push   %ebp
  102f56:	89 e5                	mov    %esp,%ebp
  102f58:	83 ec 04             	sub    $0x4,%esp
  102f5b:	e8 1c d3 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102f60:	05 f0 b9 00 00       	add    $0xb9f0,%eax
  102f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f68:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102f6b:	eb 14                	jmp    102f81 <strchr+0x2c>
        if (*s == c) {
  102f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f70:	0f b6 00             	movzbl (%eax),%eax
  102f73:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102f76:	75 05                	jne    102f7d <strchr+0x28>
            return (char *)s;
  102f78:	8b 45 08             	mov    0x8(%ebp),%eax
  102f7b:	eb 13                	jmp    102f90 <strchr+0x3b>
        }
        s ++;
  102f7d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102f81:	8b 45 08             	mov    0x8(%ebp),%eax
  102f84:	0f b6 00             	movzbl (%eax),%eax
  102f87:	84 c0                	test   %al,%al
  102f89:	75 e2                	jne    102f6d <strchr+0x18>
    }
    return NULL;
  102f8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f90:	c9                   	leave  
  102f91:	c3                   	ret    

00102f92 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102f92:	55                   	push   %ebp
  102f93:	89 e5                	mov    %esp,%ebp
  102f95:	83 ec 04             	sub    $0x4,%esp
  102f98:	e8 df d2 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102f9d:	05 b3 b9 00 00       	add    $0xb9b3,%eax
  102fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fa5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102fa8:	eb 0f                	jmp    102fb9 <strfind+0x27>
        if (*s == c) {
  102faa:	8b 45 08             	mov    0x8(%ebp),%eax
  102fad:	0f b6 00             	movzbl (%eax),%eax
  102fb0:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102fb3:	74 10                	je     102fc5 <strfind+0x33>
            break;
        }
        s ++;
  102fb5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102fbc:	0f b6 00             	movzbl (%eax),%eax
  102fbf:	84 c0                	test   %al,%al
  102fc1:	75 e7                	jne    102faa <strfind+0x18>
  102fc3:	eb 01                	jmp    102fc6 <strfind+0x34>
            break;
  102fc5:	90                   	nop
    }
    return (char *)s;
  102fc6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102fc9:	c9                   	leave  
  102fca:	c3                   	ret    

00102fcb <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102fcb:	55                   	push   %ebp
  102fcc:	89 e5                	mov    %esp,%ebp
  102fce:	83 ec 10             	sub    $0x10,%esp
  102fd1:	e8 a6 d2 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  102fd6:	05 7a b9 00 00       	add    $0xb97a,%eax
    int neg = 0;
  102fdb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102fe2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102fe9:	eb 04                	jmp    102fef <strtol+0x24>
        s ++;
  102feb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102fef:	8b 45 08             	mov    0x8(%ebp),%eax
  102ff2:	0f b6 00             	movzbl (%eax),%eax
  102ff5:	3c 20                	cmp    $0x20,%al
  102ff7:	74 f2                	je     102feb <strtol+0x20>
  102ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  102ffc:	0f b6 00             	movzbl (%eax),%eax
  102fff:	3c 09                	cmp    $0x9,%al
  103001:	74 e8                	je     102feb <strtol+0x20>
    }

    // plus/minus sign
    if (*s == '+') {
  103003:	8b 45 08             	mov    0x8(%ebp),%eax
  103006:	0f b6 00             	movzbl (%eax),%eax
  103009:	3c 2b                	cmp    $0x2b,%al
  10300b:	75 06                	jne    103013 <strtol+0x48>
        s ++;
  10300d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103011:	eb 15                	jmp    103028 <strtol+0x5d>
    }
    else if (*s == '-') {
  103013:	8b 45 08             	mov    0x8(%ebp),%eax
  103016:	0f b6 00             	movzbl (%eax),%eax
  103019:	3c 2d                	cmp    $0x2d,%al
  10301b:	75 0b                	jne    103028 <strtol+0x5d>
        s ++, neg = 1;
  10301d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103021:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103028:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10302c:	74 06                	je     103034 <strtol+0x69>
  10302e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  103032:	75 24                	jne    103058 <strtol+0x8d>
  103034:	8b 45 08             	mov    0x8(%ebp),%eax
  103037:	0f b6 00             	movzbl (%eax),%eax
  10303a:	3c 30                	cmp    $0x30,%al
  10303c:	75 1a                	jne    103058 <strtol+0x8d>
  10303e:	8b 45 08             	mov    0x8(%ebp),%eax
  103041:	83 c0 01             	add    $0x1,%eax
  103044:	0f b6 00             	movzbl (%eax),%eax
  103047:	3c 78                	cmp    $0x78,%al
  103049:	75 0d                	jne    103058 <strtol+0x8d>
        s += 2, base = 16;
  10304b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  10304f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  103056:	eb 2a                	jmp    103082 <strtol+0xb7>
    }
    else if (base == 0 && s[0] == '0') {
  103058:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10305c:	75 17                	jne    103075 <strtol+0xaa>
  10305e:	8b 45 08             	mov    0x8(%ebp),%eax
  103061:	0f b6 00             	movzbl (%eax),%eax
  103064:	3c 30                	cmp    $0x30,%al
  103066:	75 0d                	jne    103075 <strtol+0xaa>
        s ++, base = 8;
  103068:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10306c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  103073:	eb 0d                	jmp    103082 <strtol+0xb7>
    }
    else if (base == 0) {
  103075:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103079:	75 07                	jne    103082 <strtol+0xb7>
        base = 10;
  10307b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  103082:	8b 45 08             	mov    0x8(%ebp),%eax
  103085:	0f b6 00             	movzbl (%eax),%eax
  103088:	3c 2f                	cmp    $0x2f,%al
  10308a:	7e 1b                	jle    1030a7 <strtol+0xdc>
  10308c:	8b 45 08             	mov    0x8(%ebp),%eax
  10308f:	0f b6 00             	movzbl (%eax),%eax
  103092:	3c 39                	cmp    $0x39,%al
  103094:	7f 11                	jg     1030a7 <strtol+0xdc>
            dig = *s - '0';
  103096:	8b 45 08             	mov    0x8(%ebp),%eax
  103099:	0f b6 00             	movzbl (%eax),%eax
  10309c:	0f be c0             	movsbl %al,%eax
  10309f:	83 e8 30             	sub    $0x30,%eax
  1030a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030a5:	eb 48                	jmp    1030ef <strtol+0x124>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1030a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1030aa:	0f b6 00             	movzbl (%eax),%eax
  1030ad:	3c 60                	cmp    $0x60,%al
  1030af:	7e 1b                	jle    1030cc <strtol+0x101>
  1030b1:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b4:	0f b6 00             	movzbl (%eax),%eax
  1030b7:	3c 7a                	cmp    $0x7a,%al
  1030b9:	7f 11                	jg     1030cc <strtol+0x101>
            dig = *s - 'a' + 10;
  1030bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1030be:	0f b6 00             	movzbl (%eax),%eax
  1030c1:	0f be c0             	movsbl %al,%eax
  1030c4:	83 e8 57             	sub    $0x57,%eax
  1030c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030ca:	eb 23                	jmp    1030ef <strtol+0x124>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1030cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1030cf:	0f b6 00             	movzbl (%eax),%eax
  1030d2:	3c 40                	cmp    $0x40,%al
  1030d4:	7e 3c                	jle    103112 <strtol+0x147>
  1030d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d9:	0f b6 00             	movzbl (%eax),%eax
  1030dc:	3c 5a                	cmp    $0x5a,%al
  1030de:	7f 32                	jg     103112 <strtol+0x147>
            dig = *s - 'A' + 10;
  1030e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e3:	0f b6 00             	movzbl (%eax),%eax
  1030e6:	0f be c0             	movsbl %al,%eax
  1030e9:	83 e8 37             	sub    $0x37,%eax
  1030ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1030ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1030f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  1030f5:	7d 1a                	jge    103111 <strtol+0x146>
            break;
        }
        s ++, val = (val * base) + dig;
  1030f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1030fe:	0f af 45 10          	imul   0x10(%ebp),%eax
  103102:	89 c2                	mov    %eax,%edx
  103104:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103107:	01 d0                	add    %edx,%eax
  103109:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  10310c:	e9 71 ff ff ff       	jmp    103082 <strtol+0xb7>
            break;
  103111:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  103112:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103116:	74 08                	je     103120 <strtol+0x155>
        *endptr = (char *) s;
  103118:	8b 45 0c             	mov    0xc(%ebp),%eax
  10311b:	8b 55 08             	mov    0x8(%ebp),%edx
  10311e:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103120:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103124:	74 07                	je     10312d <strtol+0x162>
  103126:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103129:	f7 d8                	neg    %eax
  10312b:	eb 03                	jmp    103130 <strtol+0x165>
  10312d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103130:	c9                   	leave  
  103131:	c3                   	ret    

00103132 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103132:	55                   	push   %ebp
  103133:	89 e5                	mov    %esp,%ebp
  103135:	57                   	push   %edi
  103136:	83 ec 24             	sub    $0x24,%esp
  103139:	e8 3e d1 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10313e:	05 12 b8 00 00       	add    $0xb812,%eax
  103143:	8b 45 0c             	mov    0xc(%ebp),%eax
  103146:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103149:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  10314d:	8b 55 08             	mov    0x8(%ebp),%edx
  103150:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103153:	88 45 f7             	mov    %al,-0x9(%ebp)
  103156:	8b 45 10             	mov    0x10(%ebp),%eax
  103159:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10315c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10315f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103163:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103166:	89 d7                	mov    %edx,%edi
  103168:	f3 aa                	rep stos %al,%es:(%edi)
  10316a:	89 fa                	mov    %edi,%edx
  10316c:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10316f:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103172:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103175:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103176:	83 c4 24             	add    $0x24,%esp
  103179:	5f                   	pop    %edi
  10317a:	5d                   	pop    %ebp
  10317b:	c3                   	ret    

0010317c <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  10317c:	55                   	push   %ebp
  10317d:	89 e5                	mov    %esp,%ebp
  10317f:	57                   	push   %edi
  103180:	56                   	push   %esi
  103181:	53                   	push   %ebx
  103182:	83 ec 30             	sub    $0x30,%esp
  103185:	e8 f2 d0 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10318a:	05 c6 b7 00 00       	add    $0xb7c6,%eax
  10318f:	8b 45 08             	mov    0x8(%ebp),%eax
  103192:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103195:	8b 45 0c             	mov    0xc(%ebp),%eax
  103198:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10319b:	8b 45 10             	mov    0x10(%ebp),%eax
  10319e:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  1031a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031a4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1031a7:	73 42                	jae    1031eb <memmove+0x6f>
  1031a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1031af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1031b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031b8:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1031bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1031be:	c1 e8 02             	shr    $0x2,%eax
  1031c1:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1031c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031c9:	89 d7                	mov    %edx,%edi
  1031cb:	89 c6                	mov    %eax,%esi
  1031cd:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1031cf:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1031d2:	83 e1 03             	and    $0x3,%ecx
  1031d5:	74 02                	je     1031d9 <memmove+0x5d>
  1031d7:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1031d9:	89 f0                	mov    %esi,%eax
  1031db:	89 fa                	mov    %edi,%edx
  1031dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1031e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1031e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  1031e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  1031e9:	eb 36                	jmp    103221 <memmove+0xa5>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1031eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  1031f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031f4:	01 c2                	add    %eax,%edx
  1031f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031f9:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1031fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031ff:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  103202:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103205:	89 c1                	mov    %eax,%ecx
  103207:	89 d8                	mov    %ebx,%eax
  103209:	89 d6                	mov    %edx,%esi
  10320b:	89 c7                	mov    %eax,%edi
  10320d:	fd                   	std    
  10320e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103210:	fc                   	cld    
  103211:	89 f8                	mov    %edi,%eax
  103213:	89 f2                	mov    %esi,%edx
  103215:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103218:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10321b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  10321e:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103221:	83 c4 30             	add    $0x30,%esp
  103224:	5b                   	pop    %ebx
  103225:	5e                   	pop    %esi
  103226:	5f                   	pop    %edi
  103227:	5d                   	pop    %ebp
  103228:	c3                   	ret    

00103229 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103229:	55                   	push   %ebp
  10322a:	89 e5                	mov    %esp,%ebp
  10322c:	57                   	push   %edi
  10322d:	56                   	push   %esi
  10322e:	83 ec 20             	sub    $0x20,%esp
  103231:	e8 46 d0 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  103236:	05 1a b7 00 00       	add    $0xb71a,%eax
  10323b:	8b 45 08             	mov    0x8(%ebp),%eax
  10323e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103241:	8b 45 0c             	mov    0xc(%ebp),%eax
  103244:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103247:	8b 45 10             	mov    0x10(%ebp),%eax
  10324a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10324d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103250:	c1 e8 02             	shr    $0x2,%eax
  103253:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103255:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103258:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10325b:	89 d7                	mov    %edx,%edi
  10325d:	89 c6                	mov    %eax,%esi
  10325f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103261:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103264:	83 e1 03             	and    $0x3,%ecx
  103267:	74 02                	je     10326b <memcpy+0x42>
  103269:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10326b:	89 f0                	mov    %esi,%eax
  10326d:	89 fa                	mov    %edi,%edx
  10326f:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103272:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103275:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  103278:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  10327b:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  10327c:	83 c4 20             	add    $0x20,%esp
  10327f:	5e                   	pop    %esi
  103280:	5f                   	pop    %edi
  103281:	5d                   	pop    %ebp
  103282:	c3                   	ret    

00103283 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103283:	55                   	push   %ebp
  103284:	89 e5                	mov    %esp,%ebp
  103286:	83 ec 10             	sub    $0x10,%esp
  103289:	e8 ee cf ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10328e:	05 c2 b6 00 00       	add    $0xb6c2,%eax
    const char *s1 = (const char *)v1;
  103293:	8b 45 08             	mov    0x8(%ebp),%eax
  103296:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103299:	8b 45 0c             	mov    0xc(%ebp),%eax
  10329c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10329f:	eb 30                	jmp    1032d1 <memcmp+0x4e>
        if (*s1 != *s2) {
  1032a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032a4:	0f b6 10             	movzbl (%eax),%edx
  1032a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032aa:	0f b6 00             	movzbl (%eax),%eax
  1032ad:	38 c2                	cmp    %al,%dl
  1032af:	74 18                	je     1032c9 <memcmp+0x46>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1032b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032b4:	0f b6 00             	movzbl (%eax),%eax
  1032b7:	0f b6 d0             	movzbl %al,%edx
  1032ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032bd:	0f b6 00             	movzbl (%eax),%eax
  1032c0:	0f b6 c0             	movzbl %al,%eax
  1032c3:	29 c2                	sub    %eax,%edx
  1032c5:	89 d0                	mov    %edx,%eax
  1032c7:	eb 1a                	jmp    1032e3 <memcmp+0x60>
        }
        s1 ++, s2 ++;
  1032c9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1032cd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  1032d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1032d4:	8d 50 ff             	lea    -0x1(%eax),%edx
  1032d7:	89 55 10             	mov    %edx,0x10(%ebp)
  1032da:	85 c0                	test   %eax,%eax
  1032dc:	75 c3                	jne    1032a1 <memcmp+0x1e>
    }
    return 0;
  1032de:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1032e3:	c9                   	leave  
  1032e4:	c3                   	ret    

001032e5 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  1032e5:	55                   	push   %ebp
  1032e6:	89 e5                	mov    %esp,%ebp
  1032e8:	53                   	push   %ebx
  1032e9:	83 ec 34             	sub    $0x34,%esp
  1032ec:	e8 8f cf ff ff       	call   100280 <__x86.get_pc_thunk.bx>
  1032f1:	81 c3 5f b6 00 00    	add    $0xb65f,%ebx
  1032f7:	8b 45 10             	mov    0x10(%ebp),%eax
  1032fa:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1032fd:	8b 45 14             	mov    0x14(%ebp),%eax
  103300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  103303:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103306:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103309:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10330c:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10330f:	8b 45 18             	mov    0x18(%ebp),%eax
  103312:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103315:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103318:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10331b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10331e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103321:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103324:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103327:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10332b:	74 1c                	je     103349 <printnum+0x64>
  10332d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103330:	ba 00 00 00 00       	mov    $0x0,%edx
  103335:	f7 75 e4             	divl   -0x1c(%ebp)
  103338:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10333b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10333e:	ba 00 00 00 00       	mov    $0x0,%edx
  103343:	f7 75 e4             	divl   -0x1c(%ebp)
  103346:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103349:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10334c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10334f:	f7 75 e4             	divl   -0x1c(%ebp)
  103352:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103355:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103358:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10335b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10335e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103361:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103364:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103367:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10336a:	8b 45 18             	mov    0x18(%ebp),%eax
  10336d:	ba 00 00 00 00       	mov    $0x0,%edx
  103372:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  103375:	72 41                	jb     1033b8 <printnum+0xd3>
  103377:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  10337a:	77 05                	ja     103381 <printnum+0x9c>
  10337c:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  10337f:	72 37                	jb     1033b8 <printnum+0xd3>
        printnum(putch, putdat, result, base, width - 1, padc);
  103381:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103384:	83 e8 01             	sub    $0x1,%eax
  103387:	83 ec 04             	sub    $0x4,%esp
  10338a:	ff 75 20             	pushl  0x20(%ebp)
  10338d:	50                   	push   %eax
  10338e:	ff 75 18             	pushl  0x18(%ebp)
  103391:	ff 75 ec             	pushl  -0x14(%ebp)
  103394:	ff 75 e8             	pushl  -0x18(%ebp)
  103397:	ff 75 0c             	pushl  0xc(%ebp)
  10339a:	ff 75 08             	pushl  0x8(%ebp)
  10339d:	e8 43 ff ff ff       	call   1032e5 <printnum>
  1033a2:	83 c4 20             	add    $0x20,%esp
  1033a5:	eb 1b                	jmp    1033c2 <printnum+0xdd>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1033a7:	83 ec 08             	sub    $0x8,%esp
  1033aa:	ff 75 0c             	pushl  0xc(%ebp)
  1033ad:	ff 75 20             	pushl  0x20(%ebp)
  1033b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b3:	ff d0                	call   *%eax
  1033b5:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  1033b8:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  1033bc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1033c0:	7f e5                	jg     1033a7 <printnum+0xc2>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1033c2:	8d 93 36 57 ff ff    	lea    -0xa8ca(%ebx),%edx
  1033c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1033cb:	01 d0                	add    %edx,%eax
  1033cd:	0f b6 00             	movzbl (%eax),%eax
  1033d0:	0f be c0             	movsbl %al,%eax
  1033d3:	83 ec 08             	sub    $0x8,%esp
  1033d6:	ff 75 0c             	pushl  0xc(%ebp)
  1033d9:	50                   	push   %eax
  1033da:	8b 45 08             	mov    0x8(%ebp),%eax
  1033dd:	ff d0                	call   *%eax
  1033df:	83 c4 10             	add    $0x10,%esp
}
  1033e2:	90                   	nop
  1033e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1033e6:	c9                   	leave  
  1033e7:	c3                   	ret    

001033e8 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  1033e8:	55                   	push   %ebp
  1033e9:	89 e5                	mov    %esp,%ebp
  1033eb:	e8 8c ce ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1033f0:	05 60 b5 00 00       	add    $0xb560,%eax
    if (lflag >= 2) {
  1033f5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1033f9:	7e 14                	jle    10340f <getuint+0x27>
        return va_arg(*ap, unsigned long long);
  1033fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fe:	8b 00                	mov    (%eax),%eax
  103400:	8d 48 08             	lea    0x8(%eax),%ecx
  103403:	8b 55 08             	mov    0x8(%ebp),%edx
  103406:	89 0a                	mov    %ecx,(%edx)
  103408:	8b 50 04             	mov    0x4(%eax),%edx
  10340b:	8b 00                	mov    (%eax),%eax
  10340d:	eb 30                	jmp    10343f <getuint+0x57>
    }
    else if (lflag) {
  10340f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103413:	74 16                	je     10342b <getuint+0x43>
        return va_arg(*ap, unsigned long);
  103415:	8b 45 08             	mov    0x8(%ebp),%eax
  103418:	8b 00                	mov    (%eax),%eax
  10341a:	8d 48 04             	lea    0x4(%eax),%ecx
  10341d:	8b 55 08             	mov    0x8(%ebp),%edx
  103420:	89 0a                	mov    %ecx,(%edx)
  103422:	8b 00                	mov    (%eax),%eax
  103424:	ba 00 00 00 00       	mov    $0x0,%edx
  103429:	eb 14                	jmp    10343f <getuint+0x57>
    }
    else {
        return va_arg(*ap, unsigned int);
  10342b:	8b 45 08             	mov    0x8(%ebp),%eax
  10342e:	8b 00                	mov    (%eax),%eax
  103430:	8d 48 04             	lea    0x4(%eax),%ecx
  103433:	8b 55 08             	mov    0x8(%ebp),%edx
  103436:	89 0a                	mov    %ecx,(%edx)
  103438:	8b 00                	mov    (%eax),%eax
  10343a:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10343f:	5d                   	pop    %ebp
  103440:	c3                   	ret    

00103441 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103441:	55                   	push   %ebp
  103442:	89 e5                	mov    %esp,%ebp
  103444:	e8 33 ce ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  103449:	05 07 b5 00 00       	add    $0xb507,%eax
    if (lflag >= 2) {
  10344e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103452:	7e 14                	jle    103468 <getint+0x27>
        return va_arg(*ap, long long);
  103454:	8b 45 08             	mov    0x8(%ebp),%eax
  103457:	8b 00                	mov    (%eax),%eax
  103459:	8d 48 08             	lea    0x8(%eax),%ecx
  10345c:	8b 55 08             	mov    0x8(%ebp),%edx
  10345f:	89 0a                	mov    %ecx,(%edx)
  103461:	8b 50 04             	mov    0x4(%eax),%edx
  103464:	8b 00                	mov    (%eax),%eax
  103466:	eb 28                	jmp    103490 <getint+0x4f>
    }
    else if (lflag) {
  103468:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10346c:	74 12                	je     103480 <getint+0x3f>
        return va_arg(*ap, long);
  10346e:	8b 45 08             	mov    0x8(%ebp),%eax
  103471:	8b 00                	mov    (%eax),%eax
  103473:	8d 48 04             	lea    0x4(%eax),%ecx
  103476:	8b 55 08             	mov    0x8(%ebp),%edx
  103479:	89 0a                	mov    %ecx,(%edx)
  10347b:	8b 00                	mov    (%eax),%eax
  10347d:	99                   	cltd   
  10347e:	eb 10                	jmp    103490 <getint+0x4f>
    }
    else {
        return va_arg(*ap, int);
  103480:	8b 45 08             	mov    0x8(%ebp),%eax
  103483:	8b 00                	mov    (%eax),%eax
  103485:	8d 48 04             	lea    0x4(%eax),%ecx
  103488:	8b 55 08             	mov    0x8(%ebp),%edx
  10348b:	89 0a                	mov    %ecx,(%edx)
  10348d:	8b 00                	mov    (%eax),%eax
  10348f:	99                   	cltd   
    }
}
  103490:	5d                   	pop    %ebp
  103491:	c3                   	ret    

00103492 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  103492:	55                   	push   %ebp
  103493:	89 e5                	mov    %esp,%ebp
  103495:	83 ec 18             	sub    $0x18,%esp
  103498:	e8 df cd ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  10349d:	05 b3 b4 00 00       	add    $0xb4b3,%eax
    va_list ap;

    va_start(ap, fmt);
  1034a2:	8d 45 14             	lea    0x14(%ebp),%eax
  1034a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1034a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034ab:	50                   	push   %eax
  1034ac:	ff 75 10             	pushl  0x10(%ebp)
  1034af:	ff 75 0c             	pushl  0xc(%ebp)
  1034b2:	ff 75 08             	pushl  0x8(%ebp)
  1034b5:	e8 06 00 00 00       	call   1034c0 <vprintfmt>
  1034ba:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1034bd:	90                   	nop
  1034be:	c9                   	leave  
  1034bf:	c3                   	ret    

001034c0 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1034c0:	55                   	push   %ebp
  1034c1:	89 e5                	mov    %esp,%ebp
  1034c3:	57                   	push   %edi
  1034c4:	56                   	push   %esi
  1034c5:	53                   	push   %ebx
  1034c6:	83 ec 2c             	sub    $0x2c,%esp
  1034c9:	e8 8c 04 00 00       	call   10395a <__x86.get_pc_thunk.di>
  1034ce:	81 c7 82 b4 00 00    	add    $0xb482,%edi
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1034d4:	eb 17                	jmp    1034ed <vprintfmt+0x2d>
            if (ch == '\0') {
  1034d6:	85 db                	test   %ebx,%ebx
  1034d8:	0f 84 9a 03 00 00    	je     103878 <.L24+0x2d>
                return;
            }
            putch(ch, putdat);
  1034de:	83 ec 08             	sub    $0x8,%esp
  1034e1:	ff 75 0c             	pushl  0xc(%ebp)
  1034e4:	53                   	push   %ebx
  1034e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e8:	ff d0                	call   *%eax
  1034ea:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1034ed:	8b 45 10             	mov    0x10(%ebp),%eax
  1034f0:	8d 50 01             	lea    0x1(%eax),%edx
  1034f3:	89 55 10             	mov    %edx,0x10(%ebp)
  1034f6:	0f b6 00             	movzbl (%eax),%eax
  1034f9:	0f b6 d8             	movzbl %al,%ebx
  1034fc:	83 fb 25             	cmp    $0x25,%ebx
  1034ff:	75 d5                	jne    1034d6 <vprintfmt+0x16>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103501:	c6 45 cb 20          	movb   $0x20,-0x35(%ebp)
        width = precision = -1;
  103505:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  10350c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10350f:	89 45 d8             	mov    %eax,-0x28(%ebp)
        lflag = altflag = 0;
  103512:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  103519:	8b 45 cc             	mov    -0x34(%ebp),%eax
  10351c:	89 45 d0             	mov    %eax,-0x30(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  10351f:	8b 45 10             	mov    0x10(%ebp),%eax
  103522:	8d 50 01             	lea    0x1(%eax),%edx
  103525:	89 55 10             	mov    %edx,0x10(%ebp)
  103528:	0f b6 00             	movzbl (%eax),%eax
  10352b:	0f b6 d8             	movzbl %al,%ebx
  10352e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103531:	83 f8 55             	cmp    $0x55,%eax
  103534:	0f 87 11 03 00 00    	ja     10384b <.L24>
  10353a:	c1 e0 02             	shl    $0x2,%eax
  10353d:	8b 84 38 5c 57 ff ff 	mov    -0xa8a4(%eax,%edi,1),%eax
  103544:	01 f8                	add    %edi,%eax
  103546:	ff e0                	jmp    *%eax

00103548 <.L29>:

        // flag to pad on the right
        case '-':
            padc = '-';
  103548:	c6 45 cb 2d          	movb   $0x2d,-0x35(%ebp)
            goto reswitch;
  10354c:	eb d1                	jmp    10351f <vprintfmt+0x5f>

0010354e <.L31>:

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  10354e:	c6 45 cb 30          	movb   $0x30,-0x35(%ebp)
            goto reswitch;
  103552:	eb cb                	jmp    10351f <vprintfmt+0x5f>

00103554 <.L32>:

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103554:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
                precision = precision * 10 + ch - '0';
  10355b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10355e:	89 d0                	mov    %edx,%eax
  103560:	c1 e0 02             	shl    $0x2,%eax
  103563:	01 d0                	add    %edx,%eax
  103565:	01 c0                	add    %eax,%eax
  103567:	01 d8                	add    %ebx,%eax
  103569:	83 e8 30             	sub    $0x30,%eax
  10356c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                ch = *fmt;
  10356f:	8b 45 10             	mov    0x10(%ebp),%eax
  103572:	0f b6 00             	movzbl (%eax),%eax
  103575:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103578:	83 fb 2f             	cmp    $0x2f,%ebx
  10357b:	7e 39                	jle    1035b6 <.L25+0xc>
  10357d:	83 fb 39             	cmp    $0x39,%ebx
  103580:	7f 34                	jg     1035b6 <.L25+0xc>
            for (precision = 0; ; ++ fmt) {
  103582:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  103586:	eb d3                	jmp    10355b <.L32+0x7>

00103588 <.L28>:
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  103588:	8b 45 14             	mov    0x14(%ebp),%eax
  10358b:	8d 50 04             	lea    0x4(%eax),%edx
  10358e:	89 55 14             	mov    %edx,0x14(%ebp)
  103591:	8b 00                	mov    (%eax),%eax
  103593:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            goto process_precision;
  103596:	eb 1f                	jmp    1035b7 <.L25+0xd>

00103598 <.L30>:

        case '.':
            if (width < 0)
  103598:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10359c:	79 81                	jns    10351f <vprintfmt+0x5f>
                width = 0;
  10359e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
            goto reswitch;
  1035a5:	e9 75 ff ff ff       	jmp    10351f <vprintfmt+0x5f>

001035aa <.L25>:

        case '#':
            altflag = 1;
  1035aa:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
            goto reswitch;
  1035b1:	e9 69 ff ff ff       	jmp    10351f <vprintfmt+0x5f>
            goto process_precision;
  1035b6:	90                   	nop

        process_precision:
            if (width < 0)
  1035b7:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1035bb:	0f 89 5e ff ff ff    	jns    10351f <vprintfmt+0x5f>
                width = precision, precision = -1;
  1035c1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1035c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1035c7:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
            goto reswitch;
  1035ce:	e9 4c ff ff ff       	jmp    10351f <vprintfmt+0x5f>

001035d3 <.L36>:

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1035d3:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
            goto reswitch;
  1035d7:	e9 43 ff ff ff       	jmp    10351f <vprintfmt+0x5f>

001035dc <.L33>:

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1035dc:	8b 45 14             	mov    0x14(%ebp),%eax
  1035df:	8d 50 04             	lea    0x4(%eax),%edx
  1035e2:	89 55 14             	mov    %edx,0x14(%ebp)
  1035e5:	8b 00                	mov    (%eax),%eax
  1035e7:	83 ec 08             	sub    $0x8,%esp
  1035ea:	ff 75 0c             	pushl  0xc(%ebp)
  1035ed:	50                   	push   %eax
  1035ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1035f1:	ff d0                	call   *%eax
  1035f3:	83 c4 10             	add    $0x10,%esp
            break;
  1035f6:	e9 78 02 00 00       	jmp    103873 <.L24+0x28>

001035fb <.L35>:

        // error message
        case 'e':
            err = va_arg(ap, int);
  1035fb:	8b 45 14             	mov    0x14(%ebp),%eax
  1035fe:	8d 50 04             	lea    0x4(%eax),%edx
  103601:	89 55 14             	mov    %edx,0x14(%ebp)
  103604:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103606:	85 db                	test   %ebx,%ebx
  103608:	79 02                	jns    10360c <.L35+0x11>
                err = -err;
  10360a:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10360c:	83 fb 06             	cmp    $0x6,%ebx
  10360f:	7f 0b                	jg     10361c <.L35+0x21>
  103611:	8b b4 9f 40 01 00 00 	mov    0x140(%edi,%ebx,4),%esi
  103618:	85 f6                	test   %esi,%esi
  10361a:	75 1b                	jne    103637 <.L35+0x3c>
                printfmt(putch, putdat, "error %d", err);
  10361c:	53                   	push   %ebx
  10361d:	8d 87 47 57 ff ff    	lea    -0xa8b9(%edi),%eax
  103623:	50                   	push   %eax
  103624:	ff 75 0c             	pushl  0xc(%ebp)
  103627:	ff 75 08             	pushl  0x8(%ebp)
  10362a:	e8 63 fe ff ff       	call   103492 <printfmt>
  10362f:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103632:	e9 3c 02 00 00       	jmp    103873 <.L24+0x28>
                printfmt(putch, putdat, "%s", p);
  103637:	56                   	push   %esi
  103638:	8d 87 50 57 ff ff    	lea    -0xa8b0(%edi),%eax
  10363e:	50                   	push   %eax
  10363f:	ff 75 0c             	pushl  0xc(%ebp)
  103642:	ff 75 08             	pushl  0x8(%ebp)
  103645:	e8 48 fe ff ff       	call   103492 <printfmt>
  10364a:	83 c4 10             	add    $0x10,%esp
            break;
  10364d:	e9 21 02 00 00       	jmp    103873 <.L24+0x28>

00103652 <.L39>:

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103652:	8b 45 14             	mov    0x14(%ebp),%eax
  103655:	8d 50 04             	lea    0x4(%eax),%edx
  103658:	89 55 14             	mov    %edx,0x14(%ebp)
  10365b:	8b 30                	mov    (%eax),%esi
  10365d:	85 f6                	test   %esi,%esi
  10365f:	75 06                	jne    103667 <.L39+0x15>
                p = "(null)";
  103661:	8d b7 53 57 ff ff    	lea    -0xa8ad(%edi),%esi
            }
            if (width > 0 && padc != '-') {
  103667:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10366b:	7e 78                	jle    1036e5 <.L39+0x93>
  10366d:	80 7d cb 2d          	cmpb   $0x2d,-0x35(%ebp)
  103671:	74 72                	je     1036e5 <.L39+0x93>
                for (width -= strnlen(p, precision); width > 0; width --) {
  103673:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103676:	83 ec 08             	sub    $0x8,%esp
  103679:	50                   	push   %eax
  10367a:	56                   	push   %esi
  10367b:	89 fb                	mov    %edi,%ebx
  10367d:	e8 57 f7 ff ff       	call   102dd9 <strnlen>
  103682:	83 c4 10             	add    $0x10,%esp
  103685:	89 c2                	mov    %eax,%edx
  103687:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10368a:	29 d0                	sub    %edx,%eax
  10368c:	89 45 d8             	mov    %eax,-0x28(%ebp)
  10368f:	eb 17                	jmp    1036a8 <.L39+0x56>
                    putch(padc, putdat);
  103691:	0f be 45 cb          	movsbl -0x35(%ebp),%eax
  103695:	83 ec 08             	sub    $0x8,%esp
  103698:	ff 75 0c             	pushl  0xc(%ebp)
  10369b:	50                   	push   %eax
  10369c:	8b 45 08             	mov    0x8(%ebp),%eax
  10369f:	ff d0                	call   *%eax
  1036a1:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  1036a4:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1036a8:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036ac:	7f e3                	jg     103691 <.L39+0x3f>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1036ae:	eb 35                	jmp    1036e5 <.L39+0x93>
                if (altflag && (ch < ' ' || ch > '~')) {
  1036b0:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1036b4:	74 1c                	je     1036d2 <.L39+0x80>
  1036b6:	83 fb 1f             	cmp    $0x1f,%ebx
  1036b9:	7e 05                	jle    1036c0 <.L39+0x6e>
  1036bb:	83 fb 7e             	cmp    $0x7e,%ebx
  1036be:	7e 12                	jle    1036d2 <.L39+0x80>
                    putch('?', putdat);
  1036c0:	83 ec 08             	sub    $0x8,%esp
  1036c3:	ff 75 0c             	pushl  0xc(%ebp)
  1036c6:	6a 3f                	push   $0x3f
  1036c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1036cb:	ff d0                	call   *%eax
  1036cd:	83 c4 10             	add    $0x10,%esp
  1036d0:	eb 0f                	jmp    1036e1 <.L39+0x8f>
                }
                else {
                    putch(ch, putdat);
  1036d2:	83 ec 08             	sub    $0x8,%esp
  1036d5:	ff 75 0c             	pushl  0xc(%ebp)
  1036d8:	53                   	push   %ebx
  1036d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1036dc:	ff d0                	call   *%eax
  1036de:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1036e1:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1036e5:	89 f0                	mov    %esi,%eax
  1036e7:	8d 70 01             	lea    0x1(%eax),%esi
  1036ea:	0f b6 00             	movzbl (%eax),%eax
  1036ed:	0f be d8             	movsbl %al,%ebx
  1036f0:	85 db                	test   %ebx,%ebx
  1036f2:	74 26                	je     10371a <.L39+0xc8>
  1036f4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  1036f8:	78 b6                	js     1036b0 <.L39+0x5e>
  1036fa:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
  1036fe:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  103702:	79 ac                	jns    1036b0 <.L39+0x5e>
                }
            }
            for (; width > 0; width --) {
  103704:	eb 14                	jmp    10371a <.L39+0xc8>
                putch(' ', putdat);
  103706:	83 ec 08             	sub    $0x8,%esp
  103709:	ff 75 0c             	pushl  0xc(%ebp)
  10370c:	6a 20                	push   $0x20
  10370e:	8b 45 08             	mov    0x8(%ebp),%eax
  103711:	ff d0                	call   *%eax
  103713:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  103716:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10371a:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  10371e:	7f e6                	jg     103706 <.L39+0xb4>
            }
            break;
  103720:	e9 4e 01 00 00       	jmp    103873 <.L24+0x28>

00103725 <.L34>:

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103725:	83 ec 08             	sub    $0x8,%esp
  103728:	ff 75 d0             	pushl  -0x30(%ebp)
  10372b:	8d 45 14             	lea    0x14(%ebp),%eax
  10372e:	50                   	push   %eax
  10372f:	e8 0d fd ff ff       	call   103441 <getint>
  103734:	83 c4 10             	add    $0x10,%esp
  103737:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10373a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            if ((long long)num < 0) {
  10373d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103740:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103743:	85 d2                	test   %edx,%edx
  103745:	79 23                	jns    10376a <.L34+0x45>
                putch('-', putdat);
  103747:	83 ec 08             	sub    $0x8,%esp
  10374a:	ff 75 0c             	pushl  0xc(%ebp)
  10374d:	6a 2d                	push   $0x2d
  10374f:	8b 45 08             	mov    0x8(%ebp),%eax
  103752:	ff d0                	call   *%eax
  103754:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  103757:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10375a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10375d:	f7 d8                	neg    %eax
  10375f:	83 d2 00             	adc    $0x0,%edx
  103762:	f7 da                	neg    %edx
  103764:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103767:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            }
            base = 10;
  10376a:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  103771:	e9 9f 00 00 00       	jmp    103815 <.L41+0x1f>

00103776 <.L40>:

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  103776:	83 ec 08             	sub    $0x8,%esp
  103779:	ff 75 d0             	pushl  -0x30(%ebp)
  10377c:	8d 45 14             	lea    0x14(%ebp),%eax
  10377f:	50                   	push   %eax
  103780:	e8 63 fc ff ff       	call   1033e8 <getuint>
  103785:	83 c4 10             	add    $0x10,%esp
  103788:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10378b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 10;
  10378e:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  103795:	eb 7e                	jmp    103815 <.L41+0x1f>

00103797 <.L37>:

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103797:	83 ec 08             	sub    $0x8,%esp
  10379a:	ff 75 d0             	pushl  -0x30(%ebp)
  10379d:	8d 45 14             	lea    0x14(%ebp),%eax
  1037a0:	50                   	push   %eax
  1037a1:	e8 42 fc ff ff       	call   1033e8 <getuint>
  1037a6:	83 c4 10             	add    $0x10,%esp
  1037a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037ac:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 8;
  1037af:	c7 45 dc 08 00 00 00 	movl   $0x8,-0x24(%ebp)
            goto number;
  1037b6:	eb 5d                	jmp    103815 <.L41+0x1f>

001037b8 <.L38>:

        // pointer
        case 'p':
            putch('0', putdat);
  1037b8:	83 ec 08             	sub    $0x8,%esp
  1037bb:	ff 75 0c             	pushl  0xc(%ebp)
  1037be:	6a 30                	push   $0x30
  1037c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1037c3:	ff d0                	call   *%eax
  1037c5:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  1037c8:	83 ec 08             	sub    $0x8,%esp
  1037cb:	ff 75 0c             	pushl  0xc(%ebp)
  1037ce:	6a 78                	push   $0x78
  1037d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1037d3:	ff d0                	call   *%eax
  1037d5:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  1037d8:	8b 45 14             	mov    0x14(%ebp),%eax
  1037db:	8d 50 04             	lea    0x4(%eax),%edx
  1037de:	89 55 14             	mov    %edx,0x14(%ebp)
  1037e1:	8b 00                	mov    (%eax),%eax
  1037e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037e6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            base = 16;
  1037ed:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
            goto number;
  1037f4:	eb 1f                	jmp    103815 <.L41+0x1f>

001037f6 <.L41>:

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  1037f6:	83 ec 08             	sub    $0x8,%esp
  1037f9:	ff 75 d0             	pushl  -0x30(%ebp)
  1037fc:	8d 45 14             	lea    0x14(%ebp),%eax
  1037ff:	50                   	push   %eax
  103800:	e8 e3 fb ff ff       	call   1033e8 <getuint>
  103805:	83 c4 10             	add    $0x10,%esp
  103808:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10380b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 16;
  10380e:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103815:	0f be 55 cb          	movsbl -0x35(%ebp),%edx
  103819:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10381c:	83 ec 04             	sub    $0x4,%esp
  10381f:	52                   	push   %edx
  103820:	ff 75 d8             	pushl  -0x28(%ebp)
  103823:	50                   	push   %eax
  103824:	ff 75 e4             	pushl  -0x1c(%ebp)
  103827:	ff 75 e0             	pushl  -0x20(%ebp)
  10382a:	ff 75 0c             	pushl  0xc(%ebp)
  10382d:	ff 75 08             	pushl  0x8(%ebp)
  103830:	e8 b0 fa ff ff       	call   1032e5 <printnum>
  103835:	83 c4 20             	add    $0x20,%esp
            break;
  103838:	eb 39                	jmp    103873 <.L24+0x28>

0010383a <.L27>:

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  10383a:	83 ec 08             	sub    $0x8,%esp
  10383d:	ff 75 0c             	pushl  0xc(%ebp)
  103840:	53                   	push   %ebx
  103841:	8b 45 08             	mov    0x8(%ebp),%eax
  103844:	ff d0                	call   *%eax
  103846:	83 c4 10             	add    $0x10,%esp
            break;
  103849:	eb 28                	jmp    103873 <.L24+0x28>

0010384b <.L24>:

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  10384b:	83 ec 08             	sub    $0x8,%esp
  10384e:	ff 75 0c             	pushl  0xc(%ebp)
  103851:	6a 25                	push   $0x25
  103853:	8b 45 08             	mov    0x8(%ebp),%eax
  103856:	ff d0                	call   *%eax
  103858:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  10385b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10385f:	eb 04                	jmp    103865 <.L24+0x1a>
  103861:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103865:	8b 45 10             	mov    0x10(%ebp),%eax
  103868:	83 e8 01             	sub    $0x1,%eax
  10386b:	0f b6 00             	movzbl (%eax),%eax
  10386e:	3c 25                	cmp    $0x25,%al
  103870:	75 ef                	jne    103861 <.L24+0x16>
                /* do nothing */;
            break;
  103872:	90                   	nop
    while (1) {
  103873:	e9 5c fc ff ff       	jmp    1034d4 <vprintfmt+0x14>
                return;
  103878:	90                   	nop
        }
    }
}
  103879:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10387c:	5b                   	pop    %ebx
  10387d:	5e                   	pop    %esi
  10387e:	5f                   	pop    %edi
  10387f:	5d                   	pop    %ebp
  103880:	c3                   	ret    

00103881 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103881:	55                   	push   %ebp
  103882:	89 e5                	mov    %esp,%ebp
  103884:	e8 f3 c9 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  103889:	05 c7 b0 00 00       	add    $0xb0c7,%eax
    b->cnt ++;
  10388e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103891:	8b 40 08             	mov    0x8(%eax),%eax
  103894:	8d 50 01             	lea    0x1(%eax),%edx
  103897:	8b 45 0c             	mov    0xc(%ebp),%eax
  10389a:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  10389d:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038a0:	8b 10                	mov    (%eax),%edx
  1038a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038a5:	8b 40 04             	mov    0x4(%eax),%eax
  1038a8:	39 c2                	cmp    %eax,%edx
  1038aa:	73 12                	jae    1038be <sprintputch+0x3d>
        *b->buf ++ = ch;
  1038ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1038af:	8b 00                	mov    (%eax),%eax
  1038b1:	8d 48 01             	lea    0x1(%eax),%ecx
  1038b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1038b7:	89 0a                	mov    %ecx,(%edx)
  1038b9:	8b 55 08             	mov    0x8(%ebp),%edx
  1038bc:	88 10                	mov    %dl,(%eax)
    }
}
  1038be:	90                   	nop
  1038bf:	5d                   	pop    %ebp
  1038c0:	c3                   	ret    

001038c1 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1038c1:	55                   	push   %ebp
  1038c2:	89 e5                	mov    %esp,%ebp
  1038c4:	83 ec 18             	sub    $0x18,%esp
  1038c7:	e8 b0 c9 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1038cc:	05 84 b0 00 00       	add    $0xb084,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1038d1:	8d 45 14             	lea    0x14(%ebp),%eax
  1038d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  1038d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1038da:	50                   	push   %eax
  1038db:	ff 75 10             	pushl  0x10(%ebp)
  1038de:	ff 75 0c             	pushl  0xc(%ebp)
  1038e1:	ff 75 08             	pushl  0x8(%ebp)
  1038e4:	e8 0b 00 00 00       	call   1038f4 <vsnprintf>
  1038e9:	83 c4 10             	add    $0x10,%esp
  1038ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1038ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1038f2:	c9                   	leave  
  1038f3:	c3                   	ret    

001038f4 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  1038f4:	55                   	push   %ebp
  1038f5:	89 e5                	mov    %esp,%ebp
  1038f7:	83 ec 18             	sub    $0x18,%esp
  1038fa:	e8 7d c9 ff ff       	call   10027c <__x86.get_pc_thunk.ax>
  1038ff:	05 51 b0 00 00       	add    $0xb051,%eax
    struct sprintbuf b = {str, str + size - 1, 0};
  103904:	8b 55 08             	mov    0x8(%ebp),%edx
  103907:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10390a:	8b 55 0c             	mov    0xc(%ebp),%edx
  10390d:	8d 4a ff             	lea    -0x1(%edx),%ecx
  103910:	8b 55 08             	mov    0x8(%ebp),%edx
  103913:	01 ca                	add    %ecx,%edx
  103915:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103918:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10391f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103923:	74 0a                	je     10392f <vsnprintf+0x3b>
  103925:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103928:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10392b:	39 d1                	cmp    %edx,%ecx
  10392d:	76 07                	jbe    103936 <vsnprintf+0x42>
        return -E_INVAL;
  10392f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103934:	eb 22                	jmp    103958 <vsnprintf+0x64>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103936:	ff 75 14             	pushl  0x14(%ebp)
  103939:	ff 75 10             	pushl  0x10(%ebp)
  10393c:	8d 55 ec             	lea    -0x14(%ebp),%edx
  10393f:	52                   	push   %edx
  103940:	8d 80 31 4f ff ff    	lea    -0xb0cf(%eax),%eax
  103946:	50                   	push   %eax
  103947:	e8 74 fb ff ff       	call   1034c0 <vprintfmt>
  10394c:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  10394f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103952:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103955:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103958:	c9                   	leave  
  103959:	c3                   	ret    

0010395a <__x86.get_pc_thunk.di>:
  10395a:	8b 3c 24             	mov    (%esp),%edi
  10395d:	c3                   	ret    
