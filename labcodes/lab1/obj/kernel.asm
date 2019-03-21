
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
  100003:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	83 ec 04             	sub    $0x4,%esp
  100017:	50                   	push   %eax
  100018:	6a 00                	push   $0x0
  10001a:	68 16 ea 10 00       	push   $0x10ea16
  10001f:	e8 00 2a 00 00       	call   102a24 <memset>
  100024:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100027:	e8 73 14 00 00       	call   10149f <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002c:	c7 45 f4 c0 31 10 00 	movl   $0x1031c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100033:	83 ec 08             	sub    $0x8,%esp
  100036:	ff 75 f4             	pushl  -0xc(%ebp)
  100039:	68 dc 31 10 00       	push   $0x1031dc
  10003e:	e8 fa 01 00 00       	call   10023d <cprintf>
  100043:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100046:	e8 91 08 00 00       	call   1008dc <print_kerninfo>

    grade_backtrace();
  10004b:	e8 74 00 00 00       	call   1000c4 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100050:	e8 93 26 00 00       	call   1026e8 <pmm_init>

    pic_init();                 // init interrupt controller
  100055:	e8 88 15 00 00       	call   1015e2 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005a:	e8 e9 16 00 00       	call   101748 <idt_init>

    clock_init();               // init clock interrupt
  10005f:	e8 1c 0c 00 00       	call   100c80 <clock_init>
    intr_enable();              // enable irq interrupt
  100064:	e8 b6 16 00 00       	call   10171f <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100069:	eb fe                	jmp    100069 <kern_init+0x69>

0010006b <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  10006b:	55                   	push   %ebp
  10006c:	89 e5                	mov    %esp,%ebp
  10006e:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  100071:	83 ec 04             	sub    $0x4,%esp
  100074:	6a 00                	push   $0x0
  100076:	6a 00                	push   $0x0
  100078:	6a 00                	push   $0x0
  10007a:	e8 ef 0b 00 00       	call   100c6e <mon_backtrace>
  10007f:	83 c4 10             	add    $0x10,%esp
}
  100082:	90                   	nop
  100083:	c9                   	leave  
  100084:	c3                   	ret    

00100085 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100085:	55                   	push   %ebp
  100086:	89 e5                	mov    %esp,%ebp
  100088:	53                   	push   %ebx
  100089:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10008c:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  10008f:	8b 55 0c             	mov    0xc(%ebp),%edx
  100092:	8d 5d 08             	lea    0x8(%ebp),%ebx
  100095:	8b 45 08             	mov    0x8(%ebp),%eax
  100098:	51                   	push   %ecx
  100099:	52                   	push   %edx
  10009a:	53                   	push   %ebx
  10009b:	50                   	push   %eax
  10009c:	e8 ca ff ff ff       	call   10006b <grade_backtrace2>
  1000a1:	83 c4 10             	add    $0x10,%esp
}
  1000a4:	90                   	nop
  1000a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000a8:	c9                   	leave  
  1000a9:	c3                   	ret    

001000aa <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000aa:	55                   	push   %ebp
  1000ab:	89 e5                	mov    %esp,%ebp
  1000ad:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000b0:	83 ec 08             	sub    $0x8,%esp
  1000b3:	ff 75 10             	pushl  0x10(%ebp)
  1000b6:	ff 75 08             	pushl  0x8(%ebp)
  1000b9:	e8 c7 ff ff ff       	call   100085 <grade_backtrace1>
  1000be:	83 c4 10             	add    $0x10,%esp
}
  1000c1:	90                   	nop
  1000c2:	c9                   	leave  
  1000c3:	c3                   	ret    

001000c4 <grade_backtrace>:

void
grade_backtrace(void) {
  1000c4:	55                   	push   %ebp
  1000c5:	89 e5                	mov    %esp,%ebp
  1000c7:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000ca:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000cf:	83 ec 04             	sub    $0x4,%esp
  1000d2:	68 00 00 ff ff       	push   $0xffff0000
  1000d7:	50                   	push   %eax
  1000d8:	6a 00                	push   $0x0
  1000da:	e8 cb ff ff ff       	call   1000aa <grade_backtrace0>
  1000df:	83 c4 10             	add    $0x10,%esp
}
  1000e2:	90                   	nop
  1000e3:	c9                   	leave  
  1000e4:	c3                   	ret    

001000e5 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  1000e5:	55                   	push   %ebp
  1000e6:	89 e5                	mov    %esp,%ebp
  1000e8:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  1000eb:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  1000ee:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  1000f1:	8c 45 f2             	mov    %es,-0xe(%ebp)
  1000f4:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  1000f7:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1000fb:	0f b7 c0             	movzwl %ax,%eax
  1000fe:	83 e0 03             	and    $0x3,%eax
  100101:	89 c2                	mov    %eax,%edx
  100103:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100108:	83 ec 04             	sub    $0x4,%esp
  10010b:	52                   	push   %edx
  10010c:	50                   	push   %eax
  10010d:	68 e1 31 10 00       	push   $0x1031e1
  100112:	e8 26 01 00 00       	call   10023d <cprintf>
  100117:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  10011a:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011e:	0f b7 d0             	movzwl %ax,%edx
  100121:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100126:	83 ec 04             	sub    $0x4,%esp
  100129:	52                   	push   %edx
  10012a:	50                   	push   %eax
  10012b:	68 ef 31 10 00       	push   $0x1031ef
  100130:	e8 08 01 00 00       	call   10023d <cprintf>
  100135:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100138:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10013c:	0f b7 d0             	movzwl %ax,%edx
  10013f:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100144:	83 ec 04             	sub    $0x4,%esp
  100147:	52                   	push   %edx
  100148:	50                   	push   %eax
  100149:	68 fd 31 10 00       	push   $0x1031fd
  10014e:	e8 ea 00 00 00       	call   10023d <cprintf>
  100153:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  100156:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10015a:	0f b7 d0             	movzwl %ax,%edx
  10015d:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100162:	83 ec 04             	sub    $0x4,%esp
  100165:	52                   	push   %edx
  100166:	50                   	push   %eax
  100167:	68 0b 32 10 00       	push   $0x10320b
  10016c:	e8 cc 00 00 00       	call   10023d <cprintf>
  100171:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  100174:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  100178:	0f b7 d0             	movzwl %ax,%edx
  10017b:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100180:	83 ec 04             	sub    $0x4,%esp
  100183:	52                   	push   %edx
  100184:	50                   	push   %eax
  100185:	68 19 32 10 00       	push   $0x103219
  10018a:	e8 ae 00 00 00       	call   10023d <cprintf>
  10018f:	83 c4 10             	add    $0x10,%esp
    round ++;
  100192:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100197:	83 c0 01             	add    $0x1,%eax
  10019a:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  10019f:	90                   	nop
  1001a0:	c9                   	leave  
  1001a1:	c3                   	ret    

001001a2 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001a2:	55                   	push   %ebp
  1001a3:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001a5:	90                   	nop
  1001a6:	5d                   	pop    %ebp
  1001a7:	c3                   	ret    

001001a8 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001a8:	55                   	push   %ebp
  1001a9:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001ab:	90                   	nop
  1001ac:	5d                   	pop    %ebp
  1001ad:	c3                   	ret    

001001ae <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001ae:	55                   	push   %ebp
  1001af:	89 e5                	mov    %esp,%ebp
  1001b1:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001b4:	e8 2c ff ff ff       	call   1000e5 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001b9:	83 ec 0c             	sub    $0xc,%esp
  1001bc:	68 28 32 10 00       	push   $0x103228
  1001c1:	e8 77 00 00 00       	call   10023d <cprintf>
  1001c6:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  1001c9:	e8 d4 ff ff ff       	call   1001a2 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001ce:	e8 12 ff ff ff       	call   1000e5 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001d3:	83 ec 0c             	sub    $0xc,%esp
  1001d6:	68 48 32 10 00       	push   $0x103248
  1001db:	e8 5d 00 00 00       	call   10023d <cprintf>
  1001e0:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  1001e3:	e8 c0 ff ff ff       	call   1001a8 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  1001e8:	e8 f8 fe ff ff       	call   1000e5 <lab1_print_cur_status>
}
  1001ed:	90                   	nop
  1001ee:	c9                   	leave  
  1001ef:	c3                   	ret    

001001f0 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1001f0:	55                   	push   %ebp
  1001f1:	89 e5                	mov    %esp,%ebp
  1001f3:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  1001f6:	83 ec 0c             	sub    $0xc,%esp
  1001f9:	ff 75 08             	pushl  0x8(%ebp)
  1001fc:	e8 cf 12 00 00       	call   1014d0 <cons_putc>
  100201:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100204:	8b 45 0c             	mov    0xc(%ebp),%eax
  100207:	8b 00                	mov    (%eax),%eax
  100209:	8d 50 01             	lea    0x1(%eax),%edx
  10020c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10020f:	89 10                	mov    %edx,(%eax)
}
  100211:	90                   	nop
  100212:	c9                   	leave  
  100213:	c3                   	ret    

00100214 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100214:	55                   	push   %ebp
  100215:	89 e5                	mov    %esp,%ebp
  100217:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  10021a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100221:	ff 75 0c             	pushl  0xc(%ebp)
  100224:	ff 75 08             	pushl  0x8(%ebp)
  100227:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10022a:	50                   	push   %eax
  10022b:	68 f0 01 10 00       	push   $0x1001f0
  100230:	e8 25 2b 00 00       	call   102d5a <vprintfmt>
  100235:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100238:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10023b:	c9                   	leave  
  10023c:	c3                   	ret    

0010023d <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10023d:	55                   	push   %ebp
  10023e:	89 e5                	mov    %esp,%ebp
  100240:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100243:	8d 45 0c             	lea    0xc(%ebp),%eax
  100246:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100249:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10024c:	83 ec 08             	sub    $0x8,%esp
  10024f:	50                   	push   %eax
  100250:	ff 75 08             	pushl  0x8(%ebp)
  100253:	e8 bc ff ff ff       	call   100214 <vcprintf>
  100258:	83 c4 10             	add    $0x10,%esp
  10025b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10025e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100261:	c9                   	leave  
  100262:	c3                   	ret    

00100263 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100263:	55                   	push   %ebp
  100264:	89 e5                	mov    %esp,%ebp
  100266:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100269:	83 ec 0c             	sub    $0xc,%esp
  10026c:	ff 75 08             	pushl  0x8(%ebp)
  10026f:	e8 5c 12 00 00       	call   1014d0 <cons_putc>
  100274:	83 c4 10             	add    $0x10,%esp
}
  100277:	90                   	nop
  100278:	c9                   	leave  
  100279:	c3                   	ret    

0010027a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10027a:	55                   	push   %ebp
  10027b:	89 e5                	mov    %esp,%ebp
  10027d:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  100280:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100287:	eb 14                	jmp    10029d <cputs+0x23>
        cputch(c, &cnt);
  100289:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10028d:	83 ec 08             	sub    $0x8,%esp
  100290:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100293:	52                   	push   %edx
  100294:	50                   	push   %eax
  100295:	e8 56 ff ff ff       	call   1001f0 <cputch>
  10029a:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  10029d:	8b 45 08             	mov    0x8(%ebp),%eax
  1002a0:	8d 50 01             	lea    0x1(%eax),%edx
  1002a3:	89 55 08             	mov    %edx,0x8(%ebp)
  1002a6:	0f b6 00             	movzbl (%eax),%eax
  1002a9:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002ac:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002b0:	75 d7                	jne    100289 <cputs+0xf>
    }
    cputch('\n', &cnt);
  1002b2:	83 ec 08             	sub    $0x8,%esp
  1002b5:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002b8:	50                   	push   %eax
  1002b9:	6a 0a                	push   $0xa
  1002bb:	e8 30 ff ff ff       	call   1001f0 <cputch>
  1002c0:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1002c6:	c9                   	leave  
  1002c7:	c3                   	ret    

001002c8 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1002c8:	55                   	push   %ebp
  1002c9:	89 e5                	mov    %esp,%ebp
  1002cb:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1002ce:	e8 2d 12 00 00       	call   101500 <cons_getc>
  1002d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1002d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1002da:	74 f2                	je     1002ce <getchar+0x6>
        /* do nothing */;
    return c;
  1002dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002df:	c9                   	leave  
  1002e0:	c3                   	ret    

001002e1 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1002e1:	55                   	push   %ebp
  1002e2:	89 e5                	mov    %esp,%ebp
  1002e4:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  1002e7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1002eb:	74 13                	je     100300 <readline+0x1f>
        cprintf("%s", prompt);
  1002ed:	83 ec 08             	sub    $0x8,%esp
  1002f0:	ff 75 08             	pushl  0x8(%ebp)
  1002f3:	68 67 32 10 00       	push   $0x103267
  1002f8:	e8 40 ff ff ff       	call   10023d <cprintf>
  1002fd:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100300:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100307:	e8 bc ff ff ff       	call   1002c8 <getchar>
  10030c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10030f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100313:	79 0a                	jns    10031f <readline+0x3e>
            return NULL;
  100315:	b8 00 00 00 00       	mov    $0x0,%eax
  10031a:	e9 82 00 00 00       	jmp    1003a1 <readline+0xc0>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10031f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100323:	7e 2b                	jle    100350 <readline+0x6f>
  100325:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10032c:	7f 22                	jg     100350 <readline+0x6f>
            cputchar(c);
  10032e:	83 ec 0c             	sub    $0xc,%esp
  100331:	ff 75 f0             	pushl  -0x10(%ebp)
  100334:	e8 2a ff ff ff       	call   100263 <cputchar>
  100339:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  10033c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10033f:	8d 50 01             	lea    0x1(%eax),%edx
  100342:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100345:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100348:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  10034e:	eb 4c                	jmp    10039c <readline+0xbb>
        }
        else if (c == '\b' && i > 0) {
  100350:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100354:	75 1a                	jne    100370 <readline+0x8f>
  100356:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10035a:	7e 14                	jle    100370 <readline+0x8f>
            cputchar(c);
  10035c:	83 ec 0c             	sub    $0xc,%esp
  10035f:	ff 75 f0             	pushl  -0x10(%ebp)
  100362:	e8 fc fe ff ff       	call   100263 <cputchar>
  100367:	83 c4 10             	add    $0x10,%esp
            i --;
  10036a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10036e:	eb 2c                	jmp    10039c <readline+0xbb>
        }
        else if (c == '\n' || c == '\r') {
  100370:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100374:	74 06                	je     10037c <readline+0x9b>
  100376:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10037a:	75 8b                	jne    100307 <readline+0x26>
            cputchar(c);
  10037c:	83 ec 0c             	sub    $0xc,%esp
  10037f:	ff 75 f0             	pushl  -0x10(%ebp)
  100382:	e8 dc fe ff ff       	call   100263 <cputchar>
  100387:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  10038a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10038d:	05 40 ea 10 00       	add    $0x10ea40,%eax
  100392:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  100395:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  10039a:	eb 05                	jmp    1003a1 <readline+0xc0>
        c = getchar();
  10039c:	e9 66 ff ff ff       	jmp    100307 <readline+0x26>
        }
    }
}
  1003a1:	c9                   	leave  
  1003a2:	c3                   	ret    

001003a3 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003a3:	55                   	push   %ebp
  1003a4:	89 e5                	mov    %esp,%ebp
  1003a6:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  1003a9:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  1003ae:	85 c0                	test   %eax,%eax
  1003b0:	75 5f                	jne    100411 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  1003b2:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  1003b9:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1003bc:	8d 45 14             	lea    0x14(%ebp),%eax
  1003bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1003c2:	83 ec 04             	sub    $0x4,%esp
  1003c5:	ff 75 0c             	pushl  0xc(%ebp)
  1003c8:	ff 75 08             	pushl  0x8(%ebp)
  1003cb:	68 6a 32 10 00       	push   $0x10326a
  1003d0:	e8 68 fe ff ff       	call   10023d <cprintf>
  1003d5:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1003d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003db:	83 ec 08             	sub    $0x8,%esp
  1003de:	50                   	push   %eax
  1003df:	ff 75 10             	pushl  0x10(%ebp)
  1003e2:	e8 2d fe ff ff       	call   100214 <vcprintf>
  1003e7:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1003ea:	83 ec 0c             	sub    $0xc,%esp
  1003ed:	68 86 32 10 00       	push   $0x103286
  1003f2:	e8 46 fe ff ff       	call   10023d <cprintf>
  1003f7:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
  1003fa:	83 ec 0c             	sub    $0xc,%esp
  1003fd:	68 88 32 10 00       	push   $0x103288
  100402:	e8 36 fe ff ff       	call   10023d <cprintf>
  100407:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
  10040a:	e8 17 06 00 00       	call   100a26 <print_stackframe>
  10040f:	eb 01                	jmp    100412 <__panic+0x6f>
        goto panic_dead;
  100411:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100412:	e8 0f 13 00 00       	call   101726 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100417:	83 ec 0c             	sub    $0xc,%esp
  10041a:	6a 00                	push   $0x0
  10041c:	e8 73 07 00 00       	call   100b94 <kmonitor>
  100421:	83 c4 10             	add    $0x10,%esp
  100424:	eb f1                	jmp    100417 <__panic+0x74>

00100426 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100426:	55                   	push   %ebp
  100427:	89 e5                	mov    %esp,%ebp
  100429:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  10042c:	8d 45 14             	lea    0x14(%ebp),%eax
  10042f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100432:	83 ec 04             	sub    $0x4,%esp
  100435:	ff 75 0c             	pushl  0xc(%ebp)
  100438:	ff 75 08             	pushl  0x8(%ebp)
  10043b:	68 9a 32 10 00       	push   $0x10329a
  100440:	e8 f8 fd ff ff       	call   10023d <cprintf>
  100445:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100448:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10044b:	83 ec 08             	sub    $0x8,%esp
  10044e:	50                   	push   %eax
  10044f:	ff 75 10             	pushl  0x10(%ebp)
  100452:	e8 bd fd ff ff       	call   100214 <vcprintf>
  100457:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10045a:	83 ec 0c             	sub    $0xc,%esp
  10045d:	68 86 32 10 00       	push   $0x103286
  100462:	e8 d6 fd ff ff       	call   10023d <cprintf>
  100467:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10046a:	90                   	nop
  10046b:	c9                   	leave  
  10046c:	c3                   	ret    

0010046d <is_kernel_panic>:

bool
is_kernel_panic(void) {
  10046d:	55                   	push   %ebp
  10046e:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100470:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100475:	5d                   	pop    %ebp
  100476:	c3                   	ret    

00100477 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100477:	55                   	push   %ebp
  100478:	89 e5                	mov    %esp,%ebp
  10047a:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  10047d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100480:	8b 00                	mov    (%eax),%eax
  100482:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100485:	8b 45 10             	mov    0x10(%ebp),%eax
  100488:	8b 00                	mov    (%eax),%eax
  10048a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10048d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  100494:	e9 d2 00 00 00       	jmp    10056b <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  100499:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10049c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10049f:	01 d0                	add    %edx,%eax
  1004a1:	89 c2                	mov    %eax,%edx
  1004a3:	c1 ea 1f             	shr    $0x1f,%edx
  1004a6:	01 d0                	add    %edx,%eax
  1004a8:	d1 f8                	sar    %eax
  1004aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1004ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004b0:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1004b3:	eb 04                	jmp    1004b9 <stab_binsearch+0x42>
            m --;
  1004b5:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004bf:	7c 1f                	jl     1004e0 <stab_binsearch+0x69>
  1004c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004c4:	89 d0                	mov    %edx,%eax
  1004c6:	01 c0                	add    %eax,%eax
  1004c8:	01 d0                	add    %edx,%eax
  1004ca:	c1 e0 02             	shl    $0x2,%eax
  1004cd:	89 c2                	mov    %eax,%edx
  1004cf:	8b 45 08             	mov    0x8(%ebp),%eax
  1004d2:	01 d0                	add    %edx,%eax
  1004d4:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004d8:	0f b6 c0             	movzbl %al,%eax
  1004db:	39 45 14             	cmp    %eax,0x14(%ebp)
  1004de:	75 d5                	jne    1004b5 <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
  1004e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004e6:	7d 0b                	jge    1004f3 <stab_binsearch+0x7c>
            l = true_m + 1;
  1004e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004eb:	83 c0 01             	add    $0x1,%eax
  1004ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  1004f1:	eb 78                	jmp    10056b <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  1004f3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  1004fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004fd:	89 d0                	mov    %edx,%eax
  1004ff:	01 c0                	add    %eax,%eax
  100501:	01 d0                	add    %edx,%eax
  100503:	c1 e0 02             	shl    $0x2,%eax
  100506:	89 c2                	mov    %eax,%edx
  100508:	8b 45 08             	mov    0x8(%ebp),%eax
  10050b:	01 d0                	add    %edx,%eax
  10050d:	8b 40 08             	mov    0x8(%eax),%eax
  100510:	39 45 18             	cmp    %eax,0x18(%ebp)
  100513:	76 13                	jbe    100528 <stab_binsearch+0xb1>
            *region_left = m;
  100515:	8b 45 0c             	mov    0xc(%ebp),%eax
  100518:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10051b:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10051d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100520:	83 c0 01             	add    $0x1,%eax
  100523:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100526:	eb 43                	jmp    10056b <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100528:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10052b:	89 d0                	mov    %edx,%eax
  10052d:	01 c0                	add    %eax,%eax
  10052f:	01 d0                	add    %edx,%eax
  100531:	c1 e0 02             	shl    $0x2,%eax
  100534:	89 c2                	mov    %eax,%edx
  100536:	8b 45 08             	mov    0x8(%ebp),%eax
  100539:	01 d0                	add    %edx,%eax
  10053b:	8b 40 08             	mov    0x8(%eax),%eax
  10053e:	39 45 18             	cmp    %eax,0x18(%ebp)
  100541:	73 16                	jae    100559 <stab_binsearch+0xe2>
            *region_right = m - 1;
  100543:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100546:	8d 50 ff             	lea    -0x1(%eax),%edx
  100549:	8b 45 10             	mov    0x10(%ebp),%eax
  10054c:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10054e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100551:	83 e8 01             	sub    $0x1,%eax
  100554:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100557:	eb 12                	jmp    10056b <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100559:	8b 45 0c             	mov    0xc(%ebp),%eax
  10055c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055f:	89 10                	mov    %edx,(%eax)
            l = m;
  100561:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100564:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  100567:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  10056b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10056e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100571:	0f 8e 22 ff ff ff    	jle    100499 <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
  100577:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10057b:	75 0f                	jne    10058c <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  10057d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100580:	8b 00                	mov    (%eax),%eax
  100582:	8d 50 ff             	lea    -0x1(%eax),%edx
  100585:	8b 45 10             	mov    0x10(%ebp),%eax
  100588:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  10058a:	eb 3f                	jmp    1005cb <stab_binsearch+0x154>
        l = *region_right;
  10058c:	8b 45 10             	mov    0x10(%ebp),%eax
  10058f:	8b 00                	mov    (%eax),%eax
  100591:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100594:	eb 04                	jmp    10059a <stab_binsearch+0x123>
  100596:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  10059a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10059d:	8b 00                	mov    (%eax),%eax
  10059f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005a2:	7e 1f                	jle    1005c3 <stab_binsearch+0x14c>
  1005a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005a7:	89 d0                	mov    %edx,%eax
  1005a9:	01 c0                	add    %eax,%eax
  1005ab:	01 d0                	add    %edx,%eax
  1005ad:	c1 e0 02             	shl    $0x2,%eax
  1005b0:	89 c2                	mov    %eax,%edx
  1005b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b5:	01 d0                	add    %edx,%eax
  1005b7:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005bb:	0f b6 c0             	movzbl %al,%eax
  1005be:	39 45 14             	cmp    %eax,0x14(%ebp)
  1005c1:	75 d3                	jne    100596 <stab_binsearch+0x11f>
        *region_left = l;
  1005c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005c9:	89 10                	mov    %edx,(%eax)
}
  1005cb:	90                   	nop
  1005cc:	c9                   	leave  
  1005cd:	c3                   	ret    

001005ce <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1005ce:	55                   	push   %ebp
  1005cf:	89 e5                	mov    %esp,%ebp
  1005d1:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1005d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d7:	c7 00 b8 32 10 00    	movl   $0x1032b8,(%eax)
    info->eip_line = 0;
  1005dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1005e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ea:	c7 40 08 b8 32 10 00 	movl   $0x1032b8,0x8(%eax)
    info->eip_fn_namelen = 9;
  1005f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f4:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  1005fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005fe:	8b 55 08             	mov    0x8(%ebp),%edx
  100601:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100604:	8b 45 0c             	mov    0xc(%ebp),%eax
  100607:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10060e:	c7 45 f4 ac 3a 10 00 	movl   $0x103aac,-0xc(%ebp)
    stab_end = __STAB_END__;
  100615:	c7 45 f0 64 b5 10 00 	movl   $0x10b564,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10061c:	c7 45 ec 65 b5 10 00 	movl   $0x10b565,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100623:	c7 45 e8 17 d6 10 00 	movl   $0x10d617,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10062a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10062d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100630:	76 0d                	jbe    10063f <debuginfo_eip+0x71>
  100632:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100635:	83 e8 01             	sub    $0x1,%eax
  100638:	0f b6 00             	movzbl (%eax),%eax
  10063b:	84 c0                	test   %al,%al
  10063d:	74 0a                	je     100649 <debuginfo_eip+0x7b>
        return -1;
  10063f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100644:	e9 91 02 00 00       	jmp    1008da <debuginfo_eip+0x30c>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100649:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100650:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100653:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100656:	29 c2                	sub    %eax,%edx
  100658:	89 d0                	mov    %edx,%eax
  10065a:	c1 f8 02             	sar    $0x2,%eax
  10065d:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  100663:	83 e8 01             	sub    $0x1,%eax
  100666:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100669:	ff 75 08             	pushl  0x8(%ebp)
  10066c:	6a 64                	push   $0x64
  10066e:	8d 45 e0             	lea    -0x20(%ebp),%eax
  100671:	50                   	push   %eax
  100672:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100675:	50                   	push   %eax
  100676:	ff 75 f4             	pushl  -0xc(%ebp)
  100679:	e8 f9 fd ff ff       	call   100477 <stab_binsearch>
  10067e:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  100681:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100684:	85 c0                	test   %eax,%eax
  100686:	75 0a                	jne    100692 <debuginfo_eip+0xc4>
        return -1;
  100688:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10068d:	e9 48 02 00 00       	jmp    1008da <debuginfo_eip+0x30c>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  100692:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100695:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100698:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10069b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  10069e:	ff 75 08             	pushl  0x8(%ebp)
  1006a1:	6a 24                	push   $0x24
  1006a3:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1006a6:	50                   	push   %eax
  1006a7:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1006aa:	50                   	push   %eax
  1006ab:	ff 75 f4             	pushl  -0xc(%ebp)
  1006ae:	e8 c4 fd ff ff       	call   100477 <stab_binsearch>
  1006b3:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  1006b6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1006b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006bc:	39 c2                	cmp    %eax,%edx
  1006be:	7f 7c                	jg     10073c <debuginfo_eip+0x16e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  1006c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006c3:	89 c2                	mov    %eax,%edx
  1006c5:	89 d0                	mov    %edx,%eax
  1006c7:	01 c0                	add    %eax,%eax
  1006c9:	01 d0                	add    %edx,%eax
  1006cb:	c1 e0 02             	shl    $0x2,%eax
  1006ce:	89 c2                	mov    %eax,%edx
  1006d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006d3:	01 d0                	add    %edx,%eax
  1006d5:	8b 00                	mov    (%eax),%eax
  1006d7:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1006da:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1006dd:	29 d1                	sub    %edx,%ecx
  1006df:	89 ca                	mov    %ecx,%edx
  1006e1:	39 d0                	cmp    %edx,%eax
  1006e3:	73 22                	jae    100707 <debuginfo_eip+0x139>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  1006e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006e8:	89 c2                	mov    %eax,%edx
  1006ea:	89 d0                	mov    %edx,%eax
  1006ec:	01 c0                	add    %eax,%eax
  1006ee:	01 d0                	add    %edx,%eax
  1006f0:	c1 e0 02             	shl    $0x2,%eax
  1006f3:	89 c2                	mov    %eax,%edx
  1006f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006f8:	01 d0                	add    %edx,%eax
  1006fa:	8b 10                	mov    (%eax),%edx
  1006fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1006ff:	01 c2                	add    %eax,%edx
  100701:	8b 45 0c             	mov    0xc(%ebp),%eax
  100704:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100707:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10070a:	89 c2                	mov    %eax,%edx
  10070c:	89 d0                	mov    %edx,%eax
  10070e:	01 c0                	add    %eax,%eax
  100710:	01 d0                	add    %edx,%eax
  100712:	c1 e0 02             	shl    $0x2,%eax
  100715:	89 c2                	mov    %eax,%edx
  100717:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10071a:	01 d0                	add    %edx,%eax
  10071c:	8b 50 08             	mov    0x8(%eax),%edx
  10071f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100722:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100725:	8b 45 0c             	mov    0xc(%ebp),%eax
  100728:	8b 40 10             	mov    0x10(%eax),%eax
  10072b:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10072e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100731:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100734:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100737:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10073a:	eb 15                	jmp    100751 <debuginfo_eip+0x183>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10073c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10073f:	8b 55 08             	mov    0x8(%ebp),%edx
  100742:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100745:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100748:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  10074b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10074e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  100751:	8b 45 0c             	mov    0xc(%ebp),%eax
  100754:	8b 40 08             	mov    0x8(%eax),%eax
  100757:	83 ec 08             	sub    $0x8,%esp
  10075a:	6a 3a                	push   $0x3a
  10075c:	50                   	push   %eax
  10075d:	e8 36 21 00 00       	call   102898 <strfind>
  100762:	83 c4 10             	add    $0x10,%esp
  100765:	89 c2                	mov    %eax,%edx
  100767:	8b 45 0c             	mov    0xc(%ebp),%eax
  10076a:	8b 40 08             	mov    0x8(%eax),%eax
  10076d:	29 c2                	sub    %eax,%edx
  10076f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100772:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100775:	83 ec 0c             	sub    $0xc,%esp
  100778:	ff 75 08             	pushl  0x8(%ebp)
  10077b:	6a 44                	push   $0x44
  10077d:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100780:	50                   	push   %eax
  100781:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100784:	50                   	push   %eax
  100785:	ff 75 f4             	pushl  -0xc(%ebp)
  100788:	e8 ea fc ff ff       	call   100477 <stab_binsearch>
  10078d:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  100790:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100793:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100796:	39 c2                	cmp    %eax,%edx
  100798:	7f 24                	jg     1007be <debuginfo_eip+0x1f0>
        info->eip_line = stabs[rline].n_desc;
  10079a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10079d:	89 c2                	mov    %eax,%edx
  10079f:	89 d0                	mov    %edx,%eax
  1007a1:	01 c0                	add    %eax,%eax
  1007a3:	01 d0                	add    %edx,%eax
  1007a5:	c1 e0 02             	shl    $0x2,%eax
  1007a8:	89 c2                	mov    %eax,%edx
  1007aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ad:	01 d0                	add    %edx,%eax
  1007af:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1007b3:	0f b7 d0             	movzwl %ax,%edx
  1007b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b9:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1007bc:	eb 13                	jmp    1007d1 <debuginfo_eip+0x203>
        return -1;
  1007be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007c3:	e9 12 01 00 00       	jmp    1008da <debuginfo_eip+0x30c>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  1007c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007cb:	83 e8 01             	sub    $0x1,%eax
  1007ce:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  1007d1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007d7:	39 c2                	cmp    %eax,%edx
  1007d9:	7c 56                	jl     100831 <debuginfo_eip+0x263>
           && stabs[lline].n_type != N_SOL
  1007db:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007de:	89 c2                	mov    %eax,%edx
  1007e0:	89 d0                	mov    %edx,%eax
  1007e2:	01 c0                	add    %eax,%eax
  1007e4:	01 d0                	add    %edx,%eax
  1007e6:	c1 e0 02             	shl    $0x2,%eax
  1007e9:	89 c2                	mov    %eax,%edx
  1007eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ee:	01 d0                	add    %edx,%eax
  1007f0:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1007f4:	3c 84                	cmp    $0x84,%al
  1007f6:	74 39                	je     100831 <debuginfo_eip+0x263>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  1007f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007fb:	89 c2                	mov    %eax,%edx
  1007fd:	89 d0                	mov    %edx,%eax
  1007ff:	01 c0                	add    %eax,%eax
  100801:	01 d0                	add    %edx,%eax
  100803:	c1 e0 02             	shl    $0x2,%eax
  100806:	89 c2                	mov    %eax,%edx
  100808:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10080b:	01 d0                	add    %edx,%eax
  10080d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100811:	3c 64                	cmp    $0x64,%al
  100813:	75 b3                	jne    1007c8 <debuginfo_eip+0x1fa>
  100815:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100818:	89 c2                	mov    %eax,%edx
  10081a:	89 d0                	mov    %edx,%eax
  10081c:	01 c0                	add    %eax,%eax
  10081e:	01 d0                	add    %edx,%eax
  100820:	c1 e0 02             	shl    $0x2,%eax
  100823:	89 c2                	mov    %eax,%edx
  100825:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100828:	01 d0                	add    %edx,%eax
  10082a:	8b 40 08             	mov    0x8(%eax),%eax
  10082d:	85 c0                	test   %eax,%eax
  10082f:	74 97                	je     1007c8 <debuginfo_eip+0x1fa>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100831:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100834:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100837:	39 c2                	cmp    %eax,%edx
  100839:	7c 46                	jl     100881 <debuginfo_eip+0x2b3>
  10083b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10083e:	89 c2                	mov    %eax,%edx
  100840:	89 d0                	mov    %edx,%eax
  100842:	01 c0                	add    %eax,%eax
  100844:	01 d0                	add    %edx,%eax
  100846:	c1 e0 02             	shl    $0x2,%eax
  100849:	89 c2                	mov    %eax,%edx
  10084b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10084e:	01 d0                	add    %edx,%eax
  100850:	8b 00                	mov    (%eax),%eax
  100852:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100855:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100858:	29 d1                	sub    %edx,%ecx
  10085a:	89 ca                	mov    %ecx,%edx
  10085c:	39 d0                	cmp    %edx,%eax
  10085e:	73 21                	jae    100881 <debuginfo_eip+0x2b3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  100860:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100863:	89 c2                	mov    %eax,%edx
  100865:	89 d0                	mov    %edx,%eax
  100867:	01 c0                	add    %eax,%eax
  100869:	01 d0                	add    %edx,%eax
  10086b:	c1 e0 02             	shl    $0x2,%eax
  10086e:	89 c2                	mov    %eax,%edx
  100870:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100873:	01 d0                	add    %edx,%eax
  100875:	8b 10                	mov    (%eax),%edx
  100877:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10087a:	01 c2                	add    %eax,%edx
  10087c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10087f:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100881:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100884:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100887:	39 c2                	cmp    %eax,%edx
  100889:	7d 4a                	jge    1008d5 <debuginfo_eip+0x307>
        for (lline = lfun + 1;
  10088b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10088e:	83 c0 01             	add    $0x1,%eax
  100891:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100894:	eb 18                	jmp    1008ae <debuginfo_eip+0x2e0>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100896:	8b 45 0c             	mov    0xc(%ebp),%eax
  100899:	8b 40 14             	mov    0x14(%eax),%eax
  10089c:	8d 50 01             	lea    0x1(%eax),%edx
  10089f:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008a2:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008a8:	83 c0 01             	add    $0x1,%eax
  1008ab:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1008b4:	39 c2                	cmp    %eax,%edx
  1008b6:	7d 1d                	jge    1008d5 <debuginfo_eip+0x307>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008bb:	89 c2                	mov    %eax,%edx
  1008bd:	89 d0                	mov    %edx,%eax
  1008bf:	01 c0                	add    %eax,%eax
  1008c1:	01 d0                	add    %edx,%eax
  1008c3:	c1 e0 02             	shl    $0x2,%eax
  1008c6:	89 c2                	mov    %eax,%edx
  1008c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008cb:	01 d0                	add    %edx,%eax
  1008cd:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008d1:	3c a0                	cmp    $0xa0,%al
  1008d3:	74 c1                	je     100896 <debuginfo_eip+0x2c8>
        }
    }
    return 0;
  1008d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1008da:	c9                   	leave  
  1008db:	c3                   	ret    

001008dc <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  1008dc:	55                   	push   %ebp
  1008dd:	89 e5                	mov    %esp,%ebp
  1008df:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  1008e2:	83 ec 0c             	sub    $0xc,%esp
  1008e5:	68 c2 32 10 00       	push   $0x1032c2
  1008ea:	e8 4e f9 ff ff       	call   10023d <cprintf>
  1008ef:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  1008f2:	83 ec 08             	sub    $0x8,%esp
  1008f5:	68 00 00 10 00       	push   $0x100000
  1008fa:	68 db 32 10 00       	push   $0x1032db
  1008ff:	e8 39 f9 ff ff       	call   10023d <cprintf>
  100904:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100907:	83 ec 08             	sub    $0x8,%esp
  10090a:	68 bb 31 10 00       	push   $0x1031bb
  10090f:	68 f3 32 10 00       	push   $0x1032f3
  100914:	e8 24 f9 ff ff       	call   10023d <cprintf>
  100919:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  10091c:	83 ec 08             	sub    $0x8,%esp
  10091f:	68 16 ea 10 00       	push   $0x10ea16
  100924:	68 0b 33 10 00       	push   $0x10330b
  100929:	e8 0f f9 ff ff       	call   10023d <cprintf>
  10092e:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100931:	83 ec 08             	sub    $0x8,%esp
  100934:	68 20 fd 10 00       	push   $0x10fd20
  100939:	68 23 33 10 00       	push   $0x103323
  10093e:	e8 fa f8 ff ff       	call   10023d <cprintf>
  100943:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100946:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  10094b:	05 ff 03 00 00       	add    $0x3ff,%eax
  100950:	ba 00 00 10 00       	mov    $0x100000,%edx
  100955:	29 d0                	sub    %edx,%eax
  100957:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10095d:	85 c0                	test   %eax,%eax
  10095f:	0f 48 c2             	cmovs  %edx,%eax
  100962:	c1 f8 0a             	sar    $0xa,%eax
  100965:	83 ec 08             	sub    $0x8,%esp
  100968:	50                   	push   %eax
  100969:	68 3c 33 10 00       	push   $0x10333c
  10096e:	e8 ca f8 ff ff       	call   10023d <cprintf>
  100973:	83 c4 10             	add    $0x10,%esp
}
  100976:	90                   	nop
  100977:	c9                   	leave  
  100978:	c3                   	ret    

00100979 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100979:	55                   	push   %ebp
  10097a:	89 e5                	mov    %esp,%ebp
  10097c:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100982:	83 ec 08             	sub    $0x8,%esp
  100985:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100988:	50                   	push   %eax
  100989:	ff 75 08             	pushl  0x8(%ebp)
  10098c:	e8 3d fc ff ff       	call   1005ce <debuginfo_eip>
  100991:	83 c4 10             	add    $0x10,%esp
  100994:	85 c0                	test   %eax,%eax
  100996:	74 15                	je     1009ad <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100998:	83 ec 08             	sub    $0x8,%esp
  10099b:	ff 75 08             	pushl  0x8(%ebp)
  10099e:	68 66 33 10 00       	push   $0x103366
  1009a3:	e8 95 f8 ff ff       	call   10023d <cprintf>
  1009a8:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  1009ab:	eb 65                	jmp    100a12 <print_debuginfo+0x99>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1009b4:	eb 1c                	jmp    1009d2 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  1009b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1009b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009bc:	01 d0                	add    %edx,%eax
  1009be:	0f b6 00             	movzbl (%eax),%eax
  1009c1:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  1009c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1009ca:	01 ca                	add    %ecx,%edx
  1009cc:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1009d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009d5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1009d8:	7c dc                	jl     1009b6 <print_debuginfo+0x3d>
        fnname[j] = '\0';
  1009da:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  1009e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e3:	01 d0                	add    %edx,%eax
  1009e5:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  1009e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  1009eb:	8b 55 08             	mov    0x8(%ebp),%edx
  1009ee:	89 d1                	mov    %edx,%ecx
  1009f0:	29 c1                	sub    %eax,%ecx
  1009f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1009f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1009f8:	83 ec 0c             	sub    $0xc,%esp
  1009fb:	51                   	push   %ecx
  1009fc:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a02:	51                   	push   %ecx
  100a03:	52                   	push   %edx
  100a04:	50                   	push   %eax
  100a05:	68 82 33 10 00       	push   $0x103382
  100a0a:	e8 2e f8 ff ff       	call   10023d <cprintf>
  100a0f:	83 c4 20             	add    $0x20,%esp
}
  100a12:	90                   	nop
  100a13:	c9                   	leave  
  100a14:	c3                   	ret    

00100a15 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a15:	55                   	push   %ebp
  100a16:	89 e5                	mov    %esp,%ebp
  100a18:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a1b:	8b 45 04             	mov    0x4(%ebp),%eax
  100a1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a24:	c9                   	leave  
  100a25:	c3                   	ret    

00100a26 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a26:	55                   	push   %ebp
  100a27:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100a29:	90                   	nop
  100a2a:	5d                   	pop    %ebp
  100a2b:	c3                   	ret    

00100a2c <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a2c:	55                   	push   %ebp
  100a2d:	89 e5                	mov    %esp,%ebp
  100a2f:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100a32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a39:	eb 0c                	jmp    100a47 <parse+0x1b>
            *buf ++ = '\0';
  100a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  100a3e:	8d 50 01             	lea    0x1(%eax),%edx
  100a41:	89 55 08             	mov    %edx,0x8(%ebp)
  100a44:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a47:	8b 45 08             	mov    0x8(%ebp),%eax
  100a4a:	0f b6 00             	movzbl (%eax),%eax
  100a4d:	84 c0                	test   %al,%al
  100a4f:	74 1e                	je     100a6f <parse+0x43>
  100a51:	8b 45 08             	mov    0x8(%ebp),%eax
  100a54:	0f b6 00             	movzbl (%eax),%eax
  100a57:	0f be c0             	movsbl %al,%eax
  100a5a:	83 ec 08             	sub    $0x8,%esp
  100a5d:	50                   	push   %eax
  100a5e:	68 14 34 10 00       	push   $0x103414
  100a63:	e8 fd 1d 00 00       	call   102865 <strchr>
  100a68:	83 c4 10             	add    $0x10,%esp
  100a6b:	85 c0                	test   %eax,%eax
  100a6d:	75 cc                	jne    100a3b <parse+0xf>
        }
        if (*buf == '\0') {
  100a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  100a72:	0f b6 00             	movzbl (%eax),%eax
  100a75:	84 c0                	test   %al,%al
  100a77:	74 65                	je     100ade <parse+0xb2>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100a79:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100a7d:	75 12                	jne    100a91 <parse+0x65>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100a7f:	83 ec 08             	sub    $0x8,%esp
  100a82:	6a 10                	push   $0x10
  100a84:	68 19 34 10 00       	push   $0x103419
  100a89:	e8 af f7 ff ff       	call   10023d <cprintf>
  100a8e:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a94:	8d 50 01             	lea    0x1(%eax),%edx
  100a97:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100a9a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  100aa4:	01 c2                	add    %eax,%edx
  100aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  100aa9:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100aab:	eb 04                	jmp    100ab1 <parse+0x85>
            buf ++;
  100aad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  100ab4:	0f b6 00             	movzbl (%eax),%eax
  100ab7:	84 c0                	test   %al,%al
  100ab9:	74 8c                	je     100a47 <parse+0x1b>
  100abb:	8b 45 08             	mov    0x8(%ebp),%eax
  100abe:	0f b6 00             	movzbl (%eax),%eax
  100ac1:	0f be c0             	movsbl %al,%eax
  100ac4:	83 ec 08             	sub    $0x8,%esp
  100ac7:	50                   	push   %eax
  100ac8:	68 14 34 10 00       	push   $0x103414
  100acd:	e8 93 1d 00 00       	call   102865 <strchr>
  100ad2:	83 c4 10             	add    $0x10,%esp
  100ad5:	85 c0                	test   %eax,%eax
  100ad7:	74 d4                	je     100aad <parse+0x81>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ad9:	e9 69 ff ff ff       	jmp    100a47 <parse+0x1b>
            break;
  100ade:	90                   	nop
        }
    }
    return argc;
  100adf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100ae2:	c9                   	leave  
  100ae3:	c3                   	ret    

00100ae4 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100ae4:	55                   	push   %ebp
  100ae5:	89 e5                	mov    %esp,%ebp
  100ae7:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100aea:	83 ec 08             	sub    $0x8,%esp
  100aed:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100af0:	50                   	push   %eax
  100af1:	ff 75 08             	pushl  0x8(%ebp)
  100af4:	e8 33 ff ff ff       	call   100a2c <parse>
  100af9:	83 c4 10             	add    $0x10,%esp
  100afc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100aff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b03:	75 0a                	jne    100b0f <runcmd+0x2b>
        return 0;
  100b05:	b8 00 00 00 00       	mov    $0x0,%eax
  100b0a:	e9 83 00 00 00       	jmp    100b92 <runcmd+0xae>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b16:	eb 59                	jmp    100b71 <runcmd+0x8d>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100b18:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100b1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b1e:	89 d0                	mov    %edx,%eax
  100b20:	01 c0                	add    %eax,%eax
  100b22:	01 d0                	add    %edx,%eax
  100b24:	c1 e0 02             	shl    $0x2,%eax
  100b27:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b2c:	8b 00                	mov    (%eax),%eax
  100b2e:	83 ec 08             	sub    $0x8,%esp
  100b31:	51                   	push   %ecx
  100b32:	50                   	push   %eax
  100b33:	e8 8d 1c 00 00       	call   1027c5 <strcmp>
  100b38:	83 c4 10             	add    $0x10,%esp
  100b3b:	85 c0                	test   %eax,%eax
  100b3d:	75 2e                	jne    100b6d <runcmd+0x89>
            return commands[i].func(argc - 1, argv + 1, tf);
  100b3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b42:	89 d0                	mov    %edx,%eax
  100b44:	01 c0                	add    %eax,%eax
  100b46:	01 d0                	add    %edx,%eax
  100b48:	c1 e0 02             	shl    $0x2,%eax
  100b4b:	05 08 e0 10 00       	add    $0x10e008,%eax
  100b50:	8b 10                	mov    (%eax),%edx
  100b52:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b55:	83 c0 04             	add    $0x4,%eax
  100b58:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100b5b:	83 e9 01             	sub    $0x1,%ecx
  100b5e:	83 ec 04             	sub    $0x4,%esp
  100b61:	ff 75 0c             	pushl  0xc(%ebp)
  100b64:	50                   	push   %eax
  100b65:	51                   	push   %ecx
  100b66:	ff d2                	call   *%edx
  100b68:	83 c4 10             	add    $0x10,%esp
  100b6b:	eb 25                	jmp    100b92 <runcmd+0xae>
    for (i = 0; i < NCOMMANDS; i ++) {
  100b6d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b74:	83 f8 02             	cmp    $0x2,%eax
  100b77:	76 9f                	jbe    100b18 <runcmd+0x34>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100b79:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100b7c:	83 ec 08             	sub    $0x8,%esp
  100b7f:	50                   	push   %eax
  100b80:	68 37 34 10 00       	push   $0x103437
  100b85:	e8 b3 f6 ff ff       	call   10023d <cprintf>
  100b8a:	83 c4 10             	add    $0x10,%esp
    return 0;
  100b8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100b92:	c9                   	leave  
  100b93:	c3                   	ret    

00100b94 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100b94:	55                   	push   %ebp
  100b95:	89 e5                	mov    %esp,%ebp
  100b97:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100b9a:	83 ec 0c             	sub    $0xc,%esp
  100b9d:	68 50 34 10 00       	push   $0x103450
  100ba2:	e8 96 f6 ff ff       	call   10023d <cprintf>
  100ba7:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100baa:	83 ec 0c             	sub    $0xc,%esp
  100bad:	68 78 34 10 00       	push   $0x103478
  100bb2:	e8 86 f6 ff ff       	call   10023d <cprintf>
  100bb7:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100bba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100bbe:	74 0e                	je     100bce <kmonitor+0x3a>
        print_trapframe(tf);
  100bc0:	83 ec 0c             	sub    $0xc,%esp
  100bc3:	ff 75 08             	pushl  0x8(%ebp)
  100bc6:	e8 ca 0b 00 00       	call   101795 <print_trapframe>
  100bcb:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100bce:	83 ec 0c             	sub    $0xc,%esp
  100bd1:	68 9d 34 10 00       	push   $0x10349d
  100bd6:	e8 06 f7 ff ff       	call   1002e1 <readline>
  100bdb:	83 c4 10             	add    $0x10,%esp
  100bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100be1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100be5:	74 e7                	je     100bce <kmonitor+0x3a>
            if (runcmd(buf, tf) < 0) {
  100be7:	83 ec 08             	sub    $0x8,%esp
  100bea:	ff 75 08             	pushl  0x8(%ebp)
  100bed:	ff 75 f4             	pushl  -0xc(%ebp)
  100bf0:	e8 ef fe ff ff       	call   100ae4 <runcmd>
  100bf5:	83 c4 10             	add    $0x10,%esp
  100bf8:	85 c0                	test   %eax,%eax
  100bfa:	78 02                	js     100bfe <kmonitor+0x6a>
        if ((buf = readline("K> ")) != NULL) {
  100bfc:	eb d0                	jmp    100bce <kmonitor+0x3a>
                break;
  100bfe:	90                   	nop
            }
        }
    }
}
  100bff:	90                   	nop
  100c00:	c9                   	leave  
  100c01:	c3                   	ret    

00100c02 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c02:	55                   	push   %ebp
  100c03:	89 e5                	mov    %esp,%ebp
  100c05:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c0f:	eb 3c                	jmp    100c4d <mon_help+0x4b>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100c11:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c14:	89 d0                	mov    %edx,%eax
  100c16:	01 c0                	add    %eax,%eax
  100c18:	01 d0                	add    %edx,%eax
  100c1a:	c1 e0 02             	shl    $0x2,%eax
  100c1d:	05 04 e0 10 00       	add    $0x10e004,%eax
  100c22:	8b 08                	mov    (%eax),%ecx
  100c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c27:	89 d0                	mov    %edx,%eax
  100c29:	01 c0                	add    %eax,%eax
  100c2b:	01 d0                	add    %edx,%eax
  100c2d:	c1 e0 02             	shl    $0x2,%eax
  100c30:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c35:	8b 00                	mov    (%eax),%eax
  100c37:	83 ec 04             	sub    $0x4,%esp
  100c3a:	51                   	push   %ecx
  100c3b:	50                   	push   %eax
  100c3c:	68 a1 34 10 00       	push   $0x1034a1
  100c41:	e8 f7 f5 ff ff       	call   10023d <cprintf>
  100c46:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100c49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c50:	83 f8 02             	cmp    $0x2,%eax
  100c53:	76 bc                	jbe    100c11 <mon_help+0xf>
    }
    return 0;
  100c55:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c5a:	c9                   	leave  
  100c5b:	c3                   	ret    

00100c5c <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100c5c:	55                   	push   %ebp
  100c5d:	89 e5                	mov    %esp,%ebp
  100c5f:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100c62:	e8 75 fc ff ff       	call   1008dc <print_kerninfo>
    return 0;
  100c67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c6c:	c9                   	leave  
  100c6d:	c3                   	ret    

00100c6e <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100c6e:	55                   	push   %ebp
  100c6f:	89 e5                	mov    %esp,%ebp
  100c71:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100c74:	e8 ad fd ff ff       	call   100a26 <print_stackframe>
    return 0;
  100c79:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c7e:	c9                   	leave  
  100c7f:	c3                   	ret    

00100c80 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100c80:	55                   	push   %ebp
  100c81:	89 e5                	mov    %esp,%ebp
  100c83:	83 ec 18             	sub    $0x18,%esp
  100c86:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100c8c:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100c90:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100c94:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100c98:	ee                   	out    %al,(%dx)
  100c99:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100c9f:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100ca3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100ca7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100cab:	ee                   	out    %al,(%dx)
  100cac:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100cb2:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100cb6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100cba:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100cbe:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100cbf:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100cc6:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100cc9:	83 ec 0c             	sub    $0xc,%esp
  100ccc:	68 aa 34 10 00       	push   $0x1034aa
  100cd1:	e8 67 f5 ff ff       	call   10023d <cprintf>
  100cd6:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100cd9:	83 ec 0c             	sub    $0xc,%esp
  100cdc:	6a 00                	push   $0x0
  100cde:	e8 d2 08 00 00       	call   1015b5 <pic_enable>
  100ce3:	83 c4 10             	add    $0x10,%esp
}
  100ce6:	90                   	nop
  100ce7:	c9                   	leave  
  100ce8:	c3                   	ret    

00100ce9 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100ce9:	55                   	push   %ebp
  100cea:	89 e5                	mov    %esp,%ebp
  100cec:	83 ec 10             	sub    $0x10,%esp
  100cef:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100cf5:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100cf9:	89 c2                	mov    %eax,%edx
  100cfb:	ec                   	in     (%dx),%al
  100cfc:	88 45 f1             	mov    %al,-0xf(%ebp)
  100cff:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100d05:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100d09:	89 c2                	mov    %eax,%edx
  100d0b:	ec                   	in     (%dx),%al
  100d0c:	88 45 f5             	mov    %al,-0xb(%ebp)
  100d0f:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100d15:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100d19:	89 c2                	mov    %eax,%edx
  100d1b:	ec                   	in     (%dx),%al
  100d1c:	88 45 f9             	mov    %al,-0x7(%ebp)
  100d1f:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100d25:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100d29:	89 c2                	mov    %eax,%edx
  100d2b:	ec                   	in     (%dx),%al
  100d2c:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100d2f:	90                   	nop
  100d30:	c9                   	leave  
  100d31:	c3                   	ret    

00100d32 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100d32:	55                   	push   %ebp
  100d33:	89 e5                	mov    %esp,%ebp
  100d35:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100d38:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100d3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d42:	0f b7 00             	movzwl (%eax),%eax
  100d45:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100d49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d4c:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100d51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d54:	0f b7 00             	movzwl (%eax),%eax
  100d57:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100d5b:	74 12                	je     100d6f <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100d5d:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100d64:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100d6b:	b4 03 
  100d6d:	eb 13                	jmp    100d82 <cga_init+0x50>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100d6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d72:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100d76:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100d79:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100d80:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100d82:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100d89:	0f b7 c0             	movzwl %ax,%eax
  100d8c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100d90:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d94:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100d98:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100d9c:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100d9d:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100da4:	83 c0 01             	add    $0x1,%eax
  100da7:	0f b7 c0             	movzwl %ax,%eax
  100daa:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100dae:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100db2:	89 c2                	mov    %eax,%edx
  100db4:	ec                   	in     (%dx),%al
  100db5:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100db8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100dbc:	0f b6 c0             	movzbl %al,%eax
  100dbf:	c1 e0 08             	shl    $0x8,%eax
  100dc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100dc5:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100dcc:	0f b7 c0             	movzwl %ax,%eax
  100dcf:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100dd3:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100ddb:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100ddf:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100de0:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100de7:	83 c0 01             	add    $0x1,%eax
  100dea:	0f b7 c0             	movzwl %ax,%eax
  100ded:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100df1:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100df5:	89 c2                	mov    %eax,%edx
  100df7:	ec                   	in     (%dx),%al
  100df8:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100dfb:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dff:	0f b6 c0             	movzbl %al,%eax
  100e02:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100e05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e08:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100e10:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100e16:	90                   	nop
  100e17:	c9                   	leave  
  100e18:	c3                   	ret    

00100e19 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100e19:	55                   	push   %ebp
  100e1a:	89 e5                	mov    %esp,%ebp
  100e1c:	83 ec 38             	sub    $0x38,%esp
  100e1f:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100e25:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e29:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100e2d:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100e31:	ee                   	out    %al,(%dx)
  100e32:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100e38:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  100e3c:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100e40:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100e44:	ee                   	out    %al,(%dx)
  100e45:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100e4b:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  100e4f:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100e53:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100e57:	ee                   	out    %al,(%dx)
  100e58:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100e5e:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  100e62:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100e66:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100e6a:	ee                   	out    %al,(%dx)
  100e6b:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100e71:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  100e75:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100e79:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100e7d:	ee                   	out    %al,(%dx)
  100e7e:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100e84:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  100e88:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e8c:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100e90:	ee                   	out    %al,(%dx)
  100e91:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100e97:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  100e9b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100e9f:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ea3:	ee                   	out    %al,(%dx)
  100ea4:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100eaa:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100eae:	89 c2                	mov    %eax,%edx
  100eb0:	ec                   	in     (%dx),%al
  100eb1:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100eb4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100eb8:	3c ff                	cmp    $0xff,%al
  100eba:	0f 95 c0             	setne  %al
  100ebd:	0f b6 c0             	movzbl %al,%eax
  100ec0:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100ec5:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ecb:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100ecf:	89 c2                	mov    %eax,%edx
  100ed1:	ec                   	in     (%dx),%al
  100ed2:	88 45 f1             	mov    %al,-0xf(%ebp)
  100ed5:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  100edb:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100edf:	89 c2                	mov    %eax,%edx
  100ee1:	ec                   	in     (%dx),%al
  100ee2:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100ee5:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100eea:	85 c0                	test   %eax,%eax
  100eec:	74 0d                	je     100efb <serial_init+0xe2>
        pic_enable(IRQ_COM1);
  100eee:	83 ec 0c             	sub    $0xc,%esp
  100ef1:	6a 04                	push   $0x4
  100ef3:	e8 bd 06 00 00       	call   1015b5 <pic_enable>
  100ef8:	83 c4 10             	add    $0x10,%esp
    }
}
  100efb:	90                   	nop
  100efc:	c9                   	leave  
  100efd:	c3                   	ret    

00100efe <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100efe:	55                   	push   %ebp
  100eff:	89 e5                	mov    %esp,%ebp
  100f01:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100f0b:	eb 09                	jmp    100f16 <lpt_putc_sub+0x18>
        delay();
  100f0d:	e8 d7 fd ff ff       	call   100ce9 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f12:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100f16:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  100f1c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100f20:	89 c2                	mov    %eax,%edx
  100f22:	ec                   	in     (%dx),%al
  100f23:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  100f26:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  100f2a:	84 c0                	test   %al,%al
  100f2c:	78 09                	js     100f37 <lpt_putc_sub+0x39>
  100f2e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  100f35:	7e d6                	jle    100f0d <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
  100f37:	8b 45 08             	mov    0x8(%ebp),%eax
  100f3a:	0f b6 c0             	movzbl %al,%eax
  100f3d:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  100f43:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f46:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f4a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f4e:	ee                   	out    %al,(%dx)
  100f4f:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  100f55:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  100f59:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f5d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f61:	ee                   	out    %al,(%dx)
  100f62:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  100f68:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  100f6c:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f70:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f74:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  100f75:	90                   	nop
  100f76:	c9                   	leave  
  100f77:	c3                   	ret    

00100f78 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  100f78:	55                   	push   %ebp
  100f79:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  100f7b:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  100f7f:	74 0d                	je     100f8e <lpt_putc+0x16>
        lpt_putc_sub(c);
  100f81:	ff 75 08             	pushl  0x8(%ebp)
  100f84:	e8 75 ff ff ff       	call   100efe <lpt_putc_sub>
  100f89:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  100f8c:	eb 1e                	jmp    100fac <lpt_putc+0x34>
        lpt_putc_sub('\b');
  100f8e:	6a 08                	push   $0x8
  100f90:	e8 69 ff ff ff       	call   100efe <lpt_putc_sub>
  100f95:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  100f98:	6a 20                	push   $0x20
  100f9a:	e8 5f ff ff ff       	call   100efe <lpt_putc_sub>
  100f9f:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  100fa2:	6a 08                	push   $0x8
  100fa4:	e8 55 ff ff ff       	call   100efe <lpt_putc_sub>
  100fa9:	83 c4 04             	add    $0x4,%esp
}
  100fac:	90                   	nop
  100fad:	c9                   	leave  
  100fae:	c3                   	ret    

00100faf <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  100faf:	55                   	push   %ebp
  100fb0:	89 e5                	mov    %esp,%ebp
  100fb2:	53                   	push   %ebx
  100fb3:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  100fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  100fb9:	b0 00                	mov    $0x0,%al
  100fbb:	85 c0                	test   %eax,%eax
  100fbd:	75 07                	jne    100fc6 <cga_putc+0x17>
        c |= 0x0700;
  100fbf:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  100fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  100fc9:	0f b6 c0             	movzbl %al,%eax
  100fcc:	83 f8 0a             	cmp    $0xa,%eax
  100fcf:	74 52                	je     101023 <cga_putc+0x74>
  100fd1:	83 f8 0d             	cmp    $0xd,%eax
  100fd4:	74 5d                	je     101033 <cga_putc+0x84>
  100fd6:	83 f8 08             	cmp    $0x8,%eax
  100fd9:	0f 85 8e 00 00 00    	jne    10106d <cga_putc+0xbe>
    case '\b':
        if (crt_pos > 0) {
  100fdf:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  100fe6:	66 85 c0             	test   %ax,%ax
  100fe9:	0f 84 a4 00 00 00    	je     101093 <cga_putc+0xe4>
            crt_pos --;
  100fef:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  100ff6:	83 e8 01             	sub    $0x1,%eax
  100ff9:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  100fff:	8b 45 08             	mov    0x8(%ebp),%eax
  101002:	b0 00                	mov    $0x0,%al
  101004:	83 c8 20             	or     $0x20,%eax
  101007:	89 c1                	mov    %eax,%ecx
  101009:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10100e:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  101015:	0f b7 d2             	movzwl %dx,%edx
  101018:	01 d2                	add    %edx,%edx
  10101a:	01 d0                	add    %edx,%eax
  10101c:	89 ca                	mov    %ecx,%edx
  10101e:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101021:	eb 70                	jmp    101093 <cga_putc+0xe4>
    case '\n':
        crt_pos += CRT_COLS;
  101023:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10102a:	83 c0 50             	add    $0x50,%eax
  10102d:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101033:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  10103a:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  101041:	0f b7 c1             	movzwl %cx,%eax
  101044:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10104a:	c1 e8 10             	shr    $0x10,%eax
  10104d:	89 c2                	mov    %eax,%edx
  10104f:	66 c1 ea 06          	shr    $0x6,%dx
  101053:	89 d0                	mov    %edx,%eax
  101055:	c1 e0 02             	shl    $0x2,%eax
  101058:	01 d0                	add    %edx,%eax
  10105a:	c1 e0 04             	shl    $0x4,%eax
  10105d:	29 c1                	sub    %eax,%ecx
  10105f:	89 ca                	mov    %ecx,%edx
  101061:	89 d8                	mov    %ebx,%eax
  101063:	29 d0                	sub    %edx,%eax
  101065:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  10106b:	eb 27                	jmp    101094 <cga_putc+0xe5>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10106d:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101073:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10107a:	8d 50 01             	lea    0x1(%eax),%edx
  10107d:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101084:	0f b7 c0             	movzwl %ax,%eax
  101087:	01 c0                	add    %eax,%eax
  101089:	01 c8                	add    %ecx,%eax
  10108b:	8b 55 08             	mov    0x8(%ebp),%edx
  10108e:	66 89 10             	mov    %dx,(%eax)
        break;
  101091:	eb 01                	jmp    101094 <cga_putc+0xe5>
        break;
  101093:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101094:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10109b:	66 3d cf 07          	cmp    $0x7cf,%ax
  10109f:	76 59                	jbe    1010fa <cga_putc+0x14b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1010a1:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010a6:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1010ac:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010b1:	83 ec 04             	sub    $0x4,%esp
  1010b4:	68 00 0f 00 00       	push   $0xf00
  1010b9:	52                   	push   %edx
  1010ba:	50                   	push   %eax
  1010bb:	e8 a4 19 00 00       	call   102a64 <memmove>
  1010c0:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1010c3:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1010ca:	eb 15                	jmp    1010e1 <cga_putc+0x132>
            crt_buf[i] = 0x0700 | ' ';
  1010cc:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1010d4:	01 d2                	add    %edx,%edx
  1010d6:	01 d0                	add    %edx,%eax
  1010d8:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1010dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1010e1:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1010e8:	7e e2                	jle    1010cc <cga_putc+0x11d>
        }
        crt_pos -= CRT_COLS;
  1010ea:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010f1:	83 e8 50             	sub    $0x50,%eax
  1010f4:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1010fa:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101101:	0f b7 c0             	movzwl %ax,%eax
  101104:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101108:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  10110c:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101110:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101114:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101115:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10111c:	66 c1 e8 08          	shr    $0x8,%ax
  101120:	0f b6 c0             	movzbl %al,%eax
  101123:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10112a:	83 c2 01             	add    $0x1,%edx
  10112d:	0f b7 d2             	movzwl %dx,%edx
  101130:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101134:	88 45 e9             	mov    %al,-0x17(%ebp)
  101137:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10113b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10113f:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101140:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101147:	0f b7 c0             	movzwl %ax,%eax
  10114a:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  10114e:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  101152:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101156:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10115a:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10115b:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101162:	0f b6 c0             	movzbl %al,%eax
  101165:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10116c:	83 c2 01             	add    $0x1,%edx
  10116f:	0f b7 d2             	movzwl %dx,%edx
  101172:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101176:	88 45 f1             	mov    %al,-0xf(%ebp)
  101179:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10117d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101181:	ee                   	out    %al,(%dx)
}
  101182:	90                   	nop
  101183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101186:	c9                   	leave  
  101187:	c3                   	ret    

00101188 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101188:	55                   	push   %ebp
  101189:	89 e5                	mov    %esp,%ebp
  10118b:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10118e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101195:	eb 09                	jmp    1011a0 <serial_putc_sub+0x18>
        delay();
  101197:	e8 4d fb ff ff       	call   100ce9 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10119c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1011a0:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011a6:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1011aa:	89 c2                	mov    %eax,%edx
  1011ac:	ec                   	in     (%dx),%al
  1011ad:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1011b0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1011b4:	0f b6 c0             	movzbl %al,%eax
  1011b7:	83 e0 20             	and    $0x20,%eax
  1011ba:	85 c0                	test   %eax,%eax
  1011bc:	75 09                	jne    1011c7 <serial_putc_sub+0x3f>
  1011be:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1011c5:	7e d0                	jle    101197 <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
  1011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1011ca:	0f b6 c0             	movzbl %al,%eax
  1011cd:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011d3:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1011d6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1011da:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1011de:	ee                   	out    %al,(%dx)
}
  1011df:	90                   	nop
  1011e0:	c9                   	leave  
  1011e1:	c3                   	ret    

001011e2 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1011e2:	55                   	push   %ebp
  1011e3:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  1011e5:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1011e9:	74 0d                	je     1011f8 <serial_putc+0x16>
        serial_putc_sub(c);
  1011eb:	ff 75 08             	pushl  0x8(%ebp)
  1011ee:	e8 95 ff ff ff       	call   101188 <serial_putc_sub>
  1011f3:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  1011f6:	eb 1e                	jmp    101216 <serial_putc+0x34>
        serial_putc_sub('\b');
  1011f8:	6a 08                	push   $0x8
  1011fa:	e8 89 ff ff ff       	call   101188 <serial_putc_sub>
  1011ff:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101202:	6a 20                	push   $0x20
  101204:	e8 7f ff ff ff       	call   101188 <serial_putc_sub>
  101209:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  10120c:	6a 08                	push   $0x8
  10120e:	e8 75 ff ff ff       	call   101188 <serial_putc_sub>
  101213:	83 c4 04             	add    $0x4,%esp
}
  101216:	90                   	nop
  101217:	c9                   	leave  
  101218:	c3                   	ret    

00101219 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101219:	55                   	push   %ebp
  10121a:	89 e5                	mov    %esp,%ebp
  10121c:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  10121f:	eb 33                	jmp    101254 <cons_intr+0x3b>
        if (c != 0) {
  101221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101225:	74 2d                	je     101254 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  101227:	a1 84 f0 10 00       	mov    0x10f084,%eax
  10122c:	8d 50 01             	lea    0x1(%eax),%edx
  10122f:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  101235:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101238:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  10123e:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101243:	3d 00 02 00 00       	cmp    $0x200,%eax
  101248:	75 0a                	jne    101254 <cons_intr+0x3b>
                cons.wpos = 0;
  10124a:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  101251:	00 00 00 
    while ((c = (*proc)()) != -1) {
  101254:	8b 45 08             	mov    0x8(%ebp),%eax
  101257:	ff d0                	call   *%eax
  101259:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10125c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101260:	75 bf                	jne    101221 <cons_intr+0x8>
            }
        }
    }
}
  101262:	90                   	nop
  101263:	c9                   	leave  
  101264:	c3                   	ret    

00101265 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101265:	55                   	push   %ebp
  101266:	89 e5                	mov    %esp,%ebp
  101268:	83 ec 10             	sub    $0x10,%esp
  10126b:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101271:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101275:	89 c2                	mov    %eax,%edx
  101277:	ec                   	in     (%dx),%al
  101278:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10127b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10127f:	0f b6 c0             	movzbl %al,%eax
  101282:	83 e0 01             	and    $0x1,%eax
  101285:	85 c0                	test   %eax,%eax
  101287:	75 07                	jne    101290 <serial_proc_data+0x2b>
        return -1;
  101289:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10128e:	eb 2a                	jmp    1012ba <serial_proc_data+0x55>
  101290:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101296:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10129a:	89 c2                	mov    %eax,%edx
  10129c:	ec                   	in     (%dx),%al
  10129d:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1012a0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1012a4:	0f b6 c0             	movzbl %al,%eax
  1012a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1012aa:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1012ae:	75 07                	jne    1012b7 <serial_proc_data+0x52>
        c = '\b';
  1012b0:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  1012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1012ba:	c9                   	leave  
  1012bb:	c3                   	ret    

001012bc <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1012bc:	55                   	push   %ebp
  1012bd:	89 e5                	mov    %esp,%ebp
  1012bf:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  1012c2:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1012c7:	85 c0                	test   %eax,%eax
  1012c9:	74 10                	je     1012db <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  1012cb:	83 ec 0c             	sub    $0xc,%esp
  1012ce:	68 65 12 10 00       	push   $0x101265
  1012d3:	e8 41 ff ff ff       	call   101219 <cons_intr>
  1012d8:	83 c4 10             	add    $0x10,%esp
    }
}
  1012db:	90                   	nop
  1012dc:	c9                   	leave  
  1012dd:	c3                   	ret    

001012de <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1012de:	55                   	push   %ebp
  1012df:	89 e5                	mov    %esp,%ebp
  1012e1:	83 ec 28             	sub    $0x28,%esp
  1012e4:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012ea:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1012ee:	89 c2                	mov    %eax,%edx
  1012f0:	ec                   	in     (%dx),%al
  1012f1:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1012f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1012f8:	0f b6 c0             	movzbl %al,%eax
  1012fb:	83 e0 01             	and    $0x1,%eax
  1012fe:	85 c0                	test   %eax,%eax
  101300:	75 0a                	jne    10130c <kbd_proc_data+0x2e>
        return -1;
  101302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101307:	e9 5d 01 00 00       	jmp    101469 <kbd_proc_data+0x18b>
  10130c:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101312:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101316:	89 c2                	mov    %eax,%edx
  101318:	ec                   	in     (%dx),%al
  101319:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10131c:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101320:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101323:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101327:	75 17                	jne    101340 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  101329:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10132e:	83 c8 40             	or     $0x40,%eax
  101331:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101336:	b8 00 00 00 00       	mov    $0x0,%eax
  10133b:	e9 29 01 00 00       	jmp    101469 <kbd_proc_data+0x18b>
    } else if (data & 0x80) {
  101340:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101344:	84 c0                	test   %al,%al
  101346:	79 47                	jns    10138f <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101348:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10134d:	83 e0 40             	and    $0x40,%eax
  101350:	85 c0                	test   %eax,%eax
  101352:	75 09                	jne    10135d <kbd_proc_data+0x7f>
  101354:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101358:	83 e0 7f             	and    $0x7f,%eax
  10135b:	eb 04                	jmp    101361 <kbd_proc_data+0x83>
  10135d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101361:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101364:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101368:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10136f:	83 c8 40             	or     $0x40,%eax
  101372:	0f b6 c0             	movzbl %al,%eax
  101375:	f7 d0                	not    %eax
  101377:	89 c2                	mov    %eax,%edx
  101379:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10137e:	21 d0                	and    %edx,%eax
  101380:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101385:	b8 00 00 00 00       	mov    $0x0,%eax
  10138a:	e9 da 00 00 00       	jmp    101469 <kbd_proc_data+0x18b>
    } else if (shift & E0ESC) {
  10138f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101394:	83 e0 40             	and    $0x40,%eax
  101397:	85 c0                	test   %eax,%eax
  101399:	74 11                	je     1013ac <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10139b:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10139f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013a4:	83 e0 bf             	and    $0xffffffbf,%eax
  1013a7:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  1013ac:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013b0:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1013b7:	0f b6 d0             	movzbl %al,%edx
  1013ba:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013bf:	09 d0                	or     %edx,%eax
  1013c1:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1013c6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013ca:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1013d1:	0f b6 d0             	movzbl %al,%edx
  1013d4:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013d9:	31 d0                	xor    %edx,%eax
  1013db:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1013e0:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013e5:	83 e0 03             	and    $0x3,%eax
  1013e8:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1013ef:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013f3:	01 d0                	add    %edx,%eax
  1013f5:	0f b6 00             	movzbl (%eax),%eax
  1013f8:	0f b6 c0             	movzbl %al,%eax
  1013fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1013fe:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101403:	83 e0 08             	and    $0x8,%eax
  101406:	85 c0                	test   %eax,%eax
  101408:	74 22                	je     10142c <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  10140a:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10140e:	7e 0c                	jle    10141c <kbd_proc_data+0x13e>
  101410:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101414:	7f 06                	jg     10141c <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  101416:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10141a:	eb 10                	jmp    10142c <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  10141c:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101420:	7e 0a                	jle    10142c <kbd_proc_data+0x14e>
  101422:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101426:	7f 04                	jg     10142c <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  101428:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10142c:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101431:	f7 d0                	not    %eax
  101433:	83 e0 06             	and    $0x6,%eax
  101436:	85 c0                	test   %eax,%eax
  101438:	75 2c                	jne    101466 <kbd_proc_data+0x188>
  10143a:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101441:	75 23                	jne    101466 <kbd_proc_data+0x188>
        cprintf("Rebooting!\n");
  101443:	83 ec 0c             	sub    $0xc,%esp
  101446:	68 c5 34 10 00       	push   $0x1034c5
  10144b:	e8 ed ed ff ff       	call   10023d <cprintf>
  101450:	83 c4 10             	add    $0x10,%esp
  101453:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101459:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10145d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101461:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101465:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101466:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101469:	c9                   	leave  
  10146a:	c3                   	ret    

0010146b <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10146b:	55                   	push   %ebp
  10146c:	89 e5                	mov    %esp,%ebp
  10146e:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  101471:	83 ec 0c             	sub    $0xc,%esp
  101474:	68 de 12 10 00       	push   $0x1012de
  101479:	e8 9b fd ff ff       	call   101219 <cons_intr>
  10147e:	83 c4 10             	add    $0x10,%esp
}
  101481:	90                   	nop
  101482:	c9                   	leave  
  101483:	c3                   	ret    

00101484 <kbd_init>:

static void
kbd_init(void) {
  101484:	55                   	push   %ebp
  101485:	89 e5                	mov    %esp,%ebp
  101487:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  10148a:	e8 dc ff ff ff       	call   10146b <kbd_intr>
    pic_enable(IRQ_KBD);
  10148f:	83 ec 0c             	sub    $0xc,%esp
  101492:	6a 01                	push   $0x1
  101494:	e8 1c 01 00 00       	call   1015b5 <pic_enable>
  101499:	83 c4 10             	add    $0x10,%esp
}
  10149c:	90                   	nop
  10149d:	c9                   	leave  
  10149e:	c3                   	ret    

0010149f <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10149f:	55                   	push   %ebp
  1014a0:	89 e5                	mov    %esp,%ebp
  1014a2:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  1014a5:	e8 88 f8 ff ff       	call   100d32 <cga_init>
    serial_init();
  1014aa:	e8 6a f9 ff ff       	call   100e19 <serial_init>
    kbd_init();
  1014af:	e8 d0 ff ff ff       	call   101484 <kbd_init>
    if (!serial_exists) {
  1014b4:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1014b9:	85 c0                	test   %eax,%eax
  1014bb:	75 10                	jne    1014cd <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  1014bd:	83 ec 0c             	sub    $0xc,%esp
  1014c0:	68 d1 34 10 00       	push   $0x1034d1
  1014c5:	e8 73 ed ff ff       	call   10023d <cprintf>
  1014ca:	83 c4 10             	add    $0x10,%esp
    }
}
  1014cd:	90                   	nop
  1014ce:	c9                   	leave  
  1014cf:	c3                   	ret    

001014d0 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1014d0:	55                   	push   %ebp
  1014d1:	89 e5                	mov    %esp,%ebp
  1014d3:	83 ec 08             	sub    $0x8,%esp
    lpt_putc(c);
  1014d6:	ff 75 08             	pushl  0x8(%ebp)
  1014d9:	e8 9a fa ff ff       	call   100f78 <lpt_putc>
  1014de:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  1014e1:	83 ec 0c             	sub    $0xc,%esp
  1014e4:	ff 75 08             	pushl  0x8(%ebp)
  1014e7:	e8 c3 fa ff ff       	call   100faf <cga_putc>
  1014ec:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1014ef:	83 ec 0c             	sub    $0xc,%esp
  1014f2:	ff 75 08             	pushl  0x8(%ebp)
  1014f5:	e8 e8 fc ff ff       	call   1011e2 <serial_putc>
  1014fa:	83 c4 10             	add    $0x10,%esp
}
  1014fd:	90                   	nop
  1014fe:	c9                   	leave  
  1014ff:	c3                   	ret    

00101500 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101500:	55                   	push   %ebp
  101501:	89 e5                	mov    %esp,%ebp
  101503:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  101506:	e8 b1 fd ff ff       	call   1012bc <serial_intr>
    kbd_intr();
  10150b:	e8 5b ff ff ff       	call   10146b <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101510:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  101516:	a1 84 f0 10 00       	mov    0x10f084,%eax
  10151b:	39 c2                	cmp    %eax,%edx
  10151d:	74 36                	je     101555 <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  10151f:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101524:	8d 50 01             	lea    0x1(%eax),%edx
  101527:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  10152d:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  101534:	0f b6 c0             	movzbl %al,%eax
  101537:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  10153a:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10153f:	3d 00 02 00 00       	cmp    $0x200,%eax
  101544:	75 0a                	jne    101550 <cons_getc+0x50>
            cons.rpos = 0;
  101546:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  10154d:	00 00 00 
        }
        return c;
  101550:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101553:	eb 05                	jmp    10155a <cons_getc+0x5a>
    }
    return 0;
  101555:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10155a:	c9                   	leave  
  10155b:	c3                   	ret    

0010155c <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  10155c:	55                   	push   %ebp
  10155d:	89 e5                	mov    %esp,%ebp
  10155f:	83 ec 14             	sub    $0x14,%esp
  101562:	8b 45 08             	mov    0x8(%ebp),%eax
  101565:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101569:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10156d:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101573:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  101578:	85 c0                	test   %eax,%eax
  10157a:	74 36                	je     1015b2 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  10157c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101580:	0f b6 c0             	movzbl %al,%eax
  101583:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101589:	88 45 f9             	mov    %al,-0x7(%ebp)
  10158c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101590:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101594:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101595:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101599:	66 c1 e8 08          	shr    $0x8,%ax
  10159d:	0f b6 c0             	movzbl %al,%eax
  1015a0:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  1015a6:	88 45 fd             	mov    %al,-0x3(%ebp)
  1015a9:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1015ad:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1015b1:	ee                   	out    %al,(%dx)
    }
}
  1015b2:	90                   	nop
  1015b3:	c9                   	leave  
  1015b4:	c3                   	ret    

001015b5 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1015b5:	55                   	push   %ebp
  1015b6:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  1015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1015bb:	ba 01 00 00 00       	mov    $0x1,%edx
  1015c0:	89 c1                	mov    %eax,%ecx
  1015c2:	d3 e2                	shl    %cl,%edx
  1015c4:	89 d0                	mov    %edx,%eax
  1015c6:	f7 d0                	not    %eax
  1015c8:	89 c2                	mov    %eax,%edx
  1015ca:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1015d1:	21 d0                	and    %edx,%eax
  1015d3:	0f b7 c0             	movzwl %ax,%eax
  1015d6:	50                   	push   %eax
  1015d7:	e8 80 ff ff ff       	call   10155c <pic_setmask>
  1015dc:	83 c4 04             	add    $0x4,%esp
}
  1015df:	90                   	nop
  1015e0:	c9                   	leave  
  1015e1:	c3                   	ret    

001015e2 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1015e2:	55                   	push   %ebp
  1015e3:	89 e5                	mov    %esp,%ebp
  1015e5:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
  1015e8:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1015ef:	00 00 00 
  1015f2:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1015f8:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  1015fc:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101600:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101604:	ee                   	out    %al,(%dx)
  101605:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  10160b:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  10160f:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101613:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101617:	ee                   	out    %al,(%dx)
  101618:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  10161e:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  101622:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101626:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  10162a:	ee                   	out    %al,(%dx)
  10162b:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101631:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  101635:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101639:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  10163d:	ee                   	out    %al,(%dx)
  10163e:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101644:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101648:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10164c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101650:	ee                   	out    %al,(%dx)
  101651:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101657:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  10165b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10165f:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101663:	ee                   	out    %al,(%dx)
  101664:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  10166a:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  10166e:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101672:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101676:	ee                   	out    %al,(%dx)
  101677:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10167d:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101681:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101685:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101689:	ee                   	out    %al,(%dx)
  10168a:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101690:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101694:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101698:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10169c:	ee                   	out    %al,(%dx)
  10169d:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  1016a3:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  1016a7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1016ab:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1016af:	ee                   	out    %al,(%dx)
  1016b0:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  1016b6:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  1016ba:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1016be:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1016c2:	ee                   	out    %al,(%dx)
  1016c3:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  1016c9:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  1016cd:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1016d1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1016d5:	ee                   	out    %al,(%dx)
  1016d6:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  1016dc:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  1016e0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016e4:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016e8:	ee                   	out    %al,(%dx)
  1016e9:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1016ef:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  1016f3:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1016f7:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016fb:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1016fc:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101703:	66 83 f8 ff          	cmp    $0xffff,%ax
  101707:	74 13                	je     10171c <pic_init+0x13a>
        pic_setmask(irq_mask);
  101709:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101710:	0f b7 c0             	movzwl %ax,%eax
  101713:	50                   	push   %eax
  101714:	e8 43 fe ff ff       	call   10155c <pic_setmask>
  101719:	83 c4 04             	add    $0x4,%esp
    }
}
  10171c:	90                   	nop
  10171d:	c9                   	leave  
  10171e:	c3                   	ret    

0010171f <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  10171f:	55                   	push   %ebp
  101720:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101722:	fb                   	sti    
    sti();
}
  101723:	90                   	nop
  101724:	5d                   	pop    %ebp
  101725:	c3                   	ret    

00101726 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101726:	55                   	push   %ebp
  101727:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  101729:	fa                   	cli    
    cli();
}
  10172a:	90                   	nop
  10172b:	5d                   	pop    %ebp
  10172c:	c3                   	ret    

0010172d <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  10172d:	55                   	push   %ebp
  10172e:	89 e5                	mov    %esp,%ebp
  101730:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101733:	83 ec 08             	sub    $0x8,%esp
  101736:	6a 64                	push   $0x64
  101738:	68 00 35 10 00       	push   $0x103500
  10173d:	e8 fb ea ff ff       	call   10023d <cprintf>
  101742:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101745:	90                   	nop
  101746:	c9                   	leave  
  101747:	c3                   	ret    

00101748 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101748:	55                   	push   %ebp
  101749:	89 e5                	mov    %esp,%ebp
      *     Can you see idt[256] in this file? Yes, it's IDT! you can use SETGATE macro to setup each item of IDT
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
}
  10174b:	90                   	nop
  10174c:	5d                   	pop    %ebp
  10174d:	c3                   	ret    

0010174e <trapname>:

static const char *
trapname(int trapno) {
  10174e:	55                   	push   %ebp
  10174f:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101751:	8b 45 08             	mov    0x8(%ebp),%eax
  101754:	83 f8 13             	cmp    $0x13,%eax
  101757:	77 0c                	ja     101765 <trapname+0x17>
        return excnames[trapno];
  101759:	8b 45 08             	mov    0x8(%ebp),%eax
  10175c:	8b 04 85 60 38 10 00 	mov    0x103860(,%eax,4),%eax
  101763:	eb 18                	jmp    10177d <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101765:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101769:	7e 0d                	jle    101778 <trapname+0x2a>
  10176b:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  10176f:	7f 07                	jg     101778 <trapname+0x2a>
        return "Hardware Interrupt";
  101771:	b8 0a 35 10 00       	mov    $0x10350a,%eax
  101776:	eb 05                	jmp    10177d <trapname+0x2f>
    }
    return "(unknown trap)";
  101778:	b8 1d 35 10 00       	mov    $0x10351d,%eax
}
  10177d:	5d                   	pop    %ebp
  10177e:	c3                   	ret    

0010177f <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  10177f:	55                   	push   %ebp
  101780:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101782:	8b 45 08             	mov    0x8(%ebp),%eax
  101785:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101789:	66 83 f8 08          	cmp    $0x8,%ax
  10178d:	0f 94 c0             	sete   %al
  101790:	0f b6 c0             	movzbl %al,%eax
}
  101793:	5d                   	pop    %ebp
  101794:	c3                   	ret    

00101795 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101795:	55                   	push   %ebp
  101796:	89 e5                	mov    %esp,%ebp
  101798:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  10179b:	83 ec 08             	sub    $0x8,%esp
  10179e:	ff 75 08             	pushl  0x8(%ebp)
  1017a1:	68 5e 35 10 00       	push   $0x10355e
  1017a6:	e8 92 ea ff ff       	call   10023d <cprintf>
  1017ab:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  1017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  1017b1:	83 ec 0c             	sub    $0xc,%esp
  1017b4:	50                   	push   %eax
  1017b5:	e8 b6 01 00 00       	call   101970 <print_regs>
  1017ba:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  1017bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1017c0:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  1017c4:	0f b7 c0             	movzwl %ax,%eax
  1017c7:	83 ec 08             	sub    $0x8,%esp
  1017ca:	50                   	push   %eax
  1017cb:	68 6f 35 10 00       	push   $0x10356f
  1017d0:	e8 68 ea ff ff       	call   10023d <cprintf>
  1017d5:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  1017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1017db:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  1017df:	0f b7 c0             	movzwl %ax,%eax
  1017e2:	83 ec 08             	sub    $0x8,%esp
  1017e5:	50                   	push   %eax
  1017e6:	68 82 35 10 00       	push   $0x103582
  1017eb:	e8 4d ea ff ff       	call   10023d <cprintf>
  1017f0:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  1017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1017f6:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  1017fa:	0f b7 c0             	movzwl %ax,%eax
  1017fd:	83 ec 08             	sub    $0x8,%esp
  101800:	50                   	push   %eax
  101801:	68 95 35 10 00       	push   $0x103595
  101806:	e8 32 ea ff ff       	call   10023d <cprintf>
  10180b:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  10180e:	8b 45 08             	mov    0x8(%ebp),%eax
  101811:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101815:	0f b7 c0             	movzwl %ax,%eax
  101818:	83 ec 08             	sub    $0x8,%esp
  10181b:	50                   	push   %eax
  10181c:	68 a8 35 10 00       	push   $0x1035a8
  101821:	e8 17 ea ff ff       	call   10023d <cprintf>
  101826:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101829:	8b 45 08             	mov    0x8(%ebp),%eax
  10182c:	8b 40 30             	mov    0x30(%eax),%eax
  10182f:	83 ec 0c             	sub    $0xc,%esp
  101832:	50                   	push   %eax
  101833:	e8 16 ff ff ff       	call   10174e <trapname>
  101838:	83 c4 10             	add    $0x10,%esp
  10183b:	89 c2                	mov    %eax,%edx
  10183d:	8b 45 08             	mov    0x8(%ebp),%eax
  101840:	8b 40 30             	mov    0x30(%eax),%eax
  101843:	83 ec 04             	sub    $0x4,%esp
  101846:	52                   	push   %edx
  101847:	50                   	push   %eax
  101848:	68 bb 35 10 00       	push   $0x1035bb
  10184d:	e8 eb e9 ff ff       	call   10023d <cprintf>
  101852:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101855:	8b 45 08             	mov    0x8(%ebp),%eax
  101858:	8b 40 34             	mov    0x34(%eax),%eax
  10185b:	83 ec 08             	sub    $0x8,%esp
  10185e:	50                   	push   %eax
  10185f:	68 cd 35 10 00       	push   $0x1035cd
  101864:	e8 d4 e9 ff ff       	call   10023d <cprintf>
  101869:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  10186c:	8b 45 08             	mov    0x8(%ebp),%eax
  10186f:	8b 40 38             	mov    0x38(%eax),%eax
  101872:	83 ec 08             	sub    $0x8,%esp
  101875:	50                   	push   %eax
  101876:	68 dc 35 10 00       	push   $0x1035dc
  10187b:	e8 bd e9 ff ff       	call   10023d <cprintf>
  101880:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101883:	8b 45 08             	mov    0x8(%ebp),%eax
  101886:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10188a:	0f b7 c0             	movzwl %ax,%eax
  10188d:	83 ec 08             	sub    $0x8,%esp
  101890:	50                   	push   %eax
  101891:	68 eb 35 10 00       	push   $0x1035eb
  101896:	e8 a2 e9 ff ff       	call   10023d <cprintf>
  10189b:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  10189e:	8b 45 08             	mov    0x8(%ebp),%eax
  1018a1:	8b 40 40             	mov    0x40(%eax),%eax
  1018a4:	83 ec 08             	sub    $0x8,%esp
  1018a7:	50                   	push   %eax
  1018a8:	68 fe 35 10 00       	push   $0x1035fe
  1018ad:	e8 8b e9 ff ff       	call   10023d <cprintf>
  1018b2:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  1018b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1018bc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  1018c3:	eb 3f                	jmp    101904 <print_trapframe+0x16f>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  1018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1018c8:	8b 50 40             	mov    0x40(%eax),%edx
  1018cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1018ce:	21 d0                	and    %edx,%eax
  1018d0:	85 c0                	test   %eax,%eax
  1018d2:	74 29                	je     1018fd <print_trapframe+0x168>
  1018d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1018d7:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  1018de:	85 c0                	test   %eax,%eax
  1018e0:	74 1b                	je     1018fd <print_trapframe+0x168>
            cprintf("%s,", IA32flags[i]);
  1018e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1018e5:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  1018ec:	83 ec 08             	sub    $0x8,%esp
  1018ef:	50                   	push   %eax
  1018f0:	68 0d 36 10 00       	push   $0x10360d
  1018f5:	e8 43 e9 ff ff       	call   10023d <cprintf>
  1018fa:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  1018fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101901:	d1 65 f0             	shll   -0x10(%ebp)
  101904:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101907:	83 f8 17             	cmp    $0x17,%eax
  10190a:	76 b9                	jbe    1018c5 <print_trapframe+0x130>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  10190c:	8b 45 08             	mov    0x8(%ebp),%eax
  10190f:	8b 40 40             	mov    0x40(%eax),%eax
  101912:	c1 e8 0c             	shr    $0xc,%eax
  101915:	83 e0 03             	and    $0x3,%eax
  101918:	83 ec 08             	sub    $0x8,%esp
  10191b:	50                   	push   %eax
  10191c:	68 11 36 10 00       	push   $0x103611
  101921:	e8 17 e9 ff ff       	call   10023d <cprintf>
  101926:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101929:	83 ec 0c             	sub    $0xc,%esp
  10192c:	ff 75 08             	pushl  0x8(%ebp)
  10192f:	e8 4b fe ff ff       	call   10177f <trap_in_kernel>
  101934:	83 c4 10             	add    $0x10,%esp
  101937:	85 c0                	test   %eax,%eax
  101939:	75 32                	jne    10196d <print_trapframe+0x1d8>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  10193b:	8b 45 08             	mov    0x8(%ebp),%eax
  10193e:	8b 40 44             	mov    0x44(%eax),%eax
  101941:	83 ec 08             	sub    $0x8,%esp
  101944:	50                   	push   %eax
  101945:	68 1a 36 10 00       	push   $0x10361a
  10194a:	e8 ee e8 ff ff       	call   10023d <cprintf>
  10194f:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101952:	8b 45 08             	mov    0x8(%ebp),%eax
  101955:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101959:	0f b7 c0             	movzwl %ax,%eax
  10195c:	83 ec 08             	sub    $0x8,%esp
  10195f:	50                   	push   %eax
  101960:	68 29 36 10 00       	push   $0x103629
  101965:	e8 d3 e8 ff ff       	call   10023d <cprintf>
  10196a:	83 c4 10             	add    $0x10,%esp
    }
}
  10196d:	90                   	nop
  10196e:	c9                   	leave  
  10196f:	c3                   	ret    

00101970 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101970:	55                   	push   %ebp
  101971:	89 e5                	mov    %esp,%ebp
  101973:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101976:	8b 45 08             	mov    0x8(%ebp),%eax
  101979:	8b 00                	mov    (%eax),%eax
  10197b:	83 ec 08             	sub    $0x8,%esp
  10197e:	50                   	push   %eax
  10197f:	68 3c 36 10 00       	push   $0x10363c
  101984:	e8 b4 e8 ff ff       	call   10023d <cprintf>
  101989:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  10198c:	8b 45 08             	mov    0x8(%ebp),%eax
  10198f:	8b 40 04             	mov    0x4(%eax),%eax
  101992:	83 ec 08             	sub    $0x8,%esp
  101995:	50                   	push   %eax
  101996:	68 4b 36 10 00       	push   $0x10364b
  10199b:	e8 9d e8 ff ff       	call   10023d <cprintf>
  1019a0:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  1019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1019a6:	8b 40 08             	mov    0x8(%eax),%eax
  1019a9:	83 ec 08             	sub    $0x8,%esp
  1019ac:	50                   	push   %eax
  1019ad:	68 5a 36 10 00       	push   $0x10365a
  1019b2:	e8 86 e8 ff ff       	call   10023d <cprintf>
  1019b7:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  1019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1019bd:	8b 40 0c             	mov    0xc(%eax),%eax
  1019c0:	83 ec 08             	sub    $0x8,%esp
  1019c3:	50                   	push   %eax
  1019c4:	68 69 36 10 00       	push   $0x103669
  1019c9:	e8 6f e8 ff ff       	call   10023d <cprintf>
  1019ce:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  1019d1:	8b 45 08             	mov    0x8(%ebp),%eax
  1019d4:	8b 40 10             	mov    0x10(%eax),%eax
  1019d7:	83 ec 08             	sub    $0x8,%esp
  1019da:	50                   	push   %eax
  1019db:	68 78 36 10 00       	push   $0x103678
  1019e0:	e8 58 e8 ff ff       	call   10023d <cprintf>
  1019e5:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  1019e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1019eb:	8b 40 14             	mov    0x14(%eax),%eax
  1019ee:	83 ec 08             	sub    $0x8,%esp
  1019f1:	50                   	push   %eax
  1019f2:	68 87 36 10 00       	push   $0x103687
  1019f7:	e8 41 e8 ff ff       	call   10023d <cprintf>
  1019fc:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  1019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  101a02:	8b 40 18             	mov    0x18(%eax),%eax
  101a05:	83 ec 08             	sub    $0x8,%esp
  101a08:	50                   	push   %eax
  101a09:	68 96 36 10 00       	push   $0x103696
  101a0e:	e8 2a e8 ff ff       	call   10023d <cprintf>
  101a13:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101a16:	8b 45 08             	mov    0x8(%ebp),%eax
  101a19:	8b 40 1c             	mov    0x1c(%eax),%eax
  101a1c:	83 ec 08             	sub    $0x8,%esp
  101a1f:	50                   	push   %eax
  101a20:	68 a5 36 10 00       	push   $0x1036a5
  101a25:	e8 13 e8 ff ff       	call   10023d <cprintf>
  101a2a:	83 c4 10             	add    $0x10,%esp
}
  101a2d:	90                   	nop
  101a2e:	c9                   	leave  
  101a2f:	c3                   	ret    

00101a30 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101a30:	55                   	push   %ebp
  101a31:	89 e5                	mov    %esp,%ebp
  101a33:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
  101a36:	8b 45 08             	mov    0x8(%ebp),%eax
  101a39:	8b 40 30             	mov    0x30(%eax),%eax
  101a3c:	83 f8 2f             	cmp    $0x2f,%eax
  101a3f:	77 1e                	ja     101a5f <trap_dispatch+0x2f>
  101a41:	83 f8 2e             	cmp    $0x2e,%eax
  101a44:	0f 83 b4 00 00 00    	jae    101afe <trap_dispatch+0xce>
  101a4a:	83 f8 21             	cmp    $0x21,%eax
  101a4d:	74 3e                	je     101a8d <trap_dispatch+0x5d>
  101a4f:	83 f8 24             	cmp    $0x24,%eax
  101a52:	74 15                	je     101a69 <trap_dispatch+0x39>
  101a54:	83 f8 20             	cmp    $0x20,%eax
  101a57:	0f 84 a4 00 00 00    	je     101b01 <trap_dispatch+0xd1>
  101a5d:	eb 69                	jmp    101ac8 <trap_dispatch+0x98>
  101a5f:	83 e8 78             	sub    $0x78,%eax
  101a62:	83 f8 01             	cmp    $0x1,%eax
  101a65:	77 61                	ja     101ac8 <trap_dispatch+0x98>
  101a67:	eb 48                	jmp    101ab1 <trap_dispatch+0x81>
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101a69:	e8 92 fa ff ff       	call   101500 <cons_getc>
  101a6e:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101a71:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101a75:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101a79:	83 ec 04             	sub    $0x4,%esp
  101a7c:	52                   	push   %edx
  101a7d:	50                   	push   %eax
  101a7e:	68 b4 36 10 00       	push   $0x1036b4
  101a83:	e8 b5 e7 ff ff       	call   10023d <cprintf>
  101a88:	83 c4 10             	add    $0x10,%esp
        break;
  101a8b:	eb 75                	jmp    101b02 <trap_dispatch+0xd2>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101a8d:	e8 6e fa ff ff       	call   101500 <cons_getc>
  101a92:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101a95:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101a99:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101a9d:	83 ec 04             	sub    $0x4,%esp
  101aa0:	52                   	push   %edx
  101aa1:	50                   	push   %eax
  101aa2:	68 c6 36 10 00       	push   $0x1036c6
  101aa7:	e8 91 e7 ff ff       	call   10023d <cprintf>
  101aac:	83 c4 10             	add    $0x10,%esp
        break;
  101aaf:	eb 51                	jmp    101b02 <trap_dispatch+0xd2>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101ab1:	83 ec 04             	sub    $0x4,%esp
  101ab4:	68 d5 36 10 00       	push   $0x1036d5
  101ab9:	68 a2 00 00 00       	push   $0xa2
  101abe:	68 e5 36 10 00       	push   $0x1036e5
  101ac3:	e8 db e8 ff ff       	call   1003a3 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  101acb:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101acf:	0f b7 c0             	movzwl %ax,%eax
  101ad2:	83 e0 03             	and    $0x3,%eax
  101ad5:	85 c0                	test   %eax,%eax
  101ad7:	75 29                	jne    101b02 <trap_dispatch+0xd2>
            print_trapframe(tf);
  101ad9:	83 ec 0c             	sub    $0xc,%esp
  101adc:	ff 75 08             	pushl  0x8(%ebp)
  101adf:	e8 b1 fc ff ff       	call   101795 <print_trapframe>
  101ae4:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101ae7:	83 ec 04             	sub    $0x4,%esp
  101aea:	68 f6 36 10 00       	push   $0x1036f6
  101aef:	68 ac 00 00 00       	push   $0xac
  101af4:	68 e5 36 10 00       	push   $0x1036e5
  101af9:	e8 a5 e8 ff ff       	call   1003a3 <__panic>
        break;
  101afe:	90                   	nop
  101aff:	eb 01                	jmp    101b02 <trap_dispatch+0xd2>
        break;
  101b01:	90                   	nop
        }
    }
}
  101b02:	90                   	nop
  101b03:	c9                   	leave  
  101b04:	c3                   	ret    

00101b05 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101b05:	55                   	push   %ebp
  101b06:	89 e5                	mov    %esp,%ebp
  101b08:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101b0b:	83 ec 0c             	sub    $0xc,%esp
  101b0e:	ff 75 08             	pushl  0x8(%ebp)
  101b11:	e8 1a ff ff ff       	call   101a30 <trap_dispatch>
  101b16:	83 c4 10             	add    $0x10,%esp
}
  101b19:	90                   	nop
  101b1a:	c9                   	leave  
  101b1b:	c3                   	ret    

00101b1c <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101b1c:	6a 00                	push   $0x0
  pushl $0
  101b1e:	6a 00                	push   $0x0
  jmp __alltraps
  101b20:	e9 69 0a 00 00       	jmp    10258e <__alltraps>

00101b25 <vector1>:
.globl vector1
vector1:
  pushl $0
  101b25:	6a 00                	push   $0x0
  pushl $1
  101b27:	6a 01                	push   $0x1
  jmp __alltraps
  101b29:	e9 60 0a 00 00       	jmp    10258e <__alltraps>

00101b2e <vector2>:
.globl vector2
vector2:
  pushl $0
  101b2e:	6a 00                	push   $0x0
  pushl $2
  101b30:	6a 02                	push   $0x2
  jmp __alltraps
  101b32:	e9 57 0a 00 00       	jmp    10258e <__alltraps>

00101b37 <vector3>:
.globl vector3
vector3:
  pushl $0
  101b37:	6a 00                	push   $0x0
  pushl $3
  101b39:	6a 03                	push   $0x3
  jmp __alltraps
  101b3b:	e9 4e 0a 00 00       	jmp    10258e <__alltraps>

00101b40 <vector4>:
.globl vector4
vector4:
  pushl $0
  101b40:	6a 00                	push   $0x0
  pushl $4
  101b42:	6a 04                	push   $0x4
  jmp __alltraps
  101b44:	e9 45 0a 00 00       	jmp    10258e <__alltraps>

00101b49 <vector5>:
.globl vector5
vector5:
  pushl $0
  101b49:	6a 00                	push   $0x0
  pushl $5
  101b4b:	6a 05                	push   $0x5
  jmp __alltraps
  101b4d:	e9 3c 0a 00 00       	jmp    10258e <__alltraps>

00101b52 <vector6>:
.globl vector6
vector6:
  pushl $0
  101b52:	6a 00                	push   $0x0
  pushl $6
  101b54:	6a 06                	push   $0x6
  jmp __alltraps
  101b56:	e9 33 0a 00 00       	jmp    10258e <__alltraps>

00101b5b <vector7>:
.globl vector7
vector7:
  pushl $0
  101b5b:	6a 00                	push   $0x0
  pushl $7
  101b5d:	6a 07                	push   $0x7
  jmp __alltraps
  101b5f:	e9 2a 0a 00 00       	jmp    10258e <__alltraps>

00101b64 <vector8>:
.globl vector8
vector8:
  pushl $8
  101b64:	6a 08                	push   $0x8
  jmp __alltraps
  101b66:	e9 23 0a 00 00       	jmp    10258e <__alltraps>

00101b6b <vector9>:
.globl vector9
vector9:
  pushl $0
  101b6b:	6a 00                	push   $0x0
  pushl $9
  101b6d:	6a 09                	push   $0x9
  jmp __alltraps
  101b6f:	e9 1a 0a 00 00       	jmp    10258e <__alltraps>

00101b74 <vector10>:
.globl vector10
vector10:
  pushl $10
  101b74:	6a 0a                	push   $0xa
  jmp __alltraps
  101b76:	e9 13 0a 00 00       	jmp    10258e <__alltraps>

00101b7b <vector11>:
.globl vector11
vector11:
  pushl $11
  101b7b:	6a 0b                	push   $0xb
  jmp __alltraps
  101b7d:	e9 0c 0a 00 00       	jmp    10258e <__alltraps>

00101b82 <vector12>:
.globl vector12
vector12:
  pushl $12
  101b82:	6a 0c                	push   $0xc
  jmp __alltraps
  101b84:	e9 05 0a 00 00       	jmp    10258e <__alltraps>

00101b89 <vector13>:
.globl vector13
vector13:
  pushl $13
  101b89:	6a 0d                	push   $0xd
  jmp __alltraps
  101b8b:	e9 fe 09 00 00       	jmp    10258e <__alltraps>

00101b90 <vector14>:
.globl vector14
vector14:
  pushl $14
  101b90:	6a 0e                	push   $0xe
  jmp __alltraps
  101b92:	e9 f7 09 00 00       	jmp    10258e <__alltraps>

00101b97 <vector15>:
.globl vector15
vector15:
  pushl $0
  101b97:	6a 00                	push   $0x0
  pushl $15
  101b99:	6a 0f                	push   $0xf
  jmp __alltraps
  101b9b:	e9 ee 09 00 00       	jmp    10258e <__alltraps>

00101ba0 <vector16>:
.globl vector16
vector16:
  pushl $0
  101ba0:	6a 00                	push   $0x0
  pushl $16
  101ba2:	6a 10                	push   $0x10
  jmp __alltraps
  101ba4:	e9 e5 09 00 00       	jmp    10258e <__alltraps>

00101ba9 <vector17>:
.globl vector17
vector17:
  pushl $17
  101ba9:	6a 11                	push   $0x11
  jmp __alltraps
  101bab:	e9 de 09 00 00       	jmp    10258e <__alltraps>

00101bb0 <vector18>:
.globl vector18
vector18:
  pushl $0
  101bb0:	6a 00                	push   $0x0
  pushl $18
  101bb2:	6a 12                	push   $0x12
  jmp __alltraps
  101bb4:	e9 d5 09 00 00       	jmp    10258e <__alltraps>

00101bb9 <vector19>:
.globl vector19
vector19:
  pushl $0
  101bb9:	6a 00                	push   $0x0
  pushl $19
  101bbb:	6a 13                	push   $0x13
  jmp __alltraps
  101bbd:	e9 cc 09 00 00       	jmp    10258e <__alltraps>

00101bc2 <vector20>:
.globl vector20
vector20:
  pushl $0
  101bc2:	6a 00                	push   $0x0
  pushl $20
  101bc4:	6a 14                	push   $0x14
  jmp __alltraps
  101bc6:	e9 c3 09 00 00       	jmp    10258e <__alltraps>

00101bcb <vector21>:
.globl vector21
vector21:
  pushl $0
  101bcb:	6a 00                	push   $0x0
  pushl $21
  101bcd:	6a 15                	push   $0x15
  jmp __alltraps
  101bcf:	e9 ba 09 00 00       	jmp    10258e <__alltraps>

00101bd4 <vector22>:
.globl vector22
vector22:
  pushl $0
  101bd4:	6a 00                	push   $0x0
  pushl $22
  101bd6:	6a 16                	push   $0x16
  jmp __alltraps
  101bd8:	e9 b1 09 00 00       	jmp    10258e <__alltraps>

00101bdd <vector23>:
.globl vector23
vector23:
  pushl $0
  101bdd:	6a 00                	push   $0x0
  pushl $23
  101bdf:	6a 17                	push   $0x17
  jmp __alltraps
  101be1:	e9 a8 09 00 00       	jmp    10258e <__alltraps>

00101be6 <vector24>:
.globl vector24
vector24:
  pushl $0
  101be6:	6a 00                	push   $0x0
  pushl $24
  101be8:	6a 18                	push   $0x18
  jmp __alltraps
  101bea:	e9 9f 09 00 00       	jmp    10258e <__alltraps>

00101bef <vector25>:
.globl vector25
vector25:
  pushl $0
  101bef:	6a 00                	push   $0x0
  pushl $25
  101bf1:	6a 19                	push   $0x19
  jmp __alltraps
  101bf3:	e9 96 09 00 00       	jmp    10258e <__alltraps>

00101bf8 <vector26>:
.globl vector26
vector26:
  pushl $0
  101bf8:	6a 00                	push   $0x0
  pushl $26
  101bfa:	6a 1a                	push   $0x1a
  jmp __alltraps
  101bfc:	e9 8d 09 00 00       	jmp    10258e <__alltraps>

00101c01 <vector27>:
.globl vector27
vector27:
  pushl $0
  101c01:	6a 00                	push   $0x0
  pushl $27
  101c03:	6a 1b                	push   $0x1b
  jmp __alltraps
  101c05:	e9 84 09 00 00       	jmp    10258e <__alltraps>

00101c0a <vector28>:
.globl vector28
vector28:
  pushl $0
  101c0a:	6a 00                	push   $0x0
  pushl $28
  101c0c:	6a 1c                	push   $0x1c
  jmp __alltraps
  101c0e:	e9 7b 09 00 00       	jmp    10258e <__alltraps>

00101c13 <vector29>:
.globl vector29
vector29:
  pushl $0
  101c13:	6a 00                	push   $0x0
  pushl $29
  101c15:	6a 1d                	push   $0x1d
  jmp __alltraps
  101c17:	e9 72 09 00 00       	jmp    10258e <__alltraps>

00101c1c <vector30>:
.globl vector30
vector30:
  pushl $0
  101c1c:	6a 00                	push   $0x0
  pushl $30
  101c1e:	6a 1e                	push   $0x1e
  jmp __alltraps
  101c20:	e9 69 09 00 00       	jmp    10258e <__alltraps>

00101c25 <vector31>:
.globl vector31
vector31:
  pushl $0
  101c25:	6a 00                	push   $0x0
  pushl $31
  101c27:	6a 1f                	push   $0x1f
  jmp __alltraps
  101c29:	e9 60 09 00 00       	jmp    10258e <__alltraps>

00101c2e <vector32>:
.globl vector32
vector32:
  pushl $0
  101c2e:	6a 00                	push   $0x0
  pushl $32
  101c30:	6a 20                	push   $0x20
  jmp __alltraps
  101c32:	e9 57 09 00 00       	jmp    10258e <__alltraps>

00101c37 <vector33>:
.globl vector33
vector33:
  pushl $0
  101c37:	6a 00                	push   $0x0
  pushl $33
  101c39:	6a 21                	push   $0x21
  jmp __alltraps
  101c3b:	e9 4e 09 00 00       	jmp    10258e <__alltraps>

00101c40 <vector34>:
.globl vector34
vector34:
  pushl $0
  101c40:	6a 00                	push   $0x0
  pushl $34
  101c42:	6a 22                	push   $0x22
  jmp __alltraps
  101c44:	e9 45 09 00 00       	jmp    10258e <__alltraps>

00101c49 <vector35>:
.globl vector35
vector35:
  pushl $0
  101c49:	6a 00                	push   $0x0
  pushl $35
  101c4b:	6a 23                	push   $0x23
  jmp __alltraps
  101c4d:	e9 3c 09 00 00       	jmp    10258e <__alltraps>

00101c52 <vector36>:
.globl vector36
vector36:
  pushl $0
  101c52:	6a 00                	push   $0x0
  pushl $36
  101c54:	6a 24                	push   $0x24
  jmp __alltraps
  101c56:	e9 33 09 00 00       	jmp    10258e <__alltraps>

00101c5b <vector37>:
.globl vector37
vector37:
  pushl $0
  101c5b:	6a 00                	push   $0x0
  pushl $37
  101c5d:	6a 25                	push   $0x25
  jmp __alltraps
  101c5f:	e9 2a 09 00 00       	jmp    10258e <__alltraps>

00101c64 <vector38>:
.globl vector38
vector38:
  pushl $0
  101c64:	6a 00                	push   $0x0
  pushl $38
  101c66:	6a 26                	push   $0x26
  jmp __alltraps
  101c68:	e9 21 09 00 00       	jmp    10258e <__alltraps>

00101c6d <vector39>:
.globl vector39
vector39:
  pushl $0
  101c6d:	6a 00                	push   $0x0
  pushl $39
  101c6f:	6a 27                	push   $0x27
  jmp __alltraps
  101c71:	e9 18 09 00 00       	jmp    10258e <__alltraps>

00101c76 <vector40>:
.globl vector40
vector40:
  pushl $0
  101c76:	6a 00                	push   $0x0
  pushl $40
  101c78:	6a 28                	push   $0x28
  jmp __alltraps
  101c7a:	e9 0f 09 00 00       	jmp    10258e <__alltraps>

00101c7f <vector41>:
.globl vector41
vector41:
  pushl $0
  101c7f:	6a 00                	push   $0x0
  pushl $41
  101c81:	6a 29                	push   $0x29
  jmp __alltraps
  101c83:	e9 06 09 00 00       	jmp    10258e <__alltraps>

00101c88 <vector42>:
.globl vector42
vector42:
  pushl $0
  101c88:	6a 00                	push   $0x0
  pushl $42
  101c8a:	6a 2a                	push   $0x2a
  jmp __alltraps
  101c8c:	e9 fd 08 00 00       	jmp    10258e <__alltraps>

00101c91 <vector43>:
.globl vector43
vector43:
  pushl $0
  101c91:	6a 00                	push   $0x0
  pushl $43
  101c93:	6a 2b                	push   $0x2b
  jmp __alltraps
  101c95:	e9 f4 08 00 00       	jmp    10258e <__alltraps>

00101c9a <vector44>:
.globl vector44
vector44:
  pushl $0
  101c9a:	6a 00                	push   $0x0
  pushl $44
  101c9c:	6a 2c                	push   $0x2c
  jmp __alltraps
  101c9e:	e9 eb 08 00 00       	jmp    10258e <__alltraps>

00101ca3 <vector45>:
.globl vector45
vector45:
  pushl $0
  101ca3:	6a 00                	push   $0x0
  pushl $45
  101ca5:	6a 2d                	push   $0x2d
  jmp __alltraps
  101ca7:	e9 e2 08 00 00       	jmp    10258e <__alltraps>

00101cac <vector46>:
.globl vector46
vector46:
  pushl $0
  101cac:	6a 00                	push   $0x0
  pushl $46
  101cae:	6a 2e                	push   $0x2e
  jmp __alltraps
  101cb0:	e9 d9 08 00 00       	jmp    10258e <__alltraps>

00101cb5 <vector47>:
.globl vector47
vector47:
  pushl $0
  101cb5:	6a 00                	push   $0x0
  pushl $47
  101cb7:	6a 2f                	push   $0x2f
  jmp __alltraps
  101cb9:	e9 d0 08 00 00       	jmp    10258e <__alltraps>

00101cbe <vector48>:
.globl vector48
vector48:
  pushl $0
  101cbe:	6a 00                	push   $0x0
  pushl $48
  101cc0:	6a 30                	push   $0x30
  jmp __alltraps
  101cc2:	e9 c7 08 00 00       	jmp    10258e <__alltraps>

00101cc7 <vector49>:
.globl vector49
vector49:
  pushl $0
  101cc7:	6a 00                	push   $0x0
  pushl $49
  101cc9:	6a 31                	push   $0x31
  jmp __alltraps
  101ccb:	e9 be 08 00 00       	jmp    10258e <__alltraps>

00101cd0 <vector50>:
.globl vector50
vector50:
  pushl $0
  101cd0:	6a 00                	push   $0x0
  pushl $50
  101cd2:	6a 32                	push   $0x32
  jmp __alltraps
  101cd4:	e9 b5 08 00 00       	jmp    10258e <__alltraps>

00101cd9 <vector51>:
.globl vector51
vector51:
  pushl $0
  101cd9:	6a 00                	push   $0x0
  pushl $51
  101cdb:	6a 33                	push   $0x33
  jmp __alltraps
  101cdd:	e9 ac 08 00 00       	jmp    10258e <__alltraps>

00101ce2 <vector52>:
.globl vector52
vector52:
  pushl $0
  101ce2:	6a 00                	push   $0x0
  pushl $52
  101ce4:	6a 34                	push   $0x34
  jmp __alltraps
  101ce6:	e9 a3 08 00 00       	jmp    10258e <__alltraps>

00101ceb <vector53>:
.globl vector53
vector53:
  pushl $0
  101ceb:	6a 00                	push   $0x0
  pushl $53
  101ced:	6a 35                	push   $0x35
  jmp __alltraps
  101cef:	e9 9a 08 00 00       	jmp    10258e <__alltraps>

00101cf4 <vector54>:
.globl vector54
vector54:
  pushl $0
  101cf4:	6a 00                	push   $0x0
  pushl $54
  101cf6:	6a 36                	push   $0x36
  jmp __alltraps
  101cf8:	e9 91 08 00 00       	jmp    10258e <__alltraps>

00101cfd <vector55>:
.globl vector55
vector55:
  pushl $0
  101cfd:	6a 00                	push   $0x0
  pushl $55
  101cff:	6a 37                	push   $0x37
  jmp __alltraps
  101d01:	e9 88 08 00 00       	jmp    10258e <__alltraps>

00101d06 <vector56>:
.globl vector56
vector56:
  pushl $0
  101d06:	6a 00                	push   $0x0
  pushl $56
  101d08:	6a 38                	push   $0x38
  jmp __alltraps
  101d0a:	e9 7f 08 00 00       	jmp    10258e <__alltraps>

00101d0f <vector57>:
.globl vector57
vector57:
  pushl $0
  101d0f:	6a 00                	push   $0x0
  pushl $57
  101d11:	6a 39                	push   $0x39
  jmp __alltraps
  101d13:	e9 76 08 00 00       	jmp    10258e <__alltraps>

00101d18 <vector58>:
.globl vector58
vector58:
  pushl $0
  101d18:	6a 00                	push   $0x0
  pushl $58
  101d1a:	6a 3a                	push   $0x3a
  jmp __alltraps
  101d1c:	e9 6d 08 00 00       	jmp    10258e <__alltraps>

00101d21 <vector59>:
.globl vector59
vector59:
  pushl $0
  101d21:	6a 00                	push   $0x0
  pushl $59
  101d23:	6a 3b                	push   $0x3b
  jmp __alltraps
  101d25:	e9 64 08 00 00       	jmp    10258e <__alltraps>

00101d2a <vector60>:
.globl vector60
vector60:
  pushl $0
  101d2a:	6a 00                	push   $0x0
  pushl $60
  101d2c:	6a 3c                	push   $0x3c
  jmp __alltraps
  101d2e:	e9 5b 08 00 00       	jmp    10258e <__alltraps>

00101d33 <vector61>:
.globl vector61
vector61:
  pushl $0
  101d33:	6a 00                	push   $0x0
  pushl $61
  101d35:	6a 3d                	push   $0x3d
  jmp __alltraps
  101d37:	e9 52 08 00 00       	jmp    10258e <__alltraps>

00101d3c <vector62>:
.globl vector62
vector62:
  pushl $0
  101d3c:	6a 00                	push   $0x0
  pushl $62
  101d3e:	6a 3e                	push   $0x3e
  jmp __alltraps
  101d40:	e9 49 08 00 00       	jmp    10258e <__alltraps>

00101d45 <vector63>:
.globl vector63
vector63:
  pushl $0
  101d45:	6a 00                	push   $0x0
  pushl $63
  101d47:	6a 3f                	push   $0x3f
  jmp __alltraps
  101d49:	e9 40 08 00 00       	jmp    10258e <__alltraps>

00101d4e <vector64>:
.globl vector64
vector64:
  pushl $0
  101d4e:	6a 00                	push   $0x0
  pushl $64
  101d50:	6a 40                	push   $0x40
  jmp __alltraps
  101d52:	e9 37 08 00 00       	jmp    10258e <__alltraps>

00101d57 <vector65>:
.globl vector65
vector65:
  pushl $0
  101d57:	6a 00                	push   $0x0
  pushl $65
  101d59:	6a 41                	push   $0x41
  jmp __alltraps
  101d5b:	e9 2e 08 00 00       	jmp    10258e <__alltraps>

00101d60 <vector66>:
.globl vector66
vector66:
  pushl $0
  101d60:	6a 00                	push   $0x0
  pushl $66
  101d62:	6a 42                	push   $0x42
  jmp __alltraps
  101d64:	e9 25 08 00 00       	jmp    10258e <__alltraps>

00101d69 <vector67>:
.globl vector67
vector67:
  pushl $0
  101d69:	6a 00                	push   $0x0
  pushl $67
  101d6b:	6a 43                	push   $0x43
  jmp __alltraps
  101d6d:	e9 1c 08 00 00       	jmp    10258e <__alltraps>

00101d72 <vector68>:
.globl vector68
vector68:
  pushl $0
  101d72:	6a 00                	push   $0x0
  pushl $68
  101d74:	6a 44                	push   $0x44
  jmp __alltraps
  101d76:	e9 13 08 00 00       	jmp    10258e <__alltraps>

00101d7b <vector69>:
.globl vector69
vector69:
  pushl $0
  101d7b:	6a 00                	push   $0x0
  pushl $69
  101d7d:	6a 45                	push   $0x45
  jmp __alltraps
  101d7f:	e9 0a 08 00 00       	jmp    10258e <__alltraps>

00101d84 <vector70>:
.globl vector70
vector70:
  pushl $0
  101d84:	6a 00                	push   $0x0
  pushl $70
  101d86:	6a 46                	push   $0x46
  jmp __alltraps
  101d88:	e9 01 08 00 00       	jmp    10258e <__alltraps>

00101d8d <vector71>:
.globl vector71
vector71:
  pushl $0
  101d8d:	6a 00                	push   $0x0
  pushl $71
  101d8f:	6a 47                	push   $0x47
  jmp __alltraps
  101d91:	e9 f8 07 00 00       	jmp    10258e <__alltraps>

00101d96 <vector72>:
.globl vector72
vector72:
  pushl $0
  101d96:	6a 00                	push   $0x0
  pushl $72
  101d98:	6a 48                	push   $0x48
  jmp __alltraps
  101d9a:	e9 ef 07 00 00       	jmp    10258e <__alltraps>

00101d9f <vector73>:
.globl vector73
vector73:
  pushl $0
  101d9f:	6a 00                	push   $0x0
  pushl $73
  101da1:	6a 49                	push   $0x49
  jmp __alltraps
  101da3:	e9 e6 07 00 00       	jmp    10258e <__alltraps>

00101da8 <vector74>:
.globl vector74
vector74:
  pushl $0
  101da8:	6a 00                	push   $0x0
  pushl $74
  101daa:	6a 4a                	push   $0x4a
  jmp __alltraps
  101dac:	e9 dd 07 00 00       	jmp    10258e <__alltraps>

00101db1 <vector75>:
.globl vector75
vector75:
  pushl $0
  101db1:	6a 00                	push   $0x0
  pushl $75
  101db3:	6a 4b                	push   $0x4b
  jmp __alltraps
  101db5:	e9 d4 07 00 00       	jmp    10258e <__alltraps>

00101dba <vector76>:
.globl vector76
vector76:
  pushl $0
  101dba:	6a 00                	push   $0x0
  pushl $76
  101dbc:	6a 4c                	push   $0x4c
  jmp __alltraps
  101dbe:	e9 cb 07 00 00       	jmp    10258e <__alltraps>

00101dc3 <vector77>:
.globl vector77
vector77:
  pushl $0
  101dc3:	6a 00                	push   $0x0
  pushl $77
  101dc5:	6a 4d                	push   $0x4d
  jmp __alltraps
  101dc7:	e9 c2 07 00 00       	jmp    10258e <__alltraps>

00101dcc <vector78>:
.globl vector78
vector78:
  pushl $0
  101dcc:	6a 00                	push   $0x0
  pushl $78
  101dce:	6a 4e                	push   $0x4e
  jmp __alltraps
  101dd0:	e9 b9 07 00 00       	jmp    10258e <__alltraps>

00101dd5 <vector79>:
.globl vector79
vector79:
  pushl $0
  101dd5:	6a 00                	push   $0x0
  pushl $79
  101dd7:	6a 4f                	push   $0x4f
  jmp __alltraps
  101dd9:	e9 b0 07 00 00       	jmp    10258e <__alltraps>

00101dde <vector80>:
.globl vector80
vector80:
  pushl $0
  101dde:	6a 00                	push   $0x0
  pushl $80
  101de0:	6a 50                	push   $0x50
  jmp __alltraps
  101de2:	e9 a7 07 00 00       	jmp    10258e <__alltraps>

00101de7 <vector81>:
.globl vector81
vector81:
  pushl $0
  101de7:	6a 00                	push   $0x0
  pushl $81
  101de9:	6a 51                	push   $0x51
  jmp __alltraps
  101deb:	e9 9e 07 00 00       	jmp    10258e <__alltraps>

00101df0 <vector82>:
.globl vector82
vector82:
  pushl $0
  101df0:	6a 00                	push   $0x0
  pushl $82
  101df2:	6a 52                	push   $0x52
  jmp __alltraps
  101df4:	e9 95 07 00 00       	jmp    10258e <__alltraps>

00101df9 <vector83>:
.globl vector83
vector83:
  pushl $0
  101df9:	6a 00                	push   $0x0
  pushl $83
  101dfb:	6a 53                	push   $0x53
  jmp __alltraps
  101dfd:	e9 8c 07 00 00       	jmp    10258e <__alltraps>

00101e02 <vector84>:
.globl vector84
vector84:
  pushl $0
  101e02:	6a 00                	push   $0x0
  pushl $84
  101e04:	6a 54                	push   $0x54
  jmp __alltraps
  101e06:	e9 83 07 00 00       	jmp    10258e <__alltraps>

00101e0b <vector85>:
.globl vector85
vector85:
  pushl $0
  101e0b:	6a 00                	push   $0x0
  pushl $85
  101e0d:	6a 55                	push   $0x55
  jmp __alltraps
  101e0f:	e9 7a 07 00 00       	jmp    10258e <__alltraps>

00101e14 <vector86>:
.globl vector86
vector86:
  pushl $0
  101e14:	6a 00                	push   $0x0
  pushl $86
  101e16:	6a 56                	push   $0x56
  jmp __alltraps
  101e18:	e9 71 07 00 00       	jmp    10258e <__alltraps>

00101e1d <vector87>:
.globl vector87
vector87:
  pushl $0
  101e1d:	6a 00                	push   $0x0
  pushl $87
  101e1f:	6a 57                	push   $0x57
  jmp __alltraps
  101e21:	e9 68 07 00 00       	jmp    10258e <__alltraps>

00101e26 <vector88>:
.globl vector88
vector88:
  pushl $0
  101e26:	6a 00                	push   $0x0
  pushl $88
  101e28:	6a 58                	push   $0x58
  jmp __alltraps
  101e2a:	e9 5f 07 00 00       	jmp    10258e <__alltraps>

00101e2f <vector89>:
.globl vector89
vector89:
  pushl $0
  101e2f:	6a 00                	push   $0x0
  pushl $89
  101e31:	6a 59                	push   $0x59
  jmp __alltraps
  101e33:	e9 56 07 00 00       	jmp    10258e <__alltraps>

00101e38 <vector90>:
.globl vector90
vector90:
  pushl $0
  101e38:	6a 00                	push   $0x0
  pushl $90
  101e3a:	6a 5a                	push   $0x5a
  jmp __alltraps
  101e3c:	e9 4d 07 00 00       	jmp    10258e <__alltraps>

00101e41 <vector91>:
.globl vector91
vector91:
  pushl $0
  101e41:	6a 00                	push   $0x0
  pushl $91
  101e43:	6a 5b                	push   $0x5b
  jmp __alltraps
  101e45:	e9 44 07 00 00       	jmp    10258e <__alltraps>

00101e4a <vector92>:
.globl vector92
vector92:
  pushl $0
  101e4a:	6a 00                	push   $0x0
  pushl $92
  101e4c:	6a 5c                	push   $0x5c
  jmp __alltraps
  101e4e:	e9 3b 07 00 00       	jmp    10258e <__alltraps>

00101e53 <vector93>:
.globl vector93
vector93:
  pushl $0
  101e53:	6a 00                	push   $0x0
  pushl $93
  101e55:	6a 5d                	push   $0x5d
  jmp __alltraps
  101e57:	e9 32 07 00 00       	jmp    10258e <__alltraps>

00101e5c <vector94>:
.globl vector94
vector94:
  pushl $0
  101e5c:	6a 00                	push   $0x0
  pushl $94
  101e5e:	6a 5e                	push   $0x5e
  jmp __alltraps
  101e60:	e9 29 07 00 00       	jmp    10258e <__alltraps>

00101e65 <vector95>:
.globl vector95
vector95:
  pushl $0
  101e65:	6a 00                	push   $0x0
  pushl $95
  101e67:	6a 5f                	push   $0x5f
  jmp __alltraps
  101e69:	e9 20 07 00 00       	jmp    10258e <__alltraps>

00101e6e <vector96>:
.globl vector96
vector96:
  pushl $0
  101e6e:	6a 00                	push   $0x0
  pushl $96
  101e70:	6a 60                	push   $0x60
  jmp __alltraps
  101e72:	e9 17 07 00 00       	jmp    10258e <__alltraps>

00101e77 <vector97>:
.globl vector97
vector97:
  pushl $0
  101e77:	6a 00                	push   $0x0
  pushl $97
  101e79:	6a 61                	push   $0x61
  jmp __alltraps
  101e7b:	e9 0e 07 00 00       	jmp    10258e <__alltraps>

00101e80 <vector98>:
.globl vector98
vector98:
  pushl $0
  101e80:	6a 00                	push   $0x0
  pushl $98
  101e82:	6a 62                	push   $0x62
  jmp __alltraps
  101e84:	e9 05 07 00 00       	jmp    10258e <__alltraps>

00101e89 <vector99>:
.globl vector99
vector99:
  pushl $0
  101e89:	6a 00                	push   $0x0
  pushl $99
  101e8b:	6a 63                	push   $0x63
  jmp __alltraps
  101e8d:	e9 fc 06 00 00       	jmp    10258e <__alltraps>

00101e92 <vector100>:
.globl vector100
vector100:
  pushl $0
  101e92:	6a 00                	push   $0x0
  pushl $100
  101e94:	6a 64                	push   $0x64
  jmp __alltraps
  101e96:	e9 f3 06 00 00       	jmp    10258e <__alltraps>

00101e9b <vector101>:
.globl vector101
vector101:
  pushl $0
  101e9b:	6a 00                	push   $0x0
  pushl $101
  101e9d:	6a 65                	push   $0x65
  jmp __alltraps
  101e9f:	e9 ea 06 00 00       	jmp    10258e <__alltraps>

00101ea4 <vector102>:
.globl vector102
vector102:
  pushl $0
  101ea4:	6a 00                	push   $0x0
  pushl $102
  101ea6:	6a 66                	push   $0x66
  jmp __alltraps
  101ea8:	e9 e1 06 00 00       	jmp    10258e <__alltraps>

00101ead <vector103>:
.globl vector103
vector103:
  pushl $0
  101ead:	6a 00                	push   $0x0
  pushl $103
  101eaf:	6a 67                	push   $0x67
  jmp __alltraps
  101eb1:	e9 d8 06 00 00       	jmp    10258e <__alltraps>

00101eb6 <vector104>:
.globl vector104
vector104:
  pushl $0
  101eb6:	6a 00                	push   $0x0
  pushl $104
  101eb8:	6a 68                	push   $0x68
  jmp __alltraps
  101eba:	e9 cf 06 00 00       	jmp    10258e <__alltraps>

00101ebf <vector105>:
.globl vector105
vector105:
  pushl $0
  101ebf:	6a 00                	push   $0x0
  pushl $105
  101ec1:	6a 69                	push   $0x69
  jmp __alltraps
  101ec3:	e9 c6 06 00 00       	jmp    10258e <__alltraps>

00101ec8 <vector106>:
.globl vector106
vector106:
  pushl $0
  101ec8:	6a 00                	push   $0x0
  pushl $106
  101eca:	6a 6a                	push   $0x6a
  jmp __alltraps
  101ecc:	e9 bd 06 00 00       	jmp    10258e <__alltraps>

00101ed1 <vector107>:
.globl vector107
vector107:
  pushl $0
  101ed1:	6a 00                	push   $0x0
  pushl $107
  101ed3:	6a 6b                	push   $0x6b
  jmp __alltraps
  101ed5:	e9 b4 06 00 00       	jmp    10258e <__alltraps>

00101eda <vector108>:
.globl vector108
vector108:
  pushl $0
  101eda:	6a 00                	push   $0x0
  pushl $108
  101edc:	6a 6c                	push   $0x6c
  jmp __alltraps
  101ede:	e9 ab 06 00 00       	jmp    10258e <__alltraps>

00101ee3 <vector109>:
.globl vector109
vector109:
  pushl $0
  101ee3:	6a 00                	push   $0x0
  pushl $109
  101ee5:	6a 6d                	push   $0x6d
  jmp __alltraps
  101ee7:	e9 a2 06 00 00       	jmp    10258e <__alltraps>

00101eec <vector110>:
.globl vector110
vector110:
  pushl $0
  101eec:	6a 00                	push   $0x0
  pushl $110
  101eee:	6a 6e                	push   $0x6e
  jmp __alltraps
  101ef0:	e9 99 06 00 00       	jmp    10258e <__alltraps>

00101ef5 <vector111>:
.globl vector111
vector111:
  pushl $0
  101ef5:	6a 00                	push   $0x0
  pushl $111
  101ef7:	6a 6f                	push   $0x6f
  jmp __alltraps
  101ef9:	e9 90 06 00 00       	jmp    10258e <__alltraps>

00101efe <vector112>:
.globl vector112
vector112:
  pushl $0
  101efe:	6a 00                	push   $0x0
  pushl $112
  101f00:	6a 70                	push   $0x70
  jmp __alltraps
  101f02:	e9 87 06 00 00       	jmp    10258e <__alltraps>

00101f07 <vector113>:
.globl vector113
vector113:
  pushl $0
  101f07:	6a 00                	push   $0x0
  pushl $113
  101f09:	6a 71                	push   $0x71
  jmp __alltraps
  101f0b:	e9 7e 06 00 00       	jmp    10258e <__alltraps>

00101f10 <vector114>:
.globl vector114
vector114:
  pushl $0
  101f10:	6a 00                	push   $0x0
  pushl $114
  101f12:	6a 72                	push   $0x72
  jmp __alltraps
  101f14:	e9 75 06 00 00       	jmp    10258e <__alltraps>

00101f19 <vector115>:
.globl vector115
vector115:
  pushl $0
  101f19:	6a 00                	push   $0x0
  pushl $115
  101f1b:	6a 73                	push   $0x73
  jmp __alltraps
  101f1d:	e9 6c 06 00 00       	jmp    10258e <__alltraps>

00101f22 <vector116>:
.globl vector116
vector116:
  pushl $0
  101f22:	6a 00                	push   $0x0
  pushl $116
  101f24:	6a 74                	push   $0x74
  jmp __alltraps
  101f26:	e9 63 06 00 00       	jmp    10258e <__alltraps>

00101f2b <vector117>:
.globl vector117
vector117:
  pushl $0
  101f2b:	6a 00                	push   $0x0
  pushl $117
  101f2d:	6a 75                	push   $0x75
  jmp __alltraps
  101f2f:	e9 5a 06 00 00       	jmp    10258e <__alltraps>

00101f34 <vector118>:
.globl vector118
vector118:
  pushl $0
  101f34:	6a 00                	push   $0x0
  pushl $118
  101f36:	6a 76                	push   $0x76
  jmp __alltraps
  101f38:	e9 51 06 00 00       	jmp    10258e <__alltraps>

00101f3d <vector119>:
.globl vector119
vector119:
  pushl $0
  101f3d:	6a 00                	push   $0x0
  pushl $119
  101f3f:	6a 77                	push   $0x77
  jmp __alltraps
  101f41:	e9 48 06 00 00       	jmp    10258e <__alltraps>

00101f46 <vector120>:
.globl vector120
vector120:
  pushl $0
  101f46:	6a 00                	push   $0x0
  pushl $120
  101f48:	6a 78                	push   $0x78
  jmp __alltraps
  101f4a:	e9 3f 06 00 00       	jmp    10258e <__alltraps>

00101f4f <vector121>:
.globl vector121
vector121:
  pushl $0
  101f4f:	6a 00                	push   $0x0
  pushl $121
  101f51:	6a 79                	push   $0x79
  jmp __alltraps
  101f53:	e9 36 06 00 00       	jmp    10258e <__alltraps>

00101f58 <vector122>:
.globl vector122
vector122:
  pushl $0
  101f58:	6a 00                	push   $0x0
  pushl $122
  101f5a:	6a 7a                	push   $0x7a
  jmp __alltraps
  101f5c:	e9 2d 06 00 00       	jmp    10258e <__alltraps>

00101f61 <vector123>:
.globl vector123
vector123:
  pushl $0
  101f61:	6a 00                	push   $0x0
  pushl $123
  101f63:	6a 7b                	push   $0x7b
  jmp __alltraps
  101f65:	e9 24 06 00 00       	jmp    10258e <__alltraps>

00101f6a <vector124>:
.globl vector124
vector124:
  pushl $0
  101f6a:	6a 00                	push   $0x0
  pushl $124
  101f6c:	6a 7c                	push   $0x7c
  jmp __alltraps
  101f6e:	e9 1b 06 00 00       	jmp    10258e <__alltraps>

00101f73 <vector125>:
.globl vector125
vector125:
  pushl $0
  101f73:	6a 00                	push   $0x0
  pushl $125
  101f75:	6a 7d                	push   $0x7d
  jmp __alltraps
  101f77:	e9 12 06 00 00       	jmp    10258e <__alltraps>

00101f7c <vector126>:
.globl vector126
vector126:
  pushl $0
  101f7c:	6a 00                	push   $0x0
  pushl $126
  101f7e:	6a 7e                	push   $0x7e
  jmp __alltraps
  101f80:	e9 09 06 00 00       	jmp    10258e <__alltraps>

00101f85 <vector127>:
.globl vector127
vector127:
  pushl $0
  101f85:	6a 00                	push   $0x0
  pushl $127
  101f87:	6a 7f                	push   $0x7f
  jmp __alltraps
  101f89:	e9 00 06 00 00       	jmp    10258e <__alltraps>

00101f8e <vector128>:
.globl vector128
vector128:
  pushl $0
  101f8e:	6a 00                	push   $0x0
  pushl $128
  101f90:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  101f95:	e9 f4 05 00 00       	jmp    10258e <__alltraps>

00101f9a <vector129>:
.globl vector129
vector129:
  pushl $0
  101f9a:	6a 00                	push   $0x0
  pushl $129
  101f9c:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  101fa1:	e9 e8 05 00 00       	jmp    10258e <__alltraps>

00101fa6 <vector130>:
.globl vector130
vector130:
  pushl $0
  101fa6:	6a 00                	push   $0x0
  pushl $130
  101fa8:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  101fad:	e9 dc 05 00 00       	jmp    10258e <__alltraps>

00101fb2 <vector131>:
.globl vector131
vector131:
  pushl $0
  101fb2:	6a 00                	push   $0x0
  pushl $131
  101fb4:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  101fb9:	e9 d0 05 00 00       	jmp    10258e <__alltraps>

00101fbe <vector132>:
.globl vector132
vector132:
  pushl $0
  101fbe:	6a 00                	push   $0x0
  pushl $132
  101fc0:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  101fc5:	e9 c4 05 00 00       	jmp    10258e <__alltraps>

00101fca <vector133>:
.globl vector133
vector133:
  pushl $0
  101fca:	6a 00                	push   $0x0
  pushl $133
  101fcc:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  101fd1:	e9 b8 05 00 00       	jmp    10258e <__alltraps>

00101fd6 <vector134>:
.globl vector134
vector134:
  pushl $0
  101fd6:	6a 00                	push   $0x0
  pushl $134
  101fd8:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  101fdd:	e9 ac 05 00 00       	jmp    10258e <__alltraps>

00101fe2 <vector135>:
.globl vector135
vector135:
  pushl $0
  101fe2:	6a 00                	push   $0x0
  pushl $135
  101fe4:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  101fe9:	e9 a0 05 00 00       	jmp    10258e <__alltraps>

00101fee <vector136>:
.globl vector136
vector136:
  pushl $0
  101fee:	6a 00                	push   $0x0
  pushl $136
  101ff0:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  101ff5:	e9 94 05 00 00       	jmp    10258e <__alltraps>

00101ffa <vector137>:
.globl vector137
vector137:
  pushl $0
  101ffa:	6a 00                	push   $0x0
  pushl $137
  101ffc:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102001:	e9 88 05 00 00       	jmp    10258e <__alltraps>

00102006 <vector138>:
.globl vector138
vector138:
  pushl $0
  102006:	6a 00                	push   $0x0
  pushl $138
  102008:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10200d:	e9 7c 05 00 00       	jmp    10258e <__alltraps>

00102012 <vector139>:
.globl vector139
vector139:
  pushl $0
  102012:	6a 00                	push   $0x0
  pushl $139
  102014:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102019:	e9 70 05 00 00       	jmp    10258e <__alltraps>

0010201e <vector140>:
.globl vector140
vector140:
  pushl $0
  10201e:	6a 00                	push   $0x0
  pushl $140
  102020:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102025:	e9 64 05 00 00       	jmp    10258e <__alltraps>

0010202a <vector141>:
.globl vector141
vector141:
  pushl $0
  10202a:	6a 00                	push   $0x0
  pushl $141
  10202c:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102031:	e9 58 05 00 00       	jmp    10258e <__alltraps>

00102036 <vector142>:
.globl vector142
vector142:
  pushl $0
  102036:	6a 00                	push   $0x0
  pushl $142
  102038:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  10203d:	e9 4c 05 00 00       	jmp    10258e <__alltraps>

00102042 <vector143>:
.globl vector143
vector143:
  pushl $0
  102042:	6a 00                	push   $0x0
  pushl $143
  102044:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102049:	e9 40 05 00 00       	jmp    10258e <__alltraps>

0010204e <vector144>:
.globl vector144
vector144:
  pushl $0
  10204e:	6a 00                	push   $0x0
  pushl $144
  102050:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102055:	e9 34 05 00 00       	jmp    10258e <__alltraps>

0010205a <vector145>:
.globl vector145
vector145:
  pushl $0
  10205a:	6a 00                	push   $0x0
  pushl $145
  10205c:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102061:	e9 28 05 00 00       	jmp    10258e <__alltraps>

00102066 <vector146>:
.globl vector146
vector146:
  pushl $0
  102066:	6a 00                	push   $0x0
  pushl $146
  102068:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10206d:	e9 1c 05 00 00       	jmp    10258e <__alltraps>

00102072 <vector147>:
.globl vector147
vector147:
  pushl $0
  102072:	6a 00                	push   $0x0
  pushl $147
  102074:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102079:	e9 10 05 00 00       	jmp    10258e <__alltraps>

0010207e <vector148>:
.globl vector148
vector148:
  pushl $0
  10207e:	6a 00                	push   $0x0
  pushl $148
  102080:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102085:	e9 04 05 00 00       	jmp    10258e <__alltraps>

0010208a <vector149>:
.globl vector149
vector149:
  pushl $0
  10208a:	6a 00                	push   $0x0
  pushl $149
  10208c:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102091:	e9 f8 04 00 00       	jmp    10258e <__alltraps>

00102096 <vector150>:
.globl vector150
vector150:
  pushl $0
  102096:	6a 00                	push   $0x0
  pushl $150
  102098:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10209d:	e9 ec 04 00 00       	jmp    10258e <__alltraps>

001020a2 <vector151>:
.globl vector151
vector151:
  pushl $0
  1020a2:	6a 00                	push   $0x0
  pushl $151
  1020a4:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1020a9:	e9 e0 04 00 00       	jmp    10258e <__alltraps>

001020ae <vector152>:
.globl vector152
vector152:
  pushl $0
  1020ae:	6a 00                	push   $0x0
  pushl $152
  1020b0:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1020b5:	e9 d4 04 00 00       	jmp    10258e <__alltraps>

001020ba <vector153>:
.globl vector153
vector153:
  pushl $0
  1020ba:	6a 00                	push   $0x0
  pushl $153
  1020bc:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1020c1:	e9 c8 04 00 00       	jmp    10258e <__alltraps>

001020c6 <vector154>:
.globl vector154
vector154:
  pushl $0
  1020c6:	6a 00                	push   $0x0
  pushl $154
  1020c8:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1020cd:	e9 bc 04 00 00       	jmp    10258e <__alltraps>

001020d2 <vector155>:
.globl vector155
vector155:
  pushl $0
  1020d2:	6a 00                	push   $0x0
  pushl $155
  1020d4:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1020d9:	e9 b0 04 00 00       	jmp    10258e <__alltraps>

001020de <vector156>:
.globl vector156
vector156:
  pushl $0
  1020de:	6a 00                	push   $0x0
  pushl $156
  1020e0:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1020e5:	e9 a4 04 00 00       	jmp    10258e <__alltraps>

001020ea <vector157>:
.globl vector157
vector157:
  pushl $0
  1020ea:	6a 00                	push   $0x0
  pushl $157
  1020ec:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1020f1:	e9 98 04 00 00       	jmp    10258e <__alltraps>

001020f6 <vector158>:
.globl vector158
vector158:
  pushl $0
  1020f6:	6a 00                	push   $0x0
  pushl $158
  1020f8:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1020fd:	e9 8c 04 00 00       	jmp    10258e <__alltraps>

00102102 <vector159>:
.globl vector159
vector159:
  pushl $0
  102102:	6a 00                	push   $0x0
  pushl $159
  102104:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102109:	e9 80 04 00 00       	jmp    10258e <__alltraps>

0010210e <vector160>:
.globl vector160
vector160:
  pushl $0
  10210e:	6a 00                	push   $0x0
  pushl $160
  102110:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102115:	e9 74 04 00 00       	jmp    10258e <__alltraps>

0010211a <vector161>:
.globl vector161
vector161:
  pushl $0
  10211a:	6a 00                	push   $0x0
  pushl $161
  10211c:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102121:	e9 68 04 00 00       	jmp    10258e <__alltraps>

00102126 <vector162>:
.globl vector162
vector162:
  pushl $0
  102126:	6a 00                	push   $0x0
  pushl $162
  102128:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10212d:	e9 5c 04 00 00       	jmp    10258e <__alltraps>

00102132 <vector163>:
.globl vector163
vector163:
  pushl $0
  102132:	6a 00                	push   $0x0
  pushl $163
  102134:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102139:	e9 50 04 00 00       	jmp    10258e <__alltraps>

0010213e <vector164>:
.globl vector164
vector164:
  pushl $0
  10213e:	6a 00                	push   $0x0
  pushl $164
  102140:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102145:	e9 44 04 00 00       	jmp    10258e <__alltraps>

0010214a <vector165>:
.globl vector165
vector165:
  pushl $0
  10214a:	6a 00                	push   $0x0
  pushl $165
  10214c:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102151:	e9 38 04 00 00       	jmp    10258e <__alltraps>

00102156 <vector166>:
.globl vector166
vector166:
  pushl $0
  102156:	6a 00                	push   $0x0
  pushl $166
  102158:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10215d:	e9 2c 04 00 00       	jmp    10258e <__alltraps>

00102162 <vector167>:
.globl vector167
vector167:
  pushl $0
  102162:	6a 00                	push   $0x0
  pushl $167
  102164:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102169:	e9 20 04 00 00       	jmp    10258e <__alltraps>

0010216e <vector168>:
.globl vector168
vector168:
  pushl $0
  10216e:	6a 00                	push   $0x0
  pushl $168
  102170:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102175:	e9 14 04 00 00       	jmp    10258e <__alltraps>

0010217a <vector169>:
.globl vector169
vector169:
  pushl $0
  10217a:	6a 00                	push   $0x0
  pushl $169
  10217c:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102181:	e9 08 04 00 00       	jmp    10258e <__alltraps>

00102186 <vector170>:
.globl vector170
vector170:
  pushl $0
  102186:	6a 00                	push   $0x0
  pushl $170
  102188:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10218d:	e9 fc 03 00 00       	jmp    10258e <__alltraps>

00102192 <vector171>:
.globl vector171
vector171:
  pushl $0
  102192:	6a 00                	push   $0x0
  pushl $171
  102194:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102199:	e9 f0 03 00 00       	jmp    10258e <__alltraps>

0010219e <vector172>:
.globl vector172
vector172:
  pushl $0
  10219e:	6a 00                	push   $0x0
  pushl $172
  1021a0:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1021a5:	e9 e4 03 00 00       	jmp    10258e <__alltraps>

001021aa <vector173>:
.globl vector173
vector173:
  pushl $0
  1021aa:	6a 00                	push   $0x0
  pushl $173
  1021ac:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1021b1:	e9 d8 03 00 00       	jmp    10258e <__alltraps>

001021b6 <vector174>:
.globl vector174
vector174:
  pushl $0
  1021b6:	6a 00                	push   $0x0
  pushl $174
  1021b8:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1021bd:	e9 cc 03 00 00       	jmp    10258e <__alltraps>

001021c2 <vector175>:
.globl vector175
vector175:
  pushl $0
  1021c2:	6a 00                	push   $0x0
  pushl $175
  1021c4:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1021c9:	e9 c0 03 00 00       	jmp    10258e <__alltraps>

001021ce <vector176>:
.globl vector176
vector176:
  pushl $0
  1021ce:	6a 00                	push   $0x0
  pushl $176
  1021d0:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1021d5:	e9 b4 03 00 00       	jmp    10258e <__alltraps>

001021da <vector177>:
.globl vector177
vector177:
  pushl $0
  1021da:	6a 00                	push   $0x0
  pushl $177
  1021dc:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1021e1:	e9 a8 03 00 00       	jmp    10258e <__alltraps>

001021e6 <vector178>:
.globl vector178
vector178:
  pushl $0
  1021e6:	6a 00                	push   $0x0
  pushl $178
  1021e8:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1021ed:	e9 9c 03 00 00       	jmp    10258e <__alltraps>

001021f2 <vector179>:
.globl vector179
vector179:
  pushl $0
  1021f2:	6a 00                	push   $0x0
  pushl $179
  1021f4:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1021f9:	e9 90 03 00 00       	jmp    10258e <__alltraps>

001021fe <vector180>:
.globl vector180
vector180:
  pushl $0
  1021fe:	6a 00                	push   $0x0
  pushl $180
  102200:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102205:	e9 84 03 00 00       	jmp    10258e <__alltraps>

0010220a <vector181>:
.globl vector181
vector181:
  pushl $0
  10220a:	6a 00                	push   $0x0
  pushl $181
  10220c:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102211:	e9 78 03 00 00       	jmp    10258e <__alltraps>

00102216 <vector182>:
.globl vector182
vector182:
  pushl $0
  102216:	6a 00                	push   $0x0
  pushl $182
  102218:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10221d:	e9 6c 03 00 00       	jmp    10258e <__alltraps>

00102222 <vector183>:
.globl vector183
vector183:
  pushl $0
  102222:	6a 00                	push   $0x0
  pushl $183
  102224:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102229:	e9 60 03 00 00       	jmp    10258e <__alltraps>

0010222e <vector184>:
.globl vector184
vector184:
  pushl $0
  10222e:	6a 00                	push   $0x0
  pushl $184
  102230:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102235:	e9 54 03 00 00       	jmp    10258e <__alltraps>

0010223a <vector185>:
.globl vector185
vector185:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $185
  10223c:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102241:	e9 48 03 00 00       	jmp    10258e <__alltraps>

00102246 <vector186>:
.globl vector186
vector186:
  pushl $0
  102246:	6a 00                	push   $0x0
  pushl $186
  102248:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10224d:	e9 3c 03 00 00       	jmp    10258e <__alltraps>

00102252 <vector187>:
.globl vector187
vector187:
  pushl $0
  102252:	6a 00                	push   $0x0
  pushl $187
  102254:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102259:	e9 30 03 00 00       	jmp    10258e <__alltraps>

0010225e <vector188>:
.globl vector188
vector188:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $188
  102260:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102265:	e9 24 03 00 00       	jmp    10258e <__alltraps>

0010226a <vector189>:
.globl vector189
vector189:
  pushl $0
  10226a:	6a 00                	push   $0x0
  pushl $189
  10226c:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102271:	e9 18 03 00 00       	jmp    10258e <__alltraps>

00102276 <vector190>:
.globl vector190
vector190:
  pushl $0
  102276:	6a 00                	push   $0x0
  pushl $190
  102278:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10227d:	e9 0c 03 00 00       	jmp    10258e <__alltraps>

00102282 <vector191>:
.globl vector191
vector191:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $191
  102284:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102289:	e9 00 03 00 00       	jmp    10258e <__alltraps>

0010228e <vector192>:
.globl vector192
vector192:
  pushl $0
  10228e:	6a 00                	push   $0x0
  pushl $192
  102290:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102295:	e9 f4 02 00 00       	jmp    10258e <__alltraps>

0010229a <vector193>:
.globl vector193
vector193:
  pushl $0
  10229a:	6a 00                	push   $0x0
  pushl $193
  10229c:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1022a1:	e9 e8 02 00 00       	jmp    10258e <__alltraps>

001022a6 <vector194>:
.globl vector194
vector194:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $194
  1022a8:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1022ad:	e9 dc 02 00 00       	jmp    10258e <__alltraps>

001022b2 <vector195>:
.globl vector195
vector195:
  pushl $0
  1022b2:	6a 00                	push   $0x0
  pushl $195
  1022b4:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1022b9:	e9 d0 02 00 00       	jmp    10258e <__alltraps>

001022be <vector196>:
.globl vector196
vector196:
  pushl $0
  1022be:	6a 00                	push   $0x0
  pushl $196
  1022c0:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1022c5:	e9 c4 02 00 00       	jmp    10258e <__alltraps>

001022ca <vector197>:
.globl vector197
vector197:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $197
  1022cc:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1022d1:	e9 b8 02 00 00       	jmp    10258e <__alltraps>

001022d6 <vector198>:
.globl vector198
vector198:
  pushl $0
  1022d6:	6a 00                	push   $0x0
  pushl $198
  1022d8:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1022dd:	e9 ac 02 00 00       	jmp    10258e <__alltraps>

001022e2 <vector199>:
.globl vector199
vector199:
  pushl $0
  1022e2:	6a 00                	push   $0x0
  pushl $199
  1022e4:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1022e9:	e9 a0 02 00 00       	jmp    10258e <__alltraps>

001022ee <vector200>:
.globl vector200
vector200:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $200
  1022f0:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1022f5:	e9 94 02 00 00       	jmp    10258e <__alltraps>

001022fa <vector201>:
.globl vector201
vector201:
  pushl $0
  1022fa:	6a 00                	push   $0x0
  pushl $201
  1022fc:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102301:	e9 88 02 00 00       	jmp    10258e <__alltraps>

00102306 <vector202>:
.globl vector202
vector202:
  pushl $0
  102306:	6a 00                	push   $0x0
  pushl $202
  102308:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10230d:	e9 7c 02 00 00       	jmp    10258e <__alltraps>

00102312 <vector203>:
.globl vector203
vector203:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $203
  102314:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102319:	e9 70 02 00 00       	jmp    10258e <__alltraps>

0010231e <vector204>:
.globl vector204
vector204:
  pushl $0
  10231e:	6a 00                	push   $0x0
  pushl $204
  102320:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102325:	e9 64 02 00 00       	jmp    10258e <__alltraps>

0010232a <vector205>:
.globl vector205
vector205:
  pushl $0
  10232a:	6a 00                	push   $0x0
  pushl $205
  10232c:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102331:	e9 58 02 00 00       	jmp    10258e <__alltraps>

00102336 <vector206>:
.globl vector206
vector206:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $206
  102338:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  10233d:	e9 4c 02 00 00       	jmp    10258e <__alltraps>

00102342 <vector207>:
.globl vector207
vector207:
  pushl $0
  102342:	6a 00                	push   $0x0
  pushl $207
  102344:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102349:	e9 40 02 00 00       	jmp    10258e <__alltraps>

0010234e <vector208>:
.globl vector208
vector208:
  pushl $0
  10234e:	6a 00                	push   $0x0
  pushl $208
  102350:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102355:	e9 34 02 00 00       	jmp    10258e <__alltraps>

0010235a <vector209>:
.globl vector209
vector209:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $209
  10235c:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102361:	e9 28 02 00 00       	jmp    10258e <__alltraps>

00102366 <vector210>:
.globl vector210
vector210:
  pushl $0
  102366:	6a 00                	push   $0x0
  pushl $210
  102368:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10236d:	e9 1c 02 00 00       	jmp    10258e <__alltraps>

00102372 <vector211>:
.globl vector211
vector211:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $211
  102374:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102379:	e9 10 02 00 00       	jmp    10258e <__alltraps>

0010237e <vector212>:
.globl vector212
vector212:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $212
  102380:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102385:	e9 04 02 00 00       	jmp    10258e <__alltraps>

0010238a <vector213>:
.globl vector213
vector213:
  pushl $0
  10238a:	6a 00                	push   $0x0
  pushl $213
  10238c:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102391:	e9 f8 01 00 00       	jmp    10258e <__alltraps>

00102396 <vector214>:
.globl vector214
vector214:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $214
  102398:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10239d:	e9 ec 01 00 00       	jmp    10258e <__alltraps>

001023a2 <vector215>:
.globl vector215
vector215:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $215
  1023a4:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1023a9:	e9 e0 01 00 00       	jmp    10258e <__alltraps>

001023ae <vector216>:
.globl vector216
vector216:
  pushl $0
  1023ae:	6a 00                	push   $0x0
  pushl $216
  1023b0:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1023b5:	e9 d4 01 00 00       	jmp    10258e <__alltraps>

001023ba <vector217>:
.globl vector217
vector217:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $217
  1023bc:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1023c1:	e9 c8 01 00 00       	jmp    10258e <__alltraps>

001023c6 <vector218>:
.globl vector218
vector218:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $218
  1023c8:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1023cd:	e9 bc 01 00 00       	jmp    10258e <__alltraps>

001023d2 <vector219>:
.globl vector219
vector219:
  pushl $0
  1023d2:	6a 00                	push   $0x0
  pushl $219
  1023d4:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1023d9:	e9 b0 01 00 00       	jmp    10258e <__alltraps>

001023de <vector220>:
.globl vector220
vector220:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $220
  1023e0:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1023e5:	e9 a4 01 00 00       	jmp    10258e <__alltraps>

001023ea <vector221>:
.globl vector221
vector221:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $221
  1023ec:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1023f1:	e9 98 01 00 00       	jmp    10258e <__alltraps>

001023f6 <vector222>:
.globl vector222
vector222:
  pushl $0
  1023f6:	6a 00                	push   $0x0
  pushl $222
  1023f8:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1023fd:	e9 8c 01 00 00       	jmp    10258e <__alltraps>

00102402 <vector223>:
.globl vector223
vector223:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $223
  102404:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102409:	e9 80 01 00 00       	jmp    10258e <__alltraps>

0010240e <vector224>:
.globl vector224
vector224:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $224
  102410:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102415:	e9 74 01 00 00       	jmp    10258e <__alltraps>

0010241a <vector225>:
.globl vector225
vector225:
  pushl $0
  10241a:	6a 00                	push   $0x0
  pushl $225
  10241c:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102421:	e9 68 01 00 00       	jmp    10258e <__alltraps>

00102426 <vector226>:
.globl vector226
vector226:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $226
  102428:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10242d:	e9 5c 01 00 00       	jmp    10258e <__alltraps>

00102432 <vector227>:
.globl vector227
vector227:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $227
  102434:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102439:	e9 50 01 00 00       	jmp    10258e <__alltraps>

0010243e <vector228>:
.globl vector228
vector228:
  pushl $0
  10243e:	6a 00                	push   $0x0
  pushl $228
  102440:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102445:	e9 44 01 00 00       	jmp    10258e <__alltraps>

0010244a <vector229>:
.globl vector229
vector229:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $229
  10244c:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102451:	e9 38 01 00 00       	jmp    10258e <__alltraps>

00102456 <vector230>:
.globl vector230
vector230:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $230
  102458:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10245d:	e9 2c 01 00 00       	jmp    10258e <__alltraps>

00102462 <vector231>:
.globl vector231
vector231:
  pushl $0
  102462:	6a 00                	push   $0x0
  pushl $231
  102464:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102469:	e9 20 01 00 00       	jmp    10258e <__alltraps>

0010246e <vector232>:
.globl vector232
vector232:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $232
  102470:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102475:	e9 14 01 00 00       	jmp    10258e <__alltraps>

0010247a <vector233>:
.globl vector233
vector233:
  pushl $0
  10247a:	6a 00                	push   $0x0
  pushl $233
  10247c:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102481:	e9 08 01 00 00       	jmp    10258e <__alltraps>

00102486 <vector234>:
.globl vector234
vector234:
  pushl $0
  102486:	6a 00                	push   $0x0
  pushl $234
  102488:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10248d:	e9 fc 00 00 00       	jmp    10258e <__alltraps>

00102492 <vector235>:
.globl vector235
vector235:
  pushl $0
  102492:	6a 00                	push   $0x0
  pushl $235
  102494:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102499:	e9 f0 00 00 00       	jmp    10258e <__alltraps>

0010249e <vector236>:
.globl vector236
vector236:
  pushl $0
  10249e:	6a 00                	push   $0x0
  pushl $236
  1024a0:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1024a5:	e9 e4 00 00 00       	jmp    10258e <__alltraps>

001024aa <vector237>:
.globl vector237
vector237:
  pushl $0
  1024aa:	6a 00                	push   $0x0
  pushl $237
  1024ac:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1024b1:	e9 d8 00 00 00       	jmp    10258e <__alltraps>

001024b6 <vector238>:
.globl vector238
vector238:
  pushl $0
  1024b6:	6a 00                	push   $0x0
  pushl $238
  1024b8:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1024bd:	e9 cc 00 00 00       	jmp    10258e <__alltraps>

001024c2 <vector239>:
.globl vector239
vector239:
  pushl $0
  1024c2:	6a 00                	push   $0x0
  pushl $239
  1024c4:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1024c9:	e9 c0 00 00 00       	jmp    10258e <__alltraps>

001024ce <vector240>:
.globl vector240
vector240:
  pushl $0
  1024ce:	6a 00                	push   $0x0
  pushl $240
  1024d0:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1024d5:	e9 b4 00 00 00       	jmp    10258e <__alltraps>

001024da <vector241>:
.globl vector241
vector241:
  pushl $0
  1024da:	6a 00                	push   $0x0
  pushl $241
  1024dc:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1024e1:	e9 a8 00 00 00       	jmp    10258e <__alltraps>

001024e6 <vector242>:
.globl vector242
vector242:
  pushl $0
  1024e6:	6a 00                	push   $0x0
  pushl $242
  1024e8:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1024ed:	e9 9c 00 00 00       	jmp    10258e <__alltraps>

001024f2 <vector243>:
.globl vector243
vector243:
  pushl $0
  1024f2:	6a 00                	push   $0x0
  pushl $243
  1024f4:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1024f9:	e9 90 00 00 00       	jmp    10258e <__alltraps>

001024fe <vector244>:
.globl vector244
vector244:
  pushl $0
  1024fe:	6a 00                	push   $0x0
  pushl $244
  102500:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102505:	e9 84 00 00 00       	jmp    10258e <__alltraps>

0010250a <vector245>:
.globl vector245
vector245:
  pushl $0
  10250a:	6a 00                	push   $0x0
  pushl $245
  10250c:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102511:	e9 78 00 00 00       	jmp    10258e <__alltraps>

00102516 <vector246>:
.globl vector246
vector246:
  pushl $0
  102516:	6a 00                	push   $0x0
  pushl $246
  102518:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10251d:	e9 6c 00 00 00       	jmp    10258e <__alltraps>

00102522 <vector247>:
.globl vector247
vector247:
  pushl $0
  102522:	6a 00                	push   $0x0
  pushl $247
  102524:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102529:	e9 60 00 00 00       	jmp    10258e <__alltraps>

0010252e <vector248>:
.globl vector248
vector248:
  pushl $0
  10252e:	6a 00                	push   $0x0
  pushl $248
  102530:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102535:	e9 54 00 00 00       	jmp    10258e <__alltraps>

0010253a <vector249>:
.globl vector249
vector249:
  pushl $0
  10253a:	6a 00                	push   $0x0
  pushl $249
  10253c:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102541:	e9 48 00 00 00       	jmp    10258e <__alltraps>

00102546 <vector250>:
.globl vector250
vector250:
  pushl $0
  102546:	6a 00                	push   $0x0
  pushl $250
  102548:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  10254d:	e9 3c 00 00 00       	jmp    10258e <__alltraps>

00102552 <vector251>:
.globl vector251
vector251:
  pushl $0
  102552:	6a 00                	push   $0x0
  pushl $251
  102554:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102559:	e9 30 00 00 00       	jmp    10258e <__alltraps>

0010255e <vector252>:
.globl vector252
vector252:
  pushl $0
  10255e:	6a 00                	push   $0x0
  pushl $252
  102560:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102565:	e9 24 00 00 00       	jmp    10258e <__alltraps>

0010256a <vector253>:
.globl vector253
vector253:
  pushl $0
  10256a:	6a 00                	push   $0x0
  pushl $253
  10256c:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102571:	e9 18 00 00 00       	jmp    10258e <__alltraps>

00102576 <vector254>:
.globl vector254
vector254:
  pushl $0
  102576:	6a 00                	push   $0x0
  pushl $254
  102578:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  10257d:	e9 0c 00 00 00       	jmp    10258e <__alltraps>

00102582 <vector255>:
.globl vector255
vector255:
  pushl $0
  102582:	6a 00                	push   $0x0
  pushl $255
  102584:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102589:	e9 00 00 00 00       	jmp    10258e <__alltraps>

0010258e <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  10258e:	1e                   	push   %ds
    pushl %es
  10258f:	06                   	push   %es
    pushl %fs
  102590:	0f a0                	push   %fs
    pushl %gs
  102592:	0f a8                	push   %gs
    pushal
  102594:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102595:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  10259a:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  10259c:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  10259e:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  10259f:	e8 61 f5 ff ff       	call   101b05 <trap>

    # pop the pushed stack pointer
    popl %esp
  1025a4:	5c                   	pop    %esp

001025a5 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1025a5:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1025a6:	0f a9                	pop    %gs
    popl %fs
  1025a8:	0f a1                	pop    %fs
    popl %es
  1025aa:	07                   	pop    %es
    popl %ds
  1025ab:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1025ac:	83 c4 08             	add    $0x8,%esp
    iret
  1025af:	cf                   	iret   

001025b0 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1025b0:	55                   	push   %ebp
  1025b1:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1025b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1025b6:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  1025b9:	b8 23 00 00 00       	mov    $0x23,%eax
  1025be:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  1025c0:	b8 23 00 00 00       	mov    $0x23,%eax
  1025c5:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  1025c7:	b8 10 00 00 00       	mov    $0x10,%eax
  1025cc:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  1025ce:	b8 10 00 00 00       	mov    $0x10,%eax
  1025d3:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  1025d5:	b8 10 00 00 00       	mov    $0x10,%eax
  1025da:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  1025dc:	ea e3 25 10 00 08 00 	ljmp   $0x8,$0x1025e3
}
  1025e3:	90                   	nop
  1025e4:	5d                   	pop    %ebp
  1025e5:	c3                   	ret    

001025e6 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  1025e6:	55                   	push   %ebp
  1025e7:	89 e5                	mov    %esp,%ebp
  1025e9:	83 ec 10             	sub    $0x10,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  1025ec:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  1025f1:	05 00 04 00 00       	add    $0x400,%eax
  1025f6:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  1025fb:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  102602:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102604:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  10260b:	68 00 
  10260d:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102612:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  102618:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10261d:	c1 e8 10             	shr    $0x10,%eax
  102620:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  102625:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10262c:	83 e0 f0             	and    $0xfffffff0,%eax
  10262f:	83 c8 09             	or     $0x9,%eax
  102632:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102637:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10263e:	83 c8 10             	or     $0x10,%eax
  102641:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102646:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10264d:	83 e0 9f             	and    $0xffffff9f,%eax
  102650:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102655:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10265c:	83 c8 80             	or     $0xffffff80,%eax
  10265f:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102664:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10266b:	83 e0 f0             	and    $0xfffffff0,%eax
  10266e:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102673:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10267a:	83 e0 ef             	and    $0xffffffef,%eax
  10267d:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102682:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102689:	83 e0 df             	and    $0xffffffdf,%eax
  10268c:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102691:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102698:	83 c8 40             	or     $0x40,%eax
  10269b:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1026a0:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1026a7:	83 e0 7f             	and    $0x7f,%eax
  1026aa:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1026af:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1026b4:	c1 e8 18             	shr    $0x18,%eax
  1026b7:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  1026bc:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1026c3:	83 e0 ef             	and    $0xffffffef,%eax
  1026c6:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  1026cb:	68 10 ea 10 00       	push   $0x10ea10
  1026d0:	e8 db fe ff ff       	call   1025b0 <lgdt>
  1026d5:	83 c4 04             	add    $0x4,%esp
  1026d8:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  1026de:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  1026e2:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  1026e5:	90                   	nop
  1026e6:	c9                   	leave  
  1026e7:	c3                   	ret    

001026e8 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  1026e8:	55                   	push   %ebp
  1026e9:	89 e5                	mov    %esp,%ebp
    gdt_init();
  1026eb:	e8 f6 fe ff ff       	call   1025e6 <gdt_init>
}
  1026f0:	90                   	nop
  1026f1:	5d                   	pop    %ebp
  1026f2:	c3                   	ret    

001026f3 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1026f3:	55                   	push   %ebp
  1026f4:	89 e5                	mov    %esp,%ebp
  1026f6:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1026f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102700:	eb 04                	jmp    102706 <strlen+0x13>
        cnt ++;
  102702:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102706:	8b 45 08             	mov    0x8(%ebp),%eax
  102709:	8d 50 01             	lea    0x1(%eax),%edx
  10270c:	89 55 08             	mov    %edx,0x8(%ebp)
  10270f:	0f b6 00             	movzbl (%eax),%eax
  102712:	84 c0                	test   %al,%al
  102714:	75 ec                	jne    102702 <strlen+0xf>
    }
    return cnt;
  102716:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102719:	c9                   	leave  
  10271a:	c3                   	ret    

0010271b <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  10271b:	55                   	push   %ebp
  10271c:	89 e5                	mov    %esp,%ebp
  10271e:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102721:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102728:	eb 04                	jmp    10272e <strnlen+0x13>
        cnt ++;
  10272a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  10272e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102731:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102734:	73 10                	jae    102746 <strnlen+0x2b>
  102736:	8b 45 08             	mov    0x8(%ebp),%eax
  102739:	8d 50 01             	lea    0x1(%eax),%edx
  10273c:	89 55 08             	mov    %edx,0x8(%ebp)
  10273f:	0f b6 00             	movzbl (%eax),%eax
  102742:	84 c0                	test   %al,%al
  102744:	75 e4                	jne    10272a <strnlen+0xf>
    }
    return cnt;
  102746:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102749:	c9                   	leave  
  10274a:	c3                   	ret    

0010274b <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  10274b:	55                   	push   %ebp
  10274c:	89 e5                	mov    %esp,%ebp
  10274e:	57                   	push   %edi
  10274f:	56                   	push   %esi
  102750:	83 ec 20             	sub    $0x20,%esp
  102753:	8b 45 08             	mov    0x8(%ebp),%eax
  102756:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102759:	8b 45 0c             	mov    0xc(%ebp),%eax
  10275c:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  10275f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102762:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102765:	89 d1                	mov    %edx,%ecx
  102767:	89 c2                	mov    %eax,%edx
  102769:	89 ce                	mov    %ecx,%esi
  10276b:	89 d7                	mov    %edx,%edi
  10276d:	ac                   	lods   %ds:(%esi),%al
  10276e:	aa                   	stos   %al,%es:(%edi)
  10276f:	84 c0                	test   %al,%al
  102771:	75 fa                	jne    10276d <strcpy+0x22>
  102773:	89 fa                	mov    %edi,%edx
  102775:	89 f1                	mov    %esi,%ecx
  102777:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10277a:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10277d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102780:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102783:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102784:	83 c4 20             	add    $0x20,%esp
  102787:	5e                   	pop    %esi
  102788:	5f                   	pop    %edi
  102789:	5d                   	pop    %ebp
  10278a:	c3                   	ret    

0010278b <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  10278b:	55                   	push   %ebp
  10278c:	89 e5                	mov    %esp,%ebp
  10278e:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102791:	8b 45 08             	mov    0x8(%ebp),%eax
  102794:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102797:	eb 21                	jmp    1027ba <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102799:	8b 45 0c             	mov    0xc(%ebp),%eax
  10279c:	0f b6 10             	movzbl (%eax),%edx
  10279f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1027a2:	88 10                	mov    %dl,(%eax)
  1027a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1027a7:	0f b6 00             	movzbl (%eax),%eax
  1027aa:	84 c0                	test   %al,%al
  1027ac:	74 04                	je     1027b2 <strncpy+0x27>
            src ++;
  1027ae:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1027b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1027b6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  1027ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1027be:	75 d9                	jne    102799 <strncpy+0xe>
    }
    return dst;
  1027c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1027c3:	c9                   	leave  
  1027c4:	c3                   	ret    

001027c5 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1027c5:	55                   	push   %ebp
  1027c6:	89 e5                	mov    %esp,%ebp
  1027c8:	57                   	push   %edi
  1027c9:	56                   	push   %esi
  1027ca:	83 ec 20             	sub    $0x20,%esp
  1027cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1027d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1027d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1027d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  1027d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1027dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1027df:	89 d1                	mov    %edx,%ecx
  1027e1:	89 c2                	mov    %eax,%edx
  1027e3:	89 ce                	mov    %ecx,%esi
  1027e5:	89 d7                	mov    %edx,%edi
  1027e7:	ac                   	lods   %ds:(%esi),%al
  1027e8:	ae                   	scas   %es:(%edi),%al
  1027e9:	75 08                	jne    1027f3 <strcmp+0x2e>
  1027eb:	84 c0                	test   %al,%al
  1027ed:	75 f8                	jne    1027e7 <strcmp+0x22>
  1027ef:	31 c0                	xor    %eax,%eax
  1027f1:	eb 04                	jmp    1027f7 <strcmp+0x32>
  1027f3:	19 c0                	sbb    %eax,%eax
  1027f5:	0c 01                	or     $0x1,%al
  1027f7:	89 fa                	mov    %edi,%edx
  1027f9:	89 f1                	mov    %esi,%ecx
  1027fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1027fe:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102801:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102804:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  102807:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102808:	83 c4 20             	add    $0x20,%esp
  10280b:	5e                   	pop    %esi
  10280c:	5f                   	pop    %edi
  10280d:	5d                   	pop    %ebp
  10280e:	c3                   	ret    

0010280f <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  10280f:	55                   	push   %ebp
  102810:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102812:	eb 0c                	jmp    102820 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  102814:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102818:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10281c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102820:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102824:	74 1a                	je     102840 <strncmp+0x31>
  102826:	8b 45 08             	mov    0x8(%ebp),%eax
  102829:	0f b6 00             	movzbl (%eax),%eax
  10282c:	84 c0                	test   %al,%al
  10282e:	74 10                	je     102840 <strncmp+0x31>
  102830:	8b 45 08             	mov    0x8(%ebp),%eax
  102833:	0f b6 10             	movzbl (%eax),%edx
  102836:	8b 45 0c             	mov    0xc(%ebp),%eax
  102839:	0f b6 00             	movzbl (%eax),%eax
  10283c:	38 c2                	cmp    %al,%dl
  10283e:	74 d4                	je     102814 <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102840:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102844:	74 18                	je     10285e <strncmp+0x4f>
  102846:	8b 45 08             	mov    0x8(%ebp),%eax
  102849:	0f b6 00             	movzbl (%eax),%eax
  10284c:	0f b6 d0             	movzbl %al,%edx
  10284f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102852:	0f b6 00             	movzbl (%eax),%eax
  102855:	0f b6 c0             	movzbl %al,%eax
  102858:	29 c2                	sub    %eax,%edx
  10285a:	89 d0                	mov    %edx,%eax
  10285c:	eb 05                	jmp    102863 <strncmp+0x54>
  10285e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102863:	5d                   	pop    %ebp
  102864:	c3                   	ret    

00102865 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102865:	55                   	push   %ebp
  102866:	89 e5                	mov    %esp,%ebp
  102868:	83 ec 04             	sub    $0x4,%esp
  10286b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10286e:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102871:	eb 14                	jmp    102887 <strchr+0x22>
        if (*s == c) {
  102873:	8b 45 08             	mov    0x8(%ebp),%eax
  102876:	0f b6 00             	movzbl (%eax),%eax
  102879:	38 45 fc             	cmp    %al,-0x4(%ebp)
  10287c:	75 05                	jne    102883 <strchr+0x1e>
            return (char *)s;
  10287e:	8b 45 08             	mov    0x8(%ebp),%eax
  102881:	eb 13                	jmp    102896 <strchr+0x31>
        }
        s ++;
  102883:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102887:	8b 45 08             	mov    0x8(%ebp),%eax
  10288a:	0f b6 00             	movzbl (%eax),%eax
  10288d:	84 c0                	test   %al,%al
  10288f:	75 e2                	jne    102873 <strchr+0xe>
    }
    return NULL;
  102891:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102896:	c9                   	leave  
  102897:	c3                   	ret    

00102898 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102898:	55                   	push   %ebp
  102899:	89 e5                	mov    %esp,%ebp
  10289b:	83 ec 04             	sub    $0x4,%esp
  10289e:	8b 45 0c             	mov    0xc(%ebp),%eax
  1028a1:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1028a4:	eb 0f                	jmp    1028b5 <strfind+0x1d>
        if (*s == c) {
  1028a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1028a9:	0f b6 00             	movzbl (%eax),%eax
  1028ac:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1028af:	74 10                	je     1028c1 <strfind+0x29>
            break;
        }
        s ++;
  1028b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  1028b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1028b8:	0f b6 00             	movzbl (%eax),%eax
  1028bb:	84 c0                	test   %al,%al
  1028bd:	75 e7                	jne    1028a6 <strfind+0xe>
  1028bf:	eb 01                	jmp    1028c2 <strfind+0x2a>
            break;
  1028c1:	90                   	nop
    }
    return (char *)s;
  1028c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1028c5:	c9                   	leave  
  1028c6:	c3                   	ret    

001028c7 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1028c7:	55                   	push   %ebp
  1028c8:	89 e5                	mov    %esp,%ebp
  1028ca:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1028cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1028d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1028db:	eb 04                	jmp    1028e1 <strtol+0x1a>
        s ++;
  1028dd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  1028e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1028e4:	0f b6 00             	movzbl (%eax),%eax
  1028e7:	3c 20                	cmp    $0x20,%al
  1028e9:	74 f2                	je     1028dd <strtol+0x16>
  1028eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1028ee:	0f b6 00             	movzbl (%eax),%eax
  1028f1:	3c 09                	cmp    $0x9,%al
  1028f3:	74 e8                	je     1028dd <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
  1028f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1028f8:	0f b6 00             	movzbl (%eax),%eax
  1028fb:	3c 2b                	cmp    $0x2b,%al
  1028fd:	75 06                	jne    102905 <strtol+0x3e>
        s ++;
  1028ff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102903:	eb 15                	jmp    10291a <strtol+0x53>
    }
    else if (*s == '-') {
  102905:	8b 45 08             	mov    0x8(%ebp),%eax
  102908:	0f b6 00             	movzbl (%eax),%eax
  10290b:	3c 2d                	cmp    $0x2d,%al
  10290d:	75 0b                	jne    10291a <strtol+0x53>
        s ++, neg = 1;
  10290f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102913:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  10291a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10291e:	74 06                	je     102926 <strtol+0x5f>
  102920:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102924:	75 24                	jne    10294a <strtol+0x83>
  102926:	8b 45 08             	mov    0x8(%ebp),%eax
  102929:	0f b6 00             	movzbl (%eax),%eax
  10292c:	3c 30                	cmp    $0x30,%al
  10292e:	75 1a                	jne    10294a <strtol+0x83>
  102930:	8b 45 08             	mov    0x8(%ebp),%eax
  102933:	83 c0 01             	add    $0x1,%eax
  102936:	0f b6 00             	movzbl (%eax),%eax
  102939:	3c 78                	cmp    $0x78,%al
  10293b:	75 0d                	jne    10294a <strtol+0x83>
        s += 2, base = 16;
  10293d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102941:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102948:	eb 2a                	jmp    102974 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  10294a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10294e:	75 17                	jne    102967 <strtol+0xa0>
  102950:	8b 45 08             	mov    0x8(%ebp),%eax
  102953:	0f b6 00             	movzbl (%eax),%eax
  102956:	3c 30                	cmp    $0x30,%al
  102958:	75 0d                	jne    102967 <strtol+0xa0>
        s ++, base = 8;
  10295a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10295e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102965:	eb 0d                	jmp    102974 <strtol+0xad>
    }
    else if (base == 0) {
  102967:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10296b:	75 07                	jne    102974 <strtol+0xad>
        base = 10;
  10296d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102974:	8b 45 08             	mov    0x8(%ebp),%eax
  102977:	0f b6 00             	movzbl (%eax),%eax
  10297a:	3c 2f                	cmp    $0x2f,%al
  10297c:	7e 1b                	jle    102999 <strtol+0xd2>
  10297e:	8b 45 08             	mov    0x8(%ebp),%eax
  102981:	0f b6 00             	movzbl (%eax),%eax
  102984:	3c 39                	cmp    $0x39,%al
  102986:	7f 11                	jg     102999 <strtol+0xd2>
            dig = *s - '0';
  102988:	8b 45 08             	mov    0x8(%ebp),%eax
  10298b:	0f b6 00             	movzbl (%eax),%eax
  10298e:	0f be c0             	movsbl %al,%eax
  102991:	83 e8 30             	sub    $0x30,%eax
  102994:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102997:	eb 48                	jmp    1029e1 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102999:	8b 45 08             	mov    0x8(%ebp),%eax
  10299c:	0f b6 00             	movzbl (%eax),%eax
  10299f:	3c 60                	cmp    $0x60,%al
  1029a1:	7e 1b                	jle    1029be <strtol+0xf7>
  1029a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a6:	0f b6 00             	movzbl (%eax),%eax
  1029a9:	3c 7a                	cmp    $0x7a,%al
  1029ab:	7f 11                	jg     1029be <strtol+0xf7>
            dig = *s - 'a' + 10;
  1029ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1029b0:	0f b6 00             	movzbl (%eax),%eax
  1029b3:	0f be c0             	movsbl %al,%eax
  1029b6:	83 e8 57             	sub    $0x57,%eax
  1029b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1029bc:	eb 23                	jmp    1029e1 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1029be:	8b 45 08             	mov    0x8(%ebp),%eax
  1029c1:	0f b6 00             	movzbl (%eax),%eax
  1029c4:	3c 40                	cmp    $0x40,%al
  1029c6:	7e 3c                	jle    102a04 <strtol+0x13d>
  1029c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1029cb:	0f b6 00             	movzbl (%eax),%eax
  1029ce:	3c 5a                	cmp    $0x5a,%al
  1029d0:	7f 32                	jg     102a04 <strtol+0x13d>
            dig = *s - 'A' + 10;
  1029d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1029d5:	0f b6 00             	movzbl (%eax),%eax
  1029d8:	0f be c0             	movsbl %al,%eax
  1029db:	83 e8 37             	sub    $0x37,%eax
  1029de:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1029e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  1029e7:	7d 1a                	jge    102a03 <strtol+0x13c>
            break;
        }
        s ++, val = (val * base) + dig;
  1029e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1029ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1029f0:	0f af 45 10          	imul   0x10(%ebp),%eax
  1029f4:	89 c2                	mov    %eax,%edx
  1029f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029f9:	01 d0                	add    %edx,%eax
  1029fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  1029fe:	e9 71 ff ff ff       	jmp    102974 <strtol+0xad>
            break;
  102a03:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102a04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102a08:	74 08                	je     102a12 <strtol+0x14b>
        *endptr = (char *) s;
  102a0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a0d:	8b 55 08             	mov    0x8(%ebp),%edx
  102a10:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102a12:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102a16:	74 07                	je     102a1f <strtol+0x158>
  102a18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102a1b:	f7 d8                	neg    %eax
  102a1d:	eb 03                	jmp    102a22 <strtol+0x15b>
  102a1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102a22:	c9                   	leave  
  102a23:	c3                   	ret    

00102a24 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102a24:	55                   	push   %ebp
  102a25:	89 e5                	mov    %esp,%ebp
  102a27:	57                   	push   %edi
  102a28:	83 ec 24             	sub    $0x24,%esp
  102a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a2e:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102a31:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102a35:	8b 55 08             	mov    0x8(%ebp),%edx
  102a38:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102a3b:	88 45 f7             	mov    %al,-0x9(%ebp)
  102a3e:	8b 45 10             	mov    0x10(%ebp),%eax
  102a41:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102a44:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102a47:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102a4b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102a4e:	89 d7                	mov    %edx,%edi
  102a50:	f3 aa                	rep stos %al,%es:(%edi)
  102a52:	89 fa                	mov    %edi,%edx
  102a54:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102a57:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102a5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102a5d:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102a5e:	83 c4 24             	add    $0x24,%esp
  102a61:	5f                   	pop    %edi
  102a62:	5d                   	pop    %ebp
  102a63:	c3                   	ret    

00102a64 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102a64:	55                   	push   %ebp
  102a65:	89 e5                	mov    %esp,%ebp
  102a67:	57                   	push   %edi
  102a68:	56                   	push   %esi
  102a69:	53                   	push   %ebx
  102a6a:	83 ec 30             	sub    $0x30,%esp
  102a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102a70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102a73:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a76:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102a79:	8b 45 10             	mov    0x10(%ebp),%eax
  102a7c:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a82:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102a85:	73 42                	jae    102ac9 <memmove+0x65>
  102a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102a8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102a90:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102a93:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102a96:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102a99:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102a9c:	c1 e8 02             	shr    $0x2,%eax
  102a9f:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102aa1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102aa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102aa7:	89 d7                	mov    %edx,%edi
  102aa9:	89 c6                	mov    %eax,%esi
  102aab:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102aad:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102ab0:	83 e1 03             	and    $0x3,%ecx
  102ab3:	74 02                	je     102ab7 <memmove+0x53>
  102ab5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ab7:	89 f0                	mov    %esi,%eax
  102ab9:	89 fa                	mov    %edi,%edx
  102abb:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102abe:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102ac1:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102ac4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  102ac7:	eb 36                	jmp    102aff <memmove+0x9b>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102ac9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102acc:	8d 50 ff             	lea    -0x1(%eax),%edx
  102acf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ad2:	01 c2                	add    %eax,%edx
  102ad4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ad7:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102ada:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102add:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102ae0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ae3:	89 c1                	mov    %eax,%ecx
  102ae5:	89 d8                	mov    %ebx,%eax
  102ae7:	89 d6                	mov    %edx,%esi
  102ae9:	89 c7                	mov    %eax,%edi
  102aeb:	fd                   	std    
  102aec:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102aee:	fc                   	cld    
  102aef:	89 f8                	mov    %edi,%eax
  102af1:	89 f2                	mov    %esi,%edx
  102af3:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102af6:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102af9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102afc:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102aff:	83 c4 30             	add    $0x30,%esp
  102b02:	5b                   	pop    %ebx
  102b03:	5e                   	pop    %esi
  102b04:	5f                   	pop    %edi
  102b05:	5d                   	pop    %ebp
  102b06:	c3                   	ret    

00102b07 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102b07:	55                   	push   %ebp
  102b08:	89 e5                	mov    %esp,%ebp
  102b0a:	57                   	push   %edi
  102b0b:	56                   	push   %esi
  102b0c:	83 ec 20             	sub    $0x20,%esp
  102b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b12:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102b1b:	8b 45 10             	mov    0x10(%ebp),%eax
  102b1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102b21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102b24:	c1 e8 02             	shr    $0x2,%eax
  102b27:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102b29:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102b2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b2f:	89 d7                	mov    %edx,%edi
  102b31:	89 c6                	mov    %eax,%esi
  102b33:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102b35:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102b38:	83 e1 03             	and    $0x3,%ecx
  102b3b:	74 02                	je     102b3f <memcpy+0x38>
  102b3d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102b3f:	89 f0                	mov    %esi,%eax
  102b41:	89 fa                	mov    %edi,%edx
  102b43:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102b46:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102b49:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  102b4f:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102b50:	83 c4 20             	add    $0x20,%esp
  102b53:	5e                   	pop    %esi
  102b54:	5f                   	pop    %edi
  102b55:	5d                   	pop    %ebp
  102b56:	c3                   	ret    

00102b57 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102b57:	55                   	push   %ebp
  102b58:	89 e5                	mov    %esp,%ebp
  102b5a:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b60:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102b63:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b66:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102b69:	eb 30                	jmp    102b9b <memcmp+0x44>
        if (*s1 != *s2) {
  102b6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b6e:	0f b6 10             	movzbl (%eax),%edx
  102b71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b74:	0f b6 00             	movzbl (%eax),%eax
  102b77:	38 c2                	cmp    %al,%dl
  102b79:	74 18                	je     102b93 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102b7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b7e:	0f b6 00             	movzbl (%eax),%eax
  102b81:	0f b6 d0             	movzbl %al,%edx
  102b84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b87:	0f b6 00             	movzbl (%eax),%eax
  102b8a:	0f b6 c0             	movzbl %al,%eax
  102b8d:	29 c2                	sub    %eax,%edx
  102b8f:	89 d0                	mov    %edx,%eax
  102b91:	eb 1a                	jmp    102bad <memcmp+0x56>
        }
        s1 ++, s2 ++;
  102b93:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102b97:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  102b9b:	8b 45 10             	mov    0x10(%ebp),%eax
  102b9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ba1:	89 55 10             	mov    %edx,0x10(%ebp)
  102ba4:	85 c0                	test   %eax,%eax
  102ba6:	75 c3                	jne    102b6b <memcmp+0x14>
    }
    return 0;
  102ba8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102bad:	c9                   	leave  
  102bae:	c3                   	ret    

00102baf <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102baf:	55                   	push   %ebp
  102bb0:	89 e5                	mov    %esp,%ebp
  102bb2:	83 ec 38             	sub    $0x38,%esp
  102bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  102bb8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102bbb:	8b 45 14             	mov    0x14(%ebp),%eax
  102bbe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102bc1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102bc4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102bc7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102bca:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102bcd:	8b 45 18             	mov    0x18(%ebp),%eax
  102bd0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102bd3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102bd6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102bd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102bdc:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102bdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102be2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102be5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102be9:	74 1c                	je     102c07 <printnum+0x58>
  102beb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bee:	ba 00 00 00 00       	mov    $0x0,%edx
  102bf3:	f7 75 e4             	divl   -0x1c(%ebp)
  102bf6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bfc:	ba 00 00 00 00       	mov    $0x0,%edx
  102c01:	f7 75 e4             	divl   -0x1c(%ebp)
  102c04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c0d:	f7 75 e4             	divl   -0x1c(%ebp)
  102c10:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102c13:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102c16:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c19:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102c1c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102c1f:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102c22:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c25:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102c28:	8b 45 18             	mov    0x18(%ebp),%eax
  102c2b:	ba 00 00 00 00       	mov    $0x0,%edx
  102c30:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  102c33:	72 41                	jb     102c76 <printnum+0xc7>
  102c35:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  102c38:	77 05                	ja     102c3f <printnum+0x90>
  102c3a:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  102c3d:	72 37                	jb     102c76 <printnum+0xc7>
        printnum(putch, putdat, result, base, width - 1, padc);
  102c3f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102c42:	83 e8 01             	sub    $0x1,%eax
  102c45:	83 ec 04             	sub    $0x4,%esp
  102c48:	ff 75 20             	pushl  0x20(%ebp)
  102c4b:	50                   	push   %eax
  102c4c:	ff 75 18             	pushl  0x18(%ebp)
  102c4f:	ff 75 ec             	pushl  -0x14(%ebp)
  102c52:	ff 75 e8             	pushl  -0x18(%ebp)
  102c55:	ff 75 0c             	pushl  0xc(%ebp)
  102c58:	ff 75 08             	pushl  0x8(%ebp)
  102c5b:	e8 4f ff ff ff       	call   102baf <printnum>
  102c60:	83 c4 20             	add    $0x20,%esp
  102c63:	eb 1b                	jmp    102c80 <printnum+0xd1>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102c65:	83 ec 08             	sub    $0x8,%esp
  102c68:	ff 75 0c             	pushl  0xc(%ebp)
  102c6b:	ff 75 20             	pushl  0x20(%ebp)
  102c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c71:	ff d0                	call   *%eax
  102c73:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  102c76:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102c7a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102c7e:	7f e5                	jg     102c65 <printnum+0xb6>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102c80:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102c83:	05 30 39 10 00       	add    $0x103930,%eax
  102c88:	0f b6 00             	movzbl (%eax),%eax
  102c8b:	0f be c0             	movsbl %al,%eax
  102c8e:	83 ec 08             	sub    $0x8,%esp
  102c91:	ff 75 0c             	pushl  0xc(%ebp)
  102c94:	50                   	push   %eax
  102c95:	8b 45 08             	mov    0x8(%ebp),%eax
  102c98:	ff d0                	call   *%eax
  102c9a:	83 c4 10             	add    $0x10,%esp
}
  102c9d:	90                   	nop
  102c9e:	c9                   	leave  
  102c9f:	c3                   	ret    

00102ca0 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102ca0:	55                   	push   %ebp
  102ca1:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102ca3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102ca7:	7e 14                	jle    102cbd <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  102cac:	8b 00                	mov    (%eax),%eax
  102cae:	8d 48 08             	lea    0x8(%eax),%ecx
  102cb1:	8b 55 08             	mov    0x8(%ebp),%edx
  102cb4:	89 0a                	mov    %ecx,(%edx)
  102cb6:	8b 50 04             	mov    0x4(%eax),%edx
  102cb9:	8b 00                	mov    (%eax),%eax
  102cbb:	eb 30                	jmp    102ced <getuint+0x4d>
    }
    else if (lflag) {
  102cbd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102cc1:	74 16                	je     102cd9 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc6:	8b 00                	mov    (%eax),%eax
  102cc8:	8d 48 04             	lea    0x4(%eax),%ecx
  102ccb:	8b 55 08             	mov    0x8(%ebp),%edx
  102cce:	89 0a                	mov    %ecx,(%edx)
  102cd0:	8b 00                	mov    (%eax),%eax
  102cd2:	ba 00 00 00 00       	mov    $0x0,%edx
  102cd7:	eb 14                	jmp    102ced <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  102cdc:	8b 00                	mov    (%eax),%eax
  102cde:	8d 48 04             	lea    0x4(%eax),%ecx
  102ce1:	8b 55 08             	mov    0x8(%ebp),%edx
  102ce4:	89 0a                	mov    %ecx,(%edx)
  102ce6:	8b 00                	mov    (%eax),%eax
  102ce8:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102ced:	5d                   	pop    %ebp
  102cee:	c3                   	ret    

00102cef <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102cef:	55                   	push   %ebp
  102cf0:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102cf2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102cf6:	7e 14                	jle    102d0c <getint+0x1d>
        return va_arg(*ap, long long);
  102cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  102cfb:	8b 00                	mov    (%eax),%eax
  102cfd:	8d 48 08             	lea    0x8(%eax),%ecx
  102d00:	8b 55 08             	mov    0x8(%ebp),%edx
  102d03:	89 0a                	mov    %ecx,(%edx)
  102d05:	8b 50 04             	mov    0x4(%eax),%edx
  102d08:	8b 00                	mov    (%eax),%eax
  102d0a:	eb 28                	jmp    102d34 <getint+0x45>
    }
    else if (lflag) {
  102d0c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102d10:	74 12                	je     102d24 <getint+0x35>
        return va_arg(*ap, long);
  102d12:	8b 45 08             	mov    0x8(%ebp),%eax
  102d15:	8b 00                	mov    (%eax),%eax
  102d17:	8d 48 04             	lea    0x4(%eax),%ecx
  102d1a:	8b 55 08             	mov    0x8(%ebp),%edx
  102d1d:	89 0a                	mov    %ecx,(%edx)
  102d1f:	8b 00                	mov    (%eax),%eax
  102d21:	99                   	cltd   
  102d22:	eb 10                	jmp    102d34 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102d24:	8b 45 08             	mov    0x8(%ebp),%eax
  102d27:	8b 00                	mov    (%eax),%eax
  102d29:	8d 48 04             	lea    0x4(%eax),%ecx
  102d2c:	8b 55 08             	mov    0x8(%ebp),%edx
  102d2f:	89 0a                	mov    %ecx,(%edx)
  102d31:	8b 00                	mov    (%eax),%eax
  102d33:	99                   	cltd   
    }
}
  102d34:	5d                   	pop    %ebp
  102d35:	c3                   	ret    

00102d36 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102d36:	55                   	push   %ebp
  102d37:	89 e5                	mov    %esp,%ebp
  102d39:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  102d3c:	8d 45 14             	lea    0x14(%ebp),%eax
  102d3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102d42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d45:	50                   	push   %eax
  102d46:	ff 75 10             	pushl  0x10(%ebp)
  102d49:	ff 75 0c             	pushl  0xc(%ebp)
  102d4c:	ff 75 08             	pushl  0x8(%ebp)
  102d4f:	e8 06 00 00 00       	call   102d5a <vprintfmt>
  102d54:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  102d57:	90                   	nop
  102d58:	c9                   	leave  
  102d59:	c3                   	ret    

00102d5a <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102d5a:	55                   	push   %ebp
  102d5b:	89 e5                	mov    %esp,%ebp
  102d5d:	56                   	push   %esi
  102d5e:	53                   	push   %ebx
  102d5f:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d62:	eb 17                	jmp    102d7b <vprintfmt+0x21>
            if (ch == '\0') {
  102d64:	85 db                	test   %ebx,%ebx
  102d66:	0f 84 8e 03 00 00    	je     1030fa <vprintfmt+0x3a0>
                return;
            }
            putch(ch, putdat);
  102d6c:	83 ec 08             	sub    $0x8,%esp
  102d6f:	ff 75 0c             	pushl  0xc(%ebp)
  102d72:	53                   	push   %ebx
  102d73:	8b 45 08             	mov    0x8(%ebp),%eax
  102d76:	ff d0                	call   *%eax
  102d78:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d7b:	8b 45 10             	mov    0x10(%ebp),%eax
  102d7e:	8d 50 01             	lea    0x1(%eax),%edx
  102d81:	89 55 10             	mov    %edx,0x10(%ebp)
  102d84:	0f b6 00             	movzbl (%eax),%eax
  102d87:	0f b6 d8             	movzbl %al,%ebx
  102d8a:	83 fb 25             	cmp    $0x25,%ebx
  102d8d:	75 d5                	jne    102d64 <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
  102d8f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102d93:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102d9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d9d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102da0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102da7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102daa:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102dad:	8b 45 10             	mov    0x10(%ebp),%eax
  102db0:	8d 50 01             	lea    0x1(%eax),%edx
  102db3:	89 55 10             	mov    %edx,0x10(%ebp)
  102db6:	0f b6 00             	movzbl (%eax),%eax
  102db9:	0f b6 d8             	movzbl %al,%ebx
  102dbc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102dbf:	83 f8 55             	cmp    $0x55,%eax
  102dc2:	0f 87 05 03 00 00    	ja     1030cd <vprintfmt+0x373>
  102dc8:	8b 04 85 54 39 10 00 	mov    0x103954(,%eax,4),%eax
  102dcf:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102dd1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102dd5:	eb d6                	jmp    102dad <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102dd7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102ddb:	eb d0                	jmp    102dad <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102ddd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102de4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102de7:	89 d0                	mov    %edx,%eax
  102de9:	c1 e0 02             	shl    $0x2,%eax
  102dec:	01 d0                	add    %edx,%eax
  102dee:	01 c0                	add    %eax,%eax
  102df0:	01 d8                	add    %ebx,%eax
  102df2:	83 e8 30             	sub    $0x30,%eax
  102df5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102df8:	8b 45 10             	mov    0x10(%ebp),%eax
  102dfb:	0f b6 00             	movzbl (%eax),%eax
  102dfe:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102e01:	83 fb 2f             	cmp    $0x2f,%ebx
  102e04:	7e 39                	jle    102e3f <vprintfmt+0xe5>
  102e06:	83 fb 39             	cmp    $0x39,%ebx
  102e09:	7f 34                	jg     102e3f <vprintfmt+0xe5>
            for (precision = 0; ; ++ fmt) {
  102e0b:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  102e0f:	eb d3                	jmp    102de4 <vprintfmt+0x8a>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  102e11:	8b 45 14             	mov    0x14(%ebp),%eax
  102e14:	8d 50 04             	lea    0x4(%eax),%edx
  102e17:	89 55 14             	mov    %edx,0x14(%ebp)
  102e1a:	8b 00                	mov    (%eax),%eax
  102e1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102e1f:	eb 1f                	jmp    102e40 <vprintfmt+0xe6>

        case '.':
            if (width < 0)
  102e21:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e25:	79 86                	jns    102dad <vprintfmt+0x53>
                width = 0;
  102e27:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102e2e:	e9 7a ff ff ff       	jmp    102dad <vprintfmt+0x53>

        case '#':
            altflag = 1;
  102e33:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102e3a:	e9 6e ff ff ff       	jmp    102dad <vprintfmt+0x53>
            goto process_precision;
  102e3f:	90                   	nop

        process_precision:
            if (width < 0)
  102e40:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e44:	0f 89 63 ff ff ff    	jns    102dad <vprintfmt+0x53>
                width = precision, precision = -1;
  102e4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e4d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102e50:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102e57:	e9 51 ff ff ff       	jmp    102dad <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102e5c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102e60:	e9 48 ff ff ff       	jmp    102dad <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102e65:	8b 45 14             	mov    0x14(%ebp),%eax
  102e68:	8d 50 04             	lea    0x4(%eax),%edx
  102e6b:	89 55 14             	mov    %edx,0x14(%ebp)
  102e6e:	8b 00                	mov    (%eax),%eax
  102e70:	83 ec 08             	sub    $0x8,%esp
  102e73:	ff 75 0c             	pushl  0xc(%ebp)
  102e76:	50                   	push   %eax
  102e77:	8b 45 08             	mov    0x8(%ebp),%eax
  102e7a:	ff d0                	call   *%eax
  102e7c:	83 c4 10             	add    $0x10,%esp
            break;
  102e7f:	e9 71 02 00 00       	jmp    1030f5 <vprintfmt+0x39b>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102e84:	8b 45 14             	mov    0x14(%ebp),%eax
  102e87:	8d 50 04             	lea    0x4(%eax),%edx
  102e8a:	89 55 14             	mov    %edx,0x14(%ebp)
  102e8d:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102e8f:	85 db                	test   %ebx,%ebx
  102e91:	79 02                	jns    102e95 <vprintfmt+0x13b>
                err = -err;
  102e93:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102e95:	83 fb 06             	cmp    $0x6,%ebx
  102e98:	7f 0b                	jg     102ea5 <vprintfmt+0x14b>
  102e9a:	8b 34 9d 14 39 10 00 	mov    0x103914(,%ebx,4),%esi
  102ea1:	85 f6                	test   %esi,%esi
  102ea3:	75 19                	jne    102ebe <vprintfmt+0x164>
                printfmt(putch, putdat, "error %d", err);
  102ea5:	53                   	push   %ebx
  102ea6:	68 41 39 10 00       	push   $0x103941
  102eab:	ff 75 0c             	pushl  0xc(%ebp)
  102eae:	ff 75 08             	pushl  0x8(%ebp)
  102eb1:	e8 80 fe ff ff       	call   102d36 <printfmt>
  102eb6:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102eb9:	e9 37 02 00 00       	jmp    1030f5 <vprintfmt+0x39b>
                printfmt(putch, putdat, "%s", p);
  102ebe:	56                   	push   %esi
  102ebf:	68 4a 39 10 00       	push   $0x10394a
  102ec4:	ff 75 0c             	pushl  0xc(%ebp)
  102ec7:	ff 75 08             	pushl  0x8(%ebp)
  102eca:	e8 67 fe ff ff       	call   102d36 <printfmt>
  102ecf:	83 c4 10             	add    $0x10,%esp
            break;
  102ed2:	e9 1e 02 00 00       	jmp    1030f5 <vprintfmt+0x39b>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102ed7:	8b 45 14             	mov    0x14(%ebp),%eax
  102eda:	8d 50 04             	lea    0x4(%eax),%edx
  102edd:	89 55 14             	mov    %edx,0x14(%ebp)
  102ee0:	8b 30                	mov    (%eax),%esi
  102ee2:	85 f6                	test   %esi,%esi
  102ee4:	75 05                	jne    102eeb <vprintfmt+0x191>
                p = "(null)";
  102ee6:	be 4d 39 10 00       	mov    $0x10394d,%esi
            }
            if (width > 0 && padc != '-') {
  102eeb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102eef:	7e 76                	jle    102f67 <vprintfmt+0x20d>
  102ef1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102ef5:	74 70                	je     102f67 <vprintfmt+0x20d>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102ef7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102efa:	83 ec 08             	sub    $0x8,%esp
  102efd:	50                   	push   %eax
  102efe:	56                   	push   %esi
  102eff:	e8 17 f8 ff ff       	call   10271b <strnlen>
  102f04:	83 c4 10             	add    $0x10,%esp
  102f07:	89 c2                	mov    %eax,%edx
  102f09:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f0c:	29 d0                	sub    %edx,%eax
  102f0e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f11:	eb 17                	jmp    102f2a <vprintfmt+0x1d0>
                    putch(padc, putdat);
  102f13:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102f17:	83 ec 08             	sub    $0x8,%esp
  102f1a:	ff 75 0c             	pushl  0xc(%ebp)
  102f1d:	50                   	push   %eax
  102f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  102f21:	ff d0                	call   *%eax
  102f23:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  102f26:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f2a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102f2e:	7f e3                	jg     102f13 <vprintfmt+0x1b9>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f30:	eb 35                	jmp    102f67 <vprintfmt+0x20d>
                if (altflag && (ch < ' ' || ch > '~')) {
  102f32:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102f36:	74 1c                	je     102f54 <vprintfmt+0x1fa>
  102f38:	83 fb 1f             	cmp    $0x1f,%ebx
  102f3b:	7e 05                	jle    102f42 <vprintfmt+0x1e8>
  102f3d:	83 fb 7e             	cmp    $0x7e,%ebx
  102f40:	7e 12                	jle    102f54 <vprintfmt+0x1fa>
                    putch('?', putdat);
  102f42:	83 ec 08             	sub    $0x8,%esp
  102f45:	ff 75 0c             	pushl  0xc(%ebp)
  102f48:	6a 3f                	push   $0x3f
  102f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f4d:	ff d0                	call   *%eax
  102f4f:	83 c4 10             	add    $0x10,%esp
  102f52:	eb 0f                	jmp    102f63 <vprintfmt+0x209>
                }
                else {
                    putch(ch, putdat);
  102f54:	83 ec 08             	sub    $0x8,%esp
  102f57:	ff 75 0c             	pushl  0xc(%ebp)
  102f5a:	53                   	push   %ebx
  102f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5e:	ff d0                	call   *%eax
  102f60:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f63:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f67:	89 f0                	mov    %esi,%eax
  102f69:	8d 70 01             	lea    0x1(%eax),%esi
  102f6c:	0f b6 00             	movzbl (%eax),%eax
  102f6f:	0f be d8             	movsbl %al,%ebx
  102f72:	85 db                	test   %ebx,%ebx
  102f74:	74 26                	je     102f9c <vprintfmt+0x242>
  102f76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f7a:	78 b6                	js     102f32 <vprintfmt+0x1d8>
  102f7c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102f80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f84:	79 ac                	jns    102f32 <vprintfmt+0x1d8>
                }
            }
            for (; width > 0; width --) {
  102f86:	eb 14                	jmp    102f9c <vprintfmt+0x242>
                putch(' ', putdat);
  102f88:	83 ec 08             	sub    $0x8,%esp
  102f8b:	ff 75 0c             	pushl  0xc(%ebp)
  102f8e:	6a 20                	push   $0x20
  102f90:	8b 45 08             	mov    0x8(%ebp),%eax
  102f93:	ff d0                	call   *%eax
  102f95:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  102f98:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f9c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102fa0:	7f e6                	jg     102f88 <vprintfmt+0x22e>
            }
            break;
  102fa2:	e9 4e 01 00 00       	jmp    1030f5 <vprintfmt+0x39b>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102fa7:	83 ec 08             	sub    $0x8,%esp
  102faa:	ff 75 e0             	pushl  -0x20(%ebp)
  102fad:	8d 45 14             	lea    0x14(%ebp),%eax
  102fb0:	50                   	push   %eax
  102fb1:	e8 39 fd ff ff       	call   102cef <getint>
  102fb6:	83 c4 10             	add    $0x10,%esp
  102fb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fbc:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102fbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fc5:	85 d2                	test   %edx,%edx
  102fc7:	79 23                	jns    102fec <vprintfmt+0x292>
                putch('-', putdat);
  102fc9:	83 ec 08             	sub    $0x8,%esp
  102fcc:	ff 75 0c             	pushl  0xc(%ebp)
  102fcf:	6a 2d                	push   $0x2d
  102fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd4:	ff d0                	call   *%eax
  102fd6:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  102fd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fdc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fdf:	f7 d8                	neg    %eax
  102fe1:	83 d2 00             	adc    $0x0,%edx
  102fe4:	f7 da                	neg    %edx
  102fe6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fe9:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102fec:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ff3:	e9 9f 00 00 00       	jmp    103097 <vprintfmt+0x33d>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102ff8:	83 ec 08             	sub    $0x8,%esp
  102ffb:	ff 75 e0             	pushl  -0x20(%ebp)
  102ffe:	8d 45 14             	lea    0x14(%ebp),%eax
  103001:	50                   	push   %eax
  103002:	e8 99 fc ff ff       	call   102ca0 <getuint>
  103007:	83 c4 10             	add    $0x10,%esp
  10300a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10300d:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  103010:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103017:	eb 7e                	jmp    103097 <vprintfmt+0x33d>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103019:	83 ec 08             	sub    $0x8,%esp
  10301c:	ff 75 e0             	pushl  -0x20(%ebp)
  10301f:	8d 45 14             	lea    0x14(%ebp),%eax
  103022:	50                   	push   %eax
  103023:	e8 78 fc ff ff       	call   102ca0 <getuint>
  103028:	83 c4 10             	add    $0x10,%esp
  10302b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10302e:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103031:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  103038:	eb 5d                	jmp    103097 <vprintfmt+0x33d>

        // pointer
        case 'p':
            putch('0', putdat);
  10303a:	83 ec 08             	sub    $0x8,%esp
  10303d:	ff 75 0c             	pushl  0xc(%ebp)
  103040:	6a 30                	push   $0x30
  103042:	8b 45 08             	mov    0x8(%ebp),%eax
  103045:	ff d0                	call   *%eax
  103047:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  10304a:	83 ec 08             	sub    $0x8,%esp
  10304d:	ff 75 0c             	pushl  0xc(%ebp)
  103050:	6a 78                	push   $0x78
  103052:	8b 45 08             	mov    0x8(%ebp),%eax
  103055:	ff d0                	call   *%eax
  103057:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  10305a:	8b 45 14             	mov    0x14(%ebp),%eax
  10305d:	8d 50 04             	lea    0x4(%eax),%edx
  103060:	89 55 14             	mov    %edx,0x14(%ebp)
  103063:	8b 00                	mov    (%eax),%eax
  103065:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103068:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  10306f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103076:	eb 1f                	jmp    103097 <vprintfmt+0x33d>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103078:	83 ec 08             	sub    $0x8,%esp
  10307b:	ff 75 e0             	pushl  -0x20(%ebp)
  10307e:	8d 45 14             	lea    0x14(%ebp),%eax
  103081:	50                   	push   %eax
  103082:	e8 19 fc ff ff       	call   102ca0 <getuint>
  103087:	83 c4 10             	add    $0x10,%esp
  10308a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10308d:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103090:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103097:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  10309b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10309e:	83 ec 04             	sub    $0x4,%esp
  1030a1:	52                   	push   %edx
  1030a2:	ff 75 e8             	pushl  -0x18(%ebp)
  1030a5:	50                   	push   %eax
  1030a6:	ff 75 f4             	pushl  -0xc(%ebp)
  1030a9:	ff 75 f0             	pushl  -0x10(%ebp)
  1030ac:	ff 75 0c             	pushl  0xc(%ebp)
  1030af:	ff 75 08             	pushl  0x8(%ebp)
  1030b2:	e8 f8 fa ff ff       	call   102baf <printnum>
  1030b7:	83 c4 20             	add    $0x20,%esp
            break;
  1030ba:	eb 39                	jmp    1030f5 <vprintfmt+0x39b>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1030bc:	83 ec 08             	sub    $0x8,%esp
  1030bf:	ff 75 0c             	pushl  0xc(%ebp)
  1030c2:	53                   	push   %ebx
  1030c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c6:	ff d0                	call   *%eax
  1030c8:	83 c4 10             	add    $0x10,%esp
            break;
  1030cb:	eb 28                	jmp    1030f5 <vprintfmt+0x39b>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1030cd:	83 ec 08             	sub    $0x8,%esp
  1030d0:	ff 75 0c             	pushl  0xc(%ebp)
  1030d3:	6a 25                	push   $0x25
  1030d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d8:	ff d0                	call   *%eax
  1030da:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  1030dd:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1030e1:	eb 04                	jmp    1030e7 <vprintfmt+0x38d>
  1030e3:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1030e7:	8b 45 10             	mov    0x10(%ebp),%eax
  1030ea:	83 e8 01             	sub    $0x1,%eax
  1030ed:	0f b6 00             	movzbl (%eax),%eax
  1030f0:	3c 25                	cmp    $0x25,%al
  1030f2:	75 ef                	jne    1030e3 <vprintfmt+0x389>
                /* do nothing */;
            break;
  1030f4:	90                   	nop
    while (1) {
  1030f5:	e9 68 fc ff ff       	jmp    102d62 <vprintfmt+0x8>
                return;
  1030fa:	90                   	nop
        }
    }
}
  1030fb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1030fe:	5b                   	pop    %ebx
  1030ff:	5e                   	pop    %esi
  103100:	5d                   	pop    %ebp
  103101:	c3                   	ret    

00103102 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103102:	55                   	push   %ebp
  103103:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103105:	8b 45 0c             	mov    0xc(%ebp),%eax
  103108:	8b 40 08             	mov    0x8(%eax),%eax
  10310b:	8d 50 01             	lea    0x1(%eax),%edx
  10310e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103111:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103114:	8b 45 0c             	mov    0xc(%ebp),%eax
  103117:	8b 10                	mov    (%eax),%edx
  103119:	8b 45 0c             	mov    0xc(%ebp),%eax
  10311c:	8b 40 04             	mov    0x4(%eax),%eax
  10311f:	39 c2                	cmp    %eax,%edx
  103121:	73 12                	jae    103135 <sprintputch+0x33>
        *b->buf ++ = ch;
  103123:	8b 45 0c             	mov    0xc(%ebp),%eax
  103126:	8b 00                	mov    (%eax),%eax
  103128:	8d 48 01             	lea    0x1(%eax),%ecx
  10312b:	8b 55 0c             	mov    0xc(%ebp),%edx
  10312e:	89 0a                	mov    %ecx,(%edx)
  103130:	8b 55 08             	mov    0x8(%ebp),%edx
  103133:	88 10                	mov    %dl,(%eax)
    }
}
  103135:	90                   	nop
  103136:	5d                   	pop    %ebp
  103137:	c3                   	ret    

00103138 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103138:	55                   	push   %ebp
  103139:	89 e5                	mov    %esp,%ebp
  10313b:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10313e:	8d 45 14             	lea    0x14(%ebp),%eax
  103141:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103144:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103147:	50                   	push   %eax
  103148:	ff 75 10             	pushl  0x10(%ebp)
  10314b:	ff 75 0c             	pushl  0xc(%ebp)
  10314e:	ff 75 08             	pushl  0x8(%ebp)
  103151:	e8 0b 00 00 00       	call   103161 <vsnprintf>
  103156:	83 c4 10             	add    $0x10,%esp
  103159:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10315c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10315f:	c9                   	leave  
  103160:	c3                   	ret    

00103161 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103161:	55                   	push   %ebp
  103162:	89 e5                	mov    %esp,%ebp
  103164:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103167:	8b 45 08             	mov    0x8(%ebp),%eax
  10316a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10316d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103170:	8d 50 ff             	lea    -0x1(%eax),%edx
  103173:	8b 45 08             	mov    0x8(%ebp),%eax
  103176:	01 d0                	add    %edx,%eax
  103178:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10317b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103182:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103186:	74 0a                	je     103192 <vsnprintf+0x31>
  103188:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10318b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10318e:	39 c2                	cmp    %eax,%edx
  103190:	76 07                	jbe    103199 <vsnprintf+0x38>
        return -E_INVAL;
  103192:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103197:	eb 20                	jmp    1031b9 <vsnprintf+0x58>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103199:	ff 75 14             	pushl  0x14(%ebp)
  10319c:	ff 75 10             	pushl  0x10(%ebp)
  10319f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1031a2:	50                   	push   %eax
  1031a3:	68 02 31 10 00       	push   $0x103102
  1031a8:	e8 ad fb ff ff       	call   102d5a <vprintfmt>
  1031ad:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  1031b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031b3:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1031b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1031b9:	c9                   	leave  
  1031ba:	c3                   	ret    
