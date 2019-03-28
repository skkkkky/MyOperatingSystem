
bin/kernel:     file format elf32-i386


Disassembly of section .text:

c0100000 <kern_entry>:

.text
.globl kern_entry
kern_entry:
    # load pa of boot pgdir
    movl $REALLOC(__boot_pgdir), %eax
c0100000:	b8 00 80 11 00       	mov    $0x118000,%eax
    movl %eax, %cr3
c0100005:	0f 22 d8             	mov    %eax,%cr3

    # enable paging
    movl %cr0, %eax
c0100008:	0f 20 c0             	mov    %cr0,%eax
    orl $(CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP), %eax
c010000b:	0d 2f 00 05 80       	or     $0x8005002f,%eax
    andl $~(CR0_TS | CR0_EM), %eax
c0100010:	83 e0 f3             	and    $0xfffffff3,%eax
    movl %eax, %cr0
c0100013:	0f 22 c0             	mov    %eax,%cr0

    # update eip
    # now, eip = 0x1.....
    leal next, %eax
c0100016:	8d 05 1e 00 10 c0    	lea    0xc010001e,%eax
    # set eip = KERNBASE + 0x1.....
    jmp *%eax
c010001c:	ff e0                	jmp    *%eax

c010001e <next>:
next:

    # unmap va 0 ~ 4M, it's temporary mapping
    xorl %eax, %eax
c010001e:	31 c0                	xor    %eax,%eax
    movl %eax, __boot_pgdir
c0100020:	a3 00 80 11 c0       	mov    %eax,0xc0118000

    # set ebp, esp
    movl $0x0, %ebp
c0100025:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
c010002a:	bc 00 70 11 c0       	mov    $0xc0117000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
c010002f:	e8 02 00 00 00       	call   c0100036 <kern_init>

c0100034 <spin>:

# should never get here
spin:
    jmp spin
c0100034:	eb fe                	jmp    c0100034 <spin>

c0100036 <kern_init>:
int kern_init(void) __attribute__((noreturn));

static void lab1_switch_test(void);

int
kern_init(void) {
c0100036:	55                   	push   %ebp
c0100037:	89 e5                	mov    %esp,%ebp
c0100039:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
c010003c:	ba 28 af 11 c0       	mov    $0xc011af28,%edx
c0100041:	b8 00 a0 11 c0       	mov    $0xc011a000,%eax
c0100046:	29 c2                	sub    %eax,%edx
c0100048:	89 d0                	mov    %edx,%eax
c010004a:	83 ec 04             	sub    $0x4,%esp
c010004d:	50                   	push   %eax
c010004e:	6a 00                	push   $0x0
c0100050:	68 00 a0 11 c0       	push   $0xc011a000
c0100055:	e8 83 52 00 00       	call   c01052dd <memset>
c010005a:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
c010005d:	e8 70 15 00 00       	call   c01015d2 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
c0100062:	c7 45 f4 80 5a 10 c0 	movl   $0xc0105a80,-0xc(%ebp)
    cprintf("%s\n\n", message);
c0100069:	83 ec 08             	sub    $0x8,%esp
c010006c:	ff 75 f4             	pushl  -0xc(%ebp)
c010006f:	68 9c 5a 10 c0       	push   $0xc0105a9c
c0100074:	e8 fa 01 00 00       	call   c0100273 <cprintf>
c0100079:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
c010007c:	e8 91 08 00 00       	call   c0100912 <print_kerninfo>

    grade_backtrace();
c0100081:	e8 74 00 00 00       	call   c01000fa <grade_backtrace>

    pmm_init();                 // init physical memory management
c0100086:	e8 65 30 00 00       	call   c01030f0 <pmm_init>

    pic_init();                 // init interrupt controller
c010008b:	e8 b4 16 00 00       	call   c0101744 <pic_init>
    idt_init();                 // init interrupt descriptor table
c0100090:	e8 15 18 00 00       	call   c01018aa <idt_init>

    clock_init();               // init clock interrupt
c0100095:	e8 db 0c 00 00       	call   c0100d75 <clock_init>
    intr_enable();              // enable irq interrupt
c010009a:	e8 e2 17 00 00       	call   c0101881 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
c010009f:	eb fe                	jmp    c010009f <kern_init+0x69>

c01000a1 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
c01000a1:	55                   	push   %ebp
c01000a2:	89 e5                	mov    %esp,%ebp
c01000a4:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
c01000a7:	83 ec 04             	sub    $0x4,%esp
c01000aa:	6a 00                	push   $0x0
c01000ac:	6a 00                	push   $0x0
c01000ae:	6a 00                	push   $0x0
c01000b0:	e8 ae 0c 00 00       	call   c0100d63 <mon_backtrace>
c01000b5:	83 c4 10             	add    $0x10,%esp
}
c01000b8:	90                   	nop
c01000b9:	c9                   	leave  
c01000ba:	c3                   	ret    

c01000bb <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
c01000bb:	55                   	push   %ebp
c01000bc:	89 e5                	mov    %esp,%ebp
c01000be:	53                   	push   %ebx
c01000bf:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
c01000c2:	8d 4d 0c             	lea    0xc(%ebp),%ecx
c01000c5:	8b 55 0c             	mov    0xc(%ebp),%edx
c01000c8:	8d 5d 08             	lea    0x8(%ebp),%ebx
c01000cb:	8b 45 08             	mov    0x8(%ebp),%eax
c01000ce:	51                   	push   %ecx
c01000cf:	52                   	push   %edx
c01000d0:	53                   	push   %ebx
c01000d1:	50                   	push   %eax
c01000d2:	e8 ca ff ff ff       	call   c01000a1 <grade_backtrace2>
c01000d7:	83 c4 10             	add    $0x10,%esp
}
c01000da:	90                   	nop
c01000db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c01000de:	c9                   	leave  
c01000df:	c3                   	ret    

c01000e0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
c01000e0:	55                   	push   %ebp
c01000e1:	89 e5                	mov    %esp,%ebp
c01000e3:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
c01000e6:	83 ec 08             	sub    $0x8,%esp
c01000e9:	ff 75 10             	pushl  0x10(%ebp)
c01000ec:	ff 75 08             	pushl  0x8(%ebp)
c01000ef:	e8 c7 ff ff ff       	call   c01000bb <grade_backtrace1>
c01000f4:	83 c4 10             	add    $0x10,%esp
}
c01000f7:	90                   	nop
c01000f8:	c9                   	leave  
c01000f9:	c3                   	ret    

c01000fa <grade_backtrace>:

void
grade_backtrace(void) {
c01000fa:	55                   	push   %ebp
c01000fb:	89 e5                	mov    %esp,%ebp
c01000fd:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
c0100100:	b8 36 00 10 c0       	mov    $0xc0100036,%eax
c0100105:	83 ec 04             	sub    $0x4,%esp
c0100108:	68 00 00 ff ff       	push   $0xffff0000
c010010d:	50                   	push   %eax
c010010e:	6a 00                	push   $0x0
c0100110:	e8 cb ff ff ff       	call   c01000e0 <grade_backtrace0>
c0100115:	83 c4 10             	add    $0x10,%esp
}
c0100118:	90                   	nop
c0100119:	c9                   	leave  
c010011a:	c3                   	ret    

c010011b <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
c010011b:	55                   	push   %ebp
c010011c:	89 e5                	mov    %esp,%ebp
c010011e:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
c0100121:	8c 4d f6             	mov    %cs,-0xa(%ebp)
c0100124:	8c 5d f4             	mov    %ds,-0xc(%ebp)
c0100127:	8c 45 f2             	mov    %es,-0xe(%ebp)
c010012a:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
c010012d:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100131:	0f b7 c0             	movzwl %ax,%eax
c0100134:	83 e0 03             	and    $0x3,%eax
c0100137:	89 c2                	mov    %eax,%edx
c0100139:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c010013e:	83 ec 04             	sub    $0x4,%esp
c0100141:	52                   	push   %edx
c0100142:	50                   	push   %eax
c0100143:	68 a1 5a 10 c0       	push   $0xc0105aa1
c0100148:	e8 26 01 00 00       	call   c0100273 <cprintf>
c010014d:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
c0100150:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100154:	0f b7 d0             	movzwl %ax,%edx
c0100157:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c010015c:	83 ec 04             	sub    $0x4,%esp
c010015f:	52                   	push   %edx
c0100160:	50                   	push   %eax
c0100161:	68 af 5a 10 c0       	push   $0xc0105aaf
c0100166:	e8 08 01 00 00       	call   c0100273 <cprintf>
c010016b:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
c010016e:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c0100172:	0f b7 d0             	movzwl %ax,%edx
c0100175:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c010017a:	83 ec 04             	sub    $0x4,%esp
c010017d:	52                   	push   %edx
c010017e:	50                   	push   %eax
c010017f:	68 bd 5a 10 c0       	push   $0xc0105abd
c0100184:	e8 ea 00 00 00       	call   c0100273 <cprintf>
c0100189:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
c010018c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100190:	0f b7 d0             	movzwl %ax,%edx
c0100193:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c0100198:	83 ec 04             	sub    $0x4,%esp
c010019b:	52                   	push   %edx
c010019c:	50                   	push   %eax
c010019d:	68 cb 5a 10 c0       	push   $0xc0105acb
c01001a2:	e8 cc 00 00 00       	call   c0100273 <cprintf>
c01001a7:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
c01001aa:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01001ae:	0f b7 d0             	movzwl %ax,%edx
c01001b1:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c01001b6:	83 ec 04             	sub    $0x4,%esp
c01001b9:	52                   	push   %edx
c01001ba:	50                   	push   %eax
c01001bb:	68 d9 5a 10 c0       	push   $0xc0105ad9
c01001c0:	e8 ae 00 00 00       	call   c0100273 <cprintf>
c01001c5:	83 c4 10             	add    $0x10,%esp
    round ++;
c01001c8:	a1 00 a0 11 c0       	mov    0xc011a000,%eax
c01001cd:	83 c0 01             	add    $0x1,%eax
c01001d0:	a3 00 a0 11 c0       	mov    %eax,0xc011a000
}
c01001d5:	90                   	nop
c01001d6:	c9                   	leave  
c01001d7:	c3                   	ret    

c01001d8 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
c01001d8:	55                   	push   %ebp
c01001d9:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
c01001db:	90                   	nop
c01001dc:	5d                   	pop    %ebp
c01001dd:	c3                   	ret    

c01001de <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
c01001de:	55                   	push   %ebp
c01001df:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
c01001e1:	90                   	nop
c01001e2:	5d                   	pop    %ebp
c01001e3:	c3                   	ret    

c01001e4 <lab1_switch_test>:

static void
lab1_switch_test(void) {
c01001e4:	55                   	push   %ebp
c01001e5:	89 e5                	mov    %esp,%ebp
c01001e7:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
c01001ea:	e8 2c ff ff ff       	call   c010011b <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
c01001ef:	83 ec 0c             	sub    $0xc,%esp
c01001f2:	68 e8 5a 10 c0       	push   $0xc0105ae8
c01001f7:	e8 77 00 00 00       	call   c0100273 <cprintf>
c01001fc:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
c01001ff:	e8 d4 ff ff ff       	call   c01001d8 <lab1_switch_to_user>
    lab1_print_cur_status();
c0100204:	e8 12 ff ff ff       	call   c010011b <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
c0100209:	83 ec 0c             	sub    $0xc,%esp
c010020c:	68 08 5b 10 c0       	push   $0xc0105b08
c0100211:	e8 5d 00 00 00       	call   c0100273 <cprintf>
c0100216:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
c0100219:	e8 c0 ff ff ff       	call   c01001de <lab1_switch_to_kernel>
    lab1_print_cur_status();
c010021e:	e8 f8 fe ff ff       	call   c010011b <lab1_print_cur_status>
}
c0100223:	90                   	nop
c0100224:	c9                   	leave  
c0100225:	c3                   	ret    

c0100226 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
c0100226:	55                   	push   %ebp
c0100227:	89 e5                	mov    %esp,%ebp
c0100229:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c010022c:	83 ec 0c             	sub    $0xc,%esp
c010022f:	ff 75 08             	pushl  0x8(%ebp)
c0100232:	e8 cc 13 00 00       	call   c0101603 <cons_putc>
c0100237:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
c010023a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010023d:	8b 00                	mov    (%eax),%eax
c010023f:	8d 50 01             	lea    0x1(%eax),%edx
c0100242:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100245:	89 10                	mov    %edx,(%eax)
}
c0100247:	90                   	nop
c0100248:	c9                   	leave  
c0100249:	c3                   	ret    

c010024a <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
c010024a:	55                   	push   %ebp
c010024b:	89 e5                	mov    %esp,%ebp
c010024d:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c0100250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
c0100257:	ff 75 0c             	pushl  0xc(%ebp)
c010025a:	ff 75 08             	pushl  0x8(%ebp)
c010025d:	8d 45 f4             	lea    -0xc(%ebp),%eax
c0100260:	50                   	push   %eax
c0100261:	68 26 02 10 c0       	push   $0xc0100226
c0100266:	e8 a8 53 00 00       	call   c0105613 <vprintfmt>
c010026b:	83 c4 10             	add    $0x10,%esp
    return cnt;
c010026e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100271:	c9                   	leave  
c0100272:	c3                   	ret    

c0100273 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
c0100273:	55                   	push   %ebp
c0100274:	89 e5                	mov    %esp,%ebp
c0100276:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0100279:	8d 45 0c             	lea    0xc(%ebp),%eax
c010027c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
c010027f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100282:	83 ec 08             	sub    $0x8,%esp
c0100285:	50                   	push   %eax
c0100286:	ff 75 08             	pushl  0x8(%ebp)
c0100289:	e8 bc ff ff ff       	call   c010024a <vcprintf>
c010028e:	83 c4 10             	add    $0x10,%esp
c0100291:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0100294:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100297:	c9                   	leave  
c0100298:	c3                   	ret    

c0100299 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
c0100299:	55                   	push   %ebp
c010029a:	89 e5                	mov    %esp,%ebp
c010029c:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c010029f:	83 ec 0c             	sub    $0xc,%esp
c01002a2:	ff 75 08             	pushl  0x8(%ebp)
c01002a5:	e8 59 13 00 00       	call   c0101603 <cons_putc>
c01002aa:	83 c4 10             	add    $0x10,%esp
}
c01002ad:	90                   	nop
c01002ae:	c9                   	leave  
c01002af:	c3                   	ret    

c01002b0 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
c01002b0:	55                   	push   %ebp
c01002b1:	89 e5                	mov    %esp,%ebp
c01002b3:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c01002b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
c01002bd:	eb 14                	jmp    c01002d3 <cputs+0x23>
        cputch(c, &cnt);
c01002bf:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c01002c3:	83 ec 08             	sub    $0x8,%esp
c01002c6:	8d 55 f0             	lea    -0x10(%ebp),%edx
c01002c9:	52                   	push   %edx
c01002ca:	50                   	push   %eax
c01002cb:	e8 56 ff ff ff       	call   c0100226 <cputch>
c01002d0:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
c01002d3:	8b 45 08             	mov    0x8(%ebp),%eax
c01002d6:	8d 50 01             	lea    0x1(%eax),%edx
c01002d9:	89 55 08             	mov    %edx,0x8(%ebp)
c01002dc:	0f b6 00             	movzbl (%eax),%eax
c01002df:	88 45 f7             	mov    %al,-0x9(%ebp)
c01002e2:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
c01002e6:	75 d7                	jne    c01002bf <cputs+0xf>
    }
    cputch('\n', &cnt);
c01002e8:	83 ec 08             	sub    $0x8,%esp
c01002eb:	8d 45 f0             	lea    -0x10(%ebp),%eax
c01002ee:	50                   	push   %eax
c01002ef:	6a 0a                	push   $0xa
c01002f1:	e8 30 ff ff ff       	call   c0100226 <cputch>
c01002f6:	83 c4 10             	add    $0x10,%esp
    return cnt;
c01002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c01002fc:	c9                   	leave  
c01002fd:	c3                   	ret    

c01002fe <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
c01002fe:	55                   	push   %ebp
c01002ff:	89 e5                	mov    %esp,%ebp
c0100301:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
c0100304:	e8 43 13 00 00       	call   c010164c <cons_getc>
c0100309:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010030c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100310:	74 f2                	je     c0100304 <getchar+0x6>
        /* do nothing */;
    return c;
c0100312:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100315:	c9                   	leave  
c0100316:	c3                   	ret    

c0100317 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
c0100317:	55                   	push   %ebp
c0100318:	89 e5                	mov    %esp,%ebp
c010031a:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
c010031d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100321:	74 13                	je     c0100336 <readline+0x1f>
        cprintf("%s", prompt);
c0100323:	83 ec 08             	sub    $0x8,%esp
c0100326:	ff 75 08             	pushl  0x8(%ebp)
c0100329:	68 27 5b 10 c0       	push   $0xc0105b27
c010032e:	e8 40 ff ff ff       	call   c0100273 <cprintf>
c0100333:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
c0100336:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
c010033d:	e8 bc ff ff ff       	call   c01002fe <getchar>
c0100342:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
c0100345:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100349:	79 0a                	jns    c0100355 <readline+0x3e>
            return NULL;
c010034b:	b8 00 00 00 00       	mov    $0x0,%eax
c0100350:	e9 82 00 00 00       	jmp    c01003d7 <readline+0xc0>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
c0100355:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
c0100359:	7e 2b                	jle    c0100386 <readline+0x6f>
c010035b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
c0100362:	7f 22                	jg     c0100386 <readline+0x6f>
            cputchar(c);
c0100364:	83 ec 0c             	sub    $0xc,%esp
c0100367:	ff 75 f0             	pushl  -0x10(%ebp)
c010036a:	e8 2a ff ff ff       	call   c0100299 <cputchar>
c010036f:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
c0100372:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100375:	8d 50 01             	lea    0x1(%eax),%edx
c0100378:	89 55 f4             	mov    %edx,-0xc(%ebp)
c010037b:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010037e:	88 90 20 a0 11 c0    	mov    %dl,-0x3fee5fe0(%eax)
c0100384:	eb 4c                	jmp    c01003d2 <readline+0xbb>
        }
        else if (c == '\b' && i > 0) {
c0100386:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
c010038a:	75 1a                	jne    c01003a6 <readline+0x8f>
c010038c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100390:	7e 14                	jle    c01003a6 <readline+0x8f>
            cputchar(c);
c0100392:	83 ec 0c             	sub    $0xc,%esp
c0100395:	ff 75 f0             	pushl  -0x10(%ebp)
c0100398:	e8 fc fe ff ff       	call   c0100299 <cputchar>
c010039d:	83 c4 10             	add    $0x10,%esp
            i --;
c01003a0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01003a4:	eb 2c                	jmp    c01003d2 <readline+0xbb>
        }
        else if (c == '\n' || c == '\r') {
c01003a6:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
c01003aa:	74 06                	je     c01003b2 <readline+0x9b>
c01003ac:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
c01003b0:	75 8b                	jne    c010033d <readline+0x26>
            cputchar(c);
c01003b2:	83 ec 0c             	sub    $0xc,%esp
c01003b5:	ff 75 f0             	pushl  -0x10(%ebp)
c01003b8:	e8 dc fe ff ff       	call   c0100299 <cputchar>
c01003bd:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
c01003c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01003c3:	05 20 a0 11 c0       	add    $0xc011a020,%eax
c01003c8:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
c01003cb:	b8 20 a0 11 c0       	mov    $0xc011a020,%eax
c01003d0:	eb 05                	jmp    c01003d7 <readline+0xc0>
        c = getchar();
c01003d2:	e9 66 ff ff ff       	jmp    c010033d <readline+0x26>
        }
    }
}
c01003d7:	c9                   	leave  
c01003d8:	c3                   	ret    

c01003d9 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
c01003d9:	55                   	push   %ebp
c01003da:	89 e5                	mov    %esp,%ebp
c01003dc:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
c01003df:	a1 20 a4 11 c0       	mov    0xc011a420,%eax
c01003e4:	85 c0                	test   %eax,%eax
c01003e6:	75 5f                	jne    c0100447 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
c01003e8:	c7 05 20 a4 11 c0 01 	movl   $0x1,0xc011a420
c01003ef:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
c01003f2:	8d 45 14             	lea    0x14(%ebp),%eax
c01003f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
c01003f8:	83 ec 04             	sub    $0x4,%esp
c01003fb:	ff 75 0c             	pushl  0xc(%ebp)
c01003fe:	ff 75 08             	pushl  0x8(%ebp)
c0100401:	68 2a 5b 10 c0       	push   $0xc0105b2a
c0100406:	e8 68 fe ff ff       	call   c0100273 <cprintf>
c010040b:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c010040e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100411:	83 ec 08             	sub    $0x8,%esp
c0100414:	50                   	push   %eax
c0100415:	ff 75 10             	pushl  0x10(%ebp)
c0100418:	e8 2d fe ff ff       	call   c010024a <vcprintf>
c010041d:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c0100420:	83 ec 0c             	sub    $0xc,%esp
c0100423:	68 46 5b 10 c0       	push   $0xc0105b46
c0100428:	e8 46 fe ff ff       	call   c0100273 <cprintf>
c010042d:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
c0100430:	83 ec 0c             	sub    $0xc,%esp
c0100433:	68 48 5b 10 c0       	push   $0xc0105b48
c0100438:	e8 36 fe ff ff       	call   c0100273 <cprintf>
c010043d:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
c0100440:	e8 17 06 00 00       	call   c0100a5c <print_stackframe>
c0100445:	eb 01                	jmp    c0100448 <__panic+0x6f>
        goto panic_dead;
c0100447:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
c0100448:	e8 3b 14 00 00       	call   c0101888 <intr_disable>
    while (1) {
        kmonitor(NULL);
c010044d:	83 ec 0c             	sub    $0xc,%esp
c0100450:	6a 00                	push   $0x0
c0100452:	e8 32 08 00 00       	call   c0100c89 <kmonitor>
c0100457:	83 c4 10             	add    $0x10,%esp
c010045a:	eb f1                	jmp    c010044d <__panic+0x74>

c010045c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
c010045c:	55                   	push   %ebp
c010045d:	89 e5                	mov    %esp,%ebp
c010045f:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
c0100462:	8d 45 14             	lea    0x14(%ebp),%eax
c0100465:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
c0100468:	83 ec 04             	sub    $0x4,%esp
c010046b:	ff 75 0c             	pushl  0xc(%ebp)
c010046e:	ff 75 08             	pushl  0x8(%ebp)
c0100471:	68 5a 5b 10 c0       	push   $0xc0105b5a
c0100476:	e8 f8 fd ff ff       	call   c0100273 <cprintf>
c010047b:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c010047e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100481:	83 ec 08             	sub    $0x8,%esp
c0100484:	50                   	push   %eax
c0100485:	ff 75 10             	pushl  0x10(%ebp)
c0100488:	e8 bd fd ff ff       	call   c010024a <vcprintf>
c010048d:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c0100490:	83 ec 0c             	sub    $0xc,%esp
c0100493:	68 46 5b 10 c0       	push   $0xc0105b46
c0100498:	e8 d6 fd ff ff       	call   c0100273 <cprintf>
c010049d:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c01004a0:	90                   	nop
c01004a1:	c9                   	leave  
c01004a2:	c3                   	ret    

c01004a3 <is_kernel_panic>:

bool
is_kernel_panic(void) {
c01004a3:	55                   	push   %ebp
c01004a4:	89 e5                	mov    %esp,%ebp
    return is_panic;
c01004a6:	a1 20 a4 11 c0       	mov    0xc011a420,%eax
}
c01004ab:	5d                   	pop    %ebp
c01004ac:	c3                   	ret    

c01004ad <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
c01004ad:	55                   	push   %ebp
c01004ae:	89 e5                	mov    %esp,%ebp
c01004b0:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
c01004b3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01004b6:	8b 00                	mov    (%eax),%eax
c01004b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
c01004bb:	8b 45 10             	mov    0x10(%ebp),%eax
c01004be:	8b 00                	mov    (%eax),%eax
c01004c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01004c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
c01004ca:	e9 d2 00 00 00       	jmp    c01005a1 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
c01004cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
c01004d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01004d5:	01 d0                	add    %edx,%eax
c01004d7:	89 c2                	mov    %eax,%edx
c01004d9:	c1 ea 1f             	shr    $0x1f,%edx
c01004dc:	01 d0                	add    %edx,%eax
c01004de:	d1 f8                	sar    %eax
c01004e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01004e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01004e6:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c01004e9:	eb 04                	jmp    c01004ef <stab_binsearch+0x42>
            m --;
c01004eb:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
c01004ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01004f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c01004f5:	7c 1f                	jl     c0100516 <stab_binsearch+0x69>
c01004f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01004fa:	89 d0                	mov    %edx,%eax
c01004fc:	01 c0                	add    %eax,%eax
c01004fe:	01 d0                	add    %edx,%eax
c0100500:	c1 e0 02             	shl    $0x2,%eax
c0100503:	89 c2                	mov    %eax,%edx
c0100505:	8b 45 08             	mov    0x8(%ebp),%eax
c0100508:	01 d0                	add    %edx,%eax
c010050a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010050e:	0f b6 c0             	movzbl %al,%eax
c0100511:	39 45 14             	cmp    %eax,0x14(%ebp)
c0100514:	75 d5                	jne    c01004eb <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
c0100516:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100519:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c010051c:	7d 0b                	jge    c0100529 <stab_binsearch+0x7c>
            l = true_m + 1;
c010051e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100521:	83 c0 01             	add    $0x1,%eax
c0100524:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
c0100527:	eb 78                	jmp    c01005a1 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
c0100529:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
c0100530:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100533:	89 d0                	mov    %edx,%eax
c0100535:	01 c0                	add    %eax,%eax
c0100537:	01 d0                	add    %edx,%eax
c0100539:	c1 e0 02             	shl    $0x2,%eax
c010053c:	89 c2                	mov    %eax,%edx
c010053e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100541:	01 d0                	add    %edx,%eax
c0100543:	8b 40 08             	mov    0x8(%eax),%eax
c0100546:	39 45 18             	cmp    %eax,0x18(%ebp)
c0100549:	76 13                	jbe    c010055e <stab_binsearch+0xb1>
            *region_left = m;
c010054b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010054e:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100551:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
c0100553:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100556:	83 c0 01             	add    $0x1,%eax
c0100559:	89 45 fc             	mov    %eax,-0x4(%ebp)
c010055c:	eb 43                	jmp    c01005a1 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
c010055e:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100561:	89 d0                	mov    %edx,%eax
c0100563:	01 c0                	add    %eax,%eax
c0100565:	01 d0                	add    %edx,%eax
c0100567:	c1 e0 02             	shl    $0x2,%eax
c010056a:	89 c2                	mov    %eax,%edx
c010056c:	8b 45 08             	mov    0x8(%ebp),%eax
c010056f:	01 d0                	add    %edx,%eax
c0100571:	8b 40 08             	mov    0x8(%eax),%eax
c0100574:	39 45 18             	cmp    %eax,0x18(%ebp)
c0100577:	73 16                	jae    c010058f <stab_binsearch+0xe2>
            *region_right = m - 1;
c0100579:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010057c:	8d 50 ff             	lea    -0x1(%eax),%edx
c010057f:	8b 45 10             	mov    0x10(%ebp),%eax
c0100582:	89 10                	mov    %edx,(%eax)
            r = m - 1;
c0100584:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100587:	83 e8 01             	sub    $0x1,%eax
c010058a:	89 45 f8             	mov    %eax,-0x8(%ebp)
c010058d:	eb 12                	jmp    c01005a1 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
c010058f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100592:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100595:	89 10                	mov    %edx,(%eax)
            l = m;
c0100597:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010059a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
c010059d:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
c01005a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01005a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c01005a7:	0f 8e 22 ff ff ff    	jle    c01004cf <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
c01005ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01005b1:	75 0f                	jne    c01005c2 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
c01005b3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005b6:	8b 00                	mov    (%eax),%eax
c01005b8:	8d 50 ff             	lea    -0x1(%eax),%edx
c01005bb:	8b 45 10             	mov    0x10(%ebp),%eax
c01005be:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
c01005c0:	eb 3f                	jmp    c0100601 <stab_binsearch+0x154>
        l = *region_right;
c01005c2:	8b 45 10             	mov    0x10(%ebp),%eax
c01005c5:	8b 00                	mov    (%eax),%eax
c01005c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
c01005ca:	eb 04                	jmp    c01005d0 <stab_binsearch+0x123>
c01005cc:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
c01005d0:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005d3:	8b 00                	mov    (%eax),%eax
c01005d5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
c01005d8:	7e 1f                	jle    c01005f9 <stab_binsearch+0x14c>
c01005da:	8b 55 fc             	mov    -0x4(%ebp),%edx
c01005dd:	89 d0                	mov    %edx,%eax
c01005df:	01 c0                	add    %eax,%eax
c01005e1:	01 d0                	add    %edx,%eax
c01005e3:	c1 e0 02             	shl    $0x2,%eax
c01005e6:	89 c2                	mov    %eax,%edx
c01005e8:	8b 45 08             	mov    0x8(%ebp),%eax
c01005eb:	01 d0                	add    %edx,%eax
c01005ed:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c01005f1:	0f b6 c0             	movzbl %al,%eax
c01005f4:	39 45 14             	cmp    %eax,0x14(%ebp)
c01005f7:	75 d3                	jne    c01005cc <stab_binsearch+0x11f>
        *region_left = l;
c01005f9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
c01005ff:	89 10                	mov    %edx,(%eax)
}
c0100601:	90                   	nop
c0100602:	c9                   	leave  
c0100603:	c3                   	ret    

c0100604 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
c0100604:	55                   	push   %ebp
c0100605:	89 e5                	mov    %esp,%ebp
c0100607:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
c010060a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010060d:	c7 00 78 5b 10 c0    	movl   $0xc0105b78,(%eax)
    info->eip_line = 0;
c0100613:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100616:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
c010061d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100620:	c7 40 08 78 5b 10 c0 	movl   $0xc0105b78,0x8(%eax)
    info->eip_fn_namelen = 9;
c0100627:	8b 45 0c             	mov    0xc(%ebp),%eax
c010062a:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
c0100631:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100634:	8b 55 08             	mov    0x8(%ebp),%edx
c0100637:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
c010063a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010063d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
c0100644:	c7 45 f4 a0 6d 10 c0 	movl   $0xc0106da0,-0xc(%ebp)
    stab_end = __STAB_END__;
c010064b:	c7 45 f0 60 1f 11 c0 	movl   $0xc0111f60,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
c0100652:	c7 45 ec 61 1f 11 c0 	movl   $0xc0111f61,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
c0100659:	c7 45 e8 5f 4a 11 c0 	movl   $0xc0114a5f,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
c0100660:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100663:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0100666:	76 0d                	jbe    c0100675 <debuginfo_eip+0x71>
c0100668:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010066b:	83 e8 01             	sub    $0x1,%eax
c010066e:	0f b6 00             	movzbl (%eax),%eax
c0100671:	84 c0                	test   %al,%al
c0100673:	74 0a                	je     c010067f <debuginfo_eip+0x7b>
        return -1;
c0100675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010067a:	e9 91 02 00 00       	jmp    c0100910 <debuginfo_eip+0x30c>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
c010067f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c0100686:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100689:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010068c:	29 c2                	sub    %eax,%edx
c010068e:	89 d0                	mov    %edx,%eax
c0100690:	c1 f8 02             	sar    $0x2,%eax
c0100693:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
c0100699:	83 e8 01             	sub    $0x1,%eax
c010069c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
c010069f:	ff 75 08             	pushl  0x8(%ebp)
c01006a2:	6a 64                	push   $0x64
c01006a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
c01006a7:	50                   	push   %eax
c01006a8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
c01006ab:	50                   	push   %eax
c01006ac:	ff 75 f4             	pushl  -0xc(%ebp)
c01006af:	e8 f9 fd ff ff       	call   c01004ad <stab_binsearch>
c01006b4:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
c01006b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01006ba:	85 c0                	test   %eax,%eax
c01006bc:	75 0a                	jne    c01006c8 <debuginfo_eip+0xc4>
        return -1;
c01006be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01006c3:	e9 48 02 00 00       	jmp    c0100910 <debuginfo_eip+0x30c>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
c01006c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01006cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
c01006ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01006d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
c01006d4:	ff 75 08             	pushl  0x8(%ebp)
c01006d7:	6a 24                	push   $0x24
c01006d9:	8d 45 d8             	lea    -0x28(%ebp),%eax
c01006dc:	50                   	push   %eax
c01006dd:	8d 45 dc             	lea    -0x24(%ebp),%eax
c01006e0:	50                   	push   %eax
c01006e1:	ff 75 f4             	pushl  -0xc(%ebp)
c01006e4:	e8 c4 fd ff ff       	call   c01004ad <stab_binsearch>
c01006e9:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
c01006ec:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01006ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01006f2:	39 c2                	cmp    %eax,%edx
c01006f4:	7f 7c                	jg     c0100772 <debuginfo_eip+0x16e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
c01006f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01006f9:	89 c2                	mov    %eax,%edx
c01006fb:	89 d0                	mov    %edx,%eax
c01006fd:	01 c0                	add    %eax,%eax
c01006ff:	01 d0                	add    %edx,%eax
c0100701:	c1 e0 02             	shl    $0x2,%eax
c0100704:	89 c2                	mov    %eax,%edx
c0100706:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100709:	01 d0                	add    %edx,%eax
c010070b:	8b 00                	mov    (%eax),%eax
c010070d:	8b 4d e8             	mov    -0x18(%ebp),%ecx
c0100710:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0100713:	29 d1                	sub    %edx,%ecx
c0100715:	89 ca                	mov    %ecx,%edx
c0100717:	39 d0                	cmp    %edx,%eax
c0100719:	73 22                	jae    c010073d <debuginfo_eip+0x139>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
c010071b:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010071e:	89 c2                	mov    %eax,%edx
c0100720:	89 d0                	mov    %edx,%eax
c0100722:	01 c0                	add    %eax,%eax
c0100724:	01 d0                	add    %edx,%eax
c0100726:	c1 e0 02             	shl    $0x2,%eax
c0100729:	89 c2                	mov    %eax,%edx
c010072b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010072e:	01 d0                	add    %edx,%eax
c0100730:	8b 10                	mov    (%eax),%edx
c0100732:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100735:	01 c2                	add    %eax,%edx
c0100737:	8b 45 0c             	mov    0xc(%ebp),%eax
c010073a:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
c010073d:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100740:	89 c2                	mov    %eax,%edx
c0100742:	89 d0                	mov    %edx,%eax
c0100744:	01 c0                	add    %eax,%eax
c0100746:	01 d0                	add    %edx,%eax
c0100748:	c1 e0 02             	shl    $0x2,%eax
c010074b:	89 c2                	mov    %eax,%edx
c010074d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100750:	01 d0                	add    %edx,%eax
c0100752:	8b 50 08             	mov    0x8(%eax),%edx
c0100755:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100758:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
c010075b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010075e:	8b 40 10             	mov    0x10(%eax),%eax
c0100761:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
c0100764:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100767:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
c010076a:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010076d:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0100770:	eb 15                	jmp    c0100787 <debuginfo_eip+0x183>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
c0100772:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100775:	8b 55 08             	mov    0x8(%ebp),%edx
c0100778:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
c010077b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010077e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
c0100781:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0100784:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
c0100787:	8b 45 0c             	mov    0xc(%ebp),%eax
c010078a:	8b 40 08             	mov    0x8(%eax),%eax
c010078d:	83 ec 08             	sub    $0x8,%esp
c0100790:	6a 3a                	push   $0x3a
c0100792:	50                   	push   %eax
c0100793:	e8 b9 49 00 00       	call   c0105151 <strfind>
c0100798:	83 c4 10             	add    $0x10,%esp
c010079b:	89 c2                	mov    %eax,%edx
c010079d:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007a0:	8b 40 08             	mov    0x8(%eax),%eax
c01007a3:	29 c2                	sub    %eax,%edx
c01007a5:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007a8:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
c01007ab:	83 ec 0c             	sub    $0xc,%esp
c01007ae:	ff 75 08             	pushl  0x8(%ebp)
c01007b1:	6a 44                	push   $0x44
c01007b3:	8d 45 d0             	lea    -0x30(%ebp),%eax
c01007b6:	50                   	push   %eax
c01007b7:	8d 45 d4             	lea    -0x2c(%ebp),%eax
c01007ba:	50                   	push   %eax
c01007bb:	ff 75 f4             	pushl  -0xc(%ebp)
c01007be:	e8 ea fc ff ff       	call   c01004ad <stab_binsearch>
c01007c3:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
c01007c6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01007c9:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01007cc:	39 c2                	cmp    %eax,%edx
c01007ce:	7f 24                	jg     c01007f4 <debuginfo_eip+0x1f0>
        info->eip_line = stabs[rline].n_desc;
c01007d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01007d3:	89 c2                	mov    %eax,%edx
c01007d5:	89 d0                	mov    %edx,%eax
c01007d7:	01 c0                	add    %eax,%eax
c01007d9:	01 d0                	add    %edx,%eax
c01007db:	c1 e0 02             	shl    $0x2,%eax
c01007de:	89 c2                	mov    %eax,%edx
c01007e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007e3:	01 d0                	add    %edx,%eax
c01007e5:	0f b7 40 06          	movzwl 0x6(%eax),%eax
c01007e9:	0f b7 d0             	movzwl %ax,%edx
c01007ec:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007ef:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c01007f2:	eb 13                	jmp    c0100807 <debuginfo_eip+0x203>
        return -1;
c01007f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01007f9:	e9 12 01 00 00       	jmp    c0100910 <debuginfo_eip+0x30c>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
c01007fe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100801:	83 e8 01             	sub    $0x1,%eax
c0100804:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
c0100807:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010080a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010080d:	39 c2                	cmp    %eax,%edx
c010080f:	7c 56                	jl     c0100867 <debuginfo_eip+0x263>
           && stabs[lline].n_type != N_SOL
c0100811:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100814:	89 c2                	mov    %eax,%edx
c0100816:	89 d0                	mov    %edx,%eax
c0100818:	01 c0                	add    %eax,%eax
c010081a:	01 d0                	add    %edx,%eax
c010081c:	c1 e0 02             	shl    $0x2,%eax
c010081f:	89 c2                	mov    %eax,%edx
c0100821:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100824:	01 d0                	add    %edx,%eax
c0100826:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010082a:	3c 84                	cmp    $0x84,%al
c010082c:	74 39                	je     c0100867 <debuginfo_eip+0x263>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
c010082e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100831:	89 c2                	mov    %eax,%edx
c0100833:	89 d0                	mov    %edx,%eax
c0100835:	01 c0                	add    %eax,%eax
c0100837:	01 d0                	add    %edx,%eax
c0100839:	c1 e0 02             	shl    $0x2,%eax
c010083c:	89 c2                	mov    %eax,%edx
c010083e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100841:	01 d0                	add    %edx,%eax
c0100843:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100847:	3c 64                	cmp    $0x64,%al
c0100849:	75 b3                	jne    c01007fe <debuginfo_eip+0x1fa>
c010084b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010084e:	89 c2                	mov    %eax,%edx
c0100850:	89 d0                	mov    %edx,%eax
c0100852:	01 c0                	add    %eax,%eax
c0100854:	01 d0                	add    %edx,%eax
c0100856:	c1 e0 02             	shl    $0x2,%eax
c0100859:	89 c2                	mov    %eax,%edx
c010085b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010085e:	01 d0                	add    %edx,%eax
c0100860:	8b 40 08             	mov    0x8(%eax),%eax
c0100863:	85 c0                	test   %eax,%eax
c0100865:	74 97                	je     c01007fe <debuginfo_eip+0x1fa>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
c0100867:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010086a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010086d:	39 c2                	cmp    %eax,%edx
c010086f:	7c 46                	jl     c01008b7 <debuginfo_eip+0x2b3>
c0100871:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100874:	89 c2                	mov    %eax,%edx
c0100876:	89 d0                	mov    %edx,%eax
c0100878:	01 c0                	add    %eax,%eax
c010087a:	01 d0                	add    %edx,%eax
c010087c:	c1 e0 02             	shl    $0x2,%eax
c010087f:	89 c2                	mov    %eax,%edx
c0100881:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100884:	01 d0                	add    %edx,%eax
c0100886:	8b 00                	mov    (%eax),%eax
c0100888:	8b 4d e8             	mov    -0x18(%ebp),%ecx
c010088b:	8b 55 ec             	mov    -0x14(%ebp),%edx
c010088e:	29 d1                	sub    %edx,%ecx
c0100890:	89 ca                	mov    %ecx,%edx
c0100892:	39 d0                	cmp    %edx,%eax
c0100894:	73 21                	jae    c01008b7 <debuginfo_eip+0x2b3>
        info->eip_file = stabstr + stabs[lline].n_strx;
c0100896:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100899:	89 c2                	mov    %eax,%edx
c010089b:	89 d0                	mov    %edx,%eax
c010089d:	01 c0                	add    %eax,%eax
c010089f:	01 d0                	add    %edx,%eax
c01008a1:	c1 e0 02             	shl    $0x2,%eax
c01008a4:	89 c2                	mov    %eax,%edx
c01008a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008a9:	01 d0                	add    %edx,%eax
c01008ab:	8b 10                	mov    (%eax),%edx
c01008ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01008b0:	01 c2                	add    %eax,%edx
c01008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008b5:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
c01008b7:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01008ba:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01008bd:	39 c2                	cmp    %eax,%edx
c01008bf:	7d 4a                	jge    c010090b <debuginfo_eip+0x307>
        for (lline = lfun + 1;
c01008c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01008c4:	83 c0 01             	add    $0x1,%eax
c01008c7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c01008ca:	eb 18                	jmp    c01008e4 <debuginfo_eip+0x2e0>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
c01008cc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008cf:	8b 40 14             	mov    0x14(%eax),%eax
c01008d2:	8d 50 01             	lea    0x1(%eax),%edx
c01008d5:	8b 45 0c             	mov    0xc(%ebp),%eax
c01008d8:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
c01008db:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008de:	83 c0 01             	add    $0x1,%eax
c01008e1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
c01008e4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01008e7:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
c01008ea:	39 c2                	cmp    %eax,%edx
c01008ec:	7d 1d                	jge    c010090b <debuginfo_eip+0x307>
             lline < rfun && stabs[lline].n_type == N_PSYM;
c01008ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008f1:	89 c2                	mov    %eax,%edx
c01008f3:	89 d0                	mov    %edx,%eax
c01008f5:	01 c0                	add    %eax,%eax
c01008f7:	01 d0                	add    %edx,%eax
c01008f9:	c1 e0 02             	shl    $0x2,%eax
c01008fc:	89 c2                	mov    %eax,%edx
c01008fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100901:	01 d0                	add    %edx,%eax
c0100903:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100907:	3c a0                	cmp    $0xa0,%al
c0100909:	74 c1                	je     c01008cc <debuginfo_eip+0x2c8>
        }
    }
    return 0;
c010090b:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100910:	c9                   	leave  
c0100911:	c3                   	ret    

c0100912 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
c0100912:	55                   	push   %ebp
c0100913:	89 e5                	mov    %esp,%ebp
c0100915:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
c0100918:	83 ec 0c             	sub    $0xc,%esp
c010091b:	68 82 5b 10 c0       	push   $0xc0105b82
c0100920:	e8 4e f9 ff ff       	call   c0100273 <cprintf>
c0100925:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
c0100928:	83 ec 08             	sub    $0x8,%esp
c010092b:	68 36 00 10 c0       	push   $0xc0100036
c0100930:	68 9b 5b 10 c0       	push   $0xc0105b9b
c0100935:	e8 39 f9 ff ff       	call   c0100273 <cprintf>
c010093a:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
c010093d:	83 ec 08             	sub    $0x8,%esp
c0100940:	68 74 5a 10 c0       	push   $0xc0105a74
c0100945:	68 b3 5b 10 c0       	push   $0xc0105bb3
c010094a:	e8 24 f9 ff ff       	call   c0100273 <cprintf>
c010094f:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
c0100952:	83 ec 08             	sub    $0x8,%esp
c0100955:	68 00 a0 11 c0       	push   $0xc011a000
c010095a:	68 cb 5b 10 c0       	push   $0xc0105bcb
c010095f:	e8 0f f9 ff ff       	call   c0100273 <cprintf>
c0100964:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
c0100967:	83 ec 08             	sub    $0x8,%esp
c010096a:	68 28 af 11 c0       	push   $0xc011af28
c010096f:	68 e3 5b 10 c0       	push   $0xc0105be3
c0100974:	e8 fa f8 ff ff       	call   c0100273 <cprintf>
c0100979:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
c010097c:	b8 28 af 11 c0       	mov    $0xc011af28,%eax
c0100981:	05 ff 03 00 00       	add    $0x3ff,%eax
c0100986:	ba 36 00 10 c0       	mov    $0xc0100036,%edx
c010098b:	29 d0                	sub    %edx,%eax
c010098d:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c0100993:	85 c0                	test   %eax,%eax
c0100995:	0f 48 c2             	cmovs  %edx,%eax
c0100998:	c1 f8 0a             	sar    $0xa,%eax
c010099b:	83 ec 08             	sub    $0x8,%esp
c010099e:	50                   	push   %eax
c010099f:	68 fc 5b 10 c0       	push   $0xc0105bfc
c01009a4:	e8 ca f8 ff ff       	call   c0100273 <cprintf>
c01009a9:	83 c4 10             	add    $0x10,%esp
}
c01009ac:	90                   	nop
c01009ad:	c9                   	leave  
c01009ae:	c3                   	ret    

c01009af <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
c01009af:	55                   	push   %ebp
c01009b0:	89 e5                	mov    %esp,%ebp
c01009b2:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
c01009b8:	83 ec 08             	sub    $0x8,%esp
c01009bb:	8d 45 dc             	lea    -0x24(%ebp),%eax
c01009be:	50                   	push   %eax
c01009bf:	ff 75 08             	pushl  0x8(%ebp)
c01009c2:	e8 3d fc ff ff       	call   c0100604 <debuginfo_eip>
c01009c7:	83 c4 10             	add    $0x10,%esp
c01009ca:	85 c0                	test   %eax,%eax
c01009cc:	74 15                	je     c01009e3 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
c01009ce:	83 ec 08             	sub    $0x8,%esp
c01009d1:	ff 75 08             	pushl  0x8(%ebp)
c01009d4:	68 26 5c 10 c0       	push   $0xc0105c26
c01009d9:	e8 95 f8 ff ff       	call   c0100273 <cprintf>
c01009de:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
c01009e1:	eb 65                	jmp    c0100a48 <print_debuginfo+0x99>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c01009e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c01009ea:	eb 1c                	jmp    c0100a08 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
c01009ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01009ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01009f2:	01 d0                	add    %edx,%eax
c01009f4:	0f b6 00             	movzbl (%eax),%eax
c01009f7:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c01009fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100a00:	01 ca                	add    %ecx,%edx
c0100a02:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a04:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100a08:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100a0b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0100a0e:	7c dc                	jl     c01009ec <print_debuginfo+0x3d>
        fnname[j] = '\0';
c0100a10:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
c0100a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a19:	01 d0                	add    %edx,%eax
c0100a1b:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
c0100a1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
c0100a21:	8b 55 08             	mov    0x8(%ebp),%edx
c0100a24:	89 d1                	mov    %edx,%ecx
c0100a26:	29 c1                	sub    %eax,%ecx
c0100a28:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0100a2b:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100a2e:	83 ec 0c             	sub    $0xc,%esp
c0100a31:	51                   	push   %ecx
c0100a32:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a38:	51                   	push   %ecx
c0100a39:	52                   	push   %edx
c0100a3a:	50                   	push   %eax
c0100a3b:	68 42 5c 10 c0       	push   $0xc0105c42
c0100a40:	e8 2e f8 ff ff       	call   c0100273 <cprintf>
c0100a45:	83 c4 20             	add    $0x20,%esp
}
c0100a48:	90                   	nop
c0100a49:	c9                   	leave  
c0100a4a:	c3                   	ret    

c0100a4b <read_eip>:

static __noinline uint32_t
read_eip(void) {
c0100a4b:	55                   	push   %ebp
c0100a4c:	89 e5                	mov    %esp,%ebp
c0100a4e:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
c0100a51:	8b 45 04             	mov    0x4(%ebp),%eax
c0100a54:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
c0100a57:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0100a5a:	c9                   	leave  
c0100a5b:	c3                   	ret    

c0100a5c <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
c0100a5c:	55                   	push   %ebp
c0100a5d:	89 e5                	mov    %esp,%ebp
c0100a5f:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
c0100a62:	89 e8                	mov    %ebp,%eax
c0100a64:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
c0100a67:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
c0100a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100a6d:	e8 d9 ff ff ff       	call   c0100a4b <read_eip>
c0100a72:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
c0100a75:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0100a7c:	e9 8d 00 00 00       	jmp    c0100b0e <print_stackframe+0xb2>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
c0100a81:	83 ec 04             	sub    $0x4,%esp
c0100a84:	ff 75 f0             	pushl  -0x10(%ebp)
c0100a87:	ff 75 f4             	pushl  -0xc(%ebp)
c0100a8a:	68 54 5c 10 c0       	push   $0xc0105c54
c0100a8f:	e8 df f7 ff ff       	call   c0100273 <cprintf>
c0100a94:	83 c4 10             	add    $0x10,%esp
        uint32_t *args = (uint32_t *)ebp + 2;
c0100a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a9a:	83 c0 08             	add    $0x8,%eax
c0100a9d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
c0100aa0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
c0100aa7:	eb 26                	jmp    c0100acf <print_stackframe+0x73>
            cprintf("0x%08x ", args[j]);
c0100aa9:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100aac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100ab3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100ab6:	01 d0                	add    %edx,%eax
c0100ab8:	8b 00                	mov    (%eax),%eax
c0100aba:	83 ec 08             	sub    $0x8,%esp
c0100abd:	50                   	push   %eax
c0100abe:	68 70 5c 10 c0       	push   $0xc0105c70
c0100ac3:	e8 ab f7 ff ff       	call   c0100273 <cprintf>
c0100ac8:	83 c4 10             	add    $0x10,%esp
        for (j = 0; j < 4; j ++) {
c0100acb:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
c0100acf:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
c0100ad3:	7e d4                	jle    c0100aa9 <print_stackframe+0x4d>
        }
        cprintf("\n");
c0100ad5:	83 ec 0c             	sub    $0xc,%esp
c0100ad8:	68 78 5c 10 c0       	push   $0xc0105c78
c0100add:	e8 91 f7 ff ff       	call   c0100273 <cprintf>
c0100ae2:	83 c4 10             	add    $0x10,%esp
        print_debuginfo(eip - 1);
c0100ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100ae8:	83 e8 01             	sub    $0x1,%eax
c0100aeb:	83 ec 0c             	sub    $0xc,%esp
c0100aee:	50                   	push   %eax
c0100aef:	e8 bb fe ff ff       	call   c01009af <print_debuginfo>
c0100af4:	83 c4 10             	add    $0x10,%esp
        eip = ((uint32_t *)ebp)[1];
c0100af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100afa:	83 c0 04             	add    $0x4,%eax
c0100afd:	8b 00                	mov    (%eax),%eax
c0100aff:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
c0100b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b05:	8b 00                	mov    (%eax),%eax
c0100b07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
c0100b0a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c0100b0e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100b12:	74 0a                	je     c0100b1e <print_stackframe+0xc2>
c0100b14:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
c0100b18:	0f 8e 63 ff ff ff    	jle    c0100a81 <print_stackframe+0x25>
    }
}
c0100b1e:	90                   	nop
c0100b1f:	c9                   	leave  
c0100b20:	c3                   	ret    

c0100b21 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
c0100b21:	55                   	push   %ebp
c0100b22:	89 e5                	mov    %esp,%ebp
c0100b24:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
c0100b27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b2e:	eb 0c                	jmp    c0100b3c <parse+0x1b>
            *buf ++ = '\0';
c0100b30:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b33:	8d 50 01             	lea    0x1(%eax),%edx
c0100b36:	89 55 08             	mov    %edx,0x8(%ebp)
c0100b39:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b3c:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b3f:	0f b6 00             	movzbl (%eax),%eax
c0100b42:	84 c0                	test   %al,%al
c0100b44:	74 1e                	je     c0100b64 <parse+0x43>
c0100b46:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b49:	0f b6 00             	movzbl (%eax),%eax
c0100b4c:	0f be c0             	movsbl %al,%eax
c0100b4f:	83 ec 08             	sub    $0x8,%esp
c0100b52:	50                   	push   %eax
c0100b53:	68 fc 5c 10 c0       	push   $0xc0105cfc
c0100b58:	e8 c1 45 00 00       	call   c010511e <strchr>
c0100b5d:	83 c4 10             	add    $0x10,%esp
c0100b60:	85 c0                	test   %eax,%eax
c0100b62:	75 cc                	jne    c0100b30 <parse+0xf>
        }
        if (*buf == '\0') {
c0100b64:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b67:	0f b6 00             	movzbl (%eax),%eax
c0100b6a:	84 c0                	test   %al,%al
c0100b6c:	74 65                	je     c0100bd3 <parse+0xb2>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
c0100b6e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
c0100b72:	75 12                	jne    c0100b86 <parse+0x65>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
c0100b74:	83 ec 08             	sub    $0x8,%esp
c0100b77:	6a 10                	push   $0x10
c0100b79:	68 01 5d 10 c0       	push   $0xc0105d01
c0100b7e:	e8 f0 f6 ff ff       	call   c0100273 <cprintf>
c0100b83:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
c0100b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b89:	8d 50 01             	lea    0x1(%eax),%edx
c0100b8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0100b8f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100b96:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100b99:	01 c2                	add    %eax,%edx
c0100b9b:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b9e:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100ba0:	eb 04                	jmp    c0100ba6 <parse+0x85>
            buf ++;
c0100ba2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100ba6:	8b 45 08             	mov    0x8(%ebp),%eax
c0100ba9:	0f b6 00             	movzbl (%eax),%eax
c0100bac:	84 c0                	test   %al,%al
c0100bae:	74 8c                	je     c0100b3c <parse+0x1b>
c0100bb0:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bb3:	0f b6 00             	movzbl (%eax),%eax
c0100bb6:	0f be c0             	movsbl %al,%eax
c0100bb9:	83 ec 08             	sub    $0x8,%esp
c0100bbc:	50                   	push   %eax
c0100bbd:	68 fc 5c 10 c0       	push   $0xc0105cfc
c0100bc2:	e8 57 45 00 00       	call   c010511e <strchr>
c0100bc7:	83 c4 10             	add    $0x10,%esp
c0100bca:	85 c0                	test   %eax,%eax
c0100bcc:	74 d4                	je     c0100ba2 <parse+0x81>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100bce:	e9 69 ff ff ff       	jmp    c0100b3c <parse+0x1b>
            break;
c0100bd3:	90                   	nop
        }
    }
    return argc;
c0100bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100bd7:	c9                   	leave  
c0100bd8:	c3                   	ret    

c0100bd9 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
c0100bd9:	55                   	push   %ebp
c0100bda:	89 e5                	mov    %esp,%ebp
c0100bdc:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
c0100bdf:	83 ec 08             	sub    $0x8,%esp
c0100be2:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100be5:	50                   	push   %eax
c0100be6:	ff 75 08             	pushl  0x8(%ebp)
c0100be9:	e8 33 ff ff ff       	call   c0100b21 <parse>
c0100bee:	83 c4 10             	add    $0x10,%esp
c0100bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
c0100bf4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100bf8:	75 0a                	jne    c0100c04 <runcmd+0x2b>
        return 0;
c0100bfa:	b8 00 00 00 00       	mov    $0x0,%eax
c0100bff:	e9 83 00 00 00       	jmp    c0100c87 <runcmd+0xae>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100c0b:	eb 59                	jmp    c0100c66 <runcmd+0x8d>
        if (strcmp(commands[i].name, argv[0]) == 0) {
c0100c0d:	8b 4d b0             	mov    -0x50(%ebp),%ecx
c0100c10:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c13:	89 d0                	mov    %edx,%eax
c0100c15:	01 c0                	add    %eax,%eax
c0100c17:	01 d0                	add    %edx,%eax
c0100c19:	c1 e0 02             	shl    $0x2,%eax
c0100c1c:	05 00 70 11 c0       	add    $0xc0117000,%eax
c0100c21:	8b 00                	mov    (%eax),%eax
c0100c23:	83 ec 08             	sub    $0x8,%esp
c0100c26:	51                   	push   %ecx
c0100c27:	50                   	push   %eax
c0100c28:	e8 51 44 00 00       	call   c010507e <strcmp>
c0100c2d:	83 c4 10             	add    $0x10,%esp
c0100c30:	85 c0                	test   %eax,%eax
c0100c32:	75 2e                	jne    c0100c62 <runcmd+0x89>
            return commands[i].func(argc - 1, argv + 1, tf);
c0100c34:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c37:	89 d0                	mov    %edx,%eax
c0100c39:	01 c0                	add    %eax,%eax
c0100c3b:	01 d0                	add    %edx,%eax
c0100c3d:	c1 e0 02             	shl    $0x2,%eax
c0100c40:	05 08 70 11 c0       	add    $0xc0117008,%eax
c0100c45:	8b 10                	mov    (%eax),%edx
c0100c47:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100c4a:	83 c0 04             	add    $0x4,%eax
c0100c4d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0100c50:	83 e9 01             	sub    $0x1,%ecx
c0100c53:	83 ec 04             	sub    $0x4,%esp
c0100c56:	ff 75 0c             	pushl  0xc(%ebp)
c0100c59:	50                   	push   %eax
c0100c5a:	51                   	push   %ecx
c0100c5b:	ff d2                	call   *%edx
c0100c5d:	83 c4 10             	add    $0x10,%esp
c0100c60:	eb 25                	jmp    c0100c87 <runcmd+0xae>
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100c66:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100c69:	83 f8 02             	cmp    $0x2,%eax
c0100c6c:	76 9f                	jbe    c0100c0d <runcmd+0x34>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
c0100c6e:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0100c71:	83 ec 08             	sub    $0x8,%esp
c0100c74:	50                   	push   %eax
c0100c75:	68 1f 5d 10 c0       	push   $0xc0105d1f
c0100c7a:	e8 f4 f5 ff ff       	call   c0100273 <cprintf>
c0100c7f:	83 c4 10             	add    $0x10,%esp
    return 0;
c0100c82:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100c87:	c9                   	leave  
c0100c88:	c3                   	ret    

c0100c89 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
c0100c89:	55                   	push   %ebp
c0100c8a:	89 e5                	mov    %esp,%ebp
c0100c8c:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
c0100c8f:	83 ec 0c             	sub    $0xc,%esp
c0100c92:	68 38 5d 10 c0       	push   $0xc0105d38
c0100c97:	e8 d7 f5 ff ff       	call   c0100273 <cprintf>
c0100c9c:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
c0100c9f:	83 ec 0c             	sub    $0xc,%esp
c0100ca2:	68 60 5d 10 c0       	push   $0xc0105d60
c0100ca7:	e8 c7 f5 ff ff       	call   c0100273 <cprintf>
c0100cac:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
c0100caf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100cb3:	74 0e                	je     c0100cc3 <kmonitor+0x3a>
        print_trapframe(tf);
c0100cb5:	83 ec 0c             	sub    $0xc,%esp
c0100cb8:	ff 75 08             	pushl  0x8(%ebp)
c0100cbb:	e8 24 0d 00 00       	call   c01019e4 <print_trapframe>
c0100cc0:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
c0100cc3:	83 ec 0c             	sub    $0xc,%esp
c0100cc6:	68 85 5d 10 c0       	push   $0xc0105d85
c0100ccb:	e8 47 f6 ff ff       	call   c0100317 <readline>
c0100cd0:	83 c4 10             	add    $0x10,%esp
c0100cd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100cd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100cda:	74 e7                	je     c0100cc3 <kmonitor+0x3a>
            if (runcmd(buf, tf) < 0) {
c0100cdc:	83 ec 08             	sub    $0x8,%esp
c0100cdf:	ff 75 08             	pushl  0x8(%ebp)
c0100ce2:	ff 75 f4             	pushl  -0xc(%ebp)
c0100ce5:	e8 ef fe ff ff       	call   c0100bd9 <runcmd>
c0100cea:	83 c4 10             	add    $0x10,%esp
c0100ced:	85 c0                	test   %eax,%eax
c0100cef:	78 02                	js     c0100cf3 <kmonitor+0x6a>
        if ((buf = readline("K> ")) != NULL) {
c0100cf1:	eb d0                	jmp    c0100cc3 <kmonitor+0x3a>
                break;
c0100cf3:	90                   	nop
            }
        }
    }
}
c0100cf4:	90                   	nop
c0100cf5:	c9                   	leave  
c0100cf6:	c3                   	ret    

c0100cf7 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
c0100cf7:	55                   	push   %ebp
c0100cf8:	89 e5                	mov    %esp,%ebp
c0100cfa:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100cfd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100d04:	eb 3c                	jmp    c0100d42 <mon_help+0x4b>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
c0100d06:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d09:	89 d0                	mov    %edx,%eax
c0100d0b:	01 c0                	add    %eax,%eax
c0100d0d:	01 d0                	add    %edx,%eax
c0100d0f:	c1 e0 02             	shl    $0x2,%eax
c0100d12:	05 04 70 11 c0       	add    $0xc0117004,%eax
c0100d17:	8b 08                	mov    (%eax),%ecx
c0100d19:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d1c:	89 d0                	mov    %edx,%eax
c0100d1e:	01 c0                	add    %eax,%eax
c0100d20:	01 d0                	add    %edx,%eax
c0100d22:	c1 e0 02             	shl    $0x2,%eax
c0100d25:	05 00 70 11 c0       	add    $0xc0117000,%eax
c0100d2a:	8b 00                	mov    (%eax),%eax
c0100d2c:	83 ec 04             	sub    $0x4,%esp
c0100d2f:	51                   	push   %ecx
c0100d30:	50                   	push   %eax
c0100d31:	68 89 5d 10 c0       	push   $0xc0105d89
c0100d36:	e8 38 f5 ff ff       	call   c0100273 <cprintf>
c0100d3b:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
c0100d3e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100d42:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100d45:	83 f8 02             	cmp    $0x2,%eax
c0100d48:	76 bc                	jbe    c0100d06 <mon_help+0xf>
    }
    return 0;
c0100d4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d4f:	c9                   	leave  
c0100d50:	c3                   	ret    

c0100d51 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
c0100d51:	55                   	push   %ebp
c0100d52:	89 e5                	mov    %esp,%ebp
c0100d54:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
c0100d57:	e8 b6 fb ff ff       	call   c0100912 <print_kerninfo>
    return 0;
c0100d5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d61:	c9                   	leave  
c0100d62:	c3                   	ret    

c0100d63 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
c0100d63:	55                   	push   %ebp
c0100d64:	89 e5                	mov    %esp,%ebp
c0100d66:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
c0100d69:	e8 ee fc ff ff       	call   c0100a5c <print_stackframe>
    return 0;
c0100d6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d73:	c9                   	leave  
c0100d74:	c3                   	ret    

c0100d75 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
c0100d75:	55                   	push   %ebp
c0100d76:	89 e5                	mov    %esp,%ebp
c0100d78:	83 ec 18             	sub    $0x18,%esp
c0100d7b:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
c0100d81:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100d85:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100d89:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100d8d:	ee                   	out    %al,(%dx)
c0100d8e:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
c0100d94:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
c0100d98:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100d9c:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100da0:	ee                   	out    %al,(%dx)
c0100da1:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
c0100da7:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
c0100dab:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100daf:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100db3:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
c0100db4:	c7 05 0c af 11 c0 00 	movl   $0x0,0xc011af0c
c0100dbb:	00 00 00 

    cprintf("++ setup timer interrupts\n");
c0100dbe:	83 ec 0c             	sub    $0xc,%esp
c0100dc1:	68 92 5d 10 c0       	push   $0xc0105d92
c0100dc6:	e8 a8 f4 ff ff       	call   c0100273 <cprintf>
c0100dcb:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
c0100dce:	83 ec 0c             	sub    $0xc,%esp
c0100dd1:	6a 00                	push   $0x0
c0100dd3:	e8 3f 09 00 00       	call   c0101717 <pic_enable>
c0100dd8:	83 c4 10             	add    $0x10,%esp
}
c0100ddb:	90                   	nop
c0100ddc:	c9                   	leave  
c0100ddd:	c3                   	ret    

c0100dde <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0100dde:	55                   	push   %ebp
c0100ddf:	89 e5                	mov    %esp,%ebp
c0100de1:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0100de4:	9c                   	pushf  
c0100de5:	58                   	pop    %eax
c0100de6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0100de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0100dec:	25 00 02 00 00       	and    $0x200,%eax
c0100df1:	85 c0                	test   %eax,%eax
c0100df3:	74 0c                	je     c0100e01 <__intr_save+0x23>
        intr_disable();
c0100df5:	e8 8e 0a 00 00       	call   c0101888 <intr_disable>
        return 1;
c0100dfa:	b8 01 00 00 00       	mov    $0x1,%eax
c0100dff:	eb 05                	jmp    c0100e06 <__intr_save+0x28>
    }
    return 0;
c0100e01:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100e06:	c9                   	leave  
c0100e07:	c3                   	ret    

c0100e08 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0100e08:	55                   	push   %ebp
c0100e09:	89 e5                	mov    %esp,%ebp
c0100e0b:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0100e0e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100e12:	74 05                	je     c0100e19 <__intr_restore+0x11>
        intr_enable();
c0100e14:	e8 68 0a 00 00       	call   c0101881 <intr_enable>
    }
}
c0100e19:	90                   	nop
c0100e1a:	c9                   	leave  
c0100e1b:	c3                   	ret    

c0100e1c <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
c0100e1c:	55                   	push   %ebp
c0100e1d:	89 e5                	mov    %esp,%ebp
c0100e1f:	83 ec 10             	sub    $0x10,%esp
c0100e22:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100e28:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100e2c:	89 c2                	mov    %eax,%edx
c0100e2e:	ec                   	in     (%dx),%al
c0100e2f:	88 45 f1             	mov    %al,-0xf(%ebp)
c0100e32:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
c0100e38:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100e3c:	89 c2                	mov    %eax,%edx
c0100e3e:	ec                   	in     (%dx),%al
c0100e3f:	88 45 f5             	mov    %al,-0xb(%ebp)
c0100e42:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
c0100e48:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0100e4c:	89 c2                	mov    %eax,%edx
c0100e4e:	ec                   	in     (%dx),%al
c0100e4f:	88 45 f9             	mov    %al,-0x7(%ebp)
c0100e52:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
c0100e58:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0100e5c:	89 c2                	mov    %eax,%edx
c0100e5e:	ec                   	in     (%dx),%al
c0100e5f:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
c0100e62:	90                   	nop
c0100e63:	c9                   	leave  
c0100e64:	c3                   	ret    

c0100e65 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
c0100e65:	55                   	push   %ebp
c0100e66:	89 e5                	mov    %esp,%ebp
c0100e68:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
c0100e6b:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
c0100e72:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e75:	0f b7 00             	movzwl (%eax),%eax
c0100e78:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
c0100e7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e7f:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
c0100e84:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e87:	0f b7 00             	movzwl (%eax),%eax
c0100e8a:	66 3d 5a a5          	cmp    $0xa55a,%ax
c0100e8e:	74 12                	je     c0100ea2 <cga_init+0x3d>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
c0100e90:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
c0100e97:	66 c7 05 46 a4 11 c0 	movw   $0x3b4,0xc011a446
c0100e9e:	b4 03 
c0100ea0:	eb 13                	jmp    c0100eb5 <cga_init+0x50>
    } else {
        *cp = was;
c0100ea2:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ea5:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0100ea9:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
c0100eac:	66 c7 05 46 a4 11 c0 	movw   $0x3d4,0xc011a446
c0100eb3:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
c0100eb5:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c0100ebc:	0f b7 c0             	movzwl %ax,%eax
c0100ebf:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c0100ec3:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100ec7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100ecb:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100ecf:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
c0100ed0:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c0100ed7:	83 c0 01             	add    $0x1,%eax
c0100eda:	0f b7 c0             	movzwl %ax,%eax
c0100edd:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100ee1:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
c0100ee5:	89 c2                	mov    %eax,%edx
c0100ee7:	ec                   	in     (%dx),%al
c0100ee8:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
c0100eeb:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100eef:	0f b6 c0             	movzbl %al,%eax
c0100ef2:	c1 e0 08             	shl    $0x8,%eax
c0100ef5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
c0100ef8:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c0100eff:	0f b7 c0             	movzwl %ax,%eax
c0100f02:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0100f06:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f0a:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100f0e:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100f12:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
c0100f13:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c0100f1a:	83 c0 01             	add    $0x1,%eax
c0100f1d:	0f b7 c0             	movzwl %ax,%eax
c0100f20:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f24:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100f28:	89 c2                	mov    %eax,%edx
c0100f2a:	ec                   	in     (%dx),%al
c0100f2b:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
c0100f2e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100f32:	0f b6 c0             	movzbl %al,%eax
c0100f35:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
c0100f38:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f3b:	a3 40 a4 11 c0       	mov    %eax,0xc011a440
    crt_pos = pos;
c0100f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100f43:	66 a3 44 a4 11 c0    	mov    %ax,0xc011a444
}
c0100f49:	90                   	nop
c0100f4a:	c9                   	leave  
c0100f4b:	c3                   	ret    

c0100f4c <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
c0100f4c:	55                   	push   %ebp
c0100f4d:	89 e5                	mov    %esp,%ebp
c0100f4f:	83 ec 38             	sub    $0x38,%esp
c0100f52:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
c0100f58:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f5c:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0100f60:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0100f64:	ee                   	out    %al,(%dx)
c0100f65:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
c0100f6b:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
c0100f6f:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c0100f73:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0100f77:	ee                   	out    %al,(%dx)
c0100f78:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
c0100f7e:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
c0100f82:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c0100f86:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c0100f8a:	ee                   	out    %al,(%dx)
c0100f8b:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
c0100f91:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
c0100f95:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0100f99:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c0100f9d:	ee                   	out    %al,(%dx)
c0100f9e:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
c0100fa4:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
c0100fa8:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0100fac:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c0100fb0:	ee                   	out    %al,(%dx)
c0100fb1:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
c0100fb7:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
c0100fbb:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100fbf:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100fc3:	ee                   	out    %al,(%dx)
c0100fc4:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
c0100fca:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
c0100fce:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100fd2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0100fd6:	ee                   	out    %al,(%dx)
c0100fd7:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100fdd:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
c0100fe1:	89 c2                	mov    %eax,%edx
c0100fe3:	ec                   	in     (%dx),%al
c0100fe4:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
c0100fe7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
c0100feb:	3c ff                	cmp    $0xff,%al
c0100fed:	0f 95 c0             	setne  %al
c0100ff0:	0f b6 c0             	movzbl %al,%eax
c0100ff3:	a3 48 a4 11 c0       	mov    %eax,0xc011a448
c0100ff8:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100ffe:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0101002:	89 c2                	mov    %eax,%edx
c0101004:	ec                   	in     (%dx),%al
c0101005:	88 45 f1             	mov    %al,-0xf(%ebp)
c0101008:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c010100e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0101012:	89 c2                	mov    %eax,%edx
c0101014:	ec                   	in     (%dx),%al
c0101015:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
c0101018:	a1 48 a4 11 c0       	mov    0xc011a448,%eax
c010101d:	85 c0                	test   %eax,%eax
c010101f:	74 0d                	je     c010102e <serial_init+0xe2>
        pic_enable(IRQ_COM1);
c0101021:	83 ec 0c             	sub    $0xc,%esp
c0101024:	6a 04                	push   $0x4
c0101026:	e8 ec 06 00 00       	call   c0101717 <pic_enable>
c010102b:	83 c4 10             	add    $0x10,%esp
    }
}
c010102e:	90                   	nop
c010102f:	c9                   	leave  
c0101030:	c3                   	ret    

c0101031 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
c0101031:	55                   	push   %ebp
c0101032:	89 e5                	mov    %esp,%ebp
c0101034:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101037:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010103e:	eb 09                	jmp    c0101049 <lpt_putc_sub+0x18>
        delay();
c0101040:	e8 d7 fd ff ff       	call   c0100e1c <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101045:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0101049:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
c010104f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0101053:	89 c2                	mov    %eax,%edx
c0101055:	ec                   	in     (%dx),%al
c0101056:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101059:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c010105d:	84 c0                	test   %al,%al
c010105f:	78 09                	js     c010106a <lpt_putc_sub+0x39>
c0101061:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c0101068:	7e d6                	jle    c0101040 <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
c010106a:	8b 45 08             	mov    0x8(%ebp),%eax
c010106d:	0f b6 c0             	movzbl %al,%eax
c0101070:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
c0101076:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101079:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c010107d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101081:	ee                   	out    %al,(%dx)
c0101082:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
c0101088:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
c010108c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101090:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101094:	ee                   	out    %al,(%dx)
c0101095:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
c010109b:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
c010109f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c01010a3:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c01010a7:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
c01010a8:	90                   	nop
c01010a9:	c9                   	leave  
c01010aa:	c3                   	ret    

c01010ab <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
c01010ab:	55                   	push   %ebp
c01010ac:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c01010ae:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c01010b2:	74 0d                	je     c01010c1 <lpt_putc+0x16>
        lpt_putc_sub(c);
c01010b4:	ff 75 08             	pushl  0x8(%ebp)
c01010b7:	e8 75 ff ff ff       	call   c0101031 <lpt_putc_sub>
c01010bc:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
c01010bf:	eb 1e                	jmp    c01010df <lpt_putc+0x34>
        lpt_putc_sub('\b');
c01010c1:	6a 08                	push   $0x8
c01010c3:	e8 69 ff ff ff       	call   c0101031 <lpt_putc_sub>
c01010c8:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
c01010cb:	6a 20                	push   $0x20
c01010cd:	e8 5f ff ff ff       	call   c0101031 <lpt_putc_sub>
c01010d2:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
c01010d5:	6a 08                	push   $0x8
c01010d7:	e8 55 ff ff ff       	call   c0101031 <lpt_putc_sub>
c01010dc:	83 c4 04             	add    $0x4,%esp
}
c01010df:	90                   	nop
c01010e0:	c9                   	leave  
c01010e1:	c3                   	ret    

c01010e2 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
c01010e2:	55                   	push   %ebp
c01010e3:	89 e5                	mov    %esp,%ebp
c01010e5:	53                   	push   %ebx
c01010e6:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
c01010e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01010ec:	b0 00                	mov    $0x0,%al
c01010ee:	85 c0                	test   %eax,%eax
c01010f0:	75 07                	jne    c01010f9 <cga_putc+0x17>
        c |= 0x0700;
c01010f2:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
c01010f9:	8b 45 08             	mov    0x8(%ebp),%eax
c01010fc:	0f b6 c0             	movzbl %al,%eax
c01010ff:	83 f8 0a             	cmp    $0xa,%eax
c0101102:	74 52                	je     c0101156 <cga_putc+0x74>
c0101104:	83 f8 0d             	cmp    $0xd,%eax
c0101107:	74 5d                	je     c0101166 <cga_putc+0x84>
c0101109:	83 f8 08             	cmp    $0x8,%eax
c010110c:	0f 85 8e 00 00 00    	jne    c01011a0 <cga_putc+0xbe>
    case '\b':
        if (crt_pos > 0) {
c0101112:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c0101119:	66 85 c0             	test   %ax,%ax
c010111c:	0f 84 a4 00 00 00    	je     c01011c6 <cga_putc+0xe4>
            crt_pos --;
c0101122:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c0101129:	83 e8 01             	sub    $0x1,%eax
c010112c:	66 a3 44 a4 11 c0    	mov    %ax,0xc011a444
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
c0101132:	8b 45 08             	mov    0x8(%ebp),%eax
c0101135:	b0 00                	mov    $0x0,%al
c0101137:	83 c8 20             	or     $0x20,%eax
c010113a:	89 c1                	mov    %eax,%ecx
c010113c:	a1 40 a4 11 c0       	mov    0xc011a440,%eax
c0101141:	0f b7 15 44 a4 11 c0 	movzwl 0xc011a444,%edx
c0101148:	0f b7 d2             	movzwl %dx,%edx
c010114b:	01 d2                	add    %edx,%edx
c010114d:	01 d0                	add    %edx,%eax
c010114f:	89 ca                	mov    %ecx,%edx
c0101151:	66 89 10             	mov    %dx,(%eax)
        }
        break;
c0101154:	eb 70                	jmp    c01011c6 <cga_putc+0xe4>
    case '\n':
        crt_pos += CRT_COLS;
c0101156:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c010115d:	83 c0 50             	add    $0x50,%eax
c0101160:	66 a3 44 a4 11 c0    	mov    %ax,0xc011a444
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
c0101166:	0f b7 1d 44 a4 11 c0 	movzwl 0xc011a444,%ebx
c010116d:	0f b7 0d 44 a4 11 c0 	movzwl 0xc011a444,%ecx
c0101174:	0f b7 c1             	movzwl %cx,%eax
c0101177:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
c010117d:	c1 e8 10             	shr    $0x10,%eax
c0101180:	89 c2                	mov    %eax,%edx
c0101182:	66 c1 ea 06          	shr    $0x6,%dx
c0101186:	89 d0                	mov    %edx,%eax
c0101188:	c1 e0 02             	shl    $0x2,%eax
c010118b:	01 d0                	add    %edx,%eax
c010118d:	c1 e0 04             	shl    $0x4,%eax
c0101190:	29 c1                	sub    %eax,%ecx
c0101192:	89 ca                	mov    %ecx,%edx
c0101194:	89 d8                	mov    %ebx,%eax
c0101196:	29 d0                	sub    %edx,%eax
c0101198:	66 a3 44 a4 11 c0    	mov    %ax,0xc011a444
        break;
c010119e:	eb 27                	jmp    c01011c7 <cga_putc+0xe5>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
c01011a0:	8b 0d 40 a4 11 c0    	mov    0xc011a440,%ecx
c01011a6:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c01011ad:	8d 50 01             	lea    0x1(%eax),%edx
c01011b0:	66 89 15 44 a4 11 c0 	mov    %dx,0xc011a444
c01011b7:	0f b7 c0             	movzwl %ax,%eax
c01011ba:	01 c0                	add    %eax,%eax
c01011bc:	01 c8                	add    %ecx,%eax
c01011be:	8b 55 08             	mov    0x8(%ebp),%edx
c01011c1:	66 89 10             	mov    %dx,(%eax)
        break;
c01011c4:	eb 01                	jmp    c01011c7 <cga_putc+0xe5>
        break;
c01011c6:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
c01011c7:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c01011ce:	66 3d cf 07          	cmp    $0x7cf,%ax
c01011d2:	76 59                	jbe    c010122d <cga_putc+0x14b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
c01011d4:	a1 40 a4 11 c0       	mov    0xc011a440,%eax
c01011d9:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
c01011df:	a1 40 a4 11 c0       	mov    0xc011a440,%eax
c01011e4:	83 ec 04             	sub    $0x4,%esp
c01011e7:	68 00 0f 00 00       	push   $0xf00
c01011ec:	52                   	push   %edx
c01011ed:	50                   	push   %eax
c01011ee:	e8 2a 41 00 00       	call   c010531d <memmove>
c01011f3:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c01011f6:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
c01011fd:	eb 15                	jmp    c0101214 <cga_putc+0x132>
            crt_buf[i] = 0x0700 | ' ';
c01011ff:	a1 40 a4 11 c0       	mov    0xc011a440,%eax
c0101204:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0101207:	01 d2                	add    %edx,%edx
c0101209:	01 d0                	add    %edx,%eax
c010120b:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c0101210:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101214:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
c010121b:	7e e2                	jle    c01011ff <cga_putc+0x11d>
        }
        crt_pos -= CRT_COLS;
c010121d:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c0101224:	83 e8 50             	sub    $0x50,%eax
c0101227:	66 a3 44 a4 11 c0    	mov    %ax,0xc011a444
    }

    // move that little blinky thing
    outb(addr_6845, 14);
c010122d:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c0101234:	0f b7 c0             	movzwl %ax,%eax
c0101237:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c010123b:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
c010123f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0101243:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101247:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
c0101248:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c010124f:	66 c1 e8 08          	shr    $0x8,%ax
c0101253:	0f b6 c0             	movzbl %al,%eax
c0101256:	0f b7 15 46 a4 11 c0 	movzwl 0xc011a446,%edx
c010125d:	83 c2 01             	add    $0x1,%edx
c0101260:	0f b7 d2             	movzwl %dx,%edx
c0101263:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
c0101267:	88 45 e9             	mov    %al,-0x17(%ebp)
c010126a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c010126e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0101272:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
c0101273:	0f b7 05 46 a4 11 c0 	movzwl 0xc011a446,%eax
c010127a:	0f b7 c0             	movzwl %ax,%eax
c010127d:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0101281:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
c0101285:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101289:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c010128d:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
c010128e:	0f b7 05 44 a4 11 c0 	movzwl 0xc011a444,%eax
c0101295:	0f b6 c0             	movzbl %al,%eax
c0101298:	0f b7 15 46 a4 11 c0 	movzwl 0xc011a446,%edx
c010129f:	83 c2 01             	add    $0x1,%edx
c01012a2:	0f b7 d2             	movzwl %dx,%edx
c01012a5:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
c01012a9:	88 45 f1             	mov    %al,-0xf(%ebp)
c01012ac:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c01012b0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c01012b4:	ee                   	out    %al,(%dx)
}
c01012b5:	90                   	nop
c01012b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c01012b9:	c9                   	leave  
c01012ba:	c3                   	ret    

c01012bb <serial_putc_sub>:

static void
serial_putc_sub(int c) {
c01012bb:	55                   	push   %ebp
c01012bc:	89 e5                	mov    %esp,%ebp
c01012be:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c01012c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01012c8:	eb 09                	jmp    c01012d3 <serial_putc_sub+0x18>
        delay();
c01012ca:	e8 4d fb ff ff       	call   c0100e1c <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c01012cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01012d3:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01012d9:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01012dd:	89 c2                	mov    %eax,%edx
c01012df:	ec                   	in     (%dx),%al
c01012e0:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01012e3:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01012e7:	0f b6 c0             	movzbl %al,%eax
c01012ea:	83 e0 20             	and    $0x20,%eax
c01012ed:	85 c0                	test   %eax,%eax
c01012ef:	75 09                	jne    c01012fa <serial_putc_sub+0x3f>
c01012f1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c01012f8:	7e d0                	jle    c01012ca <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
c01012fa:	8b 45 08             	mov    0x8(%ebp),%eax
c01012fd:	0f b6 c0             	movzbl %al,%eax
c0101300:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c0101306:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101309:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c010130d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101311:	ee                   	out    %al,(%dx)
}
c0101312:	90                   	nop
c0101313:	c9                   	leave  
c0101314:	c3                   	ret    

c0101315 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
c0101315:	55                   	push   %ebp
c0101316:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c0101318:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c010131c:	74 0d                	je     c010132b <serial_putc+0x16>
        serial_putc_sub(c);
c010131e:	ff 75 08             	pushl  0x8(%ebp)
c0101321:	e8 95 ff ff ff       	call   c01012bb <serial_putc_sub>
c0101326:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
c0101329:	eb 1e                	jmp    c0101349 <serial_putc+0x34>
        serial_putc_sub('\b');
c010132b:	6a 08                	push   $0x8
c010132d:	e8 89 ff ff ff       	call   c01012bb <serial_putc_sub>
c0101332:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
c0101335:	6a 20                	push   $0x20
c0101337:	e8 7f ff ff ff       	call   c01012bb <serial_putc_sub>
c010133c:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
c010133f:	6a 08                	push   $0x8
c0101341:	e8 75 ff ff ff       	call   c01012bb <serial_putc_sub>
c0101346:	83 c4 04             	add    $0x4,%esp
}
c0101349:	90                   	nop
c010134a:	c9                   	leave  
c010134b:	c3                   	ret    

c010134c <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
c010134c:	55                   	push   %ebp
c010134d:	89 e5                	mov    %esp,%ebp
c010134f:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
c0101352:	eb 33                	jmp    c0101387 <cons_intr+0x3b>
        if (c != 0) {
c0101354:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0101358:	74 2d                	je     c0101387 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
c010135a:	a1 64 a6 11 c0       	mov    0xc011a664,%eax
c010135f:	8d 50 01             	lea    0x1(%eax),%edx
c0101362:	89 15 64 a6 11 c0    	mov    %edx,0xc011a664
c0101368:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010136b:	88 90 60 a4 11 c0    	mov    %dl,-0x3fee5ba0(%eax)
            if (cons.wpos == CONSBUFSIZE) {
c0101371:	a1 64 a6 11 c0       	mov    0xc011a664,%eax
c0101376:	3d 00 02 00 00       	cmp    $0x200,%eax
c010137b:	75 0a                	jne    c0101387 <cons_intr+0x3b>
                cons.wpos = 0;
c010137d:	c7 05 64 a6 11 c0 00 	movl   $0x0,0xc011a664
c0101384:	00 00 00 
    while ((c = (*proc)()) != -1) {
c0101387:	8b 45 08             	mov    0x8(%ebp),%eax
c010138a:	ff d0                	call   *%eax
c010138c:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010138f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c0101393:	75 bf                	jne    c0101354 <cons_intr+0x8>
            }
        }
    }
}
c0101395:	90                   	nop
c0101396:	c9                   	leave  
c0101397:	c3                   	ret    

c0101398 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
c0101398:	55                   	push   %ebp
c0101399:	89 e5                	mov    %esp,%ebp
c010139b:	83 ec 10             	sub    $0x10,%esp
c010139e:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01013a4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01013a8:	89 c2                	mov    %eax,%edx
c01013aa:	ec                   	in     (%dx),%al
c01013ab:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01013ae:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
c01013b2:	0f b6 c0             	movzbl %al,%eax
c01013b5:	83 e0 01             	and    $0x1,%eax
c01013b8:	85 c0                	test   %eax,%eax
c01013ba:	75 07                	jne    c01013c3 <serial_proc_data+0x2b>
        return -1;
c01013bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01013c1:	eb 2a                	jmp    c01013ed <serial_proc_data+0x55>
c01013c3:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01013c9:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c01013cd:	89 c2                	mov    %eax,%edx
c01013cf:	ec                   	in     (%dx),%al
c01013d0:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
c01013d3:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
c01013d7:	0f b6 c0             	movzbl %al,%eax
c01013da:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
c01013dd:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
c01013e1:	75 07                	jne    c01013ea <serial_proc_data+0x52>
        c = '\b';
c01013e3:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
c01013ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01013ed:	c9                   	leave  
c01013ee:	c3                   	ret    

c01013ef <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
c01013ef:	55                   	push   %ebp
c01013f0:	89 e5                	mov    %esp,%ebp
c01013f2:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
c01013f5:	a1 48 a4 11 c0       	mov    0xc011a448,%eax
c01013fa:	85 c0                	test   %eax,%eax
c01013fc:	74 10                	je     c010140e <serial_intr+0x1f>
        cons_intr(serial_proc_data);
c01013fe:	83 ec 0c             	sub    $0xc,%esp
c0101401:	68 98 13 10 c0       	push   $0xc0101398
c0101406:	e8 41 ff ff ff       	call   c010134c <cons_intr>
c010140b:	83 c4 10             	add    $0x10,%esp
    }
}
c010140e:	90                   	nop
c010140f:	c9                   	leave  
c0101410:	c3                   	ret    

c0101411 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
c0101411:	55                   	push   %ebp
c0101412:	89 e5                	mov    %esp,%ebp
c0101414:	83 ec 28             	sub    $0x28,%esp
c0101417:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010141d:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c0101421:	89 c2                	mov    %eax,%edx
c0101423:	ec                   	in     (%dx),%al
c0101424:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
c0101427:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
c010142b:	0f b6 c0             	movzbl %al,%eax
c010142e:	83 e0 01             	and    $0x1,%eax
c0101431:	85 c0                	test   %eax,%eax
c0101433:	75 0a                	jne    c010143f <kbd_proc_data+0x2e>
        return -1;
c0101435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010143a:	e9 5d 01 00 00       	jmp    c010159c <kbd_proc_data+0x18b>
c010143f:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101445:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0101449:	89 c2                	mov    %eax,%edx
c010144b:	ec                   	in     (%dx),%al
c010144c:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
c010144f:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
c0101453:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
c0101456:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
c010145a:	75 17                	jne    c0101473 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
c010145c:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c0101461:	83 c8 40             	or     $0x40,%eax
c0101464:	a3 68 a6 11 c0       	mov    %eax,0xc011a668
        return 0;
c0101469:	b8 00 00 00 00       	mov    $0x0,%eax
c010146e:	e9 29 01 00 00       	jmp    c010159c <kbd_proc_data+0x18b>
    } else if (data & 0x80) {
c0101473:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101477:	84 c0                	test   %al,%al
c0101479:	79 47                	jns    c01014c2 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
c010147b:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c0101480:	83 e0 40             	and    $0x40,%eax
c0101483:	85 c0                	test   %eax,%eax
c0101485:	75 09                	jne    c0101490 <kbd_proc_data+0x7f>
c0101487:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c010148b:	83 e0 7f             	and    $0x7f,%eax
c010148e:	eb 04                	jmp    c0101494 <kbd_proc_data+0x83>
c0101490:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101494:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
c0101497:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c010149b:	0f b6 80 40 70 11 c0 	movzbl -0x3fee8fc0(%eax),%eax
c01014a2:	83 c8 40             	or     $0x40,%eax
c01014a5:	0f b6 c0             	movzbl %al,%eax
c01014a8:	f7 d0                	not    %eax
c01014aa:	89 c2                	mov    %eax,%edx
c01014ac:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c01014b1:	21 d0                	and    %edx,%eax
c01014b3:	a3 68 a6 11 c0       	mov    %eax,0xc011a668
        return 0;
c01014b8:	b8 00 00 00 00       	mov    $0x0,%eax
c01014bd:	e9 da 00 00 00       	jmp    c010159c <kbd_proc_data+0x18b>
    } else if (shift & E0ESC) {
c01014c2:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c01014c7:	83 e0 40             	and    $0x40,%eax
c01014ca:	85 c0                	test   %eax,%eax
c01014cc:	74 11                	je     c01014df <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
c01014ce:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
c01014d2:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c01014d7:	83 e0 bf             	and    $0xffffffbf,%eax
c01014da:	a3 68 a6 11 c0       	mov    %eax,0xc011a668
    }

    shift |= shiftcode[data];
c01014df:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014e3:	0f b6 80 40 70 11 c0 	movzbl -0x3fee8fc0(%eax),%eax
c01014ea:	0f b6 d0             	movzbl %al,%edx
c01014ed:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c01014f2:	09 d0                	or     %edx,%eax
c01014f4:	a3 68 a6 11 c0       	mov    %eax,0xc011a668
    shift ^= togglecode[data];
c01014f9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014fd:	0f b6 80 40 71 11 c0 	movzbl -0x3fee8ec0(%eax),%eax
c0101504:	0f b6 d0             	movzbl %al,%edx
c0101507:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c010150c:	31 d0                	xor    %edx,%eax
c010150e:	a3 68 a6 11 c0       	mov    %eax,0xc011a668

    c = charcode[shift & (CTL | SHIFT)][data];
c0101513:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c0101518:	83 e0 03             	and    $0x3,%eax
c010151b:	8b 14 85 40 75 11 c0 	mov    -0x3fee8ac0(,%eax,4),%edx
c0101522:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101526:	01 d0                	add    %edx,%eax
c0101528:	0f b6 00             	movzbl (%eax),%eax
c010152b:	0f b6 c0             	movzbl %al,%eax
c010152e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
c0101531:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c0101536:	83 e0 08             	and    $0x8,%eax
c0101539:	85 c0                	test   %eax,%eax
c010153b:	74 22                	je     c010155f <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
c010153d:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
c0101541:	7e 0c                	jle    c010154f <kbd_proc_data+0x13e>
c0101543:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
c0101547:	7f 06                	jg     c010154f <kbd_proc_data+0x13e>
            c += 'A' - 'a';
c0101549:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
c010154d:	eb 10                	jmp    c010155f <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
c010154f:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
c0101553:	7e 0a                	jle    c010155f <kbd_proc_data+0x14e>
c0101555:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
c0101559:	7f 04                	jg     c010155f <kbd_proc_data+0x14e>
            c += 'a' - 'A';
c010155b:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
c010155f:	a1 68 a6 11 c0       	mov    0xc011a668,%eax
c0101564:	f7 d0                	not    %eax
c0101566:	83 e0 06             	and    $0x6,%eax
c0101569:	85 c0                	test   %eax,%eax
c010156b:	75 2c                	jne    c0101599 <kbd_proc_data+0x188>
c010156d:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
c0101574:	75 23                	jne    c0101599 <kbd_proc_data+0x188>
        cprintf("Rebooting!\n");
c0101576:	83 ec 0c             	sub    $0xc,%esp
c0101579:	68 ad 5d 10 c0       	push   $0xc0105dad
c010157e:	e8 f0 ec ff ff       	call   c0100273 <cprintf>
c0101583:	83 c4 10             	add    $0x10,%esp
c0101586:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
c010158c:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101590:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
c0101594:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
c0101598:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
c0101599:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010159c:	c9                   	leave  
c010159d:	c3                   	ret    

c010159e <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
c010159e:	55                   	push   %ebp
c010159f:	89 e5                	mov    %esp,%ebp
c01015a1:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
c01015a4:	83 ec 0c             	sub    $0xc,%esp
c01015a7:	68 11 14 10 c0       	push   $0xc0101411
c01015ac:	e8 9b fd ff ff       	call   c010134c <cons_intr>
c01015b1:	83 c4 10             	add    $0x10,%esp
}
c01015b4:	90                   	nop
c01015b5:	c9                   	leave  
c01015b6:	c3                   	ret    

c01015b7 <kbd_init>:

static void
kbd_init(void) {
c01015b7:	55                   	push   %ebp
c01015b8:	89 e5                	mov    %esp,%ebp
c01015ba:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
c01015bd:	e8 dc ff ff ff       	call   c010159e <kbd_intr>
    pic_enable(IRQ_KBD);
c01015c2:	83 ec 0c             	sub    $0xc,%esp
c01015c5:	6a 01                	push   $0x1
c01015c7:	e8 4b 01 00 00       	call   c0101717 <pic_enable>
c01015cc:	83 c4 10             	add    $0x10,%esp
}
c01015cf:	90                   	nop
c01015d0:	c9                   	leave  
c01015d1:	c3                   	ret    

c01015d2 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
c01015d2:	55                   	push   %ebp
c01015d3:	89 e5                	mov    %esp,%ebp
c01015d5:	83 ec 08             	sub    $0x8,%esp
    cga_init();
c01015d8:	e8 88 f8 ff ff       	call   c0100e65 <cga_init>
    serial_init();
c01015dd:	e8 6a f9 ff ff       	call   c0100f4c <serial_init>
    kbd_init();
c01015e2:	e8 d0 ff ff ff       	call   c01015b7 <kbd_init>
    if (!serial_exists) {
c01015e7:	a1 48 a4 11 c0       	mov    0xc011a448,%eax
c01015ec:	85 c0                	test   %eax,%eax
c01015ee:	75 10                	jne    c0101600 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
c01015f0:	83 ec 0c             	sub    $0xc,%esp
c01015f3:	68 b9 5d 10 c0       	push   $0xc0105db9
c01015f8:	e8 76 ec ff ff       	call   c0100273 <cprintf>
c01015fd:	83 c4 10             	add    $0x10,%esp
    }
}
c0101600:	90                   	nop
c0101601:	c9                   	leave  
c0101602:	c3                   	ret    

c0101603 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
c0101603:	55                   	push   %ebp
c0101604:	89 e5                	mov    %esp,%ebp
c0101606:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0101609:	e8 d0 f7 ff ff       	call   c0100dde <__intr_save>
c010160e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
c0101611:	83 ec 0c             	sub    $0xc,%esp
c0101614:	ff 75 08             	pushl  0x8(%ebp)
c0101617:	e8 8f fa ff ff       	call   c01010ab <lpt_putc>
c010161c:	83 c4 10             	add    $0x10,%esp
        cga_putc(c);
c010161f:	83 ec 0c             	sub    $0xc,%esp
c0101622:	ff 75 08             	pushl  0x8(%ebp)
c0101625:	e8 b8 fa ff ff       	call   c01010e2 <cga_putc>
c010162a:	83 c4 10             	add    $0x10,%esp
        serial_putc(c);
c010162d:	83 ec 0c             	sub    $0xc,%esp
c0101630:	ff 75 08             	pushl  0x8(%ebp)
c0101633:	e8 dd fc ff ff       	call   c0101315 <serial_putc>
c0101638:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c010163b:	83 ec 0c             	sub    $0xc,%esp
c010163e:	ff 75 f4             	pushl  -0xc(%ebp)
c0101641:	e8 c2 f7 ff ff       	call   c0100e08 <__intr_restore>
c0101646:	83 c4 10             	add    $0x10,%esp
}
c0101649:	90                   	nop
c010164a:	c9                   	leave  
c010164b:	c3                   	ret    

c010164c <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
c010164c:	55                   	push   %ebp
c010164d:	89 e5                	mov    %esp,%ebp
c010164f:	83 ec 18             	sub    $0x18,%esp
    int c = 0;
c0101652:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0101659:	e8 80 f7 ff ff       	call   c0100dde <__intr_save>
c010165e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
c0101661:	e8 89 fd ff ff       	call   c01013ef <serial_intr>
        kbd_intr();
c0101666:	e8 33 ff ff ff       	call   c010159e <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
c010166b:	8b 15 60 a6 11 c0    	mov    0xc011a660,%edx
c0101671:	a1 64 a6 11 c0       	mov    0xc011a664,%eax
c0101676:	39 c2                	cmp    %eax,%edx
c0101678:	74 31                	je     c01016ab <cons_getc+0x5f>
            c = cons.buf[cons.rpos ++];
c010167a:	a1 60 a6 11 c0       	mov    0xc011a660,%eax
c010167f:	8d 50 01             	lea    0x1(%eax),%edx
c0101682:	89 15 60 a6 11 c0    	mov    %edx,0xc011a660
c0101688:	0f b6 80 60 a4 11 c0 	movzbl -0x3fee5ba0(%eax),%eax
c010168f:	0f b6 c0             	movzbl %al,%eax
c0101692:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
c0101695:	a1 60 a6 11 c0       	mov    0xc011a660,%eax
c010169a:	3d 00 02 00 00       	cmp    $0x200,%eax
c010169f:	75 0a                	jne    c01016ab <cons_getc+0x5f>
                cons.rpos = 0;
c01016a1:	c7 05 60 a6 11 c0 00 	movl   $0x0,0xc011a660
c01016a8:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
c01016ab:	83 ec 0c             	sub    $0xc,%esp
c01016ae:	ff 75 f0             	pushl  -0x10(%ebp)
c01016b1:	e8 52 f7 ff ff       	call   c0100e08 <__intr_restore>
c01016b6:	83 c4 10             	add    $0x10,%esp
    return c;
c01016b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01016bc:	c9                   	leave  
c01016bd:	c3                   	ret    

c01016be <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
c01016be:	55                   	push   %ebp
c01016bf:	89 e5                	mov    %esp,%ebp
c01016c1:	83 ec 14             	sub    $0x14,%esp
c01016c4:	8b 45 08             	mov    0x8(%ebp),%eax
c01016c7:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
c01016cb:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01016cf:	66 a3 50 75 11 c0    	mov    %ax,0xc0117550
    if (did_init) {
c01016d5:	a1 6c a6 11 c0       	mov    0xc011a66c,%eax
c01016da:	85 c0                	test   %eax,%eax
c01016dc:	74 36                	je     c0101714 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
c01016de:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01016e2:	0f b6 c0             	movzbl %al,%eax
c01016e5:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
c01016eb:	88 45 f9             	mov    %al,-0x7(%ebp)
c01016ee:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01016f2:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c01016f6:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
c01016f7:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01016fb:	66 c1 e8 08          	shr    $0x8,%ax
c01016ff:	0f b6 c0             	movzbl %al,%eax
c0101702:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
c0101708:	88 45 fd             	mov    %al,-0x3(%ebp)
c010170b:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c010170f:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c0101713:	ee                   	out    %al,(%dx)
    }
}
c0101714:	90                   	nop
c0101715:	c9                   	leave  
c0101716:	c3                   	ret    

c0101717 <pic_enable>:

void
pic_enable(unsigned int irq) {
c0101717:	55                   	push   %ebp
c0101718:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
c010171a:	8b 45 08             	mov    0x8(%ebp),%eax
c010171d:	ba 01 00 00 00       	mov    $0x1,%edx
c0101722:	89 c1                	mov    %eax,%ecx
c0101724:	d3 e2                	shl    %cl,%edx
c0101726:	89 d0                	mov    %edx,%eax
c0101728:	f7 d0                	not    %eax
c010172a:	89 c2                	mov    %eax,%edx
c010172c:	0f b7 05 50 75 11 c0 	movzwl 0xc0117550,%eax
c0101733:	21 d0                	and    %edx,%eax
c0101735:	0f b7 c0             	movzwl %ax,%eax
c0101738:	50                   	push   %eax
c0101739:	e8 80 ff ff ff       	call   c01016be <pic_setmask>
c010173e:	83 c4 04             	add    $0x4,%esp
}
c0101741:	90                   	nop
c0101742:	c9                   	leave  
c0101743:	c3                   	ret    

c0101744 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
c0101744:	55                   	push   %ebp
c0101745:	89 e5                	mov    %esp,%ebp
c0101747:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
c010174a:	c7 05 6c a6 11 c0 01 	movl   $0x1,0xc011a66c
c0101751:	00 00 00 
c0101754:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
c010175a:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
c010175e:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
c0101762:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
c0101766:	ee                   	out    %al,(%dx)
c0101767:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
c010176d:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
c0101771:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
c0101775:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
c0101779:	ee                   	out    %al,(%dx)
c010177a:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
c0101780:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
c0101784:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0101788:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c010178c:	ee                   	out    %al,(%dx)
c010178d:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
c0101793:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
c0101797:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c010179b:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c010179f:	ee                   	out    %al,(%dx)
c01017a0:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
c01017a6:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
c01017aa:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c01017ae:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c01017b2:	ee                   	out    %al,(%dx)
c01017b3:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
c01017b9:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
c01017bd:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c01017c1:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c01017c5:	ee                   	out    %al,(%dx)
c01017c6:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
c01017cc:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
c01017d0:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c01017d4:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c01017d8:	ee                   	out    %al,(%dx)
c01017d9:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
c01017df:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
c01017e3:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c01017e7:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c01017eb:	ee                   	out    %al,(%dx)
c01017ec:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
c01017f2:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
c01017f6:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c01017fa:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c01017fe:	ee                   	out    %al,(%dx)
c01017ff:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
c0101805:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
c0101809:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c010180d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101811:	ee                   	out    %al,(%dx)
c0101812:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
c0101818:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
c010181c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101820:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101824:	ee                   	out    %al,(%dx)
c0101825:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
c010182b:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
c010182f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0101833:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101837:	ee                   	out    %al,(%dx)
c0101838:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
c010183e:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
c0101842:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101846:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c010184a:	ee                   	out    %al,(%dx)
c010184b:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
c0101851:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
c0101855:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c0101859:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c010185d:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
c010185e:	0f b7 05 50 75 11 c0 	movzwl 0xc0117550,%eax
c0101865:	66 83 f8 ff          	cmp    $0xffff,%ax
c0101869:	74 13                	je     c010187e <pic_init+0x13a>
        pic_setmask(irq_mask);
c010186b:	0f b7 05 50 75 11 c0 	movzwl 0xc0117550,%eax
c0101872:	0f b7 c0             	movzwl %ax,%eax
c0101875:	50                   	push   %eax
c0101876:	e8 43 fe ff ff       	call   c01016be <pic_setmask>
c010187b:	83 c4 04             	add    $0x4,%esp
    }
}
c010187e:	90                   	nop
c010187f:	c9                   	leave  
c0101880:	c3                   	ret    

c0101881 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
c0101881:	55                   	push   %ebp
c0101882:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
c0101884:	fb                   	sti    
    sti();
}
c0101885:	90                   	nop
c0101886:	5d                   	pop    %ebp
c0101887:	c3                   	ret    

c0101888 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
c0101888:	55                   	push   %ebp
c0101889:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
c010188b:	fa                   	cli    
    cli();
}
c010188c:	90                   	nop
c010188d:	5d                   	pop    %ebp
c010188e:	c3                   	ret    

c010188f <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
c010188f:	55                   	push   %ebp
c0101890:	89 e5                	mov    %esp,%ebp
c0101892:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
c0101895:	83 ec 08             	sub    $0x8,%esp
c0101898:	6a 64                	push   $0x64
c010189a:	68 e0 5d 10 c0       	push   $0xc0105de0
c010189f:	e8 cf e9 ff ff       	call   c0100273 <cprintf>
c01018a4:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
c01018a7:	90                   	nop
c01018a8:	c9                   	leave  
c01018a9:	c3                   	ret    

c01018aa <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
c01018aa:	55                   	push   %ebp
c01018ab:	89 e5                	mov    %esp,%ebp
c01018ad:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
c01018b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01018b7:	e9 c3 00 00 00       	jmp    c010197f <idt_init+0xd5>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
c01018bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01018bf:	8b 04 85 e0 75 11 c0 	mov    -0x3fee8a20(,%eax,4),%eax
c01018c6:	89 c2                	mov    %eax,%edx
c01018c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01018cb:	66 89 14 c5 80 a6 11 	mov    %dx,-0x3fee5980(,%eax,8)
c01018d2:	c0 
c01018d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01018d6:	66 c7 04 c5 82 a6 11 	movw   $0x8,-0x3fee597e(,%eax,8)
c01018dd:	c0 08 00 
c01018e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01018e3:	0f b6 14 c5 84 a6 11 	movzbl -0x3fee597c(,%eax,8),%edx
c01018ea:	c0 
c01018eb:	83 e2 e0             	and    $0xffffffe0,%edx
c01018ee:	88 14 c5 84 a6 11 c0 	mov    %dl,-0x3fee597c(,%eax,8)
c01018f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01018f8:	0f b6 14 c5 84 a6 11 	movzbl -0x3fee597c(,%eax,8),%edx
c01018ff:	c0 
c0101900:	83 e2 1f             	and    $0x1f,%edx
c0101903:	88 14 c5 84 a6 11 c0 	mov    %dl,-0x3fee597c(,%eax,8)
c010190a:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010190d:	0f b6 14 c5 85 a6 11 	movzbl -0x3fee597b(,%eax,8),%edx
c0101914:	c0 
c0101915:	83 e2 f0             	and    $0xfffffff0,%edx
c0101918:	83 ca 0e             	or     $0xe,%edx
c010191b:	88 14 c5 85 a6 11 c0 	mov    %dl,-0x3fee597b(,%eax,8)
c0101922:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101925:	0f b6 14 c5 85 a6 11 	movzbl -0x3fee597b(,%eax,8),%edx
c010192c:	c0 
c010192d:	83 e2 ef             	and    $0xffffffef,%edx
c0101930:	88 14 c5 85 a6 11 c0 	mov    %dl,-0x3fee597b(,%eax,8)
c0101937:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010193a:	0f b6 14 c5 85 a6 11 	movzbl -0x3fee597b(,%eax,8),%edx
c0101941:	c0 
c0101942:	83 e2 9f             	and    $0xffffff9f,%edx
c0101945:	88 14 c5 85 a6 11 c0 	mov    %dl,-0x3fee597b(,%eax,8)
c010194c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010194f:	0f b6 14 c5 85 a6 11 	movzbl -0x3fee597b(,%eax,8),%edx
c0101956:	c0 
c0101957:	83 ca 80             	or     $0xffffff80,%edx
c010195a:	88 14 c5 85 a6 11 c0 	mov    %dl,-0x3fee597b(,%eax,8)
c0101961:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101964:	8b 04 85 e0 75 11 c0 	mov    -0x3fee8a20(,%eax,4),%eax
c010196b:	c1 e8 10             	shr    $0x10,%eax
c010196e:	89 c2                	mov    %eax,%edx
c0101970:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101973:	66 89 14 c5 86 a6 11 	mov    %dx,-0x3fee597a(,%eax,8)
c010197a:	c0 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
c010197b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c010197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101982:	3d ff 00 00 00       	cmp    $0xff,%eax
c0101987:	0f 86 2f ff ff ff    	jbe    c01018bc <idt_init+0x12>
c010198d:	c7 45 f8 60 75 11 c0 	movl   $0xc0117560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
c0101994:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0101997:	0f 01 18             	lidtl  (%eax)
    }
    lidt(&idt_pd);
}
c010199a:	90                   	nop
c010199b:	c9                   	leave  
c010199c:	c3                   	ret    

c010199d <trapname>:

static const char *
trapname(int trapno) {
c010199d:	55                   	push   %ebp
c010199e:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
c01019a0:	8b 45 08             	mov    0x8(%ebp),%eax
c01019a3:	83 f8 13             	cmp    $0x13,%eax
c01019a6:	77 0c                	ja     c01019b4 <trapname+0x17>
        return excnames[trapno];
c01019a8:	8b 45 08             	mov    0x8(%ebp),%eax
c01019ab:	8b 04 85 40 61 10 c0 	mov    -0x3fef9ec0(,%eax,4),%eax
c01019b2:	eb 18                	jmp    c01019cc <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
c01019b4:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
c01019b8:	7e 0d                	jle    c01019c7 <trapname+0x2a>
c01019ba:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
c01019be:	7f 07                	jg     c01019c7 <trapname+0x2a>
        return "Hardware Interrupt";
c01019c0:	b8 ea 5d 10 c0       	mov    $0xc0105dea,%eax
c01019c5:	eb 05                	jmp    c01019cc <trapname+0x2f>
    }
    return "(unknown trap)";
c01019c7:	b8 fd 5d 10 c0       	mov    $0xc0105dfd,%eax
}
c01019cc:	5d                   	pop    %ebp
c01019cd:	c3                   	ret    

c01019ce <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
c01019ce:	55                   	push   %ebp
c01019cf:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
c01019d1:	8b 45 08             	mov    0x8(%ebp),%eax
c01019d4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c01019d8:	66 83 f8 08          	cmp    $0x8,%ax
c01019dc:	0f 94 c0             	sete   %al
c01019df:	0f b6 c0             	movzbl %al,%eax
}
c01019e2:	5d                   	pop    %ebp
c01019e3:	c3                   	ret    

c01019e4 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
c01019e4:	55                   	push   %ebp
c01019e5:	89 e5                	mov    %esp,%ebp
c01019e7:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
c01019ea:	83 ec 08             	sub    $0x8,%esp
c01019ed:	ff 75 08             	pushl  0x8(%ebp)
c01019f0:	68 3e 5e 10 c0       	push   $0xc0105e3e
c01019f5:	e8 79 e8 ff ff       	call   c0100273 <cprintf>
c01019fa:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
c01019fd:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a00:	83 ec 0c             	sub    $0xc,%esp
c0101a03:	50                   	push   %eax
c0101a04:	e8 b6 01 00 00       	call   c0101bbf <print_regs>
c0101a09:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
c0101a0c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a0f:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
c0101a13:	0f b7 c0             	movzwl %ax,%eax
c0101a16:	83 ec 08             	sub    $0x8,%esp
c0101a19:	50                   	push   %eax
c0101a1a:	68 4f 5e 10 c0       	push   $0xc0105e4f
c0101a1f:	e8 4f e8 ff ff       	call   c0100273 <cprintf>
c0101a24:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
c0101a27:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a2a:	0f b7 40 28          	movzwl 0x28(%eax),%eax
c0101a2e:	0f b7 c0             	movzwl %ax,%eax
c0101a31:	83 ec 08             	sub    $0x8,%esp
c0101a34:	50                   	push   %eax
c0101a35:	68 62 5e 10 c0       	push   $0xc0105e62
c0101a3a:	e8 34 e8 ff ff       	call   c0100273 <cprintf>
c0101a3f:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
c0101a42:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a45:	0f b7 40 24          	movzwl 0x24(%eax),%eax
c0101a49:	0f b7 c0             	movzwl %ax,%eax
c0101a4c:	83 ec 08             	sub    $0x8,%esp
c0101a4f:	50                   	push   %eax
c0101a50:	68 75 5e 10 c0       	push   $0xc0105e75
c0101a55:	e8 19 e8 ff ff       	call   c0100273 <cprintf>
c0101a5a:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
c0101a5d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a60:	0f b7 40 20          	movzwl 0x20(%eax),%eax
c0101a64:	0f b7 c0             	movzwl %ax,%eax
c0101a67:	83 ec 08             	sub    $0x8,%esp
c0101a6a:	50                   	push   %eax
c0101a6b:	68 88 5e 10 c0       	push   $0xc0105e88
c0101a70:	e8 fe e7 ff ff       	call   c0100273 <cprintf>
c0101a75:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
c0101a78:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a7b:	8b 40 30             	mov    0x30(%eax),%eax
c0101a7e:	83 ec 0c             	sub    $0xc,%esp
c0101a81:	50                   	push   %eax
c0101a82:	e8 16 ff ff ff       	call   c010199d <trapname>
c0101a87:	83 c4 10             	add    $0x10,%esp
c0101a8a:	89 c2                	mov    %eax,%edx
c0101a8c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a8f:	8b 40 30             	mov    0x30(%eax),%eax
c0101a92:	83 ec 04             	sub    $0x4,%esp
c0101a95:	52                   	push   %edx
c0101a96:	50                   	push   %eax
c0101a97:	68 9b 5e 10 c0       	push   $0xc0105e9b
c0101a9c:	e8 d2 e7 ff ff       	call   c0100273 <cprintf>
c0101aa1:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
c0101aa4:	8b 45 08             	mov    0x8(%ebp),%eax
c0101aa7:	8b 40 34             	mov    0x34(%eax),%eax
c0101aaa:	83 ec 08             	sub    $0x8,%esp
c0101aad:	50                   	push   %eax
c0101aae:	68 ad 5e 10 c0       	push   $0xc0105ead
c0101ab3:	e8 bb e7 ff ff       	call   c0100273 <cprintf>
c0101ab8:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
c0101abb:	8b 45 08             	mov    0x8(%ebp),%eax
c0101abe:	8b 40 38             	mov    0x38(%eax),%eax
c0101ac1:	83 ec 08             	sub    $0x8,%esp
c0101ac4:	50                   	push   %eax
c0101ac5:	68 bc 5e 10 c0       	push   $0xc0105ebc
c0101aca:	e8 a4 e7 ff ff       	call   c0100273 <cprintf>
c0101acf:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
c0101ad2:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ad5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101ad9:	0f b7 c0             	movzwl %ax,%eax
c0101adc:	83 ec 08             	sub    $0x8,%esp
c0101adf:	50                   	push   %eax
c0101ae0:	68 cb 5e 10 c0       	push   $0xc0105ecb
c0101ae5:	e8 89 e7 ff ff       	call   c0100273 <cprintf>
c0101aea:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
c0101aed:	8b 45 08             	mov    0x8(%ebp),%eax
c0101af0:	8b 40 40             	mov    0x40(%eax),%eax
c0101af3:	83 ec 08             	sub    $0x8,%esp
c0101af6:	50                   	push   %eax
c0101af7:	68 de 5e 10 c0       	push   $0xc0105ede
c0101afc:	e8 72 e7 ff ff       	call   c0100273 <cprintf>
c0101b01:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101b04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0101b0b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
c0101b12:	eb 3f                	jmp    c0101b53 <print_trapframe+0x16f>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
c0101b14:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b17:	8b 50 40             	mov    0x40(%eax),%edx
c0101b1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101b1d:	21 d0                	and    %edx,%eax
c0101b1f:	85 c0                	test   %eax,%eax
c0101b21:	74 29                	je     c0101b4c <print_trapframe+0x168>
c0101b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101b26:	8b 04 85 80 75 11 c0 	mov    -0x3fee8a80(,%eax,4),%eax
c0101b2d:	85 c0                	test   %eax,%eax
c0101b2f:	74 1b                	je     c0101b4c <print_trapframe+0x168>
            cprintf("%s,", IA32flags[i]);
c0101b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101b34:	8b 04 85 80 75 11 c0 	mov    -0x3fee8a80(,%eax,4),%eax
c0101b3b:	83 ec 08             	sub    $0x8,%esp
c0101b3e:	50                   	push   %eax
c0101b3f:	68 ed 5e 10 c0       	push   $0xc0105eed
c0101b44:	e8 2a e7 ff ff       	call   c0100273 <cprintf>
c0101b49:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101b4c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101b50:	d1 65 f0             	shll   -0x10(%ebp)
c0101b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101b56:	83 f8 17             	cmp    $0x17,%eax
c0101b59:	76 b9                	jbe    c0101b14 <print_trapframe+0x130>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
c0101b5b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b5e:	8b 40 40             	mov    0x40(%eax),%eax
c0101b61:	c1 e8 0c             	shr    $0xc,%eax
c0101b64:	83 e0 03             	and    $0x3,%eax
c0101b67:	83 ec 08             	sub    $0x8,%esp
c0101b6a:	50                   	push   %eax
c0101b6b:	68 f1 5e 10 c0       	push   $0xc0105ef1
c0101b70:	e8 fe e6 ff ff       	call   c0100273 <cprintf>
c0101b75:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
c0101b78:	83 ec 0c             	sub    $0xc,%esp
c0101b7b:	ff 75 08             	pushl  0x8(%ebp)
c0101b7e:	e8 4b fe ff ff       	call   c01019ce <trap_in_kernel>
c0101b83:	83 c4 10             	add    $0x10,%esp
c0101b86:	85 c0                	test   %eax,%eax
c0101b88:	75 32                	jne    c0101bbc <print_trapframe+0x1d8>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
c0101b8a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b8d:	8b 40 44             	mov    0x44(%eax),%eax
c0101b90:	83 ec 08             	sub    $0x8,%esp
c0101b93:	50                   	push   %eax
c0101b94:	68 fa 5e 10 c0       	push   $0xc0105efa
c0101b99:	e8 d5 e6 ff ff       	call   c0100273 <cprintf>
c0101b9e:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
c0101ba1:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ba4:	0f b7 40 48          	movzwl 0x48(%eax),%eax
c0101ba8:	0f b7 c0             	movzwl %ax,%eax
c0101bab:	83 ec 08             	sub    $0x8,%esp
c0101bae:	50                   	push   %eax
c0101baf:	68 09 5f 10 c0       	push   $0xc0105f09
c0101bb4:	e8 ba e6 ff ff       	call   c0100273 <cprintf>
c0101bb9:	83 c4 10             	add    $0x10,%esp
    }
}
c0101bbc:	90                   	nop
c0101bbd:	c9                   	leave  
c0101bbe:	c3                   	ret    

c0101bbf <print_regs>:

void
print_regs(struct pushregs *regs) {
c0101bbf:	55                   	push   %ebp
c0101bc0:	89 e5                	mov    %esp,%ebp
c0101bc2:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
c0101bc5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bc8:	8b 00                	mov    (%eax),%eax
c0101bca:	83 ec 08             	sub    $0x8,%esp
c0101bcd:	50                   	push   %eax
c0101bce:	68 1c 5f 10 c0       	push   $0xc0105f1c
c0101bd3:	e8 9b e6 ff ff       	call   c0100273 <cprintf>
c0101bd8:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
c0101bdb:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bde:	8b 40 04             	mov    0x4(%eax),%eax
c0101be1:	83 ec 08             	sub    $0x8,%esp
c0101be4:	50                   	push   %eax
c0101be5:	68 2b 5f 10 c0       	push   $0xc0105f2b
c0101bea:	e8 84 e6 ff ff       	call   c0100273 <cprintf>
c0101bef:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
c0101bf2:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bf5:	8b 40 08             	mov    0x8(%eax),%eax
c0101bf8:	83 ec 08             	sub    $0x8,%esp
c0101bfb:	50                   	push   %eax
c0101bfc:	68 3a 5f 10 c0       	push   $0xc0105f3a
c0101c01:	e8 6d e6 ff ff       	call   c0100273 <cprintf>
c0101c06:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
c0101c09:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c0c:	8b 40 0c             	mov    0xc(%eax),%eax
c0101c0f:	83 ec 08             	sub    $0x8,%esp
c0101c12:	50                   	push   %eax
c0101c13:	68 49 5f 10 c0       	push   $0xc0105f49
c0101c18:	e8 56 e6 ff ff       	call   c0100273 <cprintf>
c0101c1d:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
c0101c20:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c23:	8b 40 10             	mov    0x10(%eax),%eax
c0101c26:	83 ec 08             	sub    $0x8,%esp
c0101c29:	50                   	push   %eax
c0101c2a:	68 58 5f 10 c0       	push   $0xc0105f58
c0101c2f:	e8 3f e6 ff ff       	call   c0100273 <cprintf>
c0101c34:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
c0101c37:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c3a:	8b 40 14             	mov    0x14(%eax),%eax
c0101c3d:	83 ec 08             	sub    $0x8,%esp
c0101c40:	50                   	push   %eax
c0101c41:	68 67 5f 10 c0       	push   $0xc0105f67
c0101c46:	e8 28 e6 ff ff       	call   c0100273 <cprintf>
c0101c4b:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
c0101c4e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c51:	8b 40 18             	mov    0x18(%eax),%eax
c0101c54:	83 ec 08             	sub    $0x8,%esp
c0101c57:	50                   	push   %eax
c0101c58:	68 76 5f 10 c0       	push   $0xc0105f76
c0101c5d:	e8 11 e6 ff ff       	call   c0100273 <cprintf>
c0101c62:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
c0101c65:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c68:	8b 40 1c             	mov    0x1c(%eax),%eax
c0101c6b:	83 ec 08             	sub    $0x8,%esp
c0101c6e:	50                   	push   %eax
c0101c6f:	68 85 5f 10 c0       	push   $0xc0105f85
c0101c74:	e8 fa e5 ff ff       	call   c0100273 <cprintf>
c0101c79:	83 c4 10             	add    $0x10,%esp
}
c0101c7c:	90                   	nop
c0101c7d:	c9                   	leave  
c0101c7e:	c3                   	ret    

c0101c7f <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
c0101c7f:	55                   	push   %ebp
c0101c80:	89 e5                	mov    %esp,%ebp
c0101c82:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
c0101c85:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c88:	8b 40 30             	mov    0x30(%eax),%eax
c0101c8b:	83 f8 2f             	cmp    $0x2f,%eax
c0101c8e:	77 1d                	ja     c0101cad <trap_dispatch+0x2e>
c0101c90:	83 f8 2e             	cmp    $0x2e,%eax
c0101c93:	0f 83 f4 00 00 00    	jae    c0101d8d <trap_dispatch+0x10e>
c0101c99:	83 f8 21             	cmp    $0x21,%eax
c0101c9c:	74 7e                	je     c0101d1c <trap_dispatch+0x9d>
c0101c9e:	83 f8 24             	cmp    $0x24,%eax
c0101ca1:	74 55                	je     c0101cf8 <trap_dispatch+0x79>
c0101ca3:	83 f8 20             	cmp    $0x20,%eax
c0101ca6:	74 16                	je     c0101cbe <trap_dispatch+0x3f>
c0101ca8:	e9 aa 00 00 00       	jmp    c0101d57 <trap_dispatch+0xd8>
c0101cad:	83 e8 78             	sub    $0x78,%eax
c0101cb0:	83 f8 01             	cmp    $0x1,%eax
c0101cb3:	0f 87 9e 00 00 00    	ja     c0101d57 <trap_dispatch+0xd8>
c0101cb9:	e9 82 00 00 00       	jmp    c0101d40 <trap_dispatch+0xc1>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
c0101cbe:	a1 0c af 11 c0       	mov    0xc011af0c,%eax
c0101cc3:	83 c0 01             	add    $0x1,%eax
c0101cc6:	a3 0c af 11 c0       	mov    %eax,0xc011af0c
        if (ticks % TICK_NUM == 0) {
c0101ccb:	8b 0d 0c af 11 c0    	mov    0xc011af0c,%ecx
c0101cd1:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
c0101cd6:	89 c8                	mov    %ecx,%eax
c0101cd8:	f7 e2                	mul    %edx
c0101cda:	89 d0                	mov    %edx,%eax
c0101cdc:	c1 e8 05             	shr    $0x5,%eax
c0101cdf:	6b c0 64             	imul   $0x64,%eax,%eax
c0101ce2:	29 c1                	sub    %eax,%ecx
c0101ce4:	89 c8                	mov    %ecx,%eax
c0101ce6:	85 c0                	test   %eax,%eax
c0101ce8:	0f 85 a2 00 00 00    	jne    c0101d90 <trap_dispatch+0x111>
            print_ticks();
c0101cee:	e8 9c fb ff ff       	call   c010188f <print_ticks>
        }
        break;
c0101cf3:	e9 98 00 00 00       	jmp    c0101d90 <trap_dispatch+0x111>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
c0101cf8:	e8 4f f9 ff ff       	call   c010164c <cons_getc>
c0101cfd:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
c0101d00:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101d04:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101d08:	83 ec 04             	sub    $0x4,%esp
c0101d0b:	52                   	push   %edx
c0101d0c:	50                   	push   %eax
c0101d0d:	68 94 5f 10 c0       	push   $0xc0105f94
c0101d12:	e8 5c e5 ff ff       	call   c0100273 <cprintf>
c0101d17:	83 c4 10             	add    $0x10,%esp
        break;
c0101d1a:	eb 75                	jmp    c0101d91 <trap_dispatch+0x112>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
c0101d1c:	e8 2b f9 ff ff       	call   c010164c <cons_getc>
c0101d21:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
c0101d24:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101d28:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101d2c:	83 ec 04             	sub    $0x4,%esp
c0101d2f:	52                   	push   %edx
c0101d30:	50                   	push   %eax
c0101d31:	68 a6 5f 10 c0       	push   $0xc0105fa6
c0101d36:	e8 38 e5 ff ff       	call   c0100273 <cprintf>
c0101d3b:	83 c4 10             	add    $0x10,%esp
        break;
c0101d3e:	eb 51                	jmp    c0101d91 <trap_dispatch+0x112>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
c0101d40:	83 ec 04             	sub    $0x4,%esp
c0101d43:	68 b5 5f 10 c0       	push   $0xc0105fb5
c0101d48:	68 ac 00 00 00       	push   $0xac
c0101d4d:	68 c5 5f 10 c0       	push   $0xc0105fc5
c0101d52:	e8 82 e6 ff ff       	call   c01003d9 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
c0101d57:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d5a:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101d5e:	0f b7 c0             	movzwl %ax,%eax
c0101d61:	83 e0 03             	and    $0x3,%eax
c0101d64:	85 c0                	test   %eax,%eax
c0101d66:	75 29                	jne    c0101d91 <trap_dispatch+0x112>
            print_trapframe(tf);
c0101d68:	83 ec 0c             	sub    $0xc,%esp
c0101d6b:	ff 75 08             	pushl  0x8(%ebp)
c0101d6e:	e8 71 fc ff ff       	call   c01019e4 <print_trapframe>
c0101d73:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
c0101d76:	83 ec 04             	sub    $0x4,%esp
c0101d79:	68 d6 5f 10 c0       	push   $0xc0105fd6
c0101d7e:	68 b6 00 00 00       	push   $0xb6
c0101d83:	68 c5 5f 10 c0       	push   $0xc0105fc5
c0101d88:	e8 4c e6 ff ff       	call   c01003d9 <__panic>
        break;
c0101d8d:	90                   	nop
c0101d8e:	eb 01                	jmp    c0101d91 <trap_dispatch+0x112>
        break;
c0101d90:	90                   	nop
        }
    }
}
c0101d91:	90                   	nop
c0101d92:	c9                   	leave  
c0101d93:	c3                   	ret    

c0101d94 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
c0101d94:	55                   	push   %ebp
c0101d95:	89 e5                	mov    %esp,%ebp
c0101d97:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
c0101d9a:	83 ec 0c             	sub    $0xc,%esp
c0101d9d:	ff 75 08             	pushl  0x8(%ebp)
c0101da0:	e8 da fe ff ff       	call   c0101c7f <trap_dispatch>
c0101da5:	83 c4 10             	add    $0x10,%esp
}
c0101da8:	90                   	nop
c0101da9:	c9                   	leave  
c0101daa:	c3                   	ret    

c0101dab <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
c0101dab:	6a 00                	push   $0x0
  pushl $0
c0101dad:	6a 00                	push   $0x0
  jmp __alltraps
c0101daf:	e9 67 0a 00 00       	jmp    c010281b <__alltraps>

c0101db4 <vector1>:
.globl vector1
vector1:
  pushl $0
c0101db4:	6a 00                	push   $0x0
  pushl $1
c0101db6:	6a 01                	push   $0x1
  jmp __alltraps
c0101db8:	e9 5e 0a 00 00       	jmp    c010281b <__alltraps>

c0101dbd <vector2>:
.globl vector2
vector2:
  pushl $0
c0101dbd:	6a 00                	push   $0x0
  pushl $2
c0101dbf:	6a 02                	push   $0x2
  jmp __alltraps
c0101dc1:	e9 55 0a 00 00       	jmp    c010281b <__alltraps>

c0101dc6 <vector3>:
.globl vector3
vector3:
  pushl $0
c0101dc6:	6a 00                	push   $0x0
  pushl $3
c0101dc8:	6a 03                	push   $0x3
  jmp __alltraps
c0101dca:	e9 4c 0a 00 00       	jmp    c010281b <__alltraps>

c0101dcf <vector4>:
.globl vector4
vector4:
  pushl $0
c0101dcf:	6a 00                	push   $0x0
  pushl $4
c0101dd1:	6a 04                	push   $0x4
  jmp __alltraps
c0101dd3:	e9 43 0a 00 00       	jmp    c010281b <__alltraps>

c0101dd8 <vector5>:
.globl vector5
vector5:
  pushl $0
c0101dd8:	6a 00                	push   $0x0
  pushl $5
c0101dda:	6a 05                	push   $0x5
  jmp __alltraps
c0101ddc:	e9 3a 0a 00 00       	jmp    c010281b <__alltraps>

c0101de1 <vector6>:
.globl vector6
vector6:
  pushl $0
c0101de1:	6a 00                	push   $0x0
  pushl $6
c0101de3:	6a 06                	push   $0x6
  jmp __alltraps
c0101de5:	e9 31 0a 00 00       	jmp    c010281b <__alltraps>

c0101dea <vector7>:
.globl vector7
vector7:
  pushl $0
c0101dea:	6a 00                	push   $0x0
  pushl $7
c0101dec:	6a 07                	push   $0x7
  jmp __alltraps
c0101dee:	e9 28 0a 00 00       	jmp    c010281b <__alltraps>

c0101df3 <vector8>:
.globl vector8
vector8:
  pushl $8
c0101df3:	6a 08                	push   $0x8
  jmp __alltraps
c0101df5:	e9 21 0a 00 00       	jmp    c010281b <__alltraps>

c0101dfa <vector9>:
.globl vector9
vector9:
  pushl $9
c0101dfa:	6a 09                	push   $0x9
  jmp __alltraps
c0101dfc:	e9 1a 0a 00 00       	jmp    c010281b <__alltraps>

c0101e01 <vector10>:
.globl vector10
vector10:
  pushl $10
c0101e01:	6a 0a                	push   $0xa
  jmp __alltraps
c0101e03:	e9 13 0a 00 00       	jmp    c010281b <__alltraps>

c0101e08 <vector11>:
.globl vector11
vector11:
  pushl $11
c0101e08:	6a 0b                	push   $0xb
  jmp __alltraps
c0101e0a:	e9 0c 0a 00 00       	jmp    c010281b <__alltraps>

c0101e0f <vector12>:
.globl vector12
vector12:
  pushl $12
c0101e0f:	6a 0c                	push   $0xc
  jmp __alltraps
c0101e11:	e9 05 0a 00 00       	jmp    c010281b <__alltraps>

c0101e16 <vector13>:
.globl vector13
vector13:
  pushl $13
c0101e16:	6a 0d                	push   $0xd
  jmp __alltraps
c0101e18:	e9 fe 09 00 00       	jmp    c010281b <__alltraps>

c0101e1d <vector14>:
.globl vector14
vector14:
  pushl $14
c0101e1d:	6a 0e                	push   $0xe
  jmp __alltraps
c0101e1f:	e9 f7 09 00 00       	jmp    c010281b <__alltraps>

c0101e24 <vector15>:
.globl vector15
vector15:
  pushl $0
c0101e24:	6a 00                	push   $0x0
  pushl $15
c0101e26:	6a 0f                	push   $0xf
  jmp __alltraps
c0101e28:	e9 ee 09 00 00       	jmp    c010281b <__alltraps>

c0101e2d <vector16>:
.globl vector16
vector16:
  pushl $0
c0101e2d:	6a 00                	push   $0x0
  pushl $16
c0101e2f:	6a 10                	push   $0x10
  jmp __alltraps
c0101e31:	e9 e5 09 00 00       	jmp    c010281b <__alltraps>

c0101e36 <vector17>:
.globl vector17
vector17:
  pushl $17
c0101e36:	6a 11                	push   $0x11
  jmp __alltraps
c0101e38:	e9 de 09 00 00       	jmp    c010281b <__alltraps>

c0101e3d <vector18>:
.globl vector18
vector18:
  pushl $0
c0101e3d:	6a 00                	push   $0x0
  pushl $18
c0101e3f:	6a 12                	push   $0x12
  jmp __alltraps
c0101e41:	e9 d5 09 00 00       	jmp    c010281b <__alltraps>

c0101e46 <vector19>:
.globl vector19
vector19:
  pushl $0
c0101e46:	6a 00                	push   $0x0
  pushl $19
c0101e48:	6a 13                	push   $0x13
  jmp __alltraps
c0101e4a:	e9 cc 09 00 00       	jmp    c010281b <__alltraps>

c0101e4f <vector20>:
.globl vector20
vector20:
  pushl $0
c0101e4f:	6a 00                	push   $0x0
  pushl $20
c0101e51:	6a 14                	push   $0x14
  jmp __alltraps
c0101e53:	e9 c3 09 00 00       	jmp    c010281b <__alltraps>

c0101e58 <vector21>:
.globl vector21
vector21:
  pushl $0
c0101e58:	6a 00                	push   $0x0
  pushl $21
c0101e5a:	6a 15                	push   $0x15
  jmp __alltraps
c0101e5c:	e9 ba 09 00 00       	jmp    c010281b <__alltraps>

c0101e61 <vector22>:
.globl vector22
vector22:
  pushl $0
c0101e61:	6a 00                	push   $0x0
  pushl $22
c0101e63:	6a 16                	push   $0x16
  jmp __alltraps
c0101e65:	e9 b1 09 00 00       	jmp    c010281b <__alltraps>

c0101e6a <vector23>:
.globl vector23
vector23:
  pushl $0
c0101e6a:	6a 00                	push   $0x0
  pushl $23
c0101e6c:	6a 17                	push   $0x17
  jmp __alltraps
c0101e6e:	e9 a8 09 00 00       	jmp    c010281b <__alltraps>

c0101e73 <vector24>:
.globl vector24
vector24:
  pushl $0
c0101e73:	6a 00                	push   $0x0
  pushl $24
c0101e75:	6a 18                	push   $0x18
  jmp __alltraps
c0101e77:	e9 9f 09 00 00       	jmp    c010281b <__alltraps>

c0101e7c <vector25>:
.globl vector25
vector25:
  pushl $0
c0101e7c:	6a 00                	push   $0x0
  pushl $25
c0101e7e:	6a 19                	push   $0x19
  jmp __alltraps
c0101e80:	e9 96 09 00 00       	jmp    c010281b <__alltraps>

c0101e85 <vector26>:
.globl vector26
vector26:
  pushl $0
c0101e85:	6a 00                	push   $0x0
  pushl $26
c0101e87:	6a 1a                	push   $0x1a
  jmp __alltraps
c0101e89:	e9 8d 09 00 00       	jmp    c010281b <__alltraps>

c0101e8e <vector27>:
.globl vector27
vector27:
  pushl $0
c0101e8e:	6a 00                	push   $0x0
  pushl $27
c0101e90:	6a 1b                	push   $0x1b
  jmp __alltraps
c0101e92:	e9 84 09 00 00       	jmp    c010281b <__alltraps>

c0101e97 <vector28>:
.globl vector28
vector28:
  pushl $0
c0101e97:	6a 00                	push   $0x0
  pushl $28
c0101e99:	6a 1c                	push   $0x1c
  jmp __alltraps
c0101e9b:	e9 7b 09 00 00       	jmp    c010281b <__alltraps>

c0101ea0 <vector29>:
.globl vector29
vector29:
  pushl $0
c0101ea0:	6a 00                	push   $0x0
  pushl $29
c0101ea2:	6a 1d                	push   $0x1d
  jmp __alltraps
c0101ea4:	e9 72 09 00 00       	jmp    c010281b <__alltraps>

c0101ea9 <vector30>:
.globl vector30
vector30:
  pushl $0
c0101ea9:	6a 00                	push   $0x0
  pushl $30
c0101eab:	6a 1e                	push   $0x1e
  jmp __alltraps
c0101ead:	e9 69 09 00 00       	jmp    c010281b <__alltraps>

c0101eb2 <vector31>:
.globl vector31
vector31:
  pushl $0
c0101eb2:	6a 00                	push   $0x0
  pushl $31
c0101eb4:	6a 1f                	push   $0x1f
  jmp __alltraps
c0101eb6:	e9 60 09 00 00       	jmp    c010281b <__alltraps>

c0101ebb <vector32>:
.globl vector32
vector32:
  pushl $0
c0101ebb:	6a 00                	push   $0x0
  pushl $32
c0101ebd:	6a 20                	push   $0x20
  jmp __alltraps
c0101ebf:	e9 57 09 00 00       	jmp    c010281b <__alltraps>

c0101ec4 <vector33>:
.globl vector33
vector33:
  pushl $0
c0101ec4:	6a 00                	push   $0x0
  pushl $33
c0101ec6:	6a 21                	push   $0x21
  jmp __alltraps
c0101ec8:	e9 4e 09 00 00       	jmp    c010281b <__alltraps>

c0101ecd <vector34>:
.globl vector34
vector34:
  pushl $0
c0101ecd:	6a 00                	push   $0x0
  pushl $34
c0101ecf:	6a 22                	push   $0x22
  jmp __alltraps
c0101ed1:	e9 45 09 00 00       	jmp    c010281b <__alltraps>

c0101ed6 <vector35>:
.globl vector35
vector35:
  pushl $0
c0101ed6:	6a 00                	push   $0x0
  pushl $35
c0101ed8:	6a 23                	push   $0x23
  jmp __alltraps
c0101eda:	e9 3c 09 00 00       	jmp    c010281b <__alltraps>

c0101edf <vector36>:
.globl vector36
vector36:
  pushl $0
c0101edf:	6a 00                	push   $0x0
  pushl $36
c0101ee1:	6a 24                	push   $0x24
  jmp __alltraps
c0101ee3:	e9 33 09 00 00       	jmp    c010281b <__alltraps>

c0101ee8 <vector37>:
.globl vector37
vector37:
  pushl $0
c0101ee8:	6a 00                	push   $0x0
  pushl $37
c0101eea:	6a 25                	push   $0x25
  jmp __alltraps
c0101eec:	e9 2a 09 00 00       	jmp    c010281b <__alltraps>

c0101ef1 <vector38>:
.globl vector38
vector38:
  pushl $0
c0101ef1:	6a 00                	push   $0x0
  pushl $38
c0101ef3:	6a 26                	push   $0x26
  jmp __alltraps
c0101ef5:	e9 21 09 00 00       	jmp    c010281b <__alltraps>

c0101efa <vector39>:
.globl vector39
vector39:
  pushl $0
c0101efa:	6a 00                	push   $0x0
  pushl $39
c0101efc:	6a 27                	push   $0x27
  jmp __alltraps
c0101efe:	e9 18 09 00 00       	jmp    c010281b <__alltraps>

c0101f03 <vector40>:
.globl vector40
vector40:
  pushl $0
c0101f03:	6a 00                	push   $0x0
  pushl $40
c0101f05:	6a 28                	push   $0x28
  jmp __alltraps
c0101f07:	e9 0f 09 00 00       	jmp    c010281b <__alltraps>

c0101f0c <vector41>:
.globl vector41
vector41:
  pushl $0
c0101f0c:	6a 00                	push   $0x0
  pushl $41
c0101f0e:	6a 29                	push   $0x29
  jmp __alltraps
c0101f10:	e9 06 09 00 00       	jmp    c010281b <__alltraps>

c0101f15 <vector42>:
.globl vector42
vector42:
  pushl $0
c0101f15:	6a 00                	push   $0x0
  pushl $42
c0101f17:	6a 2a                	push   $0x2a
  jmp __alltraps
c0101f19:	e9 fd 08 00 00       	jmp    c010281b <__alltraps>

c0101f1e <vector43>:
.globl vector43
vector43:
  pushl $0
c0101f1e:	6a 00                	push   $0x0
  pushl $43
c0101f20:	6a 2b                	push   $0x2b
  jmp __alltraps
c0101f22:	e9 f4 08 00 00       	jmp    c010281b <__alltraps>

c0101f27 <vector44>:
.globl vector44
vector44:
  pushl $0
c0101f27:	6a 00                	push   $0x0
  pushl $44
c0101f29:	6a 2c                	push   $0x2c
  jmp __alltraps
c0101f2b:	e9 eb 08 00 00       	jmp    c010281b <__alltraps>

c0101f30 <vector45>:
.globl vector45
vector45:
  pushl $0
c0101f30:	6a 00                	push   $0x0
  pushl $45
c0101f32:	6a 2d                	push   $0x2d
  jmp __alltraps
c0101f34:	e9 e2 08 00 00       	jmp    c010281b <__alltraps>

c0101f39 <vector46>:
.globl vector46
vector46:
  pushl $0
c0101f39:	6a 00                	push   $0x0
  pushl $46
c0101f3b:	6a 2e                	push   $0x2e
  jmp __alltraps
c0101f3d:	e9 d9 08 00 00       	jmp    c010281b <__alltraps>

c0101f42 <vector47>:
.globl vector47
vector47:
  pushl $0
c0101f42:	6a 00                	push   $0x0
  pushl $47
c0101f44:	6a 2f                	push   $0x2f
  jmp __alltraps
c0101f46:	e9 d0 08 00 00       	jmp    c010281b <__alltraps>

c0101f4b <vector48>:
.globl vector48
vector48:
  pushl $0
c0101f4b:	6a 00                	push   $0x0
  pushl $48
c0101f4d:	6a 30                	push   $0x30
  jmp __alltraps
c0101f4f:	e9 c7 08 00 00       	jmp    c010281b <__alltraps>

c0101f54 <vector49>:
.globl vector49
vector49:
  pushl $0
c0101f54:	6a 00                	push   $0x0
  pushl $49
c0101f56:	6a 31                	push   $0x31
  jmp __alltraps
c0101f58:	e9 be 08 00 00       	jmp    c010281b <__alltraps>

c0101f5d <vector50>:
.globl vector50
vector50:
  pushl $0
c0101f5d:	6a 00                	push   $0x0
  pushl $50
c0101f5f:	6a 32                	push   $0x32
  jmp __alltraps
c0101f61:	e9 b5 08 00 00       	jmp    c010281b <__alltraps>

c0101f66 <vector51>:
.globl vector51
vector51:
  pushl $0
c0101f66:	6a 00                	push   $0x0
  pushl $51
c0101f68:	6a 33                	push   $0x33
  jmp __alltraps
c0101f6a:	e9 ac 08 00 00       	jmp    c010281b <__alltraps>

c0101f6f <vector52>:
.globl vector52
vector52:
  pushl $0
c0101f6f:	6a 00                	push   $0x0
  pushl $52
c0101f71:	6a 34                	push   $0x34
  jmp __alltraps
c0101f73:	e9 a3 08 00 00       	jmp    c010281b <__alltraps>

c0101f78 <vector53>:
.globl vector53
vector53:
  pushl $0
c0101f78:	6a 00                	push   $0x0
  pushl $53
c0101f7a:	6a 35                	push   $0x35
  jmp __alltraps
c0101f7c:	e9 9a 08 00 00       	jmp    c010281b <__alltraps>

c0101f81 <vector54>:
.globl vector54
vector54:
  pushl $0
c0101f81:	6a 00                	push   $0x0
  pushl $54
c0101f83:	6a 36                	push   $0x36
  jmp __alltraps
c0101f85:	e9 91 08 00 00       	jmp    c010281b <__alltraps>

c0101f8a <vector55>:
.globl vector55
vector55:
  pushl $0
c0101f8a:	6a 00                	push   $0x0
  pushl $55
c0101f8c:	6a 37                	push   $0x37
  jmp __alltraps
c0101f8e:	e9 88 08 00 00       	jmp    c010281b <__alltraps>

c0101f93 <vector56>:
.globl vector56
vector56:
  pushl $0
c0101f93:	6a 00                	push   $0x0
  pushl $56
c0101f95:	6a 38                	push   $0x38
  jmp __alltraps
c0101f97:	e9 7f 08 00 00       	jmp    c010281b <__alltraps>

c0101f9c <vector57>:
.globl vector57
vector57:
  pushl $0
c0101f9c:	6a 00                	push   $0x0
  pushl $57
c0101f9e:	6a 39                	push   $0x39
  jmp __alltraps
c0101fa0:	e9 76 08 00 00       	jmp    c010281b <__alltraps>

c0101fa5 <vector58>:
.globl vector58
vector58:
  pushl $0
c0101fa5:	6a 00                	push   $0x0
  pushl $58
c0101fa7:	6a 3a                	push   $0x3a
  jmp __alltraps
c0101fa9:	e9 6d 08 00 00       	jmp    c010281b <__alltraps>

c0101fae <vector59>:
.globl vector59
vector59:
  pushl $0
c0101fae:	6a 00                	push   $0x0
  pushl $59
c0101fb0:	6a 3b                	push   $0x3b
  jmp __alltraps
c0101fb2:	e9 64 08 00 00       	jmp    c010281b <__alltraps>

c0101fb7 <vector60>:
.globl vector60
vector60:
  pushl $0
c0101fb7:	6a 00                	push   $0x0
  pushl $60
c0101fb9:	6a 3c                	push   $0x3c
  jmp __alltraps
c0101fbb:	e9 5b 08 00 00       	jmp    c010281b <__alltraps>

c0101fc0 <vector61>:
.globl vector61
vector61:
  pushl $0
c0101fc0:	6a 00                	push   $0x0
  pushl $61
c0101fc2:	6a 3d                	push   $0x3d
  jmp __alltraps
c0101fc4:	e9 52 08 00 00       	jmp    c010281b <__alltraps>

c0101fc9 <vector62>:
.globl vector62
vector62:
  pushl $0
c0101fc9:	6a 00                	push   $0x0
  pushl $62
c0101fcb:	6a 3e                	push   $0x3e
  jmp __alltraps
c0101fcd:	e9 49 08 00 00       	jmp    c010281b <__alltraps>

c0101fd2 <vector63>:
.globl vector63
vector63:
  pushl $0
c0101fd2:	6a 00                	push   $0x0
  pushl $63
c0101fd4:	6a 3f                	push   $0x3f
  jmp __alltraps
c0101fd6:	e9 40 08 00 00       	jmp    c010281b <__alltraps>

c0101fdb <vector64>:
.globl vector64
vector64:
  pushl $0
c0101fdb:	6a 00                	push   $0x0
  pushl $64
c0101fdd:	6a 40                	push   $0x40
  jmp __alltraps
c0101fdf:	e9 37 08 00 00       	jmp    c010281b <__alltraps>

c0101fe4 <vector65>:
.globl vector65
vector65:
  pushl $0
c0101fe4:	6a 00                	push   $0x0
  pushl $65
c0101fe6:	6a 41                	push   $0x41
  jmp __alltraps
c0101fe8:	e9 2e 08 00 00       	jmp    c010281b <__alltraps>

c0101fed <vector66>:
.globl vector66
vector66:
  pushl $0
c0101fed:	6a 00                	push   $0x0
  pushl $66
c0101fef:	6a 42                	push   $0x42
  jmp __alltraps
c0101ff1:	e9 25 08 00 00       	jmp    c010281b <__alltraps>

c0101ff6 <vector67>:
.globl vector67
vector67:
  pushl $0
c0101ff6:	6a 00                	push   $0x0
  pushl $67
c0101ff8:	6a 43                	push   $0x43
  jmp __alltraps
c0101ffa:	e9 1c 08 00 00       	jmp    c010281b <__alltraps>

c0101fff <vector68>:
.globl vector68
vector68:
  pushl $0
c0101fff:	6a 00                	push   $0x0
  pushl $68
c0102001:	6a 44                	push   $0x44
  jmp __alltraps
c0102003:	e9 13 08 00 00       	jmp    c010281b <__alltraps>

c0102008 <vector69>:
.globl vector69
vector69:
  pushl $0
c0102008:	6a 00                	push   $0x0
  pushl $69
c010200a:	6a 45                	push   $0x45
  jmp __alltraps
c010200c:	e9 0a 08 00 00       	jmp    c010281b <__alltraps>

c0102011 <vector70>:
.globl vector70
vector70:
  pushl $0
c0102011:	6a 00                	push   $0x0
  pushl $70
c0102013:	6a 46                	push   $0x46
  jmp __alltraps
c0102015:	e9 01 08 00 00       	jmp    c010281b <__alltraps>

c010201a <vector71>:
.globl vector71
vector71:
  pushl $0
c010201a:	6a 00                	push   $0x0
  pushl $71
c010201c:	6a 47                	push   $0x47
  jmp __alltraps
c010201e:	e9 f8 07 00 00       	jmp    c010281b <__alltraps>

c0102023 <vector72>:
.globl vector72
vector72:
  pushl $0
c0102023:	6a 00                	push   $0x0
  pushl $72
c0102025:	6a 48                	push   $0x48
  jmp __alltraps
c0102027:	e9 ef 07 00 00       	jmp    c010281b <__alltraps>

c010202c <vector73>:
.globl vector73
vector73:
  pushl $0
c010202c:	6a 00                	push   $0x0
  pushl $73
c010202e:	6a 49                	push   $0x49
  jmp __alltraps
c0102030:	e9 e6 07 00 00       	jmp    c010281b <__alltraps>

c0102035 <vector74>:
.globl vector74
vector74:
  pushl $0
c0102035:	6a 00                	push   $0x0
  pushl $74
c0102037:	6a 4a                	push   $0x4a
  jmp __alltraps
c0102039:	e9 dd 07 00 00       	jmp    c010281b <__alltraps>

c010203e <vector75>:
.globl vector75
vector75:
  pushl $0
c010203e:	6a 00                	push   $0x0
  pushl $75
c0102040:	6a 4b                	push   $0x4b
  jmp __alltraps
c0102042:	e9 d4 07 00 00       	jmp    c010281b <__alltraps>

c0102047 <vector76>:
.globl vector76
vector76:
  pushl $0
c0102047:	6a 00                	push   $0x0
  pushl $76
c0102049:	6a 4c                	push   $0x4c
  jmp __alltraps
c010204b:	e9 cb 07 00 00       	jmp    c010281b <__alltraps>

c0102050 <vector77>:
.globl vector77
vector77:
  pushl $0
c0102050:	6a 00                	push   $0x0
  pushl $77
c0102052:	6a 4d                	push   $0x4d
  jmp __alltraps
c0102054:	e9 c2 07 00 00       	jmp    c010281b <__alltraps>

c0102059 <vector78>:
.globl vector78
vector78:
  pushl $0
c0102059:	6a 00                	push   $0x0
  pushl $78
c010205b:	6a 4e                	push   $0x4e
  jmp __alltraps
c010205d:	e9 b9 07 00 00       	jmp    c010281b <__alltraps>

c0102062 <vector79>:
.globl vector79
vector79:
  pushl $0
c0102062:	6a 00                	push   $0x0
  pushl $79
c0102064:	6a 4f                	push   $0x4f
  jmp __alltraps
c0102066:	e9 b0 07 00 00       	jmp    c010281b <__alltraps>

c010206b <vector80>:
.globl vector80
vector80:
  pushl $0
c010206b:	6a 00                	push   $0x0
  pushl $80
c010206d:	6a 50                	push   $0x50
  jmp __alltraps
c010206f:	e9 a7 07 00 00       	jmp    c010281b <__alltraps>

c0102074 <vector81>:
.globl vector81
vector81:
  pushl $0
c0102074:	6a 00                	push   $0x0
  pushl $81
c0102076:	6a 51                	push   $0x51
  jmp __alltraps
c0102078:	e9 9e 07 00 00       	jmp    c010281b <__alltraps>

c010207d <vector82>:
.globl vector82
vector82:
  pushl $0
c010207d:	6a 00                	push   $0x0
  pushl $82
c010207f:	6a 52                	push   $0x52
  jmp __alltraps
c0102081:	e9 95 07 00 00       	jmp    c010281b <__alltraps>

c0102086 <vector83>:
.globl vector83
vector83:
  pushl $0
c0102086:	6a 00                	push   $0x0
  pushl $83
c0102088:	6a 53                	push   $0x53
  jmp __alltraps
c010208a:	e9 8c 07 00 00       	jmp    c010281b <__alltraps>

c010208f <vector84>:
.globl vector84
vector84:
  pushl $0
c010208f:	6a 00                	push   $0x0
  pushl $84
c0102091:	6a 54                	push   $0x54
  jmp __alltraps
c0102093:	e9 83 07 00 00       	jmp    c010281b <__alltraps>

c0102098 <vector85>:
.globl vector85
vector85:
  pushl $0
c0102098:	6a 00                	push   $0x0
  pushl $85
c010209a:	6a 55                	push   $0x55
  jmp __alltraps
c010209c:	e9 7a 07 00 00       	jmp    c010281b <__alltraps>

c01020a1 <vector86>:
.globl vector86
vector86:
  pushl $0
c01020a1:	6a 00                	push   $0x0
  pushl $86
c01020a3:	6a 56                	push   $0x56
  jmp __alltraps
c01020a5:	e9 71 07 00 00       	jmp    c010281b <__alltraps>

c01020aa <vector87>:
.globl vector87
vector87:
  pushl $0
c01020aa:	6a 00                	push   $0x0
  pushl $87
c01020ac:	6a 57                	push   $0x57
  jmp __alltraps
c01020ae:	e9 68 07 00 00       	jmp    c010281b <__alltraps>

c01020b3 <vector88>:
.globl vector88
vector88:
  pushl $0
c01020b3:	6a 00                	push   $0x0
  pushl $88
c01020b5:	6a 58                	push   $0x58
  jmp __alltraps
c01020b7:	e9 5f 07 00 00       	jmp    c010281b <__alltraps>

c01020bc <vector89>:
.globl vector89
vector89:
  pushl $0
c01020bc:	6a 00                	push   $0x0
  pushl $89
c01020be:	6a 59                	push   $0x59
  jmp __alltraps
c01020c0:	e9 56 07 00 00       	jmp    c010281b <__alltraps>

c01020c5 <vector90>:
.globl vector90
vector90:
  pushl $0
c01020c5:	6a 00                	push   $0x0
  pushl $90
c01020c7:	6a 5a                	push   $0x5a
  jmp __alltraps
c01020c9:	e9 4d 07 00 00       	jmp    c010281b <__alltraps>

c01020ce <vector91>:
.globl vector91
vector91:
  pushl $0
c01020ce:	6a 00                	push   $0x0
  pushl $91
c01020d0:	6a 5b                	push   $0x5b
  jmp __alltraps
c01020d2:	e9 44 07 00 00       	jmp    c010281b <__alltraps>

c01020d7 <vector92>:
.globl vector92
vector92:
  pushl $0
c01020d7:	6a 00                	push   $0x0
  pushl $92
c01020d9:	6a 5c                	push   $0x5c
  jmp __alltraps
c01020db:	e9 3b 07 00 00       	jmp    c010281b <__alltraps>

c01020e0 <vector93>:
.globl vector93
vector93:
  pushl $0
c01020e0:	6a 00                	push   $0x0
  pushl $93
c01020e2:	6a 5d                	push   $0x5d
  jmp __alltraps
c01020e4:	e9 32 07 00 00       	jmp    c010281b <__alltraps>

c01020e9 <vector94>:
.globl vector94
vector94:
  pushl $0
c01020e9:	6a 00                	push   $0x0
  pushl $94
c01020eb:	6a 5e                	push   $0x5e
  jmp __alltraps
c01020ed:	e9 29 07 00 00       	jmp    c010281b <__alltraps>

c01020f2 <vector95>:
.globl vector95
vector95:
  pushl $0
c01020f2:	6a 00                	push   $0x0
  pushl $95
c01020f4:	6a 5f                	push   $0x5f
  jmp __alltraps
c01020f6:	e9 20 07 00 00       	jmp    c010281b <__alltraps>

c01020fb <vector96>:
.globl vector96
vector96:
  pushl $0
c01020fb:	6a 00                	push   $0x0
  pushl $96
c01020fd:	6a 60                	push   $0x60
  jmp __alltraps
c01020ff:	e9 17 07 00 00       	jmp    c010281b <__alltraps>

c0102104 <vector97>:
.globl vector97
vector97:
  pushl $0
c0102104:	6a 00                	push   $0x0
  pushl $97
c0102106:	6a 61                	push   $0x61
  jmp __alltraps
c0102108:	e9 0e 07 00 00       	jmp    c010281b <__alltraps>

c010210d <vector98>:
.globl vector98
vector98:
  pushl $0
c010210d:	6a 00                	push   $0x0
  pushl $98
c010210f:	6a 62                	push   $0x62
  jmp __alltraps
c0102111:	e9 05 07 00 00       	jmp    c010281b <__alltraps>

c0102116 <vector99>:
.globl vector99
vector99:
  pushl $0
c0102116:	6a 00                	push   $0x0
  pushl $99
c0102118:	6a 63                	push   $0x63
  jmp __alltraps
c010211a:	e9 fc 06 00 00       	jmp    c010281b <__alltraps>

c010211f <vector100>:
.globl vector100
vector100:
  pushl $0
c010211f:	6a 00                	push   $0x0
  pushl $100
c0102121:	6a 64                	push   $0x64
  jmp __alltraps
c0102123:	e9 f3 06 00 00       	jmp    c010281b <__alltraps>

c0102128 <vector101>:
.globl vector101
vector101:
  pushl $0
c0102128:	6a 00                	push   $0x0
  pushl $101
c010212a:	6a 65                	push   $0x65
  jmp __alltraps
c010212c:	e9 ea 06 00 00       	jmp    c010281b <__alltraps>

c0102131 <vector102>:
.globl vector102
vector102:
  pushl $0
c0102131:	6a 00                	push   $0x0
  pushl $102
c0102133:	6a 66                	push   $0x66
  jmp __alltraps
c0102135:	e9 e1 06 00 00       	jmp    c010281b <__alltraps>

c010213a <vector103>:
.globl vector103
vector103:
  pushl $0
c010213a:	6a 00                	push   $0x0
  pushl $103
c010213c:	6a 67                	push   $0x67
  jmp __alltraps
c010213e:	e9 d8 06 00 00       	jmp    c010281b <__alltraps>

c0102143 <vector104>:
.globl vector104
vector104:
  pushl $0
c0102143:	6a 00                	push   $0x0
  pushl $104
c0102145:	6a 68                	push   $0x68
  jmp __alltraps
c0102147:	e9 cf 06 00 00       	jmp    c010281b <__alltraps>

c010214c <vector105>:
.globl vector105
vector105:
  pushl $0
c010214c:	6a 00                	push   $0x0
  pushl $105
c010214e:	6a 69                	push   $0x69
  jmp __alltraps
c0102150:	e9 c6 06 00 00       	jmp    c010281b <__alltraps>

c0102155 <vector106>:
.globl vector106
vector106:
  pushl $0
c0102155:	6a 00                	push   $0x0
  pushl $106
c0102157:	6a 6a                	push   $0x6a
  jmp __alltraps
c0102159:	e9 bd 06 00 00       	jmp    c010281b <__alltraps>

c010215e <vector107>:
.globl vector107
vector107:
  pushl $0
c010215e:	6a 00                	push   $0x0
  pushl $107
c0102160:	6a 6b                	push   $0x6b
  jmp __alltraps
c0102162:	e9 b4 06 00 00       	jmp    c010281b <__alltraps>

c0102167 <vector108>:
.globl vector108
vector108:
  pushl $0
c0102167:	6a 00                	push   $0x0
  pushl $108
c0102169:	6a 6c                	push   $0x6c
  jmp __alltraps
c010216b:	e9 ab 06 00 00       	jmp    c010281b <__alltraps>

c0102170 <vector109>:
.globl vector109
vector109:
  pushl $0
c0102170:	6a 00                	push   $0x0
  pushl $109
c0102172:	6a 6d                	push   $0x6d
  jmp __alltraps
c0102174:	e9 a2 06 00 00       	jmp    c010281b <__alltraps>

c0102179 <vector110>:
.globl vector110
vector110:
  pushl $0
c0102179:	6a 00                	push   $0x0
  pushl $110
c010217b:	6a 6e                	push   $0x6e
  jmp __alltraps
c010217d:	e9 99 06 00 00       	jmp    c010281b <__alltraps>

c0102182 <vector111>:
.globl vector111
vector111:
  pushl $0
c0102182:	6a 00                	push   $0x0
  pushl $111
c0102184:	6a 6f                	push   $0x6f
  jmp __alltraps
c0102186:	e9 90 06 00 00       	jmp    c010281b <__alltraps>

c010218b <vector112>:
.globl vector112
vector112:
  pushl $0
c010218b:	6a 00                	push   $0x0
  pushl $112
c010218d:	6a 70                	push   $0x70
  jmp __alltraps
c010218f:	e9 87 06 00 00       	jmp    c010281b <__alltraps>

c0102194 <vector113>:
.globl vector113
vector113:
  pushl $0
c0102194:	6a 00                	push   $0x0
  pushl $113
c0102196:	6a 71                	push   $0x71
  jmp __alltraps
c0102198:	e9 7e 06 00 00       	jmp    c010281b <__alltraps>

c010219d <vector114>:
.globl vector114
vector114:
  pushl $0
c010219d:	6a 00                	push   $0x0
  pushl $114
c010219f:	6a 72                	push   $0x72
  jmp __alltraps
c01021a1:	e9 75 06 00 00       	jmp    c010281b <__alltraps>

c01021a6 <vector115>:
.globl vector115
vector115:
  pushl $0
c01021a6:	6a 00                	push   $0x0
  pushl $115
c01021a8:	6a 73                	push   $0x73
  jmp __alltraps
c01021aa:	e9 6c 06 00 00       	jmp    c010281b <__alltraps>

c01021af <vector116>:
.globl vector116
vector116:
  pushl $0
c01021af:	6a 00                	push   $0x0
  pushl $116
c01021b1:	6a 74                	push   $0x74
  jmp __alltraps
c01021b3:	e9 63 06 00 00       	jmp    c010281b <__alltraps>

c01021b8 <vector117>:
.globl vector117
vector117:
  pushl $0
c01021b8:	6a 00                	push   $0x0
  pushl $117
c01021ba:	6a 75                	push   $0x75
  jmp __alltraps
c01021bc:	e9 5a 06 00 00       	jmp    c010281b <__alltraps>

c01021c1 <vector118>:
.globl vector118
vector118:
  pushl $0
c01021c1:	6a 00                	push   $0x0
  pushl $118
c01021c3:	6a 76                	push   $0x76
  jmp __alltraps
c01021c5:	e9 51 06 00 00       	jmp    c010281b <__alltraps>

c01021ca <vector119>:
.globl vector119
vector119:
  pushl $0
c01021ca:	6a 00                	push   $0x0
  pushl $119
c01021cc:	6a 77                	push   $0x77
  jmp __alltraps
c01021ce:	e9 48 06 00 00       	jmp    c010281b <__alltraps>

c01021d3 <vector120>:
.globl vector120
vector120:
  pushl $0
c01021d3:	6a 00                	push   $0x0
  pushl $120
c01021d5:	6a 78                	push   $0x78
  jmp __alltraps
c01021d7:	e9 3f 06 00 00       	jmp    c010281b <__alltraps>

c01021dc <vector121>:
.globl vector121
vector121:
  pushl $0
c01021dc:	6a 00                	push   $0x0
  pushl $121
c01021de:	6a 79                	push   $0x79
  jmp __alltraps
c01021e0:	e9 36 06 00 00       	jmp    c010281b <__alltraps>

c01021e5 <vector122>:
.globl vector122
vector122:
  pushl $0
c01021e5:	6a 00                	push   $0x0
  pushl $122
c01021e7:	6a 7a                	push   $0x7a
  jmp __alltraps
c01021e9:	e9 2d 06 00 00       	jmp    c010281b <__alltraps>

c01021ee <vector123>:
.globl vector123
vector123:
  pushl $0
c01021ee:	6a 00                	push   $0x0
  pushl $123
c01021f0:	6a 7b                	push   $0x7b
  jmp __alltraps
c01021f2:	e9 24 06 00 00       	jmp    c010281b <__alltraps>

c01021f7 <vector124>:
.globl vector124
vector124:
  pushl $0
c01021f7:	6a 00                	push   $0x0
  pushl $124
c01021f9:	6a 7c                	push   $0x7c
  jmp __alltraps
c01021fb:	e9 1b 06 00 00       	jmp    c010281b <__alltraps>

c0102200 <vector125>:
.globl vector125
vector125:
  pushl $0
c0102200:	6a 00                	push   $0x0
  pushl $125
c0102202:	6a 7d                	push   $0x7d
  jmp __alltraps
c0102204:	e9 12 06 00 00       	jmp    c010281b <__alltraps>

c0102209 <vector126>:
.globl vector126
vector126:
  pushl $0
c0102209:	6a 00                	push   $0x0
  pushl $126
c010220b:	6a 7e                	push   $0x7e
  jmp __alltraps
c010220d:	e9 09 06 00 00       	jmp    c010281b <__alltraps>

c0102212 <vector127>:
.globl vector127
vector127:
  pushl $0
c0102212:	6a 00                	push   $0x0
  pushl $127
c0102214:	6a 7f                	push   $0x7f
  jmp __alltraps
c0102216:	e9 00 06 00 00       	jmp    c010281b <__alltraps>

c010221b <vector128>:
.globl vector128
vector128:
  pushl $0
c010221b:	6a 00                	push   $0x0
  pushl $128
c010221d:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
c0102222:	e9 f4 05 00 00       	jmp    c010281b <__alltraps>

c0102227 <vector129>:
.globl vector129
vector129:
  pushl $0
c0102227:	6a 00                	push   $0x0
  pushl $129
c0102229:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
c010222e:	e9 e8 05 00 00       	jmp    c010281b <__alltraps>

c0102233 <vector130>:
.globl vector130
vector130:
  pushl $0
c0102233:	6a 00                	push   $0x0
  pushl $130
c0102235:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
c010223a:	e9 dc 05 00 00       	jmp    c010281b <__alltraps>

c010223f <vector131>:
.globl vector131
vector131:
  pushl $0
c010223f:	6a 00                	push   $0x0
  pushl $131
c0102241:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
c0102246:	e9 d0 05 00 00       	jmp    c010281b <__alltraps>

c010224b <vector132>:
.globl vector132
vector132:
  pushl $0
c010224b:	6a 00                	push   $0x0
  pushl $132
c010224d:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
c0102252:	e9 c4 05 00 00       	jmp    c010281b <__alltraps>

c0102257 <vector133>:
.globl vector133
vector133:
  pushl $0
c0102257:	6a 00                	push   $0x0
  pushl $133
c0102259:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
c010225e:	e9 b8 05 00 00       	jmp    c010281b <__alltraps>

c0102263 <vector134>:
.globl vector134
vector134:
  pushl $0
c0102263:	6a 00                	push   $0x0
  pushl $134
c0102265:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
c010226a:	e9 ac 05 00 00       	jmp    c010281b <__alltraps>

c010226f <vector135>:
.globl vector135
vector135:
  pushl $0
c010226f:	6a 00                	push   $0x0
  pushl $135
c0102271:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
c0102276:	e9 a0 05 00 00       	jmp    c010281b <__alltraps>

c010227b <vector136>:
.globl vector136
vector136:
  pushl $0
c010227b:	6a 00                	push   $0x0
  pushl $136
c010227d:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
c0102282:	e9 94 05 00 00       	jmp    c010281b <__alltraps>

c0102287 <vector137>:
.globl vector137
vector137:
  pushl $0
c0102287:	6a 00                	push   $0x0
  pushl $137
c0102289:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
c010228e:	e9 88 05 00 00       	jmp    c010281b <__alltraps>

c0102293 <vector138>:
.globl vector138
vector138:
  pushl $0
c0102293:	6a 00                	push   $0x0
  pushl $138
c0102295:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
c010229a:	e9 7c 05 00 00       	jmp    c010281b <__alltraps>

c010229f <vector139>:
.globl vector139
vector139:
  pushl $0
c010229f:	6a 00                	push   $0x0
  pushl $139
c01022a1:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
c01022a6:	e9 70 05 00 00       	jmp    c010281b <__alltraps>

c01022ab <vector140>:
.globl vector140
vector140:
  pushl $0
c01022ab:	6a 00                	push   $0x0
  pushl $140
c01022ad:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
c01022b2:	e9 64 05 00 00       	jmp    c010281b <__alltraps>

c01022b7 <vector141>:
.globl vector141
vector141:
  pushl $0
c01022b7:	6a 00                	push   $0x0
  pushl $141
c01022b9:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
c01022be:	e9 58 05 00 00       	jmp    c010281b <__alltraps>

c01022c3 <vector142>:
.globl vector142
vector142:
  pushl $0
c01022c3:	6a 00                	push   $0x0
  pushl $142
c01022c5:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
c01022ca:	e9 4c 05 00 00       	jmp    c010281b <__alltraps>

c01022cf <vector143>:
.globl vector143
vector143:
  pushl $0
c01022cf:	6a 00                	push   $0x0
  pushl $143
c01022d1:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
c01022d6:	e9 40 05 00 00       	jmp    c010281b <__alltraps>

c01022db <vector144>:
.globl vector144
vector144:
  pushl $0
c01022db:	6a 00                	push   $0x0
  pushl $144
c01022dd:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
c01022e2:	e9 34 05 00 00       	jmp    c010281b <__alltraps>

c01022e7 <vector145>:
.globl vector145
vector145:
  pushl $0
c01022e7:	6a 00                	push   $0x0
  pushl $145
c01022e9:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
c01022ee:	e9 28 05 00 00       	jmp    c010281b <__alltraps>

c01022f3 <vector146>:
.globl vector146
vector146:
  pushl $0
c01022f3:	6a 00                	push   $0x0
  pushl $146
c01022f5:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
c01022fa:	e9 1c 05 00 00       	jmp    c010281b <__alltraps>

c01022ff <vector147>:
.globl vector147
vector147:
  pushl $0
c01022ff:	6a 00                	push   $0x0
  pushl $147
c0102301:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
c0102306:	e9 10 05 00 00       	jmp    c010281b <__alltraps>

c010230b <vector148>:
.globl vector148
vector148:
  pushl $0
c010230b:	6a 00                	push   $0x0
  pushl $148
c010230d:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
c0102312:	e9 04 05 00 00       	jmp    c010281b <__alltraps>

c0102317 <vector149>:
.globl vector149
vector149:
  pushl $0
c0102317:	6a 00                	push   $0x0
  pushl $149
c0102319:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
c010231e:	e9 f8 04 00 00       	jmp    c010281b <__alltraps>

c0102323 <vector150>:
.globl vector150
vector150:
  pushl $0
c0102323:	6a 00                	push   $0x0
  pushl $150
c0102325:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
c010232a:	e9 ec 04 00 00       	jmp    c010281b <__alltraps>

c010232f <vector151>:
.globl vector151
vector151:
  pushl $0
c010232f:	6a 00                	push   $0x0
  pushl $151
c0102331:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
c0102336:	e9 e0 04 00 00       	jmp    c010281b <__alltraps>

c010233b <vector152>:
.globl vector152
vector152:
  pushl $0
c010233b:	6a 00                	push   $0x0
  pushl $152
c010233d:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
c0102342:	e9 d4 04 00 00       	jmp    c010281b <__alltraps>

c0102347 <vector153>:
.globl vector153
vector153:
  pushl $0
c0102347:	6a 00                	push   $0x0
  pushl $153
c0102349:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
c010234e:	e9 c8 04 00 00       	jmp    c010281b <__alltraps>

c0102353 <vector154>:
.globl vector154
vector154:
  pushl $0
c0102353:	6a 00                	push   $0x0
  pushl $154
c0102355:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
c010235a:	e9 bc 04 00 00       	jmp    c010281b <__alltraps>

c010235f <vector155>:
.globl vector155
vector155:
  pushl $0
c010235f:	6a 00                	push   $0x0
  pushl $155
c0102361:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
c0102366:	e9 b0 04 00 00       	jmp    c010281b <__alltraps>

c010236b <vector156>:
.globl vector156
vector156:
  pushl $0
c010236b:	6a 00                	push   $0x0
  pushl $156
c010236d:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
c0102372:	e9 a4 04 00 00       	jmp    c010281b <__alltraps>

c0102377 <vector157>:
.globl vector157
vector157:
  pushl $0
c0102377:	6a 00                	push   $0x0
  pushl $157
c0102379:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
c010237e:	e9 98 04 00 00       	jmp    c010281b <__alltraps>

c0102383 <vector158>:
.globl vector158
vector158:
  pushl $0
c0102383:	6a 00                	push   $0x0
  pushl $158
c0102385:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
c010238a:	e9 8c 04 00 00       	jmp    c010281b <__alltraps>

c010238f <vector159>:
.globl vector159
vector159:
  pushl $0
c010238f:	6a 00                	push   $0x0
  pushl $159
c0102391:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
c0102396:	e9 80 04 00 00       	jmp    c010281b <__alltraps>

c010239b <vector160>:
.globl vector160
vector160:
  pushl $0
c010239b:	6a 00                	push   $0x0
  pushl $160
c010239d:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
c01023a2:	e9 74 04 00 00       	jmp    c010281b <__alltraps>

c01023a7 <vector161>:
.globl vector161
vector161:
  pushl $0
c01023a7:	6a 00                	push   $0x0
  pushl $161
c01023a9:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
c01023ae:	e9 68 04 00 00       	jmp    c010281b <__alltraps>

c01023b3 <vector162>:
.globl vector162
vector162:
  pushl $0
c01023b3:	6a 00                	push   $0x0
  pushl $162
c01023b5:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
c01023ba:	e9 5c 04 00 00       	jmp    c010281b <__alltraps>

c01023bf <vector163>:
.globl vector163
vector163:
  pushl $0
c01023bf:	6a 00                	push   $0x0
  pushl $163
c01023c1:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
c01023c6:	e9 50 04 00 00       	jmp    c010281b <__alltraps>

c01023cb <vector164>:
.globl vector164
vector164:
  pushl $0
c01023cb:	6a 00                	push   $0x0
  pushl $164
c01023cd:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
c01023d2:	e9 44 04 00 00       	jmp    c010281b <__alltraps>

c01023d7 <vector165>:
.globl vector165
vector165:
  pushl $0
c01023d7:	6a 00                	push   $0x0
  pushl $165
c01023d9:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
c01023de:	e9 38 04 00 00       	jmp    c010281b <__alltraps>

c01023e3 <vector166>:
.globl vector166
vector166:
  pushl $0
c01023e3:	6a 00                	push   $0x0
  pushl $166
c01023e5:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
c01023ea:	e9 2c 04 00 00       	jmp    c010281b <__alltraps>

c01023ef <vector167>:
.globl vector167
vector167:
  pushl $0
c01023ef:	6a 00                	push   $0x0
  pushl $167
c01023f1:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
c01023f6:	e9 20 04 00 00       	jmp    c010281b <__alltraps>

c01023fb <vector168>:
.globl vector168
vector168:
  pushl $0
c01023fb:	6a 00                	push   $0x0
  pushl $168
c01023fd:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
c0102402:	e9 14 04 00 00       	jmp    c010281b <__alltraps>

c0102407 <vector169>:
.globl vector169
vector169:
  pushl $0
c0102407:	6a 00                	push   $0x0
  pushl $169
c0102409:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
c010240e:	e9 08 04 00 00       	jmp    c010281b <__alltraps>

c0102413 <vector170>:
.globl vector170
vector170:
  pushl $0
c0102413:	6a 00                	push   $0x0
  pushl $170
c0102415:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
c010241a:	e9 fc 03 00 00       	jmp    c010281b <__alltraps>

c010241f <vector171>:
.globl vector171
vector171:
  pushl $0
c010241f:	6a 00                	push   $0x0
  pushl $171
c0102421:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
c0102426:	e9 f0 03 00 00       	jmp    c010281b <__alltraps>

c010242b <vector172>:
.globl vector172
vector172:
  pushl $0
c010242b:	6a 00                	push   $0x0
  pushl $172
c010242d:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
c0102432:	e9 e4 03 00 00       	jmp    c010281b <__alltraps>

c0102437 <vector173>:
.globl vector173
vector173:
  pushl $0
c0102437:	6a 00                	push   $0x0
  pushl $173
c0102439:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
c010243e:	e9 d8 03 00 00       	jmp    c010281b <__alltraps>

c0102443 <vector174>:
.globl vector174
vector174:
  pushl $0
c0102443:	6a 00                	push   $0x0
  pushl $174
c0102445:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
c010244a:	e9 cc 03 00 00       	jmp    c010281b <__alltraps>

c010244f <vector175>:
.globl vector175
vector175:
  pushl $0
c010244f:	6a 00                	push   $0x0
  pushl $175
c0102451:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
c0102456:	e9 c0 03 00 00       	jmp    c010281b <__alltraps>

c010245b <vector176>:
.globl vector176
vector176:
  pushl $0
c010245b:	6a 00                	push   $0x0
  pushl $176
c010245d:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
c0102462:	e9 b4 03 00 00       	jmp    c010281b <__alltraps>

c0102467 <vector177>:
.globl vector177
vector177:
  pushl $0
c0102467:	6a 00                	push   $0x0
  pushl $177
c0102469:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
c010246e:	e9 a8 03 00 00       	jmp    c010281b <__alltraps>

c0102473 <vector178>:
.globl vector178
vector178:
  pushl $0
c0102473:	6a 00                	push   $0x0
  pushl $178
c0102475:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
c010247a:	e9 9c 03 00 00       	jmp    c010281b <__alltraps>

c010247f <vector179>:
.globl vector179
vector179:
  pushl $0
c010247f:	6a 00                	push   $0x0
  pushl $179
c0102481:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
c0102486:	e9 90 03 00 00       	jmp    c010281b <__alltraps>

c010248b <vector180>:
.globl vector180
vector180:
  pushl $0
c010248b:	6a 00                	push   $0x0
  pushl $180
c010248d:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
c0102492:	e9 84 03 00 00       	jmp    c010281b <__alltraps>

c0102497 <vector181>:
.globl vector181
vector181:
  pushl $0
c0102497:	6a 00                	push   $0x0
  pushl $181
c0102499:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
c010249e:	e9 78 03 00 00       	jmp    c010281b <__alltraps>

c01024a3 <vector182>:
.globl vector182
vector182:
  pushl $0
c01024a3:	6a 00                	push   $0x0
  pushl $182
c01024a5:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
c01024aa:	e9 6c 03 00 00       	jmp    c010281b <__alltraps>

c01024af <vector183>:
.globl vector183
vector183:
  pushl $0
c01024af:	6a 00                	push   $0x0
  pushl $183
c01024b1:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
c01024b6:	e9 60 03 00 00       	jmp    c010281b <__alltraps>

c01024bb <vector184>:
.globl vector184
vector184:
  pushl $0
c01024bb:	6a 00                	push   $0x0
  pushl $184
c01024bd:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
c01024c2:	e9 54 03 00 00       	jmp    c010281b <__alltraps>

c01024c7 <vector185>:
.globl vector185
vector185:
  pushl $0
c01024c7:	6a 00                	push   $0x0
  pushl $185
c01024c9:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
c01024ce:	e9 48 03 00 00       	jmp    c010281b <__alltraps>

c01024d3 <vector186>:
.globl vector186
vector186:
  pushl $0
c01024d3:	6a 00                	push   $0x0
  pushl $186
c01024d5:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
c01024da:	e9 3c 03 00 00       	jmp    c010281b <__alltraps>

c01024df <vector187>:
.globl vector187
vector187:
  pushl $0
c01024df:	6a 00                	push   $0x0
  pushl $187
c01024e1:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
c01024e6:	e9 30 03 00 00       	jmp    c010281b <__alltraps>

c01024eb <vector188>:
.globl vector188
vector188:
  pushl $0
c01024eb:	6a 00                	push   $0x0
  pushl $188
c01024ed:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
c01024f2:	e9 24 03 00 00       	jmp    c010281b <__alltraps>

c01024f7 <vector189>:
.globl vector189
vector189:
  pushl $0
c01024f7:	6a 00                	push   $0x0
  pushl $189
c01024f9:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
c01024fe:	e9 18 03 00 00       	jmp    c010281b <__alltraps>

c0102503 <vector190>:
.globl vector190
vector190:
  pushl $0
c0102503:	6a 00                	push   $0x0
  pushl $190
c0102505:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
c010250a:	e9 0c 03 00 00       	jmp    c010281b <__alltraps>

c010250f <vector191>:
.globl vector191
vector191:
  pushl $0
c010250f:	6a 00                	push   $0x0
  pushl $191
c0102511:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
c0102516:	e9 00 03 00 00       	jmp    c010281b <__alltraps>

c010251b <vector192>:
.globl vector192
vector192:
  pushl $0
c010251b:	6a 00                	push   $0x0
  pushl $192
c010251d:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
c0102522:	e9 f4 02 00 00       	jmp    c010281b <__alltraps>

c0102527 <vector193>:
.globl vector193
vector193:
  pushl $0
c0102527:	6a 00                	push   $0x0
  pushl $193
c0102529:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
c010252e:	e9 e8 02 00 00       	jmp    c010281b <__alltraps>

c0102533 <vector194>:
.globl vector194
vector194:
  pushl $0
c0102533:	6a 00                	push   $0x0
  pushl $194
c0102535:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
c010253a:	e9 dc 02 00 00       	jmp    c010281b <__alltraps>

c010253f <vector195>:
.globl vector195
vector195:
  pushl $0
c010253f:	6a 00                	push   $0x0
  pushl $195
c0102541:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
c0102546:	e9 d0 02 00 00       	jmp    c010281b <__alltraps>

c010254b <vector196>:
.globl vector196
vector196:
  pushl $0
c010254b:	6a 00                	push   $0x0
  pushl $196
c010254d:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
c0102552:	e9 c4 02 00 00       	jmp    c010281b <__alltraps>

c0102557 <vector197>:
.globl vector197
vector197:
  pushl $0
c0102557:	6a 00                	push   $0x0
  pushl $197
c0102559:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
c010255e:	e9 b8 02 00 00       	jmp    c010281b <__alltraps>

c0102563 <vector198>:
.globl vector198
vector198:
  pushl $0
c0102563:	6a 00                	push   $0x0
  pushl $198
c0102565:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
c010256a:	e9 ac 02 00 00       	jmp    c010281b <__alltraps>

c010256f <vector199>:
.globl vector199
vector199:
  pushl $0
c010256f:	6a 00                	push   $0x0
  pushl $199
c0102571:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
c0102576:	e9 a0 02 00 00       	jmp    c010281b <__alltraps>

c010257b <vector200>:
.globl vector200
vector200:
  pushl $0
c010257b:	6a 00                	push   $0x0
  pushl $200
c010257d:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
c0102582:	e9 94 02 00 00       	jmp    c010281b <__alltraps>

c0102587 <vector201>:
.globl vector201
vector201:
  pushl $0
c0102587:	6a 00                	push   $0x0
  pushl $201
c0102589:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
c010258e:	e9 88 02 00 00       	jmp    c010281b <__alltraps>

c0102593 <vector202>:
.globl vector202
vector202:
  pushl $0
c0102593:	6a 00                	push   $0x0
  pushl $202
c0102595:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
c010259a:	e9 7c 02 00 00       	jmp    c010281b <__alltraps>

c010259f <vector203>:
.globl vector203
vector203:
  pushl $0
c010259f:	6a 00                	push   $0x0
  pushl $203
c01025a1:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
c01025a6:	e9 70 02 00 00       	jmp    c010281b <__alltraps>

c01025ab <vector204>:
.globl vector204
vector204:
  pushl $0
c01025ab:	6a 00                	push   $0x0
  pushl $204
c01025ad:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
c01025b2:	e9 64 02 00 00       	jmp    c010281b <__alltraps>

c01025b7 <vector205>:
.globl vector205
vector205:
  pushl $0
c01025b7:	6a 00                	push   $0x0
  pushl $205
c01025b9:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
c01025be:	e9 58 02 00 00       	jmp    c010281b <__alltraps>

c01025c3 <vector206>:
.globl vector206
vector206:
  pushl $0
c01025c3:	6a 00                	push   $0x0
  pushl $206
c01025c5:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
c01025ca:	e9 4c 02 00 00       	jmp    c010281b <__alltraps>

c01025cf <vector207>:
.globl vector207
vector207:
  pushl $0
c01025cf:	6a 00                	push   $0x0
  pushl $207
c01025d1:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
c01025d6:	e9 40 02 00 00       	jmp    c010281b <__alltraps>

c01025db <vector208>:
.globl vector208
vector208:
  pushl $0
c01025db:	6a 00                	push   $0x0
  pushl $208
c01025dd:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
c01025e2:	e9 34 02 00 00       	jmp    c010281b <__alltraps>

c01025e7 <vector209>:
.globl vector209
vector209:
  pushl $0
c01025e7:	6a 00                	push   $0x0
  pushl $209
c01025e9:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
c01025ee:	e9 28 02 00 00       	jmp    c010281b <__alltraps>

c01025f3 <vector210>:
.globl vector210
vector210:
  pushl $0
c01025f3:	6a 00                	push   $0x0
  pushl $210
c01025f5:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
c01025fa:	e9 1c 02 00 00       	jmp    c010281b <__alltraps>

c01025ff <vector211>:
.globl vector211
vector211:
  pushl $0
c01025ff:	6a 00                	push   $0x0
  pushl $211
c0102601:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
c0102606:	e9 10 02 00 00       	jmp    c010281b <__alltraps>

c010260b <vector212>:
.globl vector212
vector212:
  pushl $0
c010260b:	6a 00                	push   $0x0
  pushl $212
c010260d:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
c0102612:	e9 04 02 00 00       	jmp    c010281b <__alltraps>

c0102617 <vector213>:
.globl vector213
vector213:
  pushl $0
c0102617:	6a 00                	push   $0x0
  pushl $213
c0102619:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
c010261e:	e9 f8 01 00 00       	jmp    c010281b <__alltraps>

c0102623 <vector214>:
.globl vector214
vector214:
  pushl $0
c0102623:	6a 00                	push   $0x0
  pushl $214
c0102625:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
c010262a:	e9 ec 01 00 00       	jmp    c010281b <__alltraps>

c010262f <vector215>:
.globl vector215
vector215:
  pushl $0
c010262f:	6a 00                	push   $0x0
  pushl $215
c0102631:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
c0102636:	e9 e0 01 00 00       	jmp    c010281b <__alltraps>

c010263b <vector216>:
.globl vector216
vector216:
  pushl $0
c010263b:	6a 00                	push   $0x0
  pushl $216
c010263d:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
c0102642:	e9 d4 01 00 00       	jmp    c010281b <__alltraps>

c0102647 <vector217>:
.globl vector217
vector217:
  pushl $0
c0102647:	6a 00                	push   $0x0
  pushl $217
c0102649:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
c010264e:	e9 c8 01 00 00       	jmp    c010281b <__alltraps>

c0102653 <vector218>:
.globl vector218
vector218:
  pushl $0
c0102653:	6a 00                	push   $0x0
  pushl $218
c0102655:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
c010265a:	e9 bc 01 00 00       	jmp    c010281b <__alltraps>

c010265f <vector219>:
.globl vector219
vector219:
  pushl $0
c010265f:	6a 00                	push   $0x0
  pushl $219
c0102661:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
c0102666:	e9 b0 01 00 00       	jmp    c010281b <__alltraps>

c010266b <vector220>:
.globl vector220
vector220:
  pushl $0
c010266b:	6a 00                	push   $0x0
  pushl $220
c010266d:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
c0102672:	e9 a4 01 00 00       	jmp    c010281b <__alltraps>

c0102677 <vector221>:
.globl vector221
vector221:
  pushl $0
c0102677:	6a 00                	push   $0x0
  pushl $221
c0102679:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
c010267e:	e9 98 01 00 00       	jmp    c010281b <__alltraps>

c0102683 <vector222>:
.globl vector222
vector222:
  pushl $0
c0102683:	6a 00                	push   $0x0
  pushl $222
c0102685:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
c010268a:	e9 8c 01 00 00       	jmp    c010281b <__alltraps>

c010268f <vector223>:
.globl vector223
vector223:
  pushl $0
c010268f:	6a 00                	push   $0x0
  pushl $223
c0102691:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
c0102696:	e9 80 01 00 00       	jmp    c010281b <__alltraps>

c010269b <vector224>:
.globl vector224
vector224:
  pushl $0
c010269b:	6a 00                	push   $0x0
  pushl $224
c010269d:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
c01026a2:	e9 74 01 00 00       	jmp    c010281b <__alltraps>

c01026a7 <vector225>:
.globl vector225
vector225:
  pushl $0
c01026a7:	6a 00                	push   $0x0
  pushl $225
c01026a9:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
c01026ae:	e9 68 01 00 00       	jmp    c010281b <__alltraps>

c01026b3 <vector226>:
.globl vector226
vector226:
  pushl $0
c01026b3:	6a 00                	push   $0x0
  pushl $226
c01026b5:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
c01026ba:	e9 5c 01 00 00       	jmp    c010281b <__alltraps>

c01026bf <vector227>:
.globl vector227
vector227:
  pushl $0
c01026bf:	6a 00                	push   $0x0
  pushl $227
c01026c1:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
c01026c6:	e9 50 01 00 00       	jmp    c010281b <__alltraps>

c01026cb <vector228>:
.globl vector228
vector228:
  pushl $0
c01026cb:	6a 00                	push   $0x0
  pushl $228
c01026cd:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
c01026d2:	e9 44 01 00 00       	jmp    c010281b <__alltraps>

c01026d7 <vector229>:
.globl vector229
vector229:
  pushl $0
c01026d7:	6a 00                	push   $0x0
  pushl $229
c01026d9:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
c01026de:	e9 38 01 00 00       	jmp    c010281b <__alltraps>

c01026e3 <vector230>:
.globl vector230
vector230:
  pushl $0
c01026e3:	6a 00                	push   $0x0
  pushl $230
c01026e5:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
c01026ea:	e9 2c 01 00 00       	jmp    c010281b <__alltraps>

c01026ef <vector231>:
.globl vector231
vector231:
  pushl $0
c01026ef:	6a 00                	push   $0x0
  pushl $231
c01026f1:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
c01026f6:	e9 20 01 00 00       	jmp    c010281b <__alltraps>

c01026fb <vector232>:
.globl vector232
vector232:
  pushl $0
c01026fb:	6a 00                	push   $0x0
  pushl $232
c01026fd:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
c0102702:	e9 14 01 00 00       	jmp    c010281b <__alltraps>

c0102707 <vector233>:
.globl vector233
vector233:
  pushl $0
c0102707:	6a 00                	push   $0x0
  pushl $233
c0102709:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
c010270e:	e9 08 01 00 00       	jmp    c010281b <__alltraps>

c0102713 <vector234>:
.globl vector234
vector234:
  pushl $0
c0102713:	6a 00                	push   $0x0
  pushl $234
c0102715:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
c010271a:	e9 fc 00 00 00       	jmp    c010281b <__alltraps>

c010271f <vector235>:
.globl vector235
vector235:
  pushl $0
c010271f:	6a 00                	push   $0x0
  pushl $235
c0102721:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
c0102726:	e9 f0 00 00 00       	jmp    c010281b <__alltraps>

c010272b <vector236>:
.globl vector236
vector236:
  pushl $0
c010272b:	6a 00                	push   $0x0
  pushl $236
c010272d:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
c0102732:	e9 e4 00 00 00       	jmp    c010281b <__alltraps>

c0102737 <vector237>:
.globl vector237
vector237:
  pushl $0
c0102737:	6a 00                	push   $0x0
  pushl $237
c0102739:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
c010273e:	e9 d8 00 00 00       	jmp    c010281b <__alltraps>

c0102743 <vector238>:
.globl vector238
vector238:
  pushl $0
c0102743:	6a 00                	push   $0x0
  pushl $238
c0102745:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
c010274a:	e9 cc 00 00 00       	jmp    c010281b <__alltraps>

c010274f <vector239>:
.globl vector239
vector239:
  pushl $0
c010274f:	6a 00                	push   $0x0
  pushl $239
c0102751:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
c0102756:	e9 c0 00 00 00       	jmp    c010281b <__alltraps>

c010275b <vector240>:
.globl vector240
vector240:
  pushl $0
c010275b:	6a 00                	push   $0x0
  pushl $240
c010275d:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
c0102762:	e9 b4 00 00 00       	jmp    c010281b <__alltraps>

c0102767 <vector241>:
.globl vector241
vector241:
  pushl $0
c0102767:	6a 00                	push   $0x0
  pushl $241
c0102769:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
c010276e:	e9 a8 00 00 00       	jmp    c010281b <__alltraps>

c0102773 <vector242>:
.globl vector242
vector242:
  pushl $0
c0102773:	6a 00                	push   $0x0
  pushl $242
c0102775:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
c010277a:	e9 9c 00 00 00       	jmp    c010281b <__alltraps>

c010277f <vector243>:
.globl vector243
vector243:
  pushl $0
c010277f:	6a 00                	push   $0x0
  pushl $243
c0102781:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
c0102786:	e9 90 00 00 00       	jmp    c010281b <__alltraps>

c010278b <vector244>:
.globl vector244
vector244:
  pushl $0
c010278b:	6a 00                	push   $0x0
  pushl $244
c010278d:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
c0102792:	e9 84 00 00 00       	jmp    c010281b <__alltraps>

c0102797 <vector245>:
.globl vector245
vector245:
  pushl $0
c0102797:	6a 00                	push   $0x0
  pushl $245
c0102799:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
c010279e:	e9 78 00 00 00       	jmp    c010281b <__alltraps>

c01027a3 <vector246>:
.globl vector246
vector246:
  pushl $0
c01027a3:	6a 00                	push   $0x0
  pushl $246
c01027a5:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
c01027aa:	e9 6c 00 00 00       	jmp    c010281b <__alltraps>

c01027af <vector247>:
.globl vector247
vector247:
  pushl $0
c01027af:	6a 00                	push   $0x0
  pushl $247
c01027b1:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
c01027b6:	e9 60 00 00 00       	jmp    c010281b <__alltraps>

c01027bb <vector248>:
.globl vector248
vector248:
  pushl $0
c01027bb:	6a 00                	push   $0x0
  pushl $248
c01027bd:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
c01027c2:	e9 54 00 00 00       	jmp    c010281b <__alltraps>

c01027c7 <vector249>:
.globl vector249
vector249:
  pushl $0
c01027c7:	6a 00                	push   $0x0
  pushl $249
c01027c9:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
c01027ce:	e9 48 00 00 00       	jmp    c010281b <__alltraps>

c01027d3 <vector250>:
.globl vector250
vector250:
  pushl $0
c01027d3:	6a 00                	push   $0x0
  pushl $250
c01027d5:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
c01027da:	e9 3c 00 00 00       	jmp    c010281b <__alltraps>

c01027df <vector251>:
.globl vector251
vector251:
  pushl $0
c01027df:	6a 00                	push   $0x0
  pushl $251
c01027e1:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
c01027e6:	e9 30 00 00 00       	jmp    c010281b <__alltraps>

c01027eb <vector252>:
.globl vector252
vector252:
  pushl $0
c01027eb:	6a 00                	push   $0x0
  pushl $252
c01027ed:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
c01027f2:	e9 24 00 00 00       	jmp    c010281b <__alltraps>

c01027f7 <vector253>:
.globl vector253
vector253:
  pushl $0
c01027f7:	6a 00                	push   $0x0
  pushl $253
c01027f9:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
c01027fe:	e9 18 00 00 00       	jmp    c010281b <__alltraps>

c0102803 <vector254>:
.globl vector254
vector254:
  pushl $0
c0102803:	6a 00                	push   $0x0
  pushl $254
c0102805:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
c010280a:	e9 0c 00 00 00       	jmp    c010281b <__alltraps>

c010280f <vector255>:
.globl vector255
vector255:
  pushl $0
c010280f:	6a 00                	push   $0x0
  pushl $255
c0102811:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
c0102816:	e9 00 00 00 00       	jmp    c010281b <__alltraps>

c010281b <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
c010281b:	1e                   	push   %ds
    pushl %es
c010281c:	06                   	push   %es
    pushl %fs
c010281d:	0f a0                	push   %fs
    pushl %gs
c010281f:	0f a8                	push   %gs
    pushal
c0102821:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
c0102822:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c0102827:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c0102829:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
c010282b:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
c010282c:	e8 63 f5 ff ff       	call   c0101d94 <trap>

    # pop the pushed stack pointer
    popl %esp
c0102831:	5c                   	pop    %esp

c0102832 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
c0102832:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
c0102833:	0f a9                	pop    %gs
    popl %fs
c0102835:	0f a1                	pop    %fs
    popl %es
c0102837:	07                   	pop    %es
    popl %ds
c0102838:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
c0102839:	83 c4 08             	add    $0x8,%esp
    iret
c010283c:	cf                   	iret   

c010283d <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c010283d:	55                   	push   %ebp
c010283e:	89 e5                	mov    %esp,%ebp
    return page - pages;
c0102840:	8b 45 08             	mov    0x8(%ebp),%eax
c0102843:	8b 15 18 af 11 c0    	mov    0xc011af18,%edx
c0102849:	29 d0                	sub    %edx,%eax
c010284b:	c1 f8 02             	sar    $0x2,%eax
c010284e:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0102854:	5d                   	pop    %ebp
c0102855:	c3                   	ret    

c0102856 <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c0102856:	55                   	push   %ebp
c0102857:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c0102859:	ff 75 08             	pushl  0x8(%ebp)
c010285c:	e8 dc ff ff ff       	call   c010283d <page2ppn>
c0102861:	83 c4 04             	add    $0x4,%esp
c0102864:	c1 e0 0c             	shl    $0xc,%eax
}
c0102867:	c9                   	leave  
c0102868:	c3                   	ret    

c0102869 <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
c0102869:	55                   	push   %ebp
c010286a:	89 e5                	mov    %esp,%ebp
c010286c:	83 ec 08             	sub    $0x8,%esp
    if (PPN(pa) >= npage) {
c010286f:	8b 45 08             	mov    0x8(%ebp),%eax
c0102872:	c1 e8 0c             	shr    $0xc,%eax
c0102875:	89 c2                	mov    %eax,%edx
c0102877:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c010287c:	39 c2                	cmp    %eax,%edx
c010287e:	72 14                	jb     c0102894 <pa2page+0x2b>
        panic("pa2page called with invalid pa");
c0102880:	83 ec 04             	sub    $0x4,%esp
c0102883:	68 90 61 10 c0       	push   $0xc0106190
c0102888:	6a 5a                	push   $0x5a
c010288a:	68 af 61 10 c0       	push   $0xc01061af
c010288f:	e8 45 db ff ff       	call   c01003d9 <__panic>
    }
    return &pages[PPN(pa)];
c0102894:	8b 0d 18 af 11 c0    	mov    0xc011af18,%ecx
c010289a:	8b 45 08             	mov    0x8(%ebp),%eax
c010289d:	c1 e8 0c             	shr    $0xc,%eax
c01028a0:	89 c2                	mov    %eax,%edx
c01028a2:	89 d0                	mov    %edx,%eax
c01028a4:	c1 e0 02             	shl    $0x2,%eax
c01028a7:	01 d0                	add    %edx,%eax
c01028a9:	c1 e0 02             	shl    $0x2,%eax
c01028ac:	01 c8                	add    %ecx,%eax
}
c01028ae:	c9                   	leave  
c01028af:	c3                   	ret    

c01028b0 <page2kva>:

static inline void *
page2kva(struct Page *page) {
c01028b0:	55                   	push   %ebp
c01028b1:	89 e5                	mov    %esp,%ebp
c01028b3:	83 ec 18             	sub    $0x18,%esp
    return KADDR(page2pa(page));
c01028b6:	ff 75 08             	pushl  0x8(%ebp)
c01028b9:	e8 98 ff ff ff       	call   c0102856 <page2pa>
c01028be:	83 c4 04             	add    $0x4,%esp
c01028c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01028c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01028c7:	c1 e8 0c             	shr    $0xc,%eax
c01028ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01028cd:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c01028d2:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c01028d5:	72 14                	jb     c01028eb <page2kva+0x3b>
c01028d7:	ff 75 f4             	pushl  -0xc(%ebp)
c01028da:	68 c0 61 10 c0       	push   $0xc01061c0
c01028df:	6a 61                	push   $0x61
c01028e1:	68 af 61 10 c0       	push   $0xc01061af
c01028e6:	e8 ee da ff ff       	call   c01003d9 <__panic>
c01028eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01028ee:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
c01028f3:	c9                   	leave  
c01028f4:	c3                   	ret    

c01028f5 <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
c01028f5:	55                   	push   %ebp
c01028f6:	89 e5                	mov    %esp,%ebp
c01028f8:	83 ec 08             	sub    $0x8,%esp
    if (!(pte & PTE_P)) {
c01028fb:	8b 45 08             	mov    0x8(%ebp),%eax
c01028fe:	83 e0 01             	and    $0x1,%eax
c0102901:	85 c0                	test   %eax,%eax
c0102903:	75 14                	jne    c0102919 <pte2page+0x24>
        panic("pte2page called with invalid pte");
c0102905:	83 ec 04             	sub    $0x4,%esp
c0102908:	68 e4 61 10 c0       	push   $0xc01061e4
c010290d:	6a 6c                	push   $0x6c
c010290f:	68 af 61 10 c0       	push   $0xc01061af
c0102914:	e8 c0 da ff ff       	call   c01003d9 <__panic>
    }
    return pa2page(PTE_ADDR(pte));
c0102919:	8b 45 08             	mov    0x8(%ebp),%eax
c010291c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0102921:	83 ec 0c             	sub    $0xc,%esp
c0102924:	50                   	push   %eax
c0102925:	e8 3f ff ff ff       	call   c0102869 <pa2page>
c010292a:	83 c4 10             	add    $0x10,%esp
}
c010292d:	c9                   	leave  
c010292e:	c3                   	ret    

c010292f <pde2page>:

static inline struct Page *
pde2page(pde_t pde) {
c010292f:	55                   	push   %ebp
c0102930:	89 e5                	mov    %esp,%ebp
c0102932:	83 ec 08             	sub    $0x8,%esp
    return pa2page(PDE_ADDR(pde));
c0102935:	8b 45 08             	mov    0x8(%ebp),%eax
c0102938:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c010293d:	83 ec 0c             	sub    $0xc,%esp
c0102940:	50                   	push   %eax
c0102941:	e8 23 ff ff ff       	call   c0102869 <pa2page>
c0102946:	83 c4 10             	add    $0x10,%esp
}
c0102949:	c9                   	leave  
c010294a:	c3                   	ret    

c010294b <page_ref>:

static inline int
page_ref(struct Page *page) {
c010294b:	55                   	push   %ebp
c010294c:	89 e5                	mov    %esp,%ebp
    return page->ref;
c010294e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102951:	8b 00                	mov    (%eax),%eax
}
c0102953:	5d                   	pop    %ebp
c0102954:	c3                   	ret    

c0102955 <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
c0102955:	55                   	push   %ebp
c0102956:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0102958:	8b 45 08             	mov    0x8(%ebp),%eax
c010295b:	8b 55 0c             	mov    0xc(%ebp),%edx
c010295e:	89 10                	mov    %edx,(%eax)
}
c0102960:	90                   	nop
c0102961:	5d                   	pop    %ebp
c0102962:	c3                   	ret    

c0102963 <page_ref_inc>:

static inline int
page_ref_inc(struct Page *page) {
c0102963:	55                   	push   %ebp
c0102964:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
c0102966:	8b 45 08             	mov    0x8(%ebp),%eax
c0102969:	8b 00                	mov    (%eax),%eax
c010296b:	8d 50 01             	lea    0x1(%eax),%edx
c010296e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102971:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102973:	8b 45 08             	mov    0x8(%ebp),%eax
c0102976:	8b 00                	mov    (%eax),%eax
}
c0102978:	5d                   	pop    %ebp
c0102979:	c3                   	ret    

c010297a <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
c010297a:	55                   	push   %ebp
c010297b:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
c010297d:	8b 45 08             	mov    0x8(%ebp),%eax
c0102980:	8b 00                	mov    (%eax),%eax
c0102982:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102985:	8b 45 08             	mov    0x8(%ebp),%eax
c0102988:	89 10                	mov    %edx,(%eax)
    return page->ref;
c010298a:	8b 45 08             	mov    0x8(%ebp),%eax
c010298d:	8b 00                	mov    (%eax),%eax
}
c010298f:	5d                   	pop    %ebp
c0102990:	c3                   	ret    

c0102991 <__intr_save>:
__intr_save(void) {
c0102991:	55                   	push   %ebp
c0102992:	89 e5                	mov    %esp,%ebp
c0102994:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0102997:	9c                   	pushf  
c0102998:	58                   	pop    %eax
c0102999:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c010299c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c010299f:	25 00 02 00 00       	and    $0x200,%eax
c01029a4:	85 c0                	test   %eax,%eax
c01029a6:	74 0c                	je     c01029b4 <__intr_save+0x23>
        intr_disable();
c01029a8:	e8 db ee ff ff       	call   c0101888 <intr_disable>
        return 1;
c01029ad:	b8 01 00 00 00       	mov    $0x1,%eax
c01029b2:	eb 05                	jmp    c01029b9 <__intr_save+0x28>
    return 0;
c01029b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01029b9:	c9                   	leave  
c01029ba:	c3                   	ret    

c01029bb <__intr_restore>:
__intr_restore(bool flag) {
c01029bb:	55                   	push   %ebp
c01029bc:	89 e5                	mov    %esp,%ebp
c01029be:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c01029c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c01029c5:	74 05                	je     c01029cc <__intr_restore+0x11>
        intr_enable();
c01029c7:	e8 b5 ee ff ff       	call   c0101881 <intr_enable>
}
c01029cc:	90                   	nop
c01029cd:	c9                   	leave  
c01029ce:	c3                   	ret    

c01029cf <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
c01029cf:	55                   	push   %ebp
c01029d0:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
c01029d2:	8b 45 08             	mov    0x8(%ebp),%eax
c01029d5:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
c01029d8:	b8 23 00 00 00       	mov    $0x23,%eax
c01029dd:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
c01029df:	b8 23 00 00 00       	mov    $0x23,%eax
c01029e4:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
c01029e6:	b8 10 00 00 00       	mov    $0x10,%eax
c01029eb:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
c01029ed:	b8 10 00 00 00       	mov    $0x10,%eax
c01029f2:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
c01029f4:	b8 10 00 00 00       	mov    $0x10,%eax
c01029f9:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
c01029fb:	ea 02 2a 10 c0 08 00 	ljmp   $0x8,$0xc0102a02
}
c0102a02:	90                   	nop
c0102a03:	5d                   	pop    %ebp
c0102a04:	c3                   	ret    

c0102a05 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
c0102a05:	55                   	push   %ebp
c0102a06:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
c0102a08:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a0b:	a3 a4 ae 11 c0       	mov    %eax,0xc011aea4
}
c0102a10:	90                   	nop
c0102a11:	5d                   	pop    %ebp
c0102a12:	c3                   	ret    

c0102a13 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
c0102a13:	55                   	push   %ebp
c0102a14:	89 e5                	mov    %esp,%ebp
c0102a16:	83 ec 10             	sub    $0x10,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
c0102a19:	b8 00 70 11 c0       	mov    $0xc0117000,%eax
c0102a1e:	50                   	push   %eax
c0102a1f:	e8 e1 ff ff ff       	call   c0102a05 <load_esp0>
c0102a24:	83 c4 04             	add    $0x4,%esp
    ts.ts_ss0 = KERNEL_DS;
c0102a27:	66 c7 05 a8 ae 11 c0 	movw   $0x10,0xc011aea8
c0102a2e:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
c0102a30:	66 c7 05 28 7a 11 c0 	movw   $0x68,0xc0117a28
c0102a37:	68 00 
c0102a39:	b8 a0 ae 11 c0       	mov    $0xc011aea0,%eax
c0102a3e:	66 a3 2a 7a 11 c0    	mov    %ax,0xc0117a2a
c0102a44:	b8 a0 ae 11 c0       	mov    $0xc011aea0,%eax
c0102a49:	c1 e8 10             	shr    $0x10,%eax
c0102a4c:	a2 2c 7a 11 c0       	mov    %al,0xc0117a2c
c0102a51:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0102a58:	83 e0 f0             	and    $0xfffffff0,%eax
c0102a5b:	83 c8 09             	or     $0x9,%eax
c0102a5e:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0102a63:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0102a6a:	83 e0 ef             	and    $0xffffffef,%eax
c0102a6d:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0102a72:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0102a79:	83 e0 9f             	and    $0xffffff9f,%eax
c0102a7c:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0102a81:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0102a88:	83 c8 80             	or     $0xffffff80,%eax
c0102a8b:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0102a90:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0102a97:	83 e0 f0             	and    $0xfffffff0,%eax
c0102a9a:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0102a9f:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0102aa6:	83 e0 ef             	and    $0xffffffef,%eax
c0102aa9:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0102aae:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0102ab5:	83 e0 df             	and    $0xffffffdf,%eax
c0102ab8:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0102abd:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0102ac4:	83 c8 40             	or     $0x40,%eax
c0102ac7:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0102acc:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0102ad3:	83 e0 7f             	and    $0x7f,%eax
c0102ad6:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0102adb:	b8 a0 ae 11 c0       	mov    $0xc011aea0,%eax
c0102ae0:	c1 e8 18             	shr    $0x18,%eax
c0102ae3:	a2 2f 7a 11 c0       	mov    %al,0xc0117a2f

    // reload all segment registers
    lgdt(&gdt_pd);
c0102ae8:	68 30 7a 11 c0       	push   $0xc0117a30
c0102aed:	e8 dd fe ff ff       	call   c01029cf <lgdt>
c0102af2:	83 c4 04             	add    $0x4,%esp
c0102af5:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
c0102afb:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0102aff:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
c0102b02:	90                   	nop
c0102b03:	c9                   	leave  
c0102b04:	c3                   	ret    

c0102b05 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
c0102b05:	55                   	push   %ebp
c0102b06:	89 e5                	mov    %esp,%ebp
c0102b08:	83 ec 08             	sub    $0x8,%esp
    pmm_manager = &default_pmm_manager;
c0102b0b:	c7 05 10 af 11 c0 88 	movl   $0xc0106b88,0xc011af10
c0102b12:	6b 10 c0 
    cprintf("memory management: %s\n", pmm_manager->name);
c0102b15:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102b1a:	8b 00                	mov    (%eax),%eax
c0102b1c:	83 ec 08             	sub    $0x8,%esp
c0102b1f:	50                   	push   %eax
c0102b20:	68 10 62 10 c0       	push   $0xc0106210
c0102b25:	e8 49 d7 ff ff       	call   c0100273 <cprintf>
c0102b2a:	83 c4 10             	add    $0x10,%esp
    pmm_manager->init();
c0102b2d:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102b32:	8b 40 04             	mov    0x4(%eax),%eax
c0102b35:	ff d0                	call   *%eax
}
c0102b37:	90                   	nop
c0102b38:	c9                   	leave  
c0102b39:	c3                   	ret    

c0102b3a <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
c0102b3a:	55                   	push   %ebp
c0102b3b:	89 e5                	mov    %esp,%ebp
c0102b3d:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->init_memmap(base, n);
c0102b40:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102b45:	8b 40 08             	mov    0x8(%eax),%eax
c0102b48:	83 ec 08             	sub    $0x8,%esp
c0102b4b:	ff 75 0c             	pushl  0xc(%ebp)
c0102b4e:	ff 75 08             	pushl  0x8(%ebp)
c0102b51:	ff d0                	call   *%eax
c0102b53:	83 c4 10             	add    $0x10,%esp
}
c0102b56:	90                   	nop
c0102b57:	c9                   	leave  
c0102b58:	c3                   	ret    

c0102b59 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
c0102b59:	55                   	push   %ebp
c0102b5a:	89 e5                	mov    %esp,%ebp
c0102b5c:	83 ec 18             	sub    $0x18,%esp
    struct Page *page=NULL;
c0102b5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0102b66:	e8 26 fe ff ff       	call   c0102991 <__intr_save>
c0102b6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
c0102b6e:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102b73:	8b 40 0c             	mov    0xc(%eax),%eax
c0102b76:	83 ec 0c             	sub    $0xc,%esp
c0102b79:	ff 75 08             	pushl  0x8(%ebp)
c0102b7c:	ff d0                	call   *%eax
c0102b7e:	83 c4 10             	add    $0x10,%esp
c0102b81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
c0102b84:	83 ec 0c             	sub    $0xc,%esp
c0102b87:	ff 75 f0             	pushl  -0x10(%ebp)
c0102b8a:	e8 2c fe ff ff       	call   c01029bb <__intr_restore>
c0102b8f:	83 c4 10             	add    $0x10,%esp
    return page;
c0102b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0102b95:	c9                   	leave  
c0102b96:	c3                   	ret    

c0102b97 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
c0102b97:	55                   	push   %ebp
c0102b98:	89 e5                	mov    %esp,%ebp
c0102b9a:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0102b9d:	e8 ef fd ff ff       	call   c0102991 <__intr_save>
c0102ba2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
c0102ba5:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102baa:	8b 40 10             	mov    0x10(%eax),%eax
c0102bad:	83 ec 08             	sub    $0x8,%esp
c0102bb0:	ff 75 0c             	pushl  0xc(%ebp)
c0102bb3:	ff 75 08             	pushl  0x8(%ebp)
c0102bb6:	ff d0                	call   *%eax
c0102bb8:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c0102bbb:	83 ec 0c             	sub    $0xc,%esp
c0102bbe:	ff 75 f4             	pushl  -0xc(%ebp)
c0102bc1:	e8 f5 fd ff ff       	call   c01029bb <__intr_restore>
c0102bc6:	83 c4 10             	add    $0x10,%esp
}
c0102bc9:	90                   	nop
c0102bca:	c9                   	leave  
c0102bcb:	c3                   	ret    

c0102bcc <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
c0102bcc:	55                   	push   %ebp
c0102bcd:	89 e5                	mov    %esp,%ebp
c0102bcf:	83 ec 18             	sub    $0x18,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
c0102bd2:	e8 ba fd ff ff       	call   c0102991 <__intr_save>
c0102bd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
c0102bda:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c0102bdf:	8b 40 14             	mov    0x14(%eax),%eax
c0102be2:	ff d0                	call   *%eax
c0102be4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
c0102be7:	83 ec 0c             	sub    $0xc,%esp
c0102bea:	ff 75 f4             	pushl  -0xc(%ebp)
c0102bed:	e8 c9 fd ff ff       	call   c01029bb <__intr_restore>
c0102bf2:	83 c4 10             	add    $0x10,%esp
    return ret;
c0102bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0102bf8:	c9                   	leave  
c0102bf9:	c3                   	ret    

c0102bfa <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
c0102bfa:	55                   	push   %ebp
c0102bfb:	89 e5                	mov    %esp,%ebp
c0102bfd:	57                   	push   %edi
c0102bfe:	56                   	push   %esi
c0102bff:	53                   	push   %ebx
c0102c00:	83 ec 7c             	sub    $0x7c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
c0102c03:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
c0102c0a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0102c11:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
c0102c18:	83 ec 0c             	sub    $0xc,%esp
c0102c1b:	68 27 62 10 c0       	push   $0xc0106227
c0102c20:	e8 4e d6 ff ff       	call   c0100273 <cprintf>
c0102c25:	83 c4 10             	add    $0x10,%esp
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0102c28:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102c2f:	e9 fc 00 00 00       	jmp    c0102d30 <page_init+0x136>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102c34:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102c37:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102c3a:	89 d0                	mov    %edx,%eax
c0102c3c:	c1 e0 02             	shl    $0x2,%eax
c0102c3f:	01 d0                	add    %edx,%eax
c0102c41:	c1 e0 02             	shl    $0x2,%eax
c0102c44:	01 c8                	add    %ecx,%eax
c0102c46:	8b 50 08             	mov    0x8(%eax),%edx
c0102c49:	8b 40 04             	mov    0x4(%eax),%eax
c0102c4c:	89 45 a0             	mov    %eax,-0x60(%ebp)
c0102c4f:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c0102c52:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102c55:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102c58:	89 d0                	mov    %edx,%eax
c0102c5a:	c1 e0 02             	shl    $0x2,%eax
c0102c5d:	01 d0                	add    %edx,%eax
c0102c5f:	c1 e0 02             	shl    $0x2,%eax
c0102c62:	01 c8                	add    %ecx,%eax
c0102c64:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102c67:	8b 58 10             	mov    0x10(%eax),%ebx
c0102c6a:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102c6d:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102c70:	01 c8                	add    %ecx,%eax
c0102c72:	11 da                	adc    %ebx,%edx
c0102c74:	89 45 98             	mov    %eax,-0x68(%ebp)
c0102c77:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
c0102c7a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102c7d:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102c80:	89 d0                	mov    %edx,%eax
c0102c82:	c1 e0 02             	shl    $0x2,%eax
c0102c85:	01 d0                	add    %edx,%eax
c0102c87:	c1 e0 02             	shl    $0x2,%eax
c0102c8a:	01 c8                	add    %ecx,%eax
c0102c8c:	83 c0 14             	add    $0x14,%eax
c0102c8f:	8b 00                	mov    (%eax),%eax
c0102c91:	89 45 84             	mov    %eax,-0x7c(%ebp)
c0102c94:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102c97:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102c9a:	83 c0 ff             	add    $0xffffffff,%eax
c0102c9d:	83 d2 ff             	adc    $0xffffffff,%edx
c0102ca0:	89 c1                	mov    %eax,%ecx
c0102ca2:	89 d3                	mov    %edx,%ebx
c0102ca4:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0102ca7:	89 55 80             	mov    %edx,-0x80(%ebp)
c0102caa:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102cad:	89 d0                	mov    %edx,%eax
c0102caf:	c1 e0 02             	shl    $0x2,%eax
c0102cb2:	01 d0                	add    %edx,%eax
c0102cb4:	c1 e0 02             	shl    $0x2,%eax
c0102cb7:	03 45 80             	add    -0x80(%ebp),%eax
c0102cba:	8b 50 10             	mov    0x10(%eax),%edx
c0102cbd:	8b 40 0c             	mov    0xc(%eax),%eax
c0102cc0:	ff 75 84             	pushl  -0x7c(%ebp)
c0102cc3:	53                   	push   %ebx
c0102cc4:	51                   	push   %ecx
c0102cc5:	ff 75 a4             	pushl  -0x5c(%ebp)
c0102cc8:	ff 75 a0             	pushl  -0x60(%ebp)
c0102ccb:	52                   	push   %edx
c0102ccc:	50                   	push   %eax
c0102ccd:	68 34 62 10 c0       	push   $0xc0106234
c0102cd2:	e8 9c d5 ff ff       	call   c0100273 <cprintf>
c0102cd7:	83 c4 20             	add    $0x20,%esp
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
c0102cda:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102cdd:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102ce0:	89 d0                	mov    %edx,%eax
c0102ce2:	c1 e0 02             	shl    $0x2,%eax
c0102ce5:	01 d0                	add    %edx,%eax
c0102ce7:	c1 e0 02             	shl    $0x2,%eax
c0102cea:	01 c8                	add    %ecx,%eax
c0102cec:	83 c0 14             	add    $0x14,%eax
c0102cef:	8b 00                	mov    (%eax),%eax
c0102cf1:	83 f8 01             	cmp    $0x1,%eax
c0102cf4:	75 36                	jne    c0102d2c <page_init+0x132>
            if (maxpa < end && begin < KMEMSIZE) {
c0102cf6:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102cf9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102cfc:	3b 55 9c             	cmp    -0x64(%ebp),%edx
c0102cff:	77 2b                	ja     c0102d2c <page_init+0x132>
c0102d01:	3b 55 9c             	cmp    -0x64(%ebp),%edx
c0102d04:	72 05                	jb     c0102d0b <page_init+0x111>
c0102d06:	3b 45 98             	cmp    -0x68(%ebp),%eax
c0102d09:	73 21                	jae    c0102d2c <page_init+0x132>
c0102d0b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0102d0f:	77 1b                	ja     c0102d2c <page_init+0x132>
c0102d11:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0102d15:	72 09                	jb     c0102d20 <page_init+0x126>
c0102d17:	81 7d a0 ff ff ff 37 	cmpl   $0x37ffffff,-0x60(%ebp)
c0102d1e:	77 0c                	ja     c0102d2c <page_init+0x132>
                maxpa = end;
c0102d20:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102d23:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102d26:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0102d29:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
c0102d2c:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0102d30:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102d33:	8b 00                	mov    (%eax),%eax
c0102d35:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0102d38:	0f 8c f6 fe ff ff    	jl     c0102c34 <page_init+0x3a>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
c0102d3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0102d42:	72 1d                	jb     c0102d61 <page_init+0x167>
c0102d44:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0102d48:	77 09                	ja     c0102d53 <page_init+0x159>
c0102d4a:	81 7d e0 00 00 00 38 	cmpl   $0x38000000,-0x20(%ebp)
c0102d51:	76 0e                	jbe    c0102d61 <page_init+0x167>
        maxpa = KMEMSIZE;
c0102d53:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
c0102d5a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
c0102d61:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102d64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102d67:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0102d6b:	c1 ea 0c             	shr    $0xc,%edx
c0102d6e:	89 c1                	mov    %eax,%ecx
c0102d70:	89 d3                	mov    %edx,%ebx
c0102d72:	89 c8                	mov    %ecx,%eax
c0102d74:	a3 80 ae 11 c0       	mov    %eax,0xc011ae80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
c0102d79:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
c0102d80:	b8 28 af 11 c0       	mov    $0xc011af28,%eax
c0102d85:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102d88:	8b 45 c0             	mov    -0x40(%ebp),%eax
c0102d8b:	01 d0                	add    %edx,%eax
c0102d8d:	89 45 bc             	mov    %eax,-0x44(%ebp)
c0102d90:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102d93:	ba 00 00 00 00       	mov    $0x0,%edx
c0102d98:	f7 75 c0             	divl   -0x40(%ebp)
c0102d9b:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102d9e:	29 d0                	sub    %edx,%eax
c0102da0:	a3 18 af 11 c0       	mov    %eax,0xc011af18

    for (i = 0; i < npage; i ++) {
c0102da5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102dac:	eb 2f                	jmp    c0102ddd <page_init+0x1e3>
        SetPageReserved(pages + i);
c0102dae:	8b 0d 18 af 11 c0    	mov    0xc011af18,%ecx
c0102db4:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102db7:	89 d0                	mov    %edx,%eax
c0102db9:	c1 e0 02             	shl    $0x2,%eax
c0102dbc:	01 d0                	add    %edx,%eax
c0102dbe:	c1 e0 02             	shl    $0x2,%eax
c0102dc1:	01 c8                	add    %ecx,%eax
c0102dc3:	83 c0 04             	add    $0x4,%eax
c0102dc6:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
c0102dcd:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102dd0:	8b 45 90             	mov    -0x70(%ebp),%eax
c0102dd3:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0102dd6:	0f ab 10             	bts    %edx,(%eax)
    for (i = 0; i < npage; i ++) {
c0102dd9:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0102ddd:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102de0:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0102de5:	39 c2                	cmp    %eax,%edx
c0102de7:	72 c5                	jb     c0102dae <page_init+0x1b4>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
c0102de9:	8b 15 80 ae 11 c0    	mov    0xc011ae80,%edx
c0102def:	89 d0                	mov    %edx,%eax
c0102df1:	c1 e0 02             	shl    $0x2,%eax
c0102df4:	01 d0                	add    %edx,%eax
c0102df6:	c1 e0 02             	shl    $0x2,%eax
c0102df9:	89 c2                	mov    %eax,%edx
c0102dfb:	a1 18 af 11 c0       	mov    0xc011af18,%eax
c0102e00:	01 d0                	add    %edx,%eax
c0102e02:	89 45 b8             	mov    %eax,-0x48(%ebp)
c0102e05:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
c0102e0c:	77 17                	ja     c0102e25 <page_init+0x22b>
c0102e0e:	ff 75 b8             	pushl  -0x48(%ebp)
c0102e11:	68 64 62 10 c0       	push   $0xc0106264
c0102e16:	68 dc 00 00 00       	push   $0xdc
c0102e1b:	68 88 62 10 c0       	push   $0xc0106288
c0102e20:	e8 b4 d5 ff ff       	call   c01003d9 <__panic>
c0102e25:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0102e28:	05 00 00 00 40       	add    $0x40000000,%eax
c0102e2d:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
c0102e30:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102e37:	e9 71 01 00 00       	jmp    c0102fad <page_init+0x3b3>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102e3c:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e3f:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e42:	89 d0                	mov    %edx,%eax
c0102e44:	c1 e0 02             	shl    $0x2,%eax
c0102e47:	01 d0                	add    %edx,%eax
c0102e49:	c1 e0 02             	shl    $0x2,%eax
c0102e4c:	01 c8                	add    %ecx,%eax
c0102e4e:	8b 50 08             	mov    0x8(%eax),%edx
c0102e51:	8b 40 04             	mov    0x4(%eax),%eax
c0102e54:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102e57:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0102e5a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e5d:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e60:	89 d0                	mov    %edx,%eax
c0102e62:	c1 e0 02             	shl    $0x2,%eax
c0102e65:	01 d0                	add    %edx,%eax
c0102e67:	c1 e0 02             	shl    $0x2,%eax
c0102e6a:	01 c8                	add    %ecx,%eax
c0102e6c:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102e6f:	8b 58 10             	mov    0x10(%eax),%ebx
c0102e72:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102e75:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0102e78:	01 c8                	add    %ecx,%eax
c0102e7a:	11 da                	adc    %ebx,%edx
c0102e7c:	89 45 c8             	mov    %eax,-0x38(%ebp)
c0102e7f:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
c0102e82:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e85:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e88:	89 d0                	mov    %edx,%eax
c0102e8a:	c1 e0 02             	shl    $0x2,%eax
c0102e8d:	01 d0                	add    %edx,%eax
c0102e8f:	c1 e0 02             	shl    $0x2,%eax
c0102e92:	01 c8                	add    %ecx,%eax
c0102e94:	83 c0 14             	add    $0x14,%eax
c0102e97:	8b 00                	mov    (%eax),%eax
c0102e99:	83 f8 01             	cmp    $0x1,%eax
c0102e9c:	0f 85 07 01 00 00    	jne    c0102fa9 <page_init+0x3af>
            if (begin < freemem) {
c0102ea2:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0102ea5:	ba 00 00 00 00       	mov    $0x0,%edx
c0102eaa:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
c0102ead:	77 17                	ja     c0102ec6 <page_init+0x2cc>
c0102eaf:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
c0102eb2:	72 05                	jb     c0102eb9 <page_init+0x2bf>
c0102eb4:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c0102eb7:	73 0d                	jae    c0102ec6 <page_init+0x2cc>
                begin = freemem;
c0102eb9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0102ebc:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102ebf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
c0102ec6:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
c0102eca:	72 1d                	jb     c0102ee9 <page_init+0x2ef>
c0102ecc:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
c0102ed0:	77 09                	ja     c0102edb <page_init+0x2e1>
c0102ed2:	81 7d c8 00 00 00 38 	cmpl   $0x38000000,-0x38(%ebp)
c0102ed9:	76 0e                	jbe    c0102ee9 <page_init+0x2ef>
                end = KMEMSIZE;
c0102edb:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
c0102ee2:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
c0102ee9:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102eec:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0102eef:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0102ef2:	0f 87 b1 00 00 00    	ja     c0102fa9 <page_init+0x3af>
c0102ef8:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0102efb:	72 09                	jb     c0102f06 <page_init+0x30c>
c0102efd:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c0102f00:	0f 83 a3 00 00 00    	jae    c0102fa9 <page_init+0x3af>
                begin = ROUNDUP(begin, PGSIZE);
c0102f06:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
c0102f0d:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0102f10:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0102f13:	01 d0                	add    %edx,%eax
c0102f15:	83 e8 01             	sub    $0x1,%eax
c0102f18:	89 45 ac             	mov    %eax,-0x54(%ebp)
c0102f1b:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0102f1e:	ba 00 00 00 00       	mov    $0x0,%edx
c0102f23:	f7 75 b0             	divl   -0x50(%ebp)
c0102f26:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0102f29:	29 d0                	sub    %edx,%eax
c0102f2b:	ba 00 00 00 00       	mov    $0x0,%edx
c0102f30:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102f33:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
c0102f36:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0102f39:	89 45 a8             	mov    %eax,-0x58(%ebp)
c0102f3c:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0102f3f:	ba 00 00 00 00       	mov    $0x0,%edx
c0102f44:	89 c3                	mov    %eax,%ebx
c0102f46:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
c0102f4c:	89 de                	mov    %ebx,%esi
c0102f4e:	89 d0                	mov    %edx,%eax
c0102f50:	83 e0 00             	and    $0x0,%eax
c0102f53:	89 c7                	mov    %eax,%edi
c0102f55:	89 75 c8             	mov    %esi,-0x38(%ebp)
c0102f58:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
c0102f5b:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102f5e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0102f61:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0102f64:	77 43                	ja     c0102fa9 <page_init+0x3af>
c0102f66:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0102f69:	72 05                	jb     c0102f70 <page_init+0x376>
c0102f6b:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c0102f6e:	73 39                	jae    c0102fa9 <page_init+0x3af>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
c0102f70:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0102f73:	8b 55 cc             	mov    -0x34(%ebp),%edx
c0102f76:	2b 45 d0             	sub    -0x30(%ebp),%eax
c0102f79:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
c0102f7c:	89 c1                	mov    %eax,%ecx
c0102f7e:	89 d3                	mov    %edx,%ebx
c0102f80:	89 c8                	mov    %ecx,%eax
c0102f82:	89 da                	mov    %ebx,%edx
c0102f84:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0102f88:	c1 ea 0c             	shr    $0xc,%edx
c0102f8b:	89 c3                	mov    %eax,%ebx
c0102f8d:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102f90:	83 ec 0c             	sub    $0xc,%esp
c0102f93:	50                   	push   %eax
c0102f94:	e8 d0 f8 ff ff       	call   c0102869 <pa2page>
c0102f99:	83 c4 10             	add    $0x10,%esp
c0102f9c:	83 ec 08             	sub    $0x8,%esp
c0102f9f:	53                   	push   %ebx
c0102fa0:	50                   	push   %eax
c0102fa1:	e8 94 fb ff ff       	call   c0102b3a <init_memmap>
c0102fa6:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < memmap->nr_map; i ++) {
c0102fa9:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0102fad:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102fb0:	8b 00                	mov    (%eax),%eax
c0102fb2:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0102fb5:	0f 8c 81 fe ff ff    	jl     c0102e3c <page_init+0x242>
                }
            }
        }
    }
}
c0102fbb:	90                   	nop
c0102fbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
c0102fbf:	5b                   	pop    %ebx
c0102fc0:	5e                   	pop    %esi
c0102fc1:	5f                   	pop    %edi
c0102fc2:	5d                   	pop    %ebp
c0102fc3:	c3                   	ret    

c0102fc4 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
c0102fc4:	55                   	push   %ebp
c0102fc5:	89 e5                	mov    %esp,%ebp
c0102fc7:	83 ec 28             	sub    $0x28,%esp
    assert(PGOFF(la) == PGOFF(pa));
c0102fca:	8b 45 0c             	mov    0xc(%ebp),%eax
c0102fcd:	33 45 14             	xor    0x14(%ebp),%eax
c0102fd0:	25 ff 0f 00 00       	and    $0xfff,%eax
c0102fd5:	85 c0                	test   %eax,%eax
c0102fd7:	74 19                	je     c0102ff2 <boot_map_segment+0x2e>
c0102fd9:	68 96 62 10 c0       	push   $0xc0106296
c0102fde:	68 ad 62 10 c0       	push   $0xc01062ad
c0102fe3:	68 fa 00 00 00       	push   $0xfa
c0102fe8:	68 88 62 10 c0       	push   $0xc0106288
c0102fed:	e8 e7 d3 ff ff       	call   c01003d9 <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
c0102ff2:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
c0102ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
c0102ffc:	25 ff 0f 00 00       	and    $0xfff,%eax
c0103001:	89 c2                	mov    %eax,%edx
c0103003:	8b 45 10             	mov    0x10(%ebp),%eax
c0103006:	01 c2                	add    %eax,%edx
c0103008:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010300b:	01 d0                	add    %edx,%eax
c010300d:	83 e8 01             	sub    $0x1,%eax
c0103010:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103013:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103016:	ba 00 00 00 00       	mov    $0x0,%edx
c010301b:	f7 75 f0             	divl   -0x10(%ebp)
c010301e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103021:	29 d0                	sub    %edx,%eax
c0103023:	c1 e8 0c             	shr    $0xc,%eax
c0103026:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
c0103029:	8b 45 0c             	mov    0xc(%ebp),%eax
c010302c:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010302f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103032:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103037:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
c010303a:	8b 45 14             	mov    0x14(%ebp),%eax
c010303d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103040:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103043:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103048:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c010304b:	eb 57                	jmp    c01030a4 <boot_map_segment+0xe0>
        pte_t *ptep = get_pte(pgdir, la, 1);
c010304d:	83 ec 04             	sub    $0x4,%esp
c0103050:	6a 01                	push   $0x1
c0103052:	ff 75 0c             	pushl  0xc(%ebp)
c0103055:	ff 75 08             	pushl  0x8(%ebp)
c0103058:	e8 53 01 00 00       	call   c01031b0 <get_pte>
c010305d:	83 c4 10             	add    $0x10,%esp
c0103060:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
c0103063:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c0103067:	75 19                	jne    c0103082 <boot_map_segment+0xbe>
c0103069:	68 c2 62 10 c0       	push   $0xc01062c2
c010306e:	68 ad 62 10 c0       	push   $0xc01062ad
c0103073:	68 00 01 00 00       	push   $0x100
c0103078:	68 88 62 10 c0       	push   $0xc0106288
c010307d:	e8 57 d3 ff ff       	call   c01003d9 <__panic>
        *ptep = pa | PTE_P | perm;
c0103082:	8b 45 14             	mov    0x14(%ebp),%eax
c0103085:	0b 45 18             	or     0x18(%ebp),%eax
c0103088:	83 c8 01             	or     $0x1,%eax
c010308b:	89 c2                	mov    %eax,%edx
c010308d:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103090:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c0103092:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c0103096:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
c010309d:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
c01030a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01030a8:	75 a3                	jne    c010304d <boot_map_segment+0x89>
    }
}
c01030aa:	90                   	nop
c01030ab:	c9                   	leave  
c01030ac:	c3                   	ret    

c01030ad <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
c01030ad:	55                   	push   %ebp
c01030ae:	89 e5                	mov    %esp,%ebp
c01030b0:	83 ec 18             	sub    $0x18,%esp
    struct Page *p = alloc_page();
c01030b3:	83 ec 0c             	sub    $0xc,%esp
c01030b6:	6a 01                	push   $0x1
c01030b8:	e8 9c fa ff ff       	call   c0102b59 <alloc_pages>
c01030bd:	83 c4 10             	add    $0x10,%esp
c01030c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
c01030c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01030c7:	75 17                	jne    c01030e0 <boot_alloc_page+0x33>
        panic("boot_alloc_page failed.\n");
c01030c9:	83 ec 04             	sub    $0x4,%esp
c01030cc:	68 cf 62 10 c0       	push   $0xc01062cf
c01030d1:	68 0c 01 00 00       	push   $0x10c
c01030d6:	68 88 62 10 c0       	push   $0xc0106288
c01030db:	e8 f9 d2 ff ff       	call   c01003d9 <__panic>
    }
    return page2kva(p);
c01030e0:	83 ec 0c             	sub    $0xc,%esp
c01030e3:	ff 75 f4             	pushl  -0xc(%ebp)
c01030e6:	e8 c5 f7 ff ff       	call   c01028b0 <page2kva>
c01030eb:	83 c4 10             	add    $0x10,%esp
}
c01030ee:	c9                   	leave  
c01030ef:	c3                   	ret    

c01030f0 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
c01030f0:	55                   	push   %ebp
c01030f1:	89 e5                	mov    %esp,%ebp
c01030f3:	83 ec 18             	sub    $0x18,%esp
    // We've already enabled paging
    boot_cr3 = PADDR(boot_pgdir);
c01030f6:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c01030fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01030fe:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0103105:	77 17                	ja     c010311e <pmm_init+0x2e>
c0103107:	ff 75 f4             	pushl  -0xc(%ebp)
c010310a:	68 64 62 10 c0       	push   $0xc0106264
c010310f:	68 16 01 00 00       	push   $0x116
c0103114:	68 88 62 10 c0       	push   $0xc0106288
c0103119:	e8 bb d2 ff ff       	call   c01003d9 <__panic>
c010311e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103121:	05 00 00 00 40       	add    $0x40000000,%eax
c0103126:	a3 14 af 11 c0       	mov    %eax,0xc011af14
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
c010312b:	e8 d5 f9 ff ff       	call   c0102b05 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
c0103130:	e8 c5 fa ff ff       	call   c0102bfa <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
c0103135:	e8 8f 03 00 00       	call   c01034c9 <check_alloc_page>

    check_pgdir();
c010313a:	e8 ad 03 00 00       	call   c01034ec <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
c010313f:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103144:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103147:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c010314e:	77 17                	ja     c0103167 <pmm_init+0x77>
c0103150:	ff 75 f0             	pushl  -0x10(%ebp)
c0103153:	68 64 62 10 c0       	push   $0xc0106264
c0103158:	68 2c 01 00 00       	push   $0x12c
c010315d:	68 88 62 10 c0       	push   $0xc0106288
c0103162:	e8 72 d2 ff ff       	call   c01003d9 <__panic>
c0103167:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010316a:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
c0103170:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103175:	05 ac 0f 00 00       	add    $0xfac,%eax
c010317a:	83 ca 03             	or     $0x3,%edx
c010317d:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    // linear_addr KERNBASE ~ KERNBASE + KMEMSIZE = phy_addr 0 ~ KMEMSIZE
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
c010317f:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103184:	83 ec 0c             	sub    $0xc,%esp
c0103187:	6a 02                	push   $0x2
c0103189:	6a 00                	push   $0x0
c010318b:	68 00 00 00 38       	push   $0x38000000
c0103190:	68 00 00 00 c0       	push   $0xc0000000
c0103195:	50                   	push   %eax
c0103196:	e8 29 fe ff ff       	call   c0102fc4 <boot_map_segment>
c010319b:	83 c4 20             	add    $0x20,%esp

    // Since we are using bootloader's GDT,
    // we should reload gdt (second time, the last time) to get user segments and the TSS
    // map virtual_addr 0 ~ 4G = linear_addr 0 ~ 4G
    // then set kernel stack (ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
c010319e:	e8 70 f8 ff ff       	call   c0102a13 <gdt_init>

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
c01031a3:	e8 aa 08 00 00       	call   c0103a52 <check_boot_pgdir>

    print_pgdir();
c01031a8:	e8 a0 0c 00 00       	call   c0103e4d <print_pgdir>

}
c01031ad:	90                   	nop
c01031ae:	c9                   	leave  
c01031af:	c3                   	ret    

c01031b0 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
c01031b0:	55                   	push   %ebp
c01031b1:	89 e5                	mov    %esp,%ebp
c01031b3:	83 ec 28             	sub    $0x28,%esp
    //     uintptr_t pa = page2pa(page);
    //     memset(KADDR(pa), 0, PGSIZE);
    //     *pdep = pa | PTE_U | PTE_W | PTE_P;
    // }
    // return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)];
    pde_t *pdep = pgdir+PDX(la);   			//由页目录表基址pgdir与页内偏移得到表项
c01031b6:	8b 45 0c             	mov    0xc(%ebp),%eax
c01031b9:	c1 e8 16             	shr    $0x16,%eax
c01031bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01031c3:	8b 45 08             	mov    0x8(%ebp),%eax
c01031c6:	01 d0                	add    %edx,%eax
c01031c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (! (*pdep & PTE_P))					//如果该表项没有对应的二级页表则进行下列操作
c01031cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01031ce:	8b 00                	mov    (%eax),%eax
c01031d0:	83 e0 01             	and    $0x1,%eax
c01031d3:	85 c0                	test   %eax,%eax
c01031d5:	0f 85 d1 00 00 00    	jne    c01032ac <get_pte+0xfc>
    {   
        if(create)							//如果需要创建二级页表则进行创建
c01031db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01031df:	0f 84 c0 00 00 00    	je     c01032a5 <get_pte+0xf5>
        {
            struct Page *p = alloc_page();	//新建页表
c01031e5:	83 ec 0c             	sub    $0xc,%esp
c01031e8:	6a 01                	push   $0x1
c01031ea:	e8 6a f9 ff ff       	call   c0102b59 <alloc_pages>
c01031ef:	83 c4 10             	add    $0x10,%esp
c01031f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
            set_page_ref(p, 1); 			//页表引用数增加
c01031f5:	83 ec 08             	sub    $0x8,%esp
c01031f8:	6a 01                	push   $0x1
c01031fa:	ff 75 f0             	pushl  -0x10(%ebp)
c01031fd:	e8 53 f7 ff ff       	call   c0102955 <set_page_ref>
c0103202:	83 c4 10             	add    $0x10,%esp
            uintptr_t pa = page2pa(p);		//获得该页对应的物理地址
c0103205:	83 ec 0c             	sub    $0xc,%esp
c0103208:	ff 75 f0             	pushl  -0x10(%ebp)
c010320b:	e8 46 f6 ff ff       	call   c0102856 <page2pa>
c0103210:	83 c4 10             	add    $0x10,%esp
c0103213:	89 45 ec             	mov    %eax,-0x14(%ebp)
            memset(KADDR(pa), 0, PGSIZE); 	//获得该页对应的虚拟地址，并把页表初始化
c0103216:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103219:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010321c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010321f:	c1 e8 0c             	shr    $0xc,%eax
c0103222:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103225:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c010322a:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
c010322d:	72 17                	jb     c0103246 <get_pte+0x96>
c010322f:	ff 75 e8             	pushl  -0x18(%ebp)
c0103232:	68 c0 61 10 c0       	push   $0xc01061c0
c0103237:	68 7e 01 00 00       	push   $0x17e
c010323c:	68 88 62 10 c0       	push   $0xc0106288
c0103241:	e8 93 d1 ff ff       	call   c01003d9 <__panic>
c0103246:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103249:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010324e:	83 ec 04             	sub    $0x4,%esp
c0103251:	68 00 10 00 00       	push   $0x1000
c0103256:	6a 00                	push   $0x0
c0103258:	50                   	push   %eax
c0103259:	e8 7f 20 00 00       	call   c01052dd <memset>
c010325e:	83 c4 10             	add    $0x10,%esp
            *pdep = (uintptr_t)KADDR(pa) | (PTE_P+PTE_W+PTE_U);
c0103261:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103264:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0103267:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010326a:	c1 e8 0c             	shr    $0xc,%eax
c010326d:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103270:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0103275:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0103278:	72 17                	jb     c0103291 <get_pte+0xe1>
c010327a:	ff 75 e0             	pushl  -0x20(%ebp)
c010327d:	68 c0 61 10 c0       	push   $0xc01061c0
c0103282:	68 7f 01 00 00       	push   $0x17f
c0103287:	68 88 62 10 c0       	push   $0xc0106288
c010328c:	e8 48 d1 ff ff       	call   c01003d9 <__panic>
c0103291:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103294:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103299:	83 c8 07             	or     $0x7,%eax
c010329c:	89 c2                	mov    %eax,%edx
c010329e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01032a1:	89 10                	mov    %edx,(%eax)
c01032a3:	eb 07                	jmp    c01032ac <get_pte+0xfc>
            		//获得该页的虚拟地址并且修改标志位，之后更新页目录表中的地址
        }
        else 
            return NULL;					//不需要创建且无二级页表则转换失败
c01032a5:	b8 00 00 00 00       	mov    $0x0,%eax
c01032aa:	eb 1e                	jmp    c01032ca <get_pte+0x11a>
    }
    return   (pte_t *)(PDE_ADDR(*pdep)) + PTX(la);
c01032ac:	8b 45 0c             	mov    0xc(%ebp),%eax
c01032af:	c1 e8 0c             	shr    $0xc,%eax
c01032b2:	25 ff 03 00 00       	and    $0x3ff,%eax
c01032b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01032be:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01032c1:	8b 00                	mov    (%eax),%eax
c01032c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01032c8:	01 d0                	add    %edx,%eax
    //获得二级页表表项
   	//PDE_ADDR(*pdep)为根据页目录表的表项获取二级页表基址，即表项舍弃后12位标志位。
   	//(pte_t *)为转换为二级页表表项的指针
    //PTX(la)为表内偏移
    //最终和为la对应的二级页表表项
}
c01032ca:	c9                   	leave  
c01032cb:	c3                   	ret    

c01032cc <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
c01032cc:	55                   	push   %ebp
c01032cd:	89 e5                	mov    %esp,%ebp
c01032cf:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c01032d2:	83 ec 04             	sub    $0x4,%esp
c01032d5:	6a 00                	push   $0x0
c01032d7:	ff 75 0c             	pushl  0xc(%ebp)
c01032da:	ff 75 08             	pushl  0x8(%ebp)
c01032dd:	e8 ce fe ff ff       	call   c01031b0 <get_pte>
c01032e2:	83 c4 10             	add    $0x10,%esp
c01032e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
c01032e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01032ec:	74 08                	je     c01032f6 <get_page+0x2a>
        *ptep_store = ptep;
c01032ee:	8b 45 10             	mov    0x10(%ebp),%eax
c01032f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01032f4:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
c01032f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01032fa:	74 1f                	je     c010331b <get_page+0x4f>
c01032fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01032ff:	8b 00                	mov    (%eax),%eax
c0103301:	83 e0 01             	and    $0x1,%eax
c0103304:	85 c0                	test   %eax,%eax
c0103306:	74 13                	je     c010331b <get_page+0x4f>
        return pte2page(*ptep);
c0103308:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010330b:	8b 00                	mov    (%eax),%eax
c010330d:	83 ec 0c             	sub    $0xc,%esp
c0103310:	50                   	push   %eax
c0103311:	e8 df f5 ff ff       	call   c01028f5 <pte2page>
c0103316:	83 c4 10             	add    $0x10,%esp
c0103319:	eb 05                	jmp    c0103320 <get_page+0x54>
    }
    return NULL;
c010331b:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103320:	c9                   	leave  
c0103321:	c3                   	ret    

c0103322 <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
c0103322:	55                   	push   %ebp
c0103323:	89 e5                	mov    %esp,%ebp
c0103325:	83 ec 18             	sub    $0x18,%esp
                                  //(4) and free this page when page reference reachs 0
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif
    if (*ptep & PTE_P) {
c0103328:	8b 45 10             	mov    0x10(%ebp),%eax
c010332b:	8b 00                	mov    (%eax),%eax
c010332d:	83 e0 01             	and    $0x1,%eax
c0103330:	85 c0                	test   %eax,%eax
c0103332:	74 50                	je     c0103384 <page_remove_pte+0x62>
        struct Page *page = pte2page(*ptep);
c0103334:	8b 45 10             	mov    0x10(%ebp),%eax
c0103337:	8b 00                	mov    (%eax),%eax
c0103339:	83 ec 0c             	sub    $0xc,%esp
c010333c:	50                   	push   %eax
c010333d:	e8 b3 f5 ff ff       	call   c01028f5 <pte2page>
c0103342:	83 c4 10             	add    $0x10,%esp
c0103345:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (page_ref_dec(page) == 0) {
c0103348:	83 ec 0c             	sub    $0xc,%esp
c010334b:	ff 75 f4             	pushl  -0xc(%ebp)
c010334e:	e8 27 f6 ff ff       	call   c010297a <page_ref_dec>
c0103353:	83 c4 10             	add    $0x10,%esp
c0103356:	85 c0                	test   %eax,%eax
c0103358:	75 10                	jne    c010336a <page_remove_pte+0x48>
            free_page(page);
c010335a:	83 ec 08             	sub    $0x8,%esp
c010335d:	6a 01                	push   $0x1
c010335f:	ff 75 f4             	pushl  -0xc(%ebp)
c0103362:	e8 30 f8 ff ff       	call   c0102b97 <free_pages>
c0103367:	83 c4 10             	add    $0x10,%esp
        }
        *ptep = 0;
c010336a:	8b 45 10             	mov    0x10(%ebp),%eax
c010336d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        tlb_invalidate(pgdir, la);
c0103373:	83 ec 08             	sub    $0x8,%esp
c0103376:	ff 75 0c             	pushl  0xc(%ebp)
c0103379:	ff 75 08             	pushl  0x8(%ebp)
c010337c:	e8 f8 00 00 00       	call   c0103479 <tlb_invalidate>
c0103381:	83 c4 10             	add    $0x10,%esp
    }
}
c0103384:	90                   	nop
c0103385:	c9                   	leave  
c0103386:	c3                   	ret    

c0103387 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
c0103387:	55                   	push   %ebp
c0103388:	89 e5                	mov    %esp,%ebp
c010338a:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c010338d:	83 ec 04             	sub    $0x4,%esp
c0103390:	6a 00                	push   $0x0
c0103392:	ff 75 0c             	pushl  0xc(%ebp)
c0103395:	ff 75 08             	pushl  0x8(%ebp)
c0103398:	e8 13 fe ff ff       	call   c01031b0 <get_pte>
c010339d:	83 c4 10             	add    $0x10,%esp
c01033a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep != NULL) {
c01033a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01033a7:	74 14                	je     c01033bd <page_remove+0x36>
        page_remove_pte(pgdir, la, ptep);
c01033a9:	83 ec 04             	sub    $0x4,%esp
c01033ac:	ff 75 f4             	pushl  -0xc(%ebp)
c01033af:	ff 75 0c             	pushl  0xc(%ebp)
c01033b2:	ff 75 08             	pushl  0x8(%ebp)
c01033b5:	e8 68 ff ff ff       	call   c0103322 <page_remove_pte>
c01033ba:	83 c4 10             	add    $0x10,%esp
    }
}
c01033bd:	90                   	nop
c01033be:	c9                   	leave  
c01033bf:	c3                   	ret    

c01033c0 <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
c01033c0:	55                   	push   %ebp
c01033c1:	89 e5                	mov    %esp,%ebp
c01033c3:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
c01033c6:	83 ec 04             	sub    $0x4,%esp
c01033c9:	6a 01                	push   $0x1
c01033cb:	ff 75 10             	pushl  0x10(%ebp)
c01033ce:	ff 75 08             	pushl  0x8(%ebp)
c01033d1:	e8 da fd ff ff       	call   c01031b0 <get_pte>
c01033d6:	83 c4 10             	add    $0x10,%esp
c01033d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
c01033dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01033e0:	75 0a                	jne    c01033ec <page_insert+0x2c>
        return -E_NO_MEM;
c01033e2:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
c01033e7:	e9 8b 00 00 00       	jmp    c0103477 <page_insert+0xb7>
    }
    page_ref_inc(page);
c01033ec:	83 ec 0c             	sub    $0xc,%esp
c01033ef:	ff 75 0c             	pushl  0xc(%ebp)
c01033f2:	e8 6c f5 ff ff       	call   c0102963 <page_ref_inc>
c01033f7:	83 c4 10             	add    $0x10,%esp
    if (*ptep & PTE_P) {
c01033fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01033fd:	8b 00                	mov    (%eax),%eax
c01033ff:	83 e0 01             	and    $0x1,%eax
c0103402:	85 c0                	test   %eax,%eax
c0103404:	74 40                	je     c0103446 <page_insert+0x86>
        struct Page *p = pte2page(*ptep);
c0103406:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103409:	8b 00                	mov    (%eax),%eax
c010340b:	83 ec 0c             	sub    $0xc,%esp
c010340e:	50                   	push   %eax
c010340f:	e8 e1 f4 ff ff       	call   c01028f5 <pte2page>
c0103414:	83 c4 10             	add    $0x10,%esp
c0103417:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
c010341a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010341d:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103420:	75 10                	jne    c0103432 <page_insert+0x72>
            page_ref_dec(page);
c0103422:	83 ec 0c             	sub    $0xc,%esp
c0103425:	ff 75 0c             	pushl  0xc(%ebp)
c0103428:	e8 4d f5 ff ff       	call   c010297a <page_ref_dec>
c010342d:	83 c4 10             	add    $0x10,%esp
c0103430:	eb 14                	jmp    c0103446 <page_insert+0x86>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
c0103432:	83 ec 04             	sub    $0x4,%esp
c0103435:	ff 75 f4             	pushl  -0xc(%ebp)
c0103438:	ff 75 10             	pushl  0x10(%ebp)
c010343b:	ff 75 08             	pushl  0x8(%ebp)
c010343e:	e8 df fe ff ff       	call   c0103322 <page_remove_pte>
c0103443:	83 c4 10             	add    $0x10,%esp
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
c0103446:	83 ec 0c             	sub    $0xc,%esp
c0103449:	ff 75 0c             	pushl  0xc(%ebp)
c010344c:	e8 05 f4 ff ff       	call   c0102856 <page2pa>
c0103451:	83 c4 10             	add    $0x10,%esp
c0103454:	0b 45 14             	or     0x14(%ebp),%eax
c0103457:	83 c8 01             	or     $0x1,%eax
c010345a:	89 c2                	mov    %eax,%edx
c010345c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010345f:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
c0103461:	83 ec 08             	sub    $0x8,%esp
c0103464:	ff 75 10             	pushl  0x10(%ebp)
c0103467:	ff 75 08             	pushl  0x8(%ebp)
c010346a:	e8 0a 00 00 00       	call   c0103479 <tlb_invalidate>
c010346f:	83 c4 10             	add    $0x10,%esp
    return 0;
c0103472:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103477:	c9                   	leave  
c0103478:	c3                   	ret    

c0103479 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
c0103479:	55                   	push   %ebp
c010347a:	89 e5                	mov    %esp,%ebp
c010347c:	83 ec 18             	sub    $0x18,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
c010347f:	0f 20 d8             	mov    %cr3,%eax
c0103482:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
c0103485:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
c0103488:	8b 45 08             	mov    0x8(%ebp),%eax
c010348b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010348e:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0103495:	77 17                	ja     c01034ae <tlb_invalidate+0x35>
c0103497:	ff 75 f4             	pushl  -0xc(%ebp)
c010349a:	68 64 62 10 c0       	push   $0xc0106264
c010349f:	68 ec 01 00 00       	push   $0x1ec
c01034a4:	68 88 62 10 c0       	push   $0xc0106288
c01034a9:	e8 2b cf ff ff       	call   c01003d9 <__panic>
c01034ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034b1:	05 00 00 00 40       	add    $0x40000000,%eax
c01034b6:	39 d0                	cmp    %edx,%eax
c01034b8:	75 0c                	jne    c01034c6 <tlb_invalidate+0x4d>
        invlpg((void *)la);
c01034ba:	8b 45 0c             	mov    0xc(%ebp),%eax
c01034bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
c01034c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01034c3:	0f 01 38             	invlpg (%eax)
    }
}
c01034c6:	90                   	nop
c01034c7:	c9                   	leave  
c01034c8:	c3                   	ret    

c01034c9 <check_alloc_page>:

static void
check_alloc_page(void) {
c01034c9:	55                   	push   %ebp
c01034ca:	89 e5                	mov    %esp,%ebp
c01034cc:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->check();
c01034cf:	a1 10 af 11 c0       	mov    0xc011af10,%eax
c01034d4:	8b 40 18             	mov    0x18(%eax),%eax
c01034d7:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
c01034d9:	83 ec 0c             	sub    $0xc,%esp
c01034dc:	68 e8 62 10 c0       	push   $0xc01062e8
c01034e1:	e8 8d cd ff ff       	call   c0100273 <cprintf>
c01034e6:	83 c4 10             	add    $0x10,%esp
}
c01034e9:	90                   	nop
c01034ea:	c9                   	leave  
c01034eb:	c3                   	ret    

c01034ec <check_pgdir>:

static void
check_pgdir(void) {
c01034ec:	55                   	push   %ebp
c01034ed:	89 e5                	mov    %esp,%ebp
c01034ef:	83 ec 28             	sub    $0x28,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
c01034f2:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c01034f7:	3d 00 80 03 00       	cmp    $0x38000,%eax
c01034fc:	76 19                	jbe    c0103517 <check_pgdir+0x2b>
c01034fe:	68 07 63 10 c0       	push   $0xc0106307
c0103503:	68 ad 62 10 c0       	push   $0xc01062ad
c0103508:	68 f9 01 00 00       	push   $0x1f9
c010350d:	68 88 62 10 c0       	push   $0xc0106288
c0103512:	e8 c2 ce ff ff       	call   c01003d9 <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
c0103517:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c010351c:	85 c0                	test   %eax,%eax
c010351e:	74 0e                	je     c010352e <check_pgdir+0x42>
c0103520:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103525:	25 ff 0f 00 00       	and    $0xfff,%eax
c010352a:	85 c0                	test   %eax,%eax
c010352c:	74 19                	je     c0103547 <check_pgdir+0x5b>
c010352e:	68 24 63 10 c0       	push   $0xc0106324
c0103533:	68 ad 62 10 c0       	push   $0xc01062ad
c0103538:	68 fa 01 00 00       	push   $0x1fa
c010353d:	68 88 62 10 c0       	push   $0xc0106288
c0103542:	e8 92 ce ff ff       	call   c01003d9 <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
c0103547:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c010354c:	83 ec 04             	sub    $0x4,%esp
c010354f:	6a 00                	push   $0x0
c0103551:	6a 00                	push   $0x0
c0103553:	50                   	push   %eax
c0103554:	e8 73 fd ff ff       	call   c01032cc <get_page>
c0103559:	83 c4 10             	add    $0x10,%esp
c010355c:	85 c0                	test   %eax,%eax
c010355e:	74 19                	je     c0103579 <check_pgdir+0x8d>
c0103560:	68 5c 63 10 c0       	push   $0xc010635c
c0103565:	68 ad 62 10 c0       	push   $0xc01062ad
c010356a:	68 fb 01 00 00       	push   $0x1fb
c010356f:	68 88 62 10 c0       	push   $0xc0106288
c0103574:	e8 60 ce ff ff       	call   c01003d9 <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
c0103579:	83 ec 0c             	sub    $0xc,%esp
c010357c:	6a 01                	push   $0x1
c010357e:	e8 d6 f5 ff ff       	call   c0102b59 <alloc_pages>
c0103583:	83 c4 10             	add    $0x10,%esp
c0103586:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
c0103589:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c010358e:	6a 00                	push   $0x0
c0103590:	6a 00                	push   $0x0
c0103592:	ff 75 f4             	pushl  -0xc(%ebp)
c0103595:	50                   	push   %eax
c0103596:	e8 25 fe ff ff       	call   c01033c0 <page_insert>
c010359b:	83 c4 10             	add    $0x10,%esp
c010359e:	85 c0                	test   %eax,%eax
c01035a0:	74 19                	je     c01035bb <check_pgdir+0xcf>
c01035a2:	68 84 63 10 c0       	push   $0xc0106384
c01035a7:	68 ad 62 10 c0       	push   $0xc01062ad
c01035ac:	68 ff 01 00 00       	push   $0x1ff
c01035b1:	68 88 62 10 c0       	push   $0xc0106288
c01035b6:	e8 1e ce ff ff       	call   c01003d9 <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
c01035bb:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c01035c0:	83 ec 04             	sub    $0x4,%esp
c01035c3:	6a 00                	push   $0x0
c01035c5:	6a 00                	push   $0x0
c01035c7:	50                   	push   %eax
c01035c8:	e8 e3 fb ff ff       	call   c01031b0 <get_pte>
c01035cd:	83 c4 10             	add    $0x10,%esp
c01035d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01035d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01035d7:	75 19                	jne    c01035f2 <check_pgdir+0x106>
c01035d9:	68 b0 63 10 c0       	push   $0xc01063b0
c01035de:	68 ad 62 10 c0       	push   $0xc01062ad
c01035e3:	68 02 02 00 00       	push   $0x202
c01035e8:	68 88 62 10 c0       	push   $0xc0106288
c01035ed:	e8 e7 cd ff ff       	call   c01003d9 <__panic>
    assert(pte2page(*ptep) == p1);
c01035f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01035f5:	8b 00                	mov    (%eax),%eax
c01035f7:	83 ec 0c             	sub    $0xc,%esp
c01035fa:	50                   	push   %eax
c01035fb:	e8 f5 f2 ff ff       	call   c01028f5 <pte2page>
c0103600:	83 c4 10             	add    $0x10,%esp
c0103603:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0103606:	74 19                	je     c0103621 <check_pgdir+0x135>
c0103608:	68 dd 63 10 c0       	push   $0xc01063dd
c010360d:	68 ad 62 10 c0       	push   $0xc01062ad
c0103612:	68 03 02 00 00       	push   $0x203
c0103617:	68 88 62 10 c0       	push   $0xc0106288
c010361c:	e8 b8 cd ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p1) == 1);
c0103621:	83 ec 0c             	sub    $0xc,%esp
c0103624:	ff 75 f4             	pushl  -0xc(%ebp)
c0103627:	e8 1f f3 ff ff       	call   c010294b <page_ref>
c010362c:	83 c4 10             	add    $0x10,%esp
c010362f:	83 f8 01             	cmp    $0x1,%eax
c0103632:	74 19                	je     c010364d <check_pgdir+0x161>
c0103634:	68 f3 63 10 c0       	push   $0xc01063f3
c0103639:	68 ad 62 10 c0       	push   $0xc01062ad
c010363e:	68 04 02 00 00       	push   $0x204
c0103643:	68 88 62 10 c0       	push   $0xc0106288
c0103648:	e8 8c cd ff ff       	call   c01003d9 <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
c010364d:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103652:	8b 00                	mov    (%eax),%eax
c0103654:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103659:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010365c:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010365f:	c1 e8 0c             	shr    $0xc,%eax
c0103662:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0103665:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c010366a:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c010366d:	72 17                	jb     c0103686 <check_pgdir+0x19a>
c010366f:	ff 75 ec             	pushl  -0x14(%ebp)
c0103672:	68 c0 61 10 c0       	push   $0xc01061c0
c0103677:	68 06 02 00 00       	push   $0x206
c010367c:	68 88 62 10 c0       	push   $0xc0106288
c0103681:	e8 53 cd ff ff       	call   c01003d9 <__panic>
c0103686:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103689:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010368e:	83 c0 04             	add    $0x4,%eax
c0103691:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
c0103694:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103699:	83 ec 04             	sub    $0x4,%esp
c010369c:	6a 00                	push   $0x0
c010369e:	68 00 10 00 00       	push   $0x1000
c01036a3:	50                   	push   %eax
c01036a4:	e8 07 fb ff ff       	call   c01031b0 <get_pte>
c01036a9:	83 c4 10             	add    $0x10,%esp
c01036ac:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c01036af:	74 19                	je     c01036ca <check_pgdir+0x1de>
c01036b1:	68 08 64 10 c0       	push   $0xc0106408
c01036b6:	68 ad 62 10 c0       	push   $0xc01062ad
c01036bb:	68 07 02 00 00       	push   $0x207
c01036c0:	68 88 62 10 c0       	push   $0xc0106288
c01036c5:	e8 0f cd ff ff       	call   c01003d9 <__panic>

    p2 = alloc_page();
c01036ca:	83 ec 0c             	sub    $0xc,%esp
c01036cd:	6a 01                	push   $0x1
c01036cf:	e8 85 f4 ff ff       	call   c0102b59 <alloc_pages>
c01036d4:	83 c4 10             	add    $0x10,%esp
c01036d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
c01036da:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c01036df:	6a 06                	push   $0x6
c01036e1:	68 00 10 00 00       	push   $0x1000
c01036e6:	ff 75 e4             	pushl  -0x1c(%ebp)
c01036e9:	50                   	push   %eax
c01036ea:	e8 d1 fc ff ff       	call   c01033c0 <page_insert>
c01036ef:	83 c4 10             	add    $0x10,%esp
c01036f2:	85 c0                	test   %eax,%eax
c01036f4:	74 19                	je     c010370f <check_pgdir+0x223>
c01036f6:	68 30 64 10 c0       	push   $0xc0106430
c01036fb:	68 ad 62 10 c0       	push   $0xc01062ad
c0103700:	68 0a 02 00 00       	push   $0x20a
c0103705:	68 88 62 10 c0       	push   $0xc0106288
c010370a:	e8 ca cc ff ff       	call   c01003d9 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c010370f:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103714:	83 ec 04             	sub    $0x4,%esp
c0103717:	6a 00                	push   $0x0
c0103719:	68 00 10 00 00       	push   $0x1000
c010371e:	50                   	push   %eax
c010371f:	e8 8c fa ff ff       	call   c01031b0 <get_pte>
c0103724:	83 c4 10             	add    $0x10,%esp
c0103727:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010372a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010372e:	75 19                	jne    c0103749 <check_pgdir+0x25d>
c0103730:	68 68 64 10 c0       	push   $0xc0106468
c0103735:	68 ad 62 10 c0       	push   $0xc01062ad
c010373a:	68 0b 02 00 00       	push   $0x20b
c010373f:	68 88 62 10 c0       	push   $0xc0106288
c0103744:	e8 90 cc ff ff       	call   c01003d9 <__panic>
    assert(*ptep & PTE_U);
c0103749:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010374c:	8b 00                	mov    (%eax),%eax
c010374e:	83 e0 04             	and    $0x4,%eax
c0103751:	85 c0                	test   %eax,%eax
c0103753:	75 19                	jne    c010376e <check_pgdir+0x282>
c0103755:	68 98 64 10 c0       	push   $0xc0106498
c010375a:	68 ad 62 10 c0       	push   $0xc01062ad
c010375f:	68 0c 02 00 00       	push   $0x20c
c0103764:	68 88 62 10 c0       	push   $0xc0106288
c0103769:	e8 6b cc ff ff       	call   c01003d9 <__panic>
    assert(*ptep & PTE_W);
c010376e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103771:	8b 00                	mov    (%eax),%eax
c0103773:	83 e0 02             	and    $0x2,%eax
c0103776:	85 c0                	test   %eax,%eax
c0103778:	75 19                	jne    c0103793 <check_pgdir+0x2a7>
c010377a:	68 a6 64 10 c0       	push   $0xc01064a6
c010377f:	68 ad 62 10 c0       	push   $0xc01062ad
c0103784:	68 0d 02 00 00       	push   $0x20d
c0103789:	68 88 62 10 c0       	push   $0xc0106288
c010378e:	e8 46 cc ff ff       	call   c01003d9 <__panic>
    assert(boot_pgdir[0] & PTE_U);
c0103793:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103798:	8b 00                	mov    (%eax),%eax
c010379a:	83 e0 04             	and    $0x4,%eax
c010379d:	85 c0                	test   %eax,%eax
c010379f:	75 19                	jne    c01037ba <check_pgdir+0x2ce>
c01037a1:	68 b4 64 10 c0       	push   $0xc01064b4
c01037a6:	68 ad 62 10 c0       	push   $0xc01062ad
c01037ab:	68 0e 02 00 00       	push   $0x20e
c01037b0:	68 88 62 10 c0       	push   $0xc0106288
c01037b5:	e8 1f cc ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p2) == 1);
c01037ba:	83 ec 0c             	sub    $0xc,%esp
c01037bd:	ff 75 e4             	pushl  -0x1c(%ebp)
c01037c0:	e8 86 f1 ff ff       	call   c010294b <page_ref>
c01037c5:	83 c4 10             	add    $0x10,%esp
c01037c8:	83 f8 01             	cmp    $0x1,%eax
c01037cb:	74 19                	je     c01037e6 <check_pgdir+0x2fa>
c01037cd:	68 ca 64 10 c0       	push   $0xc01064ca
c01037d2:	68 ad 62 10 c0       	push   $0xc01062ad
c01037d7:	68 0f 02 00 00       	push   $0x20f
c01037dc:	68 88 62 10 c0       	push   $0xc0106288
c01037e1:	e8 f3 cb ff ff       	call   c01003d9 <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
c01037e6:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c01037eb:	6a 00                	push   $0x0
c01037ed:	68 00 10 00 00       	push   $0x1000
c01037f2:	ff 75 f4             	pushl  -0xc(%ebp)
c01037f5:	50                   	push   %eax
c01037f6:	e8 c5 fb ff ff       	call   c01033c0 <page_insert>
c01037fb:	83 c4 10             	add    $0x10,%esp
c01037fe:	85 c0                	test   %eax,%eax
c0103800:	74 19                	je     c010381b <check_pgdir+0x32f>
c0103802:	68 dc 64 10 c0       	push   $0xc01064dc
c0103807:	68 ad 62 10 c0       	push   $0xc01062ad
c010380c:	68 11 02 00 00       	push   $0x211
c0103811:	68 88 62 10 c0       	push   $0xc0106288
c0103816:	e8 be cb ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p1) == 2);
c010381b:	83 ec 0c             	sub    $0xc,%esp
c010381e:	ff 75 f4             	pushl  -0xc(%ebp)
c0103821:	e8 25 f1 ff ff       	call   c010294b <page_ref>
c0103826:	83 c4 10             	add    $0x10,%esp
c0103829:	83 f8 02             	cmp    $0x2,%eax
c010382c:	74 19                	je     c0103847 <check_pgdir+0x35b>
c010382e:	68 08 65 10 c0       	push   $0xc0106508
c0103833:	68 ad 62 10 c0       	push   $0xc01062ad
c0103838:	68 12 02 00 00       	push   $0x212
c010383d:	68 88 62 10 c0       	push   $0xc0106288
c0103842:	e8 92 cb ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p2) == 0);
c0103847:	83 ec 0c             	sub    $0xc,%esp
c010384a:	ff 75 e4             	pushl  -0x1c(%ebp)
c010384d:	e8 f9 f0 ff ff       	call   c010294b <page_ref>
c0103852:	83 c4 10             	add    $0x10,%esp
c0103855:	85 c0                	test   %eax,%eax
c0103857:	74 19                	je     c0103872 <check_pgdir+0x386>
c0103859:	68 1a 65 10 c0       	push   $0xc010651a
c010385e:	68 ad 62 10 c0       	push   $0xc01062ad
c0103863:	68 13 02 00 00       	push   $0x213
c0103868:	68 88 62 10 c0       	push   $0xc0106288
c010386d:	e8 67 cb ff ff       	call   c01003d9 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0103872:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103877:	83 ec 04             	sub    $0x4,%esp
c010387a:	6a 00                	push   $0x0
c010387c:	68 00 10 00 00       	push   $0x1000
c0103881:	50                   	push   %eax
c0103882:	e8 29 f9 ff ff       	call   c01031b0 <get_pte>
c0103887:	83 c4 10             	add    $0x10,%esp
c010388a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010388d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103891:	75 19                	jne    c01038ac <check_pgdir+0x3c0>
c0103893:	68 68 64 10 c0       	push   $0xc0106468
c0103898:	68 ad 62 10 c0       	push   $0xc01062ad
c010389d:	68 14 02 00 00       	push   $0x214
c01038a2:	68 88 62 10 c0       	push   $0xc0106288
c01038a7:	e8 2d cb ff ff       	call   c01003d9 <__panic>
    assert(pte2page(*ptep) == p1);
c01038ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01038af:	8b 00                	mov    (%eax),%eax
c01038b1:	83 ec 0c             	sub    $0xc,%esp
c01038b4:	50                   	push   %eax
c01038b5:	e8 3b f0 ff ff       	call   c01028f5 <pte2page>
c01038ba:	83 c4 10             	add    $0x10,%esp
c01038bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01038c0:	74 19                	je     c01038db <check_pgdir+0x3ef>
c01038c2:	68 dd 63 10 c0       	push   $0xc01063dd
c01038c7:	68 ad 62 10 c0       	push   $0xc01062ad
c01038cc:	68 15 02 00 00       	push   $0x215
c01038d1:	68 88 62 10 c0       	push   $0xc0106288
c01038d6:	e8 fe ca ff ff       	call   c01003d9 <__panic>
    assert((*ptep & PTE_U) == 0);
c01038db:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01038de:	8b 00                	mov    (%eax),%eax
c01038e0:	83 e0 04             	and    $0x4,%eax
c01038e3:	85 c0                	test   %eax,%eax
c01038e5:	74 19                	je     c0103900 <check_pgdir+0x414>
c01038e7:	68 2c 65 10 c0       	push   $0xc010652c
c01038ec:	68 ad 62 10 c0       	push   $0xc01062ad
c01038f1:	68 16 02 00 00       	push   $0x216
c01038f6:	68 88 62 10 c0       	push   $0xc0106288
c01038fb:	e8 d9 ca ff ff       	call   c01003d9 <__panic>

    page_remove(boot_pgdir, 0x0);
c0103900:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103905:	83 ec 08             	sub    $0x8,%esp
c0103908:	6a 00                	push   $0x0
c010390a:	50                   	push   %eax
c010390b:	e8 77 fa ff ff       	call   c0103387 <page_remove>
c0103910:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 1);
c0103913:	83 ec 0c             	sub    $0xc,%esp
c0103916:	ff 75 f4             	pushl  -0xc(%ebp)
c0103919:	e8 2d f0 ff ff       	call   c010294b <page_ref>
c010391e:	83 c4 10             	add    $0x10,%esp
c0103921:	83 f8 01             	cmp    $0x1,%eax
c0103924:	74 19                	je     c010393f <check_pgdir+0x453>
c0103926:	68 f3 63 10 c0       	push   $0xc01063f3
c010392b:	68 ad 62 10 c0       	push   $0xc01062ad
c0103930:	68 19 02 00 00       	push   $0x219
c0103935:	68 88 62 10 c0       	push   $0xc0106288
c010393a:	e8 9a ca ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p2) == 0);
c010393f:	83 ec 0c             	sub    $0xc,%esp
c0103942:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103945:	e8 01 f0 ff ff       	call   c010294b <page_ref>
c010394a:	83 c4 10             	add    $0x10,%esp
c010394d:	85 c0                	test   %eax,%eax
c010394f:	74 19                	je     c010396a <check_pgdir+0x47e>
c0103951:	68 1a 65 10 c0       	push   $0xc010651a
c0103956:	68 ad 62 10 c0       	push   $0xc01062ad
c010395b:	68 1a 02 00 00       	push   $0x21a
c0103960:	68 88 62 10 c0       	push   $0xc0106288
c0103965:	e8 6f ca ff ff       	call   c01003d9 <__panic>

    page_remove(boot_pgdir, PGSIZE);
c010396a:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c010396f:	83 ec 08             	sub    $0x8,%esp
c0103972:	68 00 10 00 00       	push   $0x1000
c0103977:	50                   	push   %eax
c0103978:	e8 0a fa ff ff       	call   c0103387 <page_remove>
c010397d:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 0);
c0103980:	83 ec 0c             	sub    $0xc,%esp
c0103983:	ff 75 f4             	pushl  -0xc(%ebp)
c0103986:	e8 c0 ef ff ff       	call   c010294b <page_ref>
c010398b:	83 c4 10             	add    $0x10,%esp
c010398e:	85 c0                	test   %eax,%eax
c0103990:	74 19                	je     c01039ab <check_pgdir+0x4bf>
c0103992:	68 41 65 10 c0       	push   $0xc0106541
c0103997:	68 ad 62 10 c0       	push   $0xc01062ad
c010399c:	68 1d 02 00 00       	push   $0x21d
c01039a1:	68 88 62 10 c0       	push   $0xc0106288
c01039a6:	e8 2e ca ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p2) == 0);
c01039ab:	83 ec 0c             	sub    $0xc,%esp
c01039ae:	ff 75 e4             	pushl  -0x1c(%ebp)
c01039b1:	e8 95 ef ff ff       	call   c010294b <page_ref>
c01039b6:	83 c4 10             	add    $0x10,%esp
c01039b9:	85 c0                	test   %eax,%eax
c01039bb:	74 19                	je     c01039d6 <check_pgdir+0x4ea>
c01039bd:	68 1a 65 10 c0       	push   $0xc010651a
c01039c2:	68 ad 62 10 c0       	push   $0xc01062ad
c01039c7:	68 1e 02 00 00       	push   $0x21e
c01039cc:	68 88 62 10 c0       	push   $0xc0106288
c01039d1:	e8 03 ca ff ff       	call   c01003d9 <__panic>

    assert(page_ref(pde2page(boot_pgdir[0])) == 1);
c01039d6:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c01039db:	8b 00                	mov    (%eax),%eax
c01039dd:	83 ec 0c             	sub    $0xc,%esp
c01039e0:	50                   	push   %eax
c01039e1:	e8 49 ef ff ff       	call   c010292f <pde2page>
c01039e6:	83 c4 10             	add    $0x10,%esp
c01039e9:	83 ec 0c             	sub    $0xc,%esp
c01039ec:	50                   	push   %eax
c01039ed:	e8 59 ef ff ff       	call   c010294b <page_ref>
c01039f2:	83 c4 10             	add    $0x10,%esp
c01039f5:	83 f8 01             	cmp    $0x1,%eax
c01039f8:	74 19                	je     c0103a13 <check_pgdir+0x527>
c01039fa:	68 54 65 10 c0       	push   $0xc0106554
c01039ff:	68 ad 62 10 c0       	push   $0xc01062ad
c0103a04:	68 20 02 00 00       	push   $0x220
c0103a09:	68 88 62 10 c0       	push   $0xc0106288
c0103a0e:	e8 c6 c9 ff ff       	call   c01003d9 <__panic>
    free_page(pde2page(boot_pgdir[0]));
c0103a13:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103a18:	8b 00                	mov    (%eax),%eax
c0103a1a:	83 ec 0c             	sub    $0xc,%esp
c0103a1d:	50                   	push   %eax
c0103a1e:	e8 0c ef ff ff       	call   c010292f <pde2page>
c0103a23:	83 c4 10             	add    $0x10,%esp
c0103a26:	83 ec 08             	sub    $0x8,%esp
c0103a29:	6a 01                	push   $0x1
c0103a2b:	50                   	push   %eax
c0103a2c:	e8 66 f1 ff ff       	call   c0102b97 <free_pages>
c0103a31:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103a34:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103a39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
c0103a3f:	83 ec 0c             	sub    $0xc,%esp
c0103a42:	68 7b 65 10 c0       	push   $0xc010657b
c0103a47:	e8 27 c8 ff ff       	call   c0100273 <cprintf>
c0103a4c:	83 c4 10             	add    $0x10,%esp
}
c0103a4f:	90                   	nop
c0103a50:	c9                   	leave  
c0103a51:	c3                   	ret    

c0103a52 <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
c0103a52:	55                   	push   %ebp
c0103a53:	89 e5                	mov    %esp,%ebp
c0103a55:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c0103a58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0103a5f:	e9 a3 00 00 00       	jmp    c0103b07 <check_boot_pgdir+0xb5>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
c0103a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103a67:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103a6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103a6d:	c1 e8 0c             	shr    $0xc,%eax
c0103a70:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0103a73:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0103a78:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0103a7b:	72 17                	jb     c0103a94 <check_boot_pgdir+0x42>
c0103a7d:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103a80:	68 c0 61 10 c0       	push   $0xc01061c0
c0103a85:	68 2c 02 00 00       	push   $0x22c
c0103a8a:	68 88 62 10 c0       	push   $0xc0106288
c0103a8f:	e8 45 c9 ff ff       	call   c01003d9 <__panic>
c0103a94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103a97:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103a9c:	89 c2                	mov    %eax,%edx
c0103a9e:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103aa3:	83 ec 04             	sub    $0x4,%esp
c0103aa6:	6a 00                	push   $0x0
c0103aa8:	52                   	push   %edx
c0103aa9:	50                   	push   %eax
c0103aaa:	e8 01 f7 ff ff       	call   c01031b0 <get_pte>
c0103aaf:	83 c4 10             	add    $0x10,%esp
c0103ab2:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103ab5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0103ab9:	75 19                	jne    c0103ad4 <check_boot_pgdir+0x82>
c0103abb:	68 98 65 10 c0       	push   $0xc0106598
c0103ac0:	68 ad 62 10 c0       	push   $0xc01062ad
c0103ac5:	68 2c 02 00 00       	push   $0x22c
c0103aca:	68 88 62 10 c0       	push   $0xc0106288
c0103acf:	e8 05 c9 ff ff       	call   c01003d9 <__panic>
        assert(PTE_ADDR(*ptep) == i);
c0103ad4:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103ad7:	8b 00                	mov    (%eax),%eax
c0103ad9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103ade:	89 c2                	mov    %eax,%edx
c0103ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103ae3:	39 c2                	cmp    %eax,%edx
c0103ae5:	74 19                	je     c0103b00 <check_boot_pgdir+0xae>
c0103ae7:	68 d5 65 10 c0       	push   $0xc01065d5
c0103aec:	68 ad 62 10 c0       	push   $0xc01062ad
c0103af1:	68 2d 02 00 00       	push   $0x22d
c0103af6:	68 88 62 10 c0       	push   $0xc0106288
c0103afb:	e8 d9 c8 ff ff       	call   c01003d9 <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
c0103b00:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
c0103b07:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103b0a:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0103b0f:	39 c2                	cmp    %eax,%edx
c0103b11:	0f 82 4d ff ff ff    	jb     c0103a64 <check_boot_pgdir+0x12>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
c0103b17:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103b1c:	05 ac 0f 00 00       	add    $0xfac,%eax
c0103b21:	8b 00                	mov    (%eax),%eax
c0103b23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103b28:	89 c2                	mov    %eax,%edx
c0103b2a:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103b2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103b32:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c0103b39:	77 17                	ja     c0103b52 <check_boot_pgdir+0x100>
c0103b3b:	ff 75 f0             	pushl  -0x10(%ebp)
c0103b3e:	68 64 62 10 c0       	push   $0xc0106264
c0103b43:	68 30 02 00 00       	push   $0x230
c0103b48:	68 88 62 10 c0       	push   $0xc0106288
c0103b4d:	e8 87 c8 ff ff       	call   c01003d9 <__panic>
c0103b52:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103b55:	05 00 00 00 40       	add    $0x40000000,%eax
c0103b5a:	39 d0                	cmp    %edx,%eax
c0103b5c:	74 19                	je     c0103b77 <check_boot_pgdir+0x125>
c0103b5e:	68 ec 65 10 c0       	push   $0xc01065ec
c0103b63:	68 ad 62 10 c0       	push   $0xc01062ad
c0103b68:	68 30 02 00 00       	push   $0x230
c0103b6d:	68 88 62 10 c0       	push   $0xc0106288
c0103b72:	e8 62 c8 ff ff       	call   c01003d9 <__panic>

    assert(boot_pgdir[0] == 0);
c0103b77:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103b7c:	8b 00                	mov    (%eax),%eax
c0103b7e:	85 c0                	test   %eax,%eax
c0103b80:	74 19                	je     c0103b9b <check_boot_pgdir+0x149>
c0103b82:	68 20 66 10 c0       	push   $0xc0106620
c0103b87:	68 ad 62 10 c0       	push   $0xc01062ad
c0103b8c:	68 32 02 00 00       	push   $0x232
c0103b91:	68 88 62 10 c0       	push   $0xc0106288
c0103b96:	e8 3e c8 ff ff       	call   c01003d9 <__panic>

    struct Page *p;
    p = alloc_page();
c0103b9b:	83 ec 0c             	sub    $0xc,%esp
c0103b9e:	6a 01                	push   $0x1
c0103ba0:	e8 b4 ef ff ff       	call   c0102b59 <alloc_pages>
c0103ba5:	83 c4 10             	add    $0x10,%esp
c0103ba8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
c0103bab:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103bb0:	6a 02                	push   $0x2
c0103bb2:	68 00 01 00 00       	push   $0x100
c0103bb7:	ff 75 ec             	pushl  -0x14(%ebp)
c0103bba:	50                   	push   %eax
c0103bbb:	e8 00 f8 ff ff       	call   c01033c0 <page_insert>
c0103bc0:	83 c4 10             	add    $0x10,%esp
c0103bc3:	85 c0                	test   %eax,%eax
c0103bc5:	74 19                	je     c0103be0 <check_boot_pgdir+0x18e>
c0103bc7:	68 34 66 10 c0       	push   $0xc0106634
c0103bcc:	68 ad 62 10 c0       	push   $0xc01062ad
c0103bd1:	68 36 02 00 00       	push   $0x236
c0103bd6:	68 88 62 10 c0       	push   $0xc0106288
c0103bdb:	e8 f9 c7 ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p) == 1);
c0103be0:	83 ec 0c             	sub    $0xc,%esp
c0103be3:	ff 75 ec             	pushl  -0x14(%ebp)
c0103be6:	e8 60 ed ff ff       	call   c010294b <page_ref>
c0103beb:	83 c4 10             	add    $0x10,%esp
c0103bee:	83 f8 01             	cmp    $0x1,%eax
c0103bf1:	74 19                	je     c0103c0c <check_boot_pgdir+0x1ba>
c0103bf3:	68 62 66 10 c0       	push   $0xc0106662
c0103bf8:	68 ad 62 10 c0       	push   $0xc01062ad
c0103bfd:	68 37 02 00 00       	push   $0x237
c0103c02:	68 88 62 10 c0       	push   $0xc0106288
c0103c07:	e8 cd c7 ff ff       	call   c01003d9 <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
c0103c0c:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103c11:	6a 02                	push   $0x2
c0103c13:	68 00 11 00 00       	push   $0x1100
c0103c18:	ff 75 ec             	pushl  -0x14(%ebp)
c0103c1b:	50                   	push   %eax
c0103c1c:	e8 9f f7 ff ff       	call   c01033c0 <page_insert>
c0103c21:	83 c4 10             	add    $0x10,%esp
c0103c24:	85 c0                	test   %eax,%eax
c0103c26:	74 19                	je     c0103c41 <check_boot_pgdir+0x1ef>
c0103c28:	68 74 66 10 c0       	push   $0xc0106674
c0103c2d:	68 ad 62 10 c0       	push   $0xc01062ad
c0103c32:	68 38 02 00 00       	push   $0x238
c0103c37:	68 88 62 10 c0       	push   $0xc0106288
c0103c3c:	e8 98 c7 ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p) == 2);
c0103c41:	83 ec 0c             	sub    $0xc,%esp
c0103c44:	ff 75 ec             	pushl  -0x14(%ebp)
c0103c47:	e8 ff ec ff ff       	call   c010294b <page_ref>
c0103c4c:	83 c4 10             	add    $0x10,%esp
c0103c4f:	83 f8 02             	cmp    $0x2,%eax
c0103c52:	74 19                	je     c0103c6d <check_boot_pgdir+0x21b>
c0103c54:	68 ab 66 10 c0       	push   $0xc01066ab
c0103c59:	68 ad 62 10 c0       	push   $0xc01062ad
c0103c5e:	68 39 02 00 00       	push   $0x239
c0103c63:	68 88 62 10 c0       	push   $0xc0106288
c0103c68:	e8 6c c7 ff ff       	call   c01003d9 <__panic>

    const char *str = "ucore: Hello world!!";
c0103c6d:	c7 45 e8 bc 66 10 c0 	movl   $0xc01066bc,-0x18(%ebp)
    strcpy((void *)0x100, str);
c0103c74:	83 ec 08             	sub    $0x8,%esp
c0103c77:	ff 75 e8             	pushl  -0x18(%ebp)
c0103c7a:	68 00 01 00 00       	push   $0x100
c0103c7f:	e8 80 13 00 00       	call   c0105004 <strcpy>
c0103c84:	83 c4 10             	add    $0x10,%esp
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
c0103c87:	83 ec 08             	sub    $0x8,%esp
c0103c8a:	68 00 11 00 00       	push   $0x1100
c0103c8f:	68 00 01 00 00       	push   $0x100
c0103c94:	e8 e5 13 00 00       	call   c010507e <strcmp>
c0103c99:	83 c4 10             	add    $0x10,%esp
c0103c9c:	85 c0                	test   %eax,%eax
c0103c9e:	74 19                	je     c0103cb9 <check_boot_pgdir+0x267>
c0103ca0:	68 d4 66 10 c0       	push   $0xc01066d4
c0103ca5:	68 ad 62 10 c0       	push   $0xc01062ad
c0103caa:	68 3d 02 00 00       	push   $0x23d
c0103caf:	68 88 62 10 c0       	push   $0xc0106288
c0103cb4:	e8 20 c7 ff ff       	call   c01003d9 <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
c0103cb9:	83 ec 0c             	sub    $0xc,%esp
c0103cbc:	ff 75 ec             	pushl  -0x14(%ebp)
c0103cbf:	e8 ec eb ff ff       	call   c01028b0 <page2kva>
c0103cc4:	83 c4 10             	add    $0x10,%esp
c0103cc7:	05 00 01 00 00       	add    $0x100,%eax
c0103ccc:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
c0103ccf:	83 ec 0c             	sub    $0xc,%esp
c0103cd2:	68 00 01 00 00       	push   $0x100
c0103cd7:	e8 d0 12 00 00       	call   c0104fac <strlen>
c0103cdc:	83 c4 10             	add    $0x10,%esp
c0103cdf:	85 c0                	test   %eax,%eax
c0103ce1:	74 19                	je     c0103cfc <check_boot_pgdir+0x2aa>
c0103ce3:	68 0c 67 10 c0       	push   $0xc010670c
c0103ce8:	68 ad 62 10 c0       	push   $0xc01062ad
c0103ced:	68 40 02 00 00       	push   $0x240
c0103cf2:	68 88 62 10 c0       	push   $0xc0106288
c0103cf7:	e8 dd c6 ff ff       	call   c01003d9 <__panic>

    free_page(p);
c0103cfc:	83 ec 08             	sub    $0x8,%esp
c0103cff:	6a 01                	push   $0x1
c0103d01:	ff 75 ec             	pushl  -0x14(%ebp)
c0103d04:	e8 8e ee ff ff       	call   c0102b97 <free_pages>
c0103d09:	83 c4 10             	add    $0x10,%esp
    free_page(pde2page(boot_pgdir[0]));
c0103d0c:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103d11:	8b 00                	mov    (%eax),%eax
c0103d13:	83 ec 0c             	sub    $0xc,%esp
c0103d16:	50                   	push   %eax
c0103d17:	e8 13 ec ff ff       	call   c010292f <pde2page>
c0103d1c:	83 c4 10             	add    $0x10,%esp
c0103d1f:	83 ec 08             	sub    $0x8,%esp
c0103d22:	6a 01                	push   $0x1
c0103d24:	50                   	push   %eax
c0103d25:	e8 6d ee ff ff       	call   c0102b97 <free_pages>
c0103d2a:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103d2d:	a1 e0 79 11 c0       	mov    0xc01179e0,%eax
c0103d32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
c0103d38:	83 ec 0c             	sub    $0xc,%esp
c0103d3b:	68 30 67 10 c0       	push   $0xc0106730
c0103d40:	e8 2e c5 ff ff       	call   c0100273 <cprintf>
c0103d45:	83 c4 10             	add    $0x10,%esp
}
c0103d48:	90                   	nop
c0103d49:	c9                   	leave  
c0103d4a:	c3                   	ret    

c0103d4b <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
c0103d4b:	55                   	push   %ebp
c0103d4c:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
c0103d4e:	8b 45 08             	mov    0x8(%ebp),%eax
c0103d51:	83 e0 04             	and    $0x4,%eax
c0103d54:	85 c0                	test   %eax,%eax
c0103d56:	74 07                	je     c0103d5f <perm2str+0x14>
c0103d58:	b8 75 00 00 00       	mov    $0x75,%eax
c0103d5d:	eb 05                	jmp    c0103d64 <perm2str+0x19>
c0103d5f:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103d64:	a2 08 af 11 c0       	mov    %al,0xc011af08
    str[1] = 'r';
c0103d69:	c6 05 09 af 11 c0 72 	movb   $0x72,0xc011af09
    str[2] = (perm & PTE_W) ? 'w' : '-';
c0103d70:	8b 45 08             	mov    0x8(%ebp),%eax
c0103d73:	83 e0 02             	and    $0x2,%eax
c0103d76:	85 c0                	test   %eax,%eax
c0103d78:	74 07                	je     c0103d81 <perm2str+0x36>
c0103d7a:	b8 77 00 00 00       	mov    $0x77,%eax
c0103d7f:	eb 05                	jmp    c0103d86 <perm2str+0x3b>
c0103d81:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103d86:	a2 0a af 11 c0       	mov    %al,0xc011af0a
    str[3] = '\0';
c0103d8b:	c6 05 0b af 11 c0 00 	movb   $0x0,0xc011af0b
    return str;
c0103d92:	b8 08 af 11 c0       	mov    $0xc011af08,%eax
}
c0103d97:	5d                   	pop    %ebp
c0103d98:	c3                   	ret    

c0103d99 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
c0103d99:	55                   	push   %ebp
c0103d9a:	89 e5                	mov    %esp,%ebp
c0103d9c:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
c0103d9f:	8b 45 10             	mov    0x10(%ebp),%eax
c0103da2:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103da5:	72 0e                	jb     c0103db5 <get_pgtable_items+0x1c>
        return 0;
c0103da7:	b8 00 00 00 00       	mov    $0x0,%eax
c0103dac:	e9 9a 00 00 00       	jmp    c0103e4b <get_pgtable_items+0xb2>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
c0103db1:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
c0103db5:	8b 45 10             	mov    0x10(%ebp),%eax
c0103db8:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103dbb:	73 18                	jae    c0103dd5 <get_pgtable_items+0x3c>
c0103dbd:	8b 45 10             	mov    0x10(%ebp),%eax
c0103dc0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103dc7:	8b 45 14             	mov    0x14(%ebp),%eax
c0103dca:	01 d0                	add    %edx,%eax
c0103dcc:	8b 00                	mov    (%eax),%eax
c0103dce:	83 e0 01             	and    $0x1,%eax
c0103dd1:	85 c0                	test   %eax,%eax
c0103dd3:	74 dc                	je     c0103db1 <get_pgtable_items+0x18>
    }
    if (start < right) {
c0103dd5:	8b 45 10             	mov    0x10(%ebp),%eax
c0103dd8:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103ddb:	73 69                	jae    c0103e46 <get_pgtable_items+0xad>
        if (left_store != NULL) {
c0103ddd:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
c0103de1:	74 08                	je     c0103deb <get_pgtable_items+0x52>
            *left_store = start;
c0103de3:	8b 45 18             	mov    0x18(%ebp),%eax
c0103de6:	8b 55 10             	mov    0x10(%ebp),%edx
c0103de9:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
c0103deb:	8b 45 10             	mov    0x10(%ebp),%eax
c0103dee:	8d 50 01             	lea    0x1(%eax),%edx
c0103df1:	89 55 10             	mov    %edx,0x10(%ebp)
c0103df4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103dfb:	8b 45 14             	mov    0x14(%ebp),%eax
c0103dfe:	01 d0                	add    %edx,%eax
c0103e00:	8b 00                	mov    (%eax),%eax
c0103e02:	83 e0 07             	and    $0x7,%eax
c0103e05:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0103e08:	eb 04                	jmp    c0103e0e <get_pgtable_items+0x75>
            start ++;
c0103e0a:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0103e0e:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e11:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103e14:	73 1d                	jae    c0103e33 <get_pgtable_items+0x9a>
c0103e16:	8b 45 10             	mov    0x10(%ebp),%eax
c0103e19:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0103e20:	8b 45 14             	mov    0x14(%ebp),%eax
c0103e23:	01 d0                	add    %edx,%eax
c0103e25:	8b 00                	mov    (%eax),%eax
c0103e27:	83 e0 07             	and    $0x7,%eax
c0103e2a:	89 c2                	mov    %eax,%edx
c0103e2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103e2f:	39 c2                	cmp    %eax,%edx
c0103e31:	74 d7                	je     c0103e0a <get_pgtable_items+0x71>
        }
        if (right_store != NULL) {
c0103e33:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0103e37:	74 08                	je     c0103e41 <get_pgtable_items+0xa8>
            *right_store = start;
c0103e39:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0103e3c:	8b 55 10             	mov    0x10(%ebp),%edx
c0103e3f:	89 10                	mov    %edx,(%eax)
        }
        return perm;
c0103e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103e44:	eb 05                	jmp    c0103e4b <get_pgtable_items+0xb2>
    }
    return 0;
c0103e46:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103e4b:	c9                   	leave  
c0103e4c:	c3                   	ret    

c0103e4d <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
c0103e4d:	55                   	push   %ebp
c0103e4e:	89 e5                	mov    %esp,%ebp
c0103e50:	57                   	push   %edi
c0103e51:	56                   	push   %esi
c0103e52:	53                   	push   %ebx
c0103e53:	83 ec 2c             	sub    $0x2c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
c0103e56:	83 ec 0c             	sub    $0xc,%esp
c0103e59:	68 50 67 10 c0       	push   $0xc0106750
c0103e5e:	e8 10 c4 ff ff       	call   c0100273 <cprintf>
c0103e63:	83 c4 10             	add    $0x10,%esp
    size_t left, right = 0, perm;
c0103e66:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0103e6d:	e9 e5 00 00 00       	jmp    c0103f57 <print_pgdir+0x10a>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c0103e72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103e75:	83 ec 0c             	sub    $0xc,%esp
c0103e78:	50                   	push   %eax
c0103e79:	e8 cd fe ff ff       	call   c0103d4b <perm2str>
c0103e7e:	83 c4 10             	add    $0x10,%esp
c0103e81:	89 c7                	mov    %eax,%edi
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
c0103e83:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103e86:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103e89:	29 c2                	sub    %eax,%edx
c0103e8b:	89 d0                	mov    %edx,%eax
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c0103e8d:	c1 e0 16             	shl    $0x16,%eax
c0103e90:	89 c3                	mov    %eax,%ebx
c0103e92:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103e95:	c1 e0 16             	shl    $0x16,%eax
c0103e98:	89 c1                	mov    %eax,%ecx
c0103e9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103e9d:	c1 e0 16             	shl    $0x16,%eax
c0103ea0:	89 c2                	mov    %eax,%edx
c0103ea2:	8b 75 dc             	mov    -0x24(%ebp),%esi
c0103ea5:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103ea8:	29 c6                	sub    %eax,%esi
c0103eaa:	89 f0                	mov    %esi,%eax
c0103eac:	83 ec 08             	sub    $0x8,%esp
c0103eaf:	57                   	push   %edi
c0103eb0:	53                   	push   %ebx
c0103eb1:	51                   	push   %ecx
c0103eb2:	52                   	push   %edx
c0103eb3:	50                   	push   %eax
c0103eb4:	68 81 67 10 c0       	push   $0xc0106781
c0103eb9:	e8 b5 c3 ff ff       	call   c0100273 <cprintf>
c0103ebe:	83 c4 20             	add    $0x20,%esp
        size_t l, r = left * NPTEENTRY;
c0103ec1:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103ec4:	c1 e0 0a             	shl    $0xa,%eax
c0103ec7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0103eca:	eb 4f                	jmp    c0103f1b <print_pgdir+0xce>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0103ecc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103ecf:	83 ec 0c             	sub    $0xc,%esp
c0103ed2:	50                   	push   %eax
c0103ed3:	e8 73 fe ff ff       	call   c0103d4b <perm2str>
c0103ed8:	83 c4 10             	add    $0x10,%esp
c0103edb:	89 c7                	mov    %eax,%edi
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
c0103edd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103ee0:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0103ee3:	29 c2                	sub    %eax,%edx
c0103ee5:	89 d0                	mov    %edx,%eax
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0103ee7:	c1 e0 0c             	shl    $0xc,%eax
c0103eea:	89 c3                	mov    %eax,%ebx
c0103eec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0103eef:	c1 e0 0c             	shl    $0xc,%eax
c0103ef2:	89 c1                	mov    %eax,%ecx
c0103ef4:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0103ef7:	c1 e0 0c             	shl    $0xc,%eax
c0103efa:	89 c2                	mov    %eax,%edx
c0103efc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
c0103eff:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0103f02:	29 c6                	sub    %eax,%esi
c0103f04:	89 f0                	mov    %esi,%eax
c0103f06:	83 ec 08             	sub    $0x8,%esp
c0103f09:	57                   	push   %edi
c0103f0a:	53                   	push   %ebx
c0103f0b:	51                   	push   %ecx
c0103f0c:	52                   	push   %edx
c0103f0d:	50                   	push   %eax
c0103f0e:	68 a0 67 10 c0       	push   $0xc01067a0
c0103f13:	e8 5b c3 ff ff       	call   c0100273 <cprintf>
c0103f18:	83 c4 20             	add    $0x20,%esp
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0103f1b:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
c0103f20:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0103f23:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f26:	89 d3                	mov    %edx,%ebx
c0103f28:	c1 e3 0a             	shl    $0xa,%ebx
c0103f2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0103f2e:	89 d1                	mov    %edx,%ecx
c0103f30:	c1 e1 0a             	shl    $0xa,%ecx
c0103f33:	83 ec 08             	sub    $0x8,%esp
c0103f36:	8d 55 d4             	lea    -0x2c(%ebp),%edx
c0103f39:	52                   	push   %edx
c0103f3a:	8d 55 d8             	lea    -0x28(%ebp),%edx
c0103f3d:	52                   	push   %edx
c0103f3e:	56                   	push   %esi
c0103f3f:	50                   	push   %eax
c0103f40:	53                   	push   %ebx
c0103f41:	51                   	push   %ecx
c0103f42:	e8 52 fe ff ff       	call   c0103d99 <get_pgtable_items>
c0103f47:	83 c4 20             	add    $0x20,%esp
c0103f4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103f4d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0103f51:	0f 85 75 ff ff ff    	jne    c0103ecc <print_pgdir+0x7f>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0103f57:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
c0103f5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103f5f:	83 ec 08             	sub    $0x8,%esp
c0103f62:	8d 55 dc             	lea    -0x24(%ebp),%edx
c0103f65:	52                   	push   %edx
c0103f66:	8d 55 e0             	lea    -0x20(%ebp),%edx
c0103f69:	52                   	push   %edx
c0103f6a:	51                   	push   %ecx
c0103f6b:	50                   	push   %eax
c0103f6c:	68 00 04 00 00       	push   $0x400
c0103f71:	6a 00                	push   $0x0
c0103f73:	e8 21 fe ff ff       	call   c0103d99 <get_pgtable_items>
c0103f78:	83 c4 20             	add    $0x20,%esp
c0103f7b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103f7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0103f82:	0f 85 ea fe ff ff    	jne    c0103e72 <print_pgdir+0x25>
        }
    }
    cprintf("--------------------- END ---------------------\n");
c0103f88:	83 ec 0c             	sub    $0xc,%esp
c0103f8b:	68 c4 67 10 c0       	push   $0xc01067c4
c0103f90:	e8 de c2 ff ff       	call   c0100273 <cprintf>
c0103f95:	83 c4 10             	add    $0x10,%esp
}
c0103f98:	90                   	nop
c0103f99:	8d 65 f4             	lea    -0xc(%ebp),%esp
c0103f9c:	5b                   	pop    %ebx
c0103f9d:	5e                   	pop    %esi
c0103f9e:	5f                   	pop    %edi
c0103f9f:	5d                   	pop    %ebp
c0103fa0:	c3                   	ret    

c0103fa1 <page2ppn>:
page2ppn(struct Page *page) {
c0103fa1:	55                   	push   %ebp
c0103fa2:	89 e5                	mov    %esp,%ebp
    return page - pages;
c0103fa4:	8b 45 08             	mov    0x8(%ebp),%eax
c0103fa7:	8b 15 18 af 11 c0    	mov    0xc011af18,%edx
c0103fad:	29 d0                	sub    %edx,%eax
c0103faf:	c1 f8 02             	sar    $0x2,%eax
c0103fb2:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0103fb8:	5d                   	pop    %ebp
c0103fb9:	c3                   	ret    

c0103fba <page2pa>:
page2pa(struct Page *page) {
c0103fba:	55                   	push   %ebp
c0103fbb:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c0103fbd:	ff 75 08             	pushl  0x8(%ebp)
c0103fc0:	e8 dc ff ff ff       	call   c0103fa1 <page2ppn>
c0103fc5:	83 c4 04             	add    $0x4,%esp
c0103fc8:	c1 e0 0c             	shl    $0xc,%eax
}
c0103fcb:	c9                   	leave  
c0103fcc:	c3                   	ret    

c0103fcd <page_ref>:
page_ref(struct Page *page) {
c0103fcd:	55                   	push   %ebp
c0103fce:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0103fd0:	8b 45 08             	mov    0x8(%ebp),%eax
c0103fd3:	8b 00                	mov    (%eax),%eax
}
c0103fd5:	5d                   	pop    %ebp
c0103fd6:	c3                   	ret    

c0103fd7 <set_page_ref>:
set_page_ref(struct Page *page, int val) {
c0103fd7:	55                   	push   %ebp
c0103fd8:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0103fda:	8b 45 08             	mov    0x8(%ebp),%eax
c0103fdd:	8b 55 0c             	mov    0xc(%ebp),%edx
c0103fe0:	89 10                	mov    %edx,(%eax)
}
c0103fe2:	90                   	nop
c0103fe3:	5d                   	pop    %ebp
c0103fe4:	c3                   	ret    

c0103fe5 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
c0103fe5:	55                   	push   %ebp
c0103fe6:	89 e5                	mov    %esp,%ebp
c0103fe8:	83 ec 10             	sub    $0x10,%esp
c0103feb:	c7 45 fc 1c af 11 c0 	movl   $0xc011af1c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c0103ff2:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103ff5:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0103ff8:	89 50 04             	mov    %edx,0x4(%eax)
c0103ffb:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103ffe:	8b 50 04             	mov    0x4(%eax),%edx
c0104001:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104004:	89 10                	mov    %edx,(%eax)
    list_init(&free_list);
    nr_free = 0;
c0104006:	c7 05 24 af 11 c0 00 	movl   $0x0,0xc011af24
c010400d:	00 00 00 
}
c0104010:	90                   	nop
c0104011:	c9                   	leave  
c0104012:	c3                   	ret    

c0104013 <default_init_memmap>:

static void
default_init_memmap(struct Page *base, size_t n) {
c0104013:	55                   	push   %ebp
c0104014:	89 e5                	mov    %esp,%ebp
c0104016:	83 ec 38             	sub    $0x38,%esp
    assert(n > 0);
c0104019:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010401d:	75 16                	jne    c0104035 <default_init_memmap+0x22>
c010401f:	68 f8 67 10 c0       	push   $0xc01067f8
c0104024:	68 fe 67 10 c0       	push   $0xc01067fe
c0104029:	6a 6d                	push   $0x6d
c010402b:	68 13 68 10 c0       	push   $0xc0106813
c0104030:	e8 a4 c3 ff ff       	call   c01003d9 <__panic>
    struct Page *p = base;
c0104035:	8b 45 08             	mov    0x8(%ebp),%eax
c0104038:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c010403b:	eb 6c                	jmp    c01040a9 <default_init_memmap+0x96>
        assert(PageReserved(p));
c010403d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104040:	83 c0 04             	add    $0x4,%eax
c0104043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c010404a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c010404d:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104050:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0104053:	0f a3 10             	bt     %edx,(%eax)
c0104056:	19 c0                	sbb    %eax,%eax
c0104058:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
c010405b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c010405f:	0f 95 c0             	setne  %al
c0104062:	0f b6 c0             	movzbl %al,%eax
c0104065:	85 c0                	test   %eax,%eax
c0104067:	75 16                	jne    c010407f <default_init_memmap+0x6c>
c0104069:	68 29 68 10 c0       	push   $0xc0106829
c010406e:	68 fe 67 10 c0       	push   $0xc01067fe
c0104073:	6a 70                	push   $0x70
c0104075:	68 13 68 10 c0       	push   $0xc0106813
c010407a:	e8 5a c3 ff ff       	call   c01003d9 <__panic>
        p->flags = p->property = 0;
c010407f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104082:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
c0104089:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010408c:	8b 50 08             	mov    0x8(%eax),%edx
c010408f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104092:	89 50 04             	mov    %edx,0x4(%eax)
        set_page_ref(p, 0);
c0104095:	83 ec 08             	sub    $0x8,%esp
c0104098:	6a 00                	push   $0x0
c010409a:	ff 75 f4             	pushl  -0xc(%ebp)
c010409d:	e8 35 ff ff ff       	call   c0103fd7 <set_page_ref>
c01040a2:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
c01040a5:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c01040a9:	8b 55 0c             	mov    0xc(%ebp),%edx
c01040ac:	89 d0                	mov    %edx,%eax
c01040ae:	c1 e0 02             	shl    $0x2,%eax
c01040b1:	01 d0                	add    %edx,%eax
c01040b3:	c1 e0 02             	shl    $0x2,%eax
c01040b6:	89 c2                	mov    %eax,%edx
c01040b8:	8b 45 08             	mov    0x8(%ebp),%eax
c01040bb:	01 d0                	add    %edx,%eax
c01040bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01040c0:	0f 85 77 ff ff ff    	jne    c010403d <default_init_memmap+0x2a>
    }
    base->property = n;
c01040c6:	8b 45 08             	mov    0x8(%ebp),%eax
c01040c9:	8b 55 0c             	mov    0xc(%ebp),%edx
c01040cc:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
c01040cf:	8b 45 08             	mov    0x8(%ebp),%eax
c01040d2:	83 c0 04             	add    $0x4,%eax
c01040d5:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c01040dc:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01040df:	8b 45 cc             	mov    -0x34(%ebp),%eax
c01040e2:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01040e5:	0f ab 10             	bts    %edx,(%eax)
    nr_free += n;
c01040e8:	8b 15 24 af 11 c0    	mov    0xc011af24,%edx
c01040ee:	8b 45 0c             	mov    0xc(%ebp),%eax
c01040f1:	01 d0                	add    %edx,%eax
c01040f3:	a3 24 af 11 c0       	mov    %eax,0xc011af24
    list_add_before(&free_list, &(base->page_link));
c01040f8:	8b 45 08             	mov    0x8(%ebp),%eax
c01040fb:	83 c0 0c             	add    $0xc,%eax
c01040fe:	c7 45 e4 1c af 11 c0 	movl   $0xc011af1c,-0x1c(%ebp)
c0104105:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
c0104108:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010410b:	8b 00                	mov    (%eax),%eax
c010410d:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104110:	89 55 dc             	mov    %edx,-0x24(%ebp)
c0104113:	89 45 d8             	mov    %eax,-0x28(%ebp)
c0104116:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104119:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c010411c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010411f:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104122:	89 10                	mov    %edx,(%eax)
c0104124:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104127:	8b 10                	mov    (%eax),%edx
c0104129:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010412c:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c010412f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104132:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104135:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0104138:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010413b:	8b 55 d8             	mov    -0x28(%ebp),%edx
c010413e:	89 10                	mov    %edx,(%eax)
}
c0104140:	90                   	nop
c0104141:	c9                   	leave  
c0104142:	c3                   	ret    

c0104143 <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
c0104143:	55                   	push   %ebp
c0104144:	89 e5                	mov    %esp,%ebp
c0104146:	83 ec 58             	sub    $0x58,%esp
    assert(n > 0);
c0104149:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c010414d:	75 16                	jne    c0104165 <default_alloc_pages+0x22>
c010414f:	68 f8 67 10 c0       	push   $0xc01067f8
c0104154:	68 fe 67 10 c0       	push   $0xc01067fe
c0104159:	6a 7c                	push   $0x7c
c010415b:	68 13 68 10 c0       	push   $0xc0106813
c0104160:	e8 74 c2 ff ff       	call   c01003d9 <__panic>
    if (n > nr_free) {
c0104165:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c010416a:	39 45 08             	cmp    %eax,0x8(%ebp)
c010416d:	76 0a                	jbe    c0104179 <default_alloc_pages+0x36>
        return NULL;
c010416f:	b8 00 00 00 00       	mov    $0x0,%eax
c0104174:	e9 3d 01 00 00       	jmp    c01042b6 <default_alloc_pages+0x173>
    }
    struct Page *page = NULL;
c0104179:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
c0104180:	c7 45 f0 1c af 11 c0 	movl   $0xc011af1c,-0x10(%ebp)
    // TODO: optimize (next-fit)
    while ((le = list_next(le)) != &free_list) {
c0104187:	eb 1c                	jmp    c01041a5 <default_alloc_pages+0x62>
        struct Page *p = le2page(le, page_link);
c0104189:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010418c:	83 e8 0c             	sub    $0xc,%eax
c010418f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (p->property >= n) {
c0104192:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104195:	8b 40 08             	mov    0x8(%eax),%eax
c0104198:	39 45 08             	cmp    %eax,0x8(%ebp)
c010419b:	77 08                	ja     c01041a5 <default_alloc_pages+0x62>
            page = p;
c010419d:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01041a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
c01041a3:	eb 18                	jmp    c01041bd <default_alloc_pages+0x7a>
c01041a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01041a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return listelm->next;
c01041ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01041ae:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c01041b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01041b4:	81 7d f0 1c af 11 c0 	cmpl   $0xc011af1c,-0x10(%ebp)
c01041bb:	75 cc                	jne    c0104189 <default_alloc_pages+0x46>
        }
    }
    if (page != NULL) {
c01041bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01041c1:	0f 84 ec 00 00 00    	je     c01042b3 <default_alloc_pages+0x170>
        if (page->property > n) {
c01041c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01041ca:	8b 40 08             	mov    0x8(%eax),%eax
c01041cd:	39 45 08             	cmp    %eax,0x8(%ebp)
c01041d0:	0f 83 8c 00 00 00    	jae    c0104262 <default_alloc_pages+0x11f>
            struct Page *p = page + n;
c01041d6:	8b 55 08             	mov    0x8(%ebp),%edx
c01041d9:	89 d0                	mov    %edx,%eax
c01041db:	c1 e0 02             	shl    $0x2,%eax
c01041de:	01 d0                	add    %edx,%eax
c01041e0:	c1 e0 02             	shl    $0x2,%eax
c01041e3:	89 c2                	mov    %eax,%edx
c01041e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01041e8:	01 d0                	add    %edx,%eax
c01041ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
            p->property = page->property - n;
c01041ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01041f0:	8b 40 08             	mov    0x8(%eax),%eax
c01041f3:	2b 45 08             	sub    0x8(%ebp),%eax
c01041f6:	89 c2                	mov    %eax,%edx
c01041f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01041fb:	89 50 08             	mov    %edx,0x8(%eax)
            SetPageProperty(p);
c01041fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104201:	83 c0 04             	add    $0x4,%eax
c0104204:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
c010420b:	89 45 c8             	mov    %eax,-0x38(%ebp)
c010420e:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0104211:	8b 55 cc             	mov    -0x34(%ebp),%edx
c0104214:	0f ab 10             	bts    %edx,(%eax)
            list_add_after(&(page->page_link), &(p->page_link));
c0104217:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010421a:	83 c0 0c             	add    $0xc,%eax
c010421d:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0104220:	83 c2 0c             	add    $0xc,%edx
c0104223:	89 55 e0             	mov    %edx,-0x20(%ebp)
c0104226:	89 45 dc             	mov    %eax,-0x24(%ebp)
    __list_add(elm, listelm, listelm->next);
c0104229:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010422c:	8b 40 04             	mov    0x4(%eax),%eax
c010422f:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104232:	89 55 d8             	mov    %edx,-0x28(%ebp)
c0104235:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104238:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c010423b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    prev->next = next->prev = elm;
c010423e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104241:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104244:	89 10                	mov    %edx,(%eax)
c0104246:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104249:	8b 10                	mov    (%eax),%edx
c010424b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010424e:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0104251:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104254:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104257:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c010425a:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010425d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104260:	89 10                	mov    %edx,(%eax)
        }
        list_del(&(page->page_link));
c0104262:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104265:	83 c0 0c             	add    $0xc,%eax
c0104268:	89 45 bc             	mov    %eax,-0x44(%ebp)
    __list_del(listelm->prev, listelm->next);
c010426b:	8b 45 bc             	mov    -0x44(%ebp),%eax
c010426e:	8b 40 04             	mov    0x4(%eax),%eax
c0104271:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0104274:	8b 12                	mov    (%edx),%edx
c0104276:	89 55 b8             	mov    %edx,-0x48(%ebp)
c0104279:	89 45 b4             	mov    %eax,-0x4c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c010427c:	8b 45 b8             	mov    -0x48(%ebp),%eax
c010427f:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0104282:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0104285:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104288:	8b 55 b8             	mov    -0x48(%ebp),%edx
c010428b:	89 10                	mov    %edx,(%eax)
        nr_free -= n;
c010428d:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c0104292:	2b 45 08             	sub    0x8(%ebp),%eax
c0104295:	a3 24 af 11 c0       	mov    %eax,0xc011af24
        ClearPageProperty(page);
c010429a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010429d:	83 c0 04             	add    $0x4,%eax
c01042a0:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
c01042a7:	89 45 c0             	mov    %eax,-0x40(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01042aa:	8b 45 c0             	mov    -0x40(%ebp),%eax
c01042ad:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c01042b0:	0f b3 10             	btr    %edx,(%eax)
    }
    return page;
c01042b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01042b6:	c9                   	leave  
c01042b7:	c3                   	ret    

c01042b8 <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
c01042b8:	55                   	push   %ebp
c01042b9:	89 e5                	mov    %esp,%ebp
c01042bb:	81 ec 88 00 00 00    	sub    $0x88,%esp
    assert(n > 0);
c01042c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01042c5:	75 19                	jne    c01042e0 <default_free_pages+0x28>
c01042c7:	68 f8 67 10 c0       	push   $0xc01067f8
c01042cc:	68 fe 67 10 c0       	push   $0xc01067fe
c01042d1:	68 9a 00 00 00       	push   $0x9a
c01042d6:	68 13 68 10 c0       	push   $0xc0106813
c01042db:	e8 f9 c0 ff ff       	call   c01003d9 <__panic>
    struct Page *p = base;
c01042e0:	8b 45 08             	mov    0x8(%ebp),%eax
c01042e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c01042e6:	e9 8f 00 00 00       	jmp    c010437a <default_free_pages+0xc2>
        assert(!PageReserved(p) && !PageProperty(p));
c01042eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042ee:	83 c0 04             	add    $0x4,%eax
c01042f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c01042f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01042fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01042fe:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0104301:	0f a3 10             	bt     %edx,(%eax)
c0104304:	19 c0                	sbb    %eax,%eax
c0104306:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return oldbit != 0;
c0104309:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010430d:	0f 95 c0             	setne  %al
c0104310:	0f b6 c0             	movzbl %al,%eax
c0104313:	85 c0                	test   %eax,%eax
c0104315:	75 2c                	jne    c0104343 <default_free_pages+0x8b>
c0104317:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010431a:	83 c0 04             	add    $0x4,%eax
c010431d:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
c0104324:	89 45 dc             	mov    %eax,-0x24(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104327:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010432a:	8b 55 e0             	mov    -0x20(%ebp),%edx
c010432d:	0f a3 10             	bt     %edx,(%eax)
c0104330:	19 c0                	sbb    %eax,%eax
c0104332:	89 45 d8             	mov    %eax,-0x28(%ebp)
    return oldbit != 0;
c0104335:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
c0104339:	0f 95 c0             	setne  %al
c010433c:	0f b6 c0             	movzbl %al,%eax
c010433f:	85 c0                	test   %eax,%eax
c0104341:	74 19                	je     c010435c <default_free_pages+0xa4>
c0104343:	68 3c 68 10 c0       	push   $0xc010683c
c0104348:	68 fe 67 10 c0       	push   $0xc01067fe
c010434d:	68 9d 00 00 00       	push   $0x9d
c0104352:	68 13 68 10 c0       	push   $0xc0106813
c0104357:	e8 7d c0 ff ff       	call   c01003d9 <__panic>
        p->flags = 0;
c010435c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010435f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        set_page_ref(p, 0);
c0104366:	83 ec 08             	sub    $0x8,%esp
c0104369:	6a 00                	push   $0x0
c010436b:	ff 75 f4             	pushl  -0xc(%ebp)
c010436e:	e8 64 fc ff ff       	call   c0103fd7 <set_page_ref>
c0104373:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
c0104376:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c010437a:	8b 55 0c             	mov    0xc(%ebp),%edx
c010437d:	89 d0                	mov    %edx,%eax
c010437f:	c1 e0 02             	shl    $0x2,%eax
c0104382:	01 d0                	add    %edx,%eax
c0104384:	c1 e0 02             	shl    $0x2,%eax
c0104387:	89 c2                	mov    %eax,%edx
c0104389:	8b 45 08             	mov    0x8(%ebp),%eax
c010438c:	01 d0                	add    %edx,%eax
c010438e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104391:	0f 85 54 ff ff ff    	jne    c01042eb <default_free_pages+0x33>
    }
    base->property = n;
c0104397:	8b 45 08             	mov    0x8(%ebp),%eax
c010439a:	8b 55 0c             	mov    0xc(%ebp),%edx
c010439d:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
c01043a0:	8b 45 08             	mov    0x8(%ebp),%eax
c01043a3:	83 c0 04             	add    $0x4,%eax
c01043a6:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c01043ad:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01043b0:	8b 45 cc             	mov    -0x34(%ebp),%eax
c01043b3:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01043b6:	0f ab 10             	bts    %edx,(%eax)
c01043b9:	c7 45 d4 1c af 11 c0 	movl   $0xc011af1c,-0x2c(%ebp)
    return listelm->next;
c01043c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01043c3:	8b 40 04             	mov    0x4(%eax),%eax
    list_entry_t *le = list_next(&free_list);
c01043c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list) {
c01043c9:	e9 08 01 00 00       	jmp    c01044d6 <default_free_pages+0x21e>
        p = le2page(le, page_link);
c01043ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01043d1:	83 e8 0c             	sub    $0xc,%eax
c01043d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01043d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01043da:	89 45 c8             	mov    %eax,-0x38(%ebp)
c01043dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
c01043e0:	8b 40 04             	mov    0x4(%eax),%eax
        le = list_next(le);
c01043e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
        // TODO: optimize
        if (base + base->property == p) {
c01043e6:	8b 45 08             	mov    0x8(%ebp),%eax
c01043e9:	8b 50 08             	mov    0x8(%eax),%edx
c01043ec:	89 d0                	mov    %edx,%eax
c01043ee:	c1 e0 02             	shl    $0x2,%eax
c01043f1:	01 d0                	add    %edx,%eax
c01043f3:	c1 e0 02             	shl    $0x2,%eax
c01043f6:	89 c2                	mov    %eax,%edx
c01043f8:	8b 45 08             	mov    0x8(%ebp),%eax
c01043fb:	01 d0                	add    %edx,%eax
c01043fd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104400:	75 5a                	jne    c010445c <default_free_pages+0x1a4>
            base->property += p->property;
c0104402:	8b 45 08             	mov    0x8(%ebp),%eax
c0104405:	8b 50 08             	mov    0x8(%eax),%edx
c0104408:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010440b:	8b 40 08             	mov    0x8(%eax),%eax
c010440e:	01 c2                	add    %eax,%edx
c0104410:	8b 45 08             	mov    0x8(%ebp),%eax
c0104413:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(p);
c0104416:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104419:	83 c0 04             	add    $0x4,%eax
c010441c:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
c0104423:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104426:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104429:	8b 55 b8             	mov    -0x48(%ebp),%edx
c010442c:	0f b3 10             	btr    %edx,(%eax)
            list_del(&(p->page_link));
c010442f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104432:	83 c0 0c             	add    $0xc,%eax
c0104435:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    __list_del(listelm->prev, listelm->next);
c0104438:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c010443b:	8b 40 04             	mov    0x4(%eax),%eax
c010443e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0104441:	8b 12                	mov    (%edx),%edx
c0104443:	89 55 c0             	mov    %edx,-0x40(%ebp)
c0104446:	89 45 bc             	mov    %eax,-0x44(%ebp)
    prev->next = next;
c0104449:	8b 45 c0             	mov    -0x40(%ebp),%eax
c010444c:	8b 55 bc             	mov    -0x44(%ebp),%edx
c010444f:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0104452:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104455:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104458:	89 10                	mov    %edx,(%eax)
c010445a:	eb 7a                	jmp    c01044d6 <default_free_pages+0x21e>
        }
        else if (p + p->property == base) {
c010445c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010445f:	8b 50 08             	mov    0x8(%eax),%edx
c0104462:	89 d0                	mov    %edx,%eax
c0104464:	c1 e0 02             	shl    $0x2,%eax
c0104467:	01 d0                	add    %edx,%eax
c0104469:	c1 e0 02             	shl    $0x2,%eax
c010446c:	89 c2                	mov    %eax,%edx
c010446e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104471:	01 d0                	add    %edx,%eax
c0104473:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104476:	75 5e                	jne    c01044d6 <default_free_pages+0x21e>
            p->property += base->property;
c0104478:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010447b:	8b 50 08             	mov    0x8(%eax),%edx
c010447e:	8b 45 08             	mov    0x8(%ebp),%eax
c0104481:	8b 40 08             	mov    0x8(%eax),%eax
c0104484:	01 c2                	add    %eax,%edx
c0104486:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104489:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(base);
c010448c:	8b 45 08             	mov    0x8(%ebp),%eax
c010448f:	83 c0 04             	add    $0x4,%eax
c0104492:	c7 45 a4 01 00 00 00 	movl   $0x1,-0x5c(%ebp)
c0104499:	89 45 a0             	mov    %eax,-0x60(%ebp)
c010449c:	8b 45 a0             	mov    -0x60(%ebp),%eax
c010449f:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c01044a2:	0f b3 10             	btr    %edx,(%eax)
            base = p;
c01044a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044a8:	89 45 08             	mov    %eax,0x8(%ebp)
            list_del(&(p->page_link));
c01044ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044ae:	83 c0 0c             	add    $0xc,%eax
c01044b1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    __list_del(listelm->prev, listelm->next);
c01044b4:	8b 45 b0             	mov    -0x50(%ebp),%eax
c01044b7:	8b 40 04             	mov    0x4(%eax),%eax
c01044ba:	8b 55 b0             	mov    -0x50(%ebp),%edx
c01044bd:	8b 12                	mov    (%edx),%edx
c01044bf:	89 55 ac             	mov    %edx,-0x54(%ebp)
c01044c2:	89 45 a8             	mov    %eax,-0x58(%ebp)
    prev->next = next;
c01044c5:	8b 45 ac             	mov    -0x54(%ebp),%eax
c01044c8:	8b 55 a8             	mov    -0x58(%ebp),%edx
c01044cb:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01044ce:	8b 45 a8             	mov    -0x58(%ebp),%eax
c01044d1:	8b 55 ac             	mov    -0x54(%ebp),%edx
c01044d4:	89 10                	mov    %edx,(%eax)
    while (le != &free_list) {
c01044d6:	81 7d f0 1c af 11 c0 	cmpl   $0xc011af1c,-0x10(%ebp)
c01044dd:	0f 85 eb fe ff ff    	jne    c01043ce <default_free_pages+0x116>
        }
    }
    nr_free += n;
c01044e3:	8b 15 24 af 11 c0    	mov    0xc011af24,%edx
c01044e9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01044ec:	01 d0                	add    %edx,%eax
c01044ee:	a3 24 af 11 c0       	mov    %eax,0xc011af24
c01044f3:	c7 45 9c 1c af 11 c0 	movl   $0xc011af1c,-0x64(%ebp)
    return listelm->next;
c01044fa:	8b 45 9c             	mov    -0x64(%ebp),%eax
c01044fd:	8b 40 04             	mov    0x4(%eax),%eax
    le = list_next(&free_list);
c0104500:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list) {
c0104503:	eb 69                	jmp    c010456e <default_free_pages+0x2b6>
        p = le2page(le, page_link);
c0104505:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104508:	83 e8 0c             	sub    $0xc,%eax
c010450b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (base + base->property <= p) {
c010450e:	8b 45 08             	mov    0x8(%ebp),%eax
c0104511:	8b 50 08             	mov    0x8(%eax),%edx
c0104514:	89 d0                	mov    %edx,%eax
c0104516:	c1 e0 02             	shl    $0x2,%eax
c0104519:	01 d0                	add    %edx,%eax
c010451b:	c1 e0 02             	shl    $0x2,%eax
c010451e:	89 c2                	mov    %eax,%edx
c0104520:	8b 45 08             	mov    0x8(%ebp),%eax
c0104523:	01 d0                	add    %edx,%eax
c0104525:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104528:	72 35                	jb     c010455f <default_free_pages+0x2a7>
            assert(base + base->property != p);
c010452a:	8b 45 08             	mov    0x8(%ebp),%eax
c010452d:	8b 50 08             	mov    0x8(%eax),%edx
c0104530:	89 d0                	mov    %edx,%eax
c0104532:	c1 e0 02             	shl    $0x2,%eax
c0104535:	01 d0                	add    %edx,%eax
c0104537:	c1 e0 02             	shl    $0x2,%eax
c010453a:	89 c2                	mov    %eax,%edx
c010453c:	8b 45 08             	mov    0x8(%ebp),%eax
c010453f:	01 d0                	add    %edx,%eax
c0104541:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104544:	75 33                	jne    c0104579 <default_free_pages+0x2c1>
c0104546:	68 61 68 10 c0       	push   $0xc0106861
c010454b:	68 fe 67 10 c0       	push   $0xc01067fe
c0104550:	68 b9 00 00 00       	push   $0xb9
c0104555:	68 13 68 10 c0       	push   $0xc0106813
c010455a:	e8 7a be ff ff       	call   c01003d9 <__panic>
c010455f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104562:	89 45 98             	mov    %eax,-0x68(%ebp)
c0104565:	8b 45 98             	mov    -0x68(%ebp),%eax
c0104568:	8b 40 04             	mov    0x4(%eax),%eax
            break;
        }
        le = list_next(le);
c010456b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list) {
c010456e:	81 7d f0 1c af 11 c0 	cmpl   $0xc011af1c,-0x10(%ebp)
c0104575:	75 8e                	jne    c0104505 <default_free_pages+0x24d>
c0104577:	eb 01                	jmp    c010457a <default_free_pages+0x2c2>
            break;
c0104579:	90                   	nop
    }
    list_add_before(le, &(base->page_link));
c010457a:	8b 45 08             	mov    0x8(%ebp),%eax
c010457d:	8d 50 0c             	lea    0xc(%eax),%edx
c0104580:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104583:	89 45 94             	mov    %eax,-0x6c(%ebp)
c0104586:	89 55 90             	mov    %edx,-0x70(%ebp)
    __list_add(elm, listelm->prev, listelm);
c0104589:	8b 45 94             	mov    -0x6c(%ebp),%eax
c010458c:	8b 00                	mov    (%eax),%eax
c010458e:	8b 55 90             	mov    -0x70(%ebp),%edx
c0104591:	89 55 8c             	mov    %edx,-0x74(%ebp)
c0104594:	89 45 88             	mov    %eax,-0x78(%ebp)
c0104597:	8b 45 94             	mov    -0x6c(%ebp),%eax
c010459a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    prev->next = next->prev = elm;
c010459d:	8b 45 84             	mov    -0x7c(%ebp),%eax
c01045a0:	8b 55 8c             	mov    -0x74(%ebp),%edx
c01045a3:	89 10                	mov    %edx,(%eax)
c01045a5:	8b 45 84             	mov    -0x7c(%ebp),%eax
c01045a8:	8b 10                	mov    (%eax),%edx
c01045aa:	8b 45 88             	mov    -0x78(%ebp),%eax
c01045ad:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c01045b0:	8b 45 8c             	mov    -0x74(%ebp),%eax
c01045b3:	8b 55 84             	mov    -0x7c(%ebp),%edx
c01045b6:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c01045b9:	8b 45 8c             	mov    -0x74(%ebp),%eax
c01045bc:	8b 55 88             	mov    -0x78(%ebp),%edx
c01045bf:	89 10                	mov    %edx,(%eax)
}
c01045c1:	90                   	nop
c01045c2:	c9                   	leave  
c01045c3:	c3                   	ret    

c01045c4 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
c01045c4:	55                   	push   %ebp
c01045c5:	89 e5                	mov    %esp,%ebp
    return nr_free;
c01045c7:	a1 24 af 11 c0       	mov    0xc011af24,%eax
}
c01045cc:	5d                   	pop    %ebp
c01045cd:	c3                   	ret    

c01045ce <basic_check>:

static void
basic_check(void) {
c01045ce:	55                   	push   %ebp
c01045cf:	89 e5                	mov    %esp,%ebp
c01045d1:	83 ec 38             	sub    $0x38,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
c01045d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c01045db:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01045de:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01045e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01045e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
c01045e7:	83 ec 0c             	sub    $0xc,%esp
c01045ea:	6a 01                	push   $0x1
c01045ec:	e8 68 e5 ff ff       	call   c0102b59 <alloc_pages>
c01045f1:	83 c4 10             	add    $0x10,%esp
c01045f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01045f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c01045fb:	75 19                	jne    c0104616 <basic_check+0x48>
c01045fd:	68 7c 68 10 c0       	push   $0xc010687c
c0104602:	68 fe 67 10 c0       	push   $0xc01067fe
c0104607:	68 ca 00 00 00       	push   $0xca
c010460c:	68 13 68 10 c0       	push   $0xc0106813
c0104611:	e8 c3 bd ff ff       	call   c01003d9 <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104616:	83 ec 0c             	sub    $0xc,%esp
c0104619:	6a 01                	push   $0x1
c010461b:	e8 39 e5 ff ff       	call   c0102b59 <alloc_pages>
c0104620:	83 c4 10             	add    $0x10,%esp
c0104623:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104626:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010462a:	75 19                	jne    c0104645 <basic_check+0x77>
c010462c:	68 98 68 10 c0       	push   $0xc0106898
c0104631:	68 fe 67 10 c0       	push   $0xc01067fe
c0104636:	68 cb 00 00 00       	push   $0xcb
c010463b:	68 13 68 10 c0       	push   $0xc0106813
c0104640:	e8 94 bd ff ff       	call   c01003d9 <__panic>
    assert((p2 = alloc_page()) != NULL);
c0104645:	83 ec 0c             	sub    $0xc,%esp
c0104648:	6a 01                	push   $0x1
c010464a:	e8 0a e5 ff ff       	call   c0102b59 <alloc_pages>
c010464f:	83 c4 10             	add    $0x10,%esp
c0104652:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104655:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104659:	75 19                	jne    c0104674 <basic_check+0xa6>
c010465b:	68 b4 68 10 c0       	push   $0xc01068b4
c0104660:	68 fe 67 10 c0       	push   $0xc01067fe
c0104665:	68 cc 00 00 00       	push   $0xcc
c010466a:	68 13 68 10 c0       	push   $0xc0106813
c010466f:	e8 65 bd ff ff       	call   c01003d9 <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
c0104674:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104677:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c010467a:	74 10                	je     c010468c <basic_check+0xbe>
c010467c:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010467f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0104682:	74 08                	je     c010468c <basic_check+0xbe>
c0104684:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104687:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c010468a:	75 19                	jne    c01046a5 <basic_check+0xd7>
c010468c:	68 d0 68 10 c0       	push   $0xc01068d0
c0104691:	68 fe 67 10 c0       	push   $0xc01067fe
c0104696:	68 ce 00 00 00       	push   $0xce
c010469b:	68 13 68 10 c0       	push   $0xc0106813
c01046a0:	e8 34 bd ff ff       	call   c01003d9 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
c01046a5:	83 ec 0c             	sub    $0xc,%esp
c01046a8:	ff 75 ec             	pushl  -0x14(%ebp)
c01046ab:	e8 1d f9 ff ff       	call   c0103fcd <page_ref>
c01046b0:	83 c4 10             	add    $0x10,%esp
c01046b3:	85 c0                	test   %eax,%eax
c01046b5:	75 24                	jne    c01046db <basic_check+0x10d>
c01046b7:	83 ec 0c             	sub    $0xc,%esp
c01046ba:	ff 75 f0             	pushl  -0x10(%ebp)
c01046bd:	e8 0b f9 ff ff       	call   c0103fcd <page_ref>
c01046c2:	83 c4 10             	add    $0x10,%esp
c01046c5:	85 c0                	test   %eax,%eax
c01046c7:	75 12                	jne    c01046db <basic_check+0x10d>
c01046c9:	83 ec 0c             	sub    $0xc,%esp
c01046cc:	ff 75 f4             	pushl  -0xc(%ebp)
c01046cf:	e8 f9 f8 ff ff       	call   c0103fcd <page_ref>
c01046d4:	83 c4 10             	add    $0x10,%esp
c01046d7:	85 c0                	test   %eax,%eax
c01046d9:	74 19                	je     c01046f4 <basic_check+0x126>
c01046db:	68 f4 68 10 c0       	push   $0xc01068f4
c01046e0:	68 fe 67 10 c0       	push   $0xc01067fe
c01046e5:	68 cf 00 00 00       	push   $0xcf
c01046ea:	68 13 68 10 c0       	push   $0xc0106813
c01046ef:	e8 e5 bc ff ff       	call   c01003d9 <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
c01046f4:	83 ec 0c             	sub    $0xc,%esp
c01046f7:	ff 75 ec             	pushl  -0x14(%ebp)
c01046fa:	e8 bb f8 ff ff       	call   c0103fba <page2pa>
c01046ff:	83 c4 10             	add    $0x10,%esp
c0104702:	89 c2                	mov    %eax,%edx
c0104704:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0104709:	c1 e0 0c             	shl    $0xc,%eax
c010470c:	39 c2                	cmp    %eax,%edx
c010470e:	72 19                	jb     c0104729 <basic_check+0x15b>
c0104710:	68 30 69 10 c0       	push   $0xc0106930
c0104715:	68 fe 67 10 c0       	push   $0xc01067fe
c010471a:	68 d1 00 00 00       	push   $0xd1
c010471f:	68 13 68 10 c0       	push   $0xc0106813
c0104724:	e8 b0 bc ff ff       	call   c01003d9 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
c0104729:	83 ec 0c             	sub    $0xc,%esp
c010472c:	ff 75 f0             	pushl  -0x10(%ebp)
c010472f:	e8 86 f8 ff ff       	call   c0103fba <page2pa>
c0104734:	83 c4 10             	add    $0x10,%esp
c0104737:	89 c2                	mov    %eax,%edx
c0104739:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c010473e:	c1 e0 0c             	shl    $0xc,%eax
c0104741:	39 c2                	cmp    %eax,%edx
c0104743:	72 19                	jb     c010475e <basic_check+0x190>
c0104745:	68 4d 69 10 c0       	push   $0xc010694d
c010474a:	68 fe 67 10 c0       	push   $0xc01067fe
c010474f:	68 d2 00 00 00       	push   $0xd2
c0104754:	68 13 68 10 c0       	push   $0xc0106813
c0104759:	e8 7b bc ff ff       	call   c01003d9 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
c010475e:	83 ec 0c             	sub    $0xc,%esp
c0104761:	ff 75 f4             	pushl  -0xc(%ebp)
c0104764:	e8 51 f8 ff ff       	call   c0103fba <page2pa>
c0104769:	83 c4 10             	add    $0x10,%esp
c010476c:	89 c2                	mov    %eax,%edx
c010476e:	a1 80 ae 11 c0       	mov    0xc011ae80,%eax
c0104773:	c1 e0 0c             	shl    $0xc,%eax
c0104776:	39 c2                	cmp    %eax,%edx
c0104778:	72 19                	jb     c0104793 <basic_check+0x1c5>
c010477a:	68 6a 69 10 c0       	push   $0xc010696a
c010477f:	68 fe 67 10 c0       	push   $0xc01067fe
c0104784:	68 d3 00 00 00       	push   $0xd3
c0104789:	68 13 68 10 c0       	push   $0xc0106813
c010478e:	e8 46 bc ff ff       	call   c01003d9 <__panic>

    list_entry_t free_list_store = free_list;
c0104793:	a1 1c af 11 c0       	mov    0xc011af1c,%eax
c0104798:	8b 15 20 af 11 c0    	mov    0xc011af20,%edx
c010479e:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01047a1:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01047a4:	c7 45 dc 1c af 11 c0 	movl   $0xc011af1c,-0x24(%ebp)
    elm->prev = elm->next = elm;
c01047ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01047ae:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01047b1:	89 50 04             	mov    %edx,0x4(%eax)
c01047b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01047b7:	8b 50 04             	mov    0x4(%eax),%edx
c01047ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01047bd:	89 10                	mov    %edx,(%eax)
c01047bf:	c7 45 e0 1c af 11 c0 	movl   $0xc011af1c,-0x20(%ebp)
    return list->next == list;
c01047c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01047c9:	8b 40 04             	mov    0x4(%eax),%eax
c01047cc:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c01047cf:	0f 94 c0             	sete   %al
c01047d2:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c01047d5:	85 c0                	test   %eax,%eax
c01047d7:	75 19                	jne    c01047f2 <basic_check+0x224>
c01047d9:	68 87 69 10 c0       	push   $0xc0106987
c01047de:	68 fe 67 10 c0       	push   $0xc01067fe
c01047e3:	68 d7 00 00 00       	push   $0xd7
c01047e8:	68 13 68 10 c0       	push   $0xc0106813
c01047ed:	e8 e7 bb ff ff       	call   c01003d9 <__panic>

    unsigned int nr_free_store = nr_free;
c01047f2:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c01047f7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
c01047fa:	c7 05 24 af 11 c0 00 	movl   $0x0,0xc011af24
c0104801:	00 00 00 

    assert(alloc_page() == NULL);
c0104804:	83 ec 0c             	sub    $0xc,%esp
c0104807:	6a 01                	push   $0x1
c0104809:	e8 4b e3 ff ff       	call   c0102b59 <alloc_pages>
c010480e:	83 c4 10             	add    $0x10,%esp
c0104811:	85 c0                	test   %eax,%eax
c0104813:	74 19                	je     c010482e <basic_check+0x260>
c0104815:	68 9e 69 10 c0       	push   $0xc010699e
c010481a:	68 fe 67 10 c0       	push   $0xc01067fe
c010481f:	68 dc 00 00 00       	push   $0xdc
c0104824:	68 13 68 10 c0       	push   $0xc0106813
c0104829:	e8 ab bb ff ff       	call   c01003d9 <__panic>

    free_page(p0);
c010482e:	83 ec 08             	sub    $0x8,%esp
c0104831:	6a 01                	push   $0x1
c0104833:	ff 75 ec             	pushl  -0x14(%ebp)
c0104836:	e8 5c e3 ff ff       	call   c0102b97 <free_pages>
c010483b:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c010483e:	83 ec 08             	sub    $0x8,%esp
c0104841:	6a 01                	push   $0x1
c0104843:	ff 75 f0             	pushl  -0x10(%ebp)
c0104846:	e8 4c e3 ff ff       	call   c0102b97 <free_pages>
c010484b:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c010484e:	83 ec 08             	sub    $0x8,%esp
c0104851:	6a 01                	push   $0x1
c0104853:	ff 75 f4             	pushl  -0xc(%ebp)
c0104856:	e8 3c e3 ff ff       	call   c0102b97 <free_pages>
c010485b:	83 c4 10             	add    $0x10,%esp
    assert(nr_free == 3);
c010485e:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c0104863:	83 f8 03             	cmp    $0x3,%eax
c0104866:	74 19                	je     c0104881 <basic_check+0x2b3>
c0104868:	68 b3 69 10 c0       	push   $0xc01069b3
c010486d:	68 fe 67 10 c0       	push   $0xc01067fe
c0104872:	68 e1 00 00 00       	push   $0xe1
c0104877:	68 13 68 10 c0       	push   $0xc0106813
c010487c:	e8 58 bb ff ff       	call   c01003d9 <__panic>

    assert((p0 = alloc_page()) != NULL);
c0104881:	83 ec 0c             	sub    $0xc,%esp
c0104884:	6a 01                	push   $0x1
c0104886:	e8 ce e2 ff ff       	call   c0102b59 <alloc_pages>
c010488b:	83 c4 10             	add    $0x10,%esp
c010488e:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104891:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104895:	75 19                	jne    c01048b0 <basic_check+0x2e2>
c0104897:	68 7c 68 10 c0       	push   $0xc010687c
c010489c:	68 fe 67 10 c0       	push   $0xc01067fe
c01048a1:	68 e3 00 00 00       	push   $0xe3
c01048a6:	68 13 68 10 c0       	push   $0xc0106813
c01048ab:	e8 29 bb ff ff       	call   c01003d9 <__panic>
    assert((p1 = alloc_page()) != NULL);
c01048b0:	83 ec 0c             	sub    $0xc,%esp
c01048b3:	6a 01                	push   $0x1
c01048b5:	e8 9f e2 ff ff       	call   c0102b59 <alloc_pages>
c01048ba:	83 c4 10             	add    $0x10,%esp
c01048bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01048c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01048c4:	75 19                	jne    c01048df <basic_check+0x311>
c01048c6:	68 98 68 10 c0       	push   $0xc0106898
c01048cb:	68 fe 67 10 c0       	push   $0xc01067fe
c01048d0:	68 e4 00 00 00       	push   $0xe4
c01048d5:	68 13 68 10 c0       	push   $0xc0106813
c01048da:	e8 fa ba ff ff       	call   c01003d9 <__panic>
    assert((p2 = alloc_page()) != NULL);
c01048df:	83 ec 0c             	sub    $0xc,%esp
c01048e2:	6a 01                	push   $0x1
c01048e4:	e8 70 e2 ff ff       	call   c0102b59 <alloc_pages>
c01048e9:	83 c4 10             	add    $0x10,%esp
c01048ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01048ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01048f3:	75 19                	jne    c010490e <basic_check+0x340>
c01048f5:	68 b4 68 10 c0       	push   $0xc01068b4
c01048fa:	68 fe 67 10 c0       	push   $0xc01067fe
c01048ff:	68 e5 00 00 00       	push   $0xe5
c0104904:	68 13 68 10 c0       	push   $0xc0106813
c0104909:	e8 cb ba ff ff       	call   c01003d9 <__panic>

    assert(alloc_page() == NULL);
c010490e:	83 ec 0c             	sub    $0xc,%esp
c0104911:	6a 01                	push   $0x1
c0104913:	e8 41 e2 ff ff       	call   c0102b59 <alloc_pages>
c0104918:	83 c4 10             	add    $0x10,%esp
c010491b:	85 c0                	test   %eax,%eax
c010491d:	74 19                	je     c0104938 <basic_check+0x36a>
c010491f:	68 9e 69 10 c0       	push   $0xc010699e
c0104924:	68 fe 67 10 c0       	push   $0xc01067fe
c0104929:	68 e7 00 00 00       	push   $0xe7
c010492e:	68 13 68 10 c0       	push   $0xc0106813
c0104933:	e8 a1 ba ff ff       	call   c01003d9 <__panic>

    free_page(p0);
c0104938:	83 ec 08             	sub    $0x8,%esp
c010493b:	6a 01                	push   $0x1
c010493d:	ff 75 ec             	pushl  -0x14(%ebp)
c0104940:	e8 52 e2 ff ff       	call   c0102b97 <free_pages>
c0104945:	83 c4 10             	add    $0x10,%esp
c0104948:	c7 45 d8 1c af 11 c0 	movl   $0xc011af1c,-0x28(%ebp)
c010494f:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104952:	8b 40 04             	mov    0x4(%eax),%eax
c0104955:	39 45 d8             	cmp    %eax,-0x28(%ebp)
c0104958:	0f 94 c0             	sete   %al
c010495b:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
c010495e:	85 c0                	test   %eax,%eax
c0104960:	74 19                	je     c010497b <basic_check+0x3ad>
c0104962:	68 c0 69 10 c0       	push   $0xc01069c0
c0104967:	68 fe 67 10 c0       	push   $0xc01067fe
c010496c:	68 ea 00 00 00       	push   $0xea
c0104971:	68 13 68 10 c0       	push   $0xc0106813
c0104976:	e8 5e ba ff ff       	call   c01003d9 <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
c010497b:	83 ec 0c             	sub    $0xc,%esp
c010497e:	6a 01                	push   $0x1
c0104980:	e8 d4 e1 ff ff       	call   c0102b59 <alloc_pages>
c0104985:	83 c4 10             	add    $0x10,%esp
c0104988:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010498b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010498e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0104991:	74 19                	je     c01049ac <basic_check+0x3de>
c0104993:	68 d8 69 10 c0       	push   $0xc01069d8
c0104998:	68 fe 67 10 c0       	push   $0xc01067fe
c010499d:	68 ed 00 00 00       	push   $0xed
c01049a2:	68 13 68 10 c0       	push   $0xc0106813
c01049a7:	e8 2d ba ff ff       	call   c01003d9 <__panic>
    assert(alloc_page() == NULL);
c01049ac:	83 ec 0c             	sub    $0xc,%esp
c01049af:	6a 01                	push   $0x1
c01049b1:	e8 a3 e1 ff ff       	call   c0102b59 <alloc_pages>
c01049b6:	83 c4 10             	add    $0x10,%esp
c01049b9:	85 c0                	test   %eax,%eax
c01049bb:	74 19                	je     c01049d6 <basic_check+0x408>
c01049bd:	68 9e 69 10 c0       	push   $0xc010699e
c01049c2:	68 fe 67 10 c0       	push   $0xc01067fe
c01049c7:	68 ee 00 00 00       	push   $0xee
c01049cc:	68 13 68 10 c0       	push   $0xc0106813
c01049d1:	e8 03 ba ff ff       	call   c01003d9 <__panic>

    assert(nr_free == 0);
c01049d6:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c01049db:	85 c0                	test   %eax,%eax
c01049dd:	74 19                	je     c01049f8 <basic_check+0x42a>
c01049df:	68 f1 69 10 c0       	push   $0xc01069f1
c01049e4:	68 fe 67 10 c0       	push   $0xc01067fe
c01049e9:	68 f0 00 00 00       	push   $0xf0
c01049ee:	68 13 68 10 c0       	push   $0xc0106813
c01049f3:	e8 e1 b9 ff ff       	call   c01003d9 <__panic>
    free_list = free_list_store;
c01049f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01049fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01049fe:	a3 1c af 11 c0       	mov    %eax,0xc011af1c
c0104a03:	89 15 20 af 11 c0    	mov    %edx,0xc011af20
    nr_free = nr_free_store;
c0104a09:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104a0c:	a3 24 af 11 c0       	mov    %eax,0xc011af24

    free_page(p);
c0104a11:	83 ec 08             	sub    $0x8,%esp
c0104a14:	6a 01                	push   $0x1
c0104a16:	ff 75 e4             	pushl  -0x1c(%ebp)
c0104a19:	e8 79 e1 ff ff       	call   c0102b97 <free_pages>
c0104a1e:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c0104a21:	83 ec 08             	sub    $0x8,%esp
c0104a24:	6a 01                	push   $0x1
c0104a26:	ff 75 f0             	pushl  -0x10(%ebp)
c0104a29:	e8 69 e1 ff ff       	call   c0102b97 <free_pages>
c0104a2e:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104a31:	83 ec 08             	sub    $0x8,%esp
c0104a34:	6a 01                	push   $0x1
c0104a36:	ff 75 f4             	pushl  -0xc(%ebp)
c0104a39:	e8 59 e1 ff ff       	call   c0102b97 <free_pages>
c0104a3e:	83 c4 10             	add    $0x10,%esp
}
c0104a41:	90                   	nop
c0104a42:	c9                   	leave  
c0104a43:	c3                   	ret    

c0104a44 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
c0104a44:	55                   	push   %ebp
c0104a45:	89 e5                	mov    %esp,%ebp
c0104a47:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int count = 0, total = 0;
c0104a4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104a54:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
c0104a5b:	c7 45 ec 1c af 11 c0 	movl   $0xc011af1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0104a62:	eb 60                	jmp    c0104ac4 <default_check+0x80>
        struct Page *p = le2page(le, page_link);
c0104a64:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104a67:	83 e8 0c             	sub    $0xc,%eax
c0104a6a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
c0104a6d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104a70:	83 c0 04             	add    $0x4,%eax
c0104a73:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104a7a:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104a7d:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104a80:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104a83:	0f a3 10             	bt     %edx,(%eax)
c0104a86:	19 c0                	sbb    %eax,%eax
c0104a88:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
c0104a8b:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
c0104a8f:	0f 95 c0             	setne  %al
c0104a92:	0f b6 c0             	movzbl %al,%eax
c0104a95:	85 c0                	test   %eax,%eax
c0104a97:	75 19                	jne    c0104ab2 <default_check+0x6e>
c0104a99:	68 fe 69 10 c0       	push   $0xc01069fe
c0104a9e:	68 fe 67 10 c0       	push   $0xc01067fe
c0104aa3:	68 01 01 00 00       	push   $0x101
c0104aa8:	68 13 68 10 c0       	push   $0xc0106813
c0104aad:	e8 27 b9 ff ff       	call   c01003d9 <__panic>
        count ++, total += p->property;
c0104ab2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0104ab6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104ab9:	8b 50 08             	mov    0x8(%eax),%edx
c0104abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104abf:	01 d0                	add    %edx,%eax
c0104ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104ac4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104ac7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
c0104aca:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104acd:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0104ad0:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104ad3:	81 7d ec 1c af 11 c0 	cmpl   $0xc011af1c,-0x14(%ebp)
c0104ada:	75 88                	jne    c0104a64 <default_check+0x20>
    }
    assert(total == nr_free_pages());
c0104adc:	e8 eb e0 ff ff       	call   c0102bcc <nr_free_pages>
c0104ae1:	89 c2                	mov    %eax,%edx
c0104ae3:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104ae6:	39 c2                	cmp    %eax,%edx
c0104ae8:	74 19                	je     c0104b03 <default_check+0xbf>
c0104aea:	68 0e 6a 10 c0       	push   $0xc0106a0e
c0104aef:	68 fe 67 10 c0       	push   $0xc01067fe
c0104af4:	68 04 01 00 00       	push   $0x104
c0104af9:	68 13 68 10 c0       	push   $0xc0106813
c0104afe:	e8 d6 b8 ff ff       	call   c01003d9 <__panic>

    basic_check();
c0104b03:	e8 c6 fa ff ff       	call   c01045ce <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
c0104b08:	83 ec 0c             	sub    $0xc,%esp
c0104b0b:	6a 05                	push   $0x5
c0104b0d:	e8 47 e0 ff ff       	call   c0102b59 <alloc_pages>
c0104b12:	83 c4 10             	add    $0x10,%esp
c0104b15:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
c0104b18:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104b1c:	75 19                	jne    c0104b37 <default_check+0xf3>
c0104b1e:	68 27 6a 10 c0       	push   $0xc0106a27
c0104b23:	68 fe 67 10 c0       	push   $0xc01067fe
c0104b28:	68 09 01 00 00       	push   $0x109
c0104b2d:	68 13 68 10 c0       	push   $0xc0106813
c0104b32:	e8 a2 b8 ff ff       	call   c01003d9 <__panic>
    assert(!PageProperty(p0));
c0104b37:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104b3a:	83 c0 04             	add    $0x4,%eax
c0104b3d:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c0104b44:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104b47:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104b4a:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104b4d:	0f a3 10             	bt     %edx,(%eax)
c0104b50:	19 c0                	sbb    %eax,%eax
c0104b52:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
c0104b55:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
c0104b59:	0f 95 c0             	setne  %al
c0104b5c:	0f b6 c0             	movzbl %al,%eax
c0104b5f:	85 c0                	test   %eax,%eax
c0104b61:	74 19                	je     c0104b7c <default_check+0x138>
c0104b63:	68 32 6a 10 c0       	push   $0xc0106a32
c0104b68:	68 fe 67 10 c0       	push   $0xc01067fe
c0104b6d:	68 0a 01 00 00       	push   $0x10a
c0104b72:	68 13 68 10 c0       	push   $0xc0106813
c0104b77:	e8 5d b8 ff ff       	call   c01003d9 <__panic>

    list_entry_t free_list_store = free_list;
c0104b7c:	a1 1c af 11 c0       	mov    0xc011af1c,%eax
c0104b81:	8b 15 20 af 11 c0    	mov    0xc011af20,%edx
c0104b87:	89 45 80             	mov    %eax,-0x80(%ebp)
c0104b8a:	89 55 84             	mov    %edx,-0x7c(%ebp)
c0104b8d:	c7 45 b0 1c af 11 c0 	movl   $0xc011af1c,-0x50(%ebp)
    elm->prev = elm->next = elm;
c0104b94:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104b97:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0104b9a:	89 50 04             	mov    %edx,0x4(%eax)
c0104b9d:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104ba0:	8b 50 04             	mov    0x4(%eax),%edx
c0104ba3:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104ba6:	89 10                	mov    %edx,(%eax)
c0104ba8:	c7 45 b4 1c af 11 c0 	movl   $0xc011af1c,-0x4c(%ebp)
    return list->next == list;
c0104baf:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104bb2:	8b 40 04             	mov    0x4(%eax),%eax
c0104bb5:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
c0104bb8:	0f 94 c0             	sete   %al
c0104bbb:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104bbe:	85 c0                	test   %eax,%eax
c0104bc0:	75 19                	jne    c0104bdb <default_check+0x197>
c0104bc2:	68 87 69 10 c0       	push   $0xc0106987
c0104bc7:	68 fe 67 10 c0       	push   $0xc01067fe
c0104bcc:	68 0e 01 00 00       	push   $0x10e
c0104bd1:	68 13 68 10 c0       	push   $0xc0106813
c0104bd6:	e8 fe b7 ff ff       	call   c01003d9 <__panic>
    assert(alloc_page() == NULL);
c0104bdb:	83 ec 0c             	sub    $0xc,%esp
c0104bde:	6a 01                	push   $0x1
c0104be0:	e8 74 df ff ff       	call   c0102b59 <alloc_pages>
c0104be5:	83 c4 10             	add    $0x10,%esp
c0104be8:	85 c0                	test   %eax,%eax
c0104bea:	74 19                	je     c0104c05 <default_check+0x1c1>
c0104bec:	68 9e 69 10 c0       	push   $0xc010699e
c0104bf1:	68 fe 67 10 c0       	push   $0xc01067fe
c0104bf6:	68 0f 01 00 00       	push   $0x10f
c0104bfb:	68 13 68 10 c0       	push   $0xc0106813
c0104c00:	e8 d4 b7 ff ff       	call   c01003d9 <__panic>

    unsigned int nr_free_store = nr_free;
c0104c05:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c0104c0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
c0104c0d:	c7 05 24 af 11 c0 00 	movl   $0x0,0xc011af24
c0104c14:	00 00 00 

    free_pages(p0 + 2, 3);
c0104c17:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104c1a:	83 c0 28             	add    $0x28,%eax
c0104c1d:	83 ec 08             	sub    $0x8,%esp
c0104c20:	6a 03                	push   $0x3
c0104c22:	50                   	push   %eax
c0104c23:	e8 6f df ff ff       	call   c0102b97 <free_pages>
c0104c28:	83 c4 10             	add    $0x10,%esp
    assert(alloc_pages(4) == NULL);
c0104c2b:	83 ec 0c             	sub    $0xc,%esp
c0104c2e:	6a 04                	push   $0x4
c0104c30:	e8 24 df ff ff       	call   c0102b59 <alloc_pages>
c0104c35:	83 c4 10             	add    $0x10,%esp
c0104c38:	85 c0                	test   %eax,%eax
c0104c3a:	74 19                	je     c0104c55 <default_check+0x211>
c0104c3c:	68 44 6a 10 c0       	push   $0xc0106a44
c0104c41:	68 fe 67 10 c0       	push   $0xc01067fe
c0104c46:	68 15 01 00 00       	push   $0x115
c0104c4b:	68 13 68 10 c0       	push   $0xc0106813
c0104c50:	e8 84 b7 ff ff       	call   c01003d9 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
c0104c55:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104c58:	83 c0 28             	add    $0x28,%eax
c0104c5b:	83 c0 04             	add    $0x4,%eax
c0104c5e:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0104c65:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104c68:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0104c6b:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0104c6e:	0f a3 10             	bt     %edx,(%eax)
c0104c71:	19 c0                	sbb    %eax,%eax
c0104c73:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
c0104c76:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0104c7a:	0f 95 c0             	setne  %al
c0104c7d:	0f b6 c0             	movzbl %al,%eax
c0104c80:	85 c0                	test   %eax,%eax
c0104c82:	74 0e                	je     c0104c92 <default_check+0x24e>
c0104c84:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104c87:	83 c0 28             	add    $0x28,%eax
c0104c8a:	8b 40 08             	mov    0x8(%eax),%eax
c0104c8d:	83 f8 03             	cmp    $0x3,%eax
c0104c90:	74 19                	je     c0104cab <default_check+0x267>
c0104c92:	68 5c 6a 10 c0       	push   $0xc0106a5c
c0104c97:	68 fe 67 10 c0       	push   $0xc01067fe
c0104c9c:	68 16 01 00 00       	push   $0x116
c0104ca1:	68 13 68 10 c0       	push   $0xc0106813
c0104ca6:	e8 2e b7 ff ff       	call   c01003d9 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
c0104cab:	83 ec 0c             	sub    $0xc,%esp
c0104cae:	6a 03                	push   $0x3
c0104cb0:	e8 a4 de ff ff       	call   c0102b59 <alloc_pages>
c0104cb5:	83 c4 10             	add    $0x10,%esp
c0104cb8:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0104cbb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c0104cbf:	75 19                	jne    c0104cda <default_check+0x296>
c0104cc1:	68 88 6a 10 c0       	push   $0xc0106a88
c0104cc6:	68 fe 67 10 c0       	push   $0xc01067fe
c0104ccb:	68 17 01 00 00       	push   $0x117
c0104cd0:	68 13 68 10 c0       	push   $0xc0106813
c0104cd5:	e8 ff b6 ff ff       	call   c01003d9 <__panic>
    assert(alloc_page() == NULL);
c0104cda:	83 ec 0c             	sub    $0xc,%esp
c0104cdd:	6a 01                	push   $0x1
c0104cdf:	e8 75 de ff ff       	call   c0102b59 <alloc_pages>
c0104ce4:	83 c4 10             	add    $0x10,%esp
c0104ce7:	85 c0                	test   %eax,%eax
c0104ce9:	74 19                	je     c0104d04 <default_check+0x2c0>
c0104ceb:	68 9e 69 10 c0       	push   $0xc010699e
c0104cf0:	68 fe 67 10 c0       	push   $0xc01067fe
c0104cf5:	68 18 01 00 00       	push   $0x118
c0104cfa:	68 13 68 10 c0       	push   $0xc0106813
c0104cff:	e8 d5 b6 ff ff       	call   c01003d9 <__panic>
    assert(p0 + 2 == p1);
c0104d04:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d07:	83 c0 28             	add    $0x28,%eax
c0104d0a:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104d0d:	74 19                	je     c0104d28 <default_check+0x2e4>
c0104d0f:	68 a6 6a 10 c0       	push   $0xc0106aa6
c0104d14:	68 fe 67 10 c0       	push   $0xc01067fe
c0104d19:	68 19 01 00 00       	push   $0x119
c0104d1e:	68 13 68 10 c0       	push   $0xc0106813
c0104d23:	e8 b1 b6 ff ff       	call   c01003d9 <__panic>

    p2 = p0 + 1;
c0104d28:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d2b:	83 c0 14             	add    $0x14,%eax
c0104d2e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
c0104d31:	83 ec 08             	sub    $0x8,%esp
c0104d34:	6a 01                	push   $0x1
c0104d36:	ff 75 e8             	pushl  -0x18(%ebp)
c0104d39:	e8 59 de ff ff       	call   c0102b97 <free_pages>
c0104d3e:	83 c4 10             	add    $0x10,%esp
    free_pages(p1, 3);
c0104d41:	83 ec 08             	sub    $0x8,%esp
c0104d44:	6a 03                	push   $0x3
c0104d46:	ff 75 e0             	pushl  -0x20(%ebp)
c0104d49:	e8 49 de ff ff       	call   c0102b97 <free_pages>
c0104d4e:	83 c4 10             	add    $0x10,%esp
    assert(PageProperty(p0) && p0->property == 1);
c0104d51:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d54:	83 c0 04             	add    $0x4,%eax
c0104d57:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
c0104d5e:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104d61:	8b 45 9c             	mov    -0x64(%ebp),%eax
c0104d64:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0104d67:	0f a3 10             	bt     %edx,(%eax)
c0104d6a:	19 c0                	sbb    %eax,%eax
c0104d6c:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
c0104d6f:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
c0104d73:	0f 95 c0             	setne  %al
c0104d76:	0f b6 c0             	movzbl %al,%eax
c0104d79:	85 c0                	test   %eax,%eax
c0104d7b:	74 0b                	je     c0104d88 <default_check+0x344>
c0104d7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d80:	8b 40 08             	mov    0x8(%eax),%eax
c0104d83:	83 f8 01             	cmp    $0x1,%eax
c0104d86:	74 19                	je     c0104da1 <default_check+0x35d>
c0104d88:	68 b4 6a 10 c0       	push   $0xc0106ab4
c0104d8d:	68 fe 67 10 c0       	push   $0xc01067fe
c0104d92:	68 1e 01 00 00       	push   $0x11e
c0104d97:	68 13 68 10 c0       	push   $0xc0106813
c0104d9c:	e8 38 b6 ff ff       	call   c01003d9 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
c0104da1:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104da4:	83 c0 04             	add    $0x4,%eax
c0104da7:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c0104dae:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104db1:	8b 45 90             	mov    -0x70(%ebp),%eax
c0104db4:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0104db7:	0f a3 10             	bt     %edx,(%eax)
c0104dba:	19 c0                	sbb    %eax,%eax
c0104dbc:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
c0104dbf:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
c0104dc3:	0f 95 c0             	setne  %al
c0104dc6:	0f b6 c0             	movzbl %al,%eax
c0104dc9:	85 c0                	test   %eax,%eax
c0104dcb:	74 0b                	je     c0104dd8 <default_check+0x394>
c0104dcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104dd0:	8b 40 08             	mov    0x8(%eax),%eax
c0104dd3:	83 f8 03             	cmp    $0x3,%eax
c0104dd6:	74 19                	je     c0104df1 <default_check+0x3ad>
c0104dd8:	68 dc 6a 10 c0       	push   $0xc0106adc
c0104ddd:	68 fe 67 10 c0       	push   $0xc01067fe
c0104de2:	68 1f 01 00 00       	push   $0x11f
c0104de7:	68 13 68 10 c0       	push   $0xc0106813
c0104dec:	e8 e8 b5 ff ff       	call   c01003d9 <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
c0104df1:	83 ec 0c             	sub    $0xc,%esp
c0104df4:	6a 01                	push   $0x1
c0104df6:	e8 5e dd ff ff       	call   c0102b59 <alloc_pages>
c0104dfb:	83 c4 10             	add    $0x10,%esp
c0104dfe:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104e01:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104e04:	83 e8 14             	sub    $0x14,%eax
c0104e07:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0104e0a:	74 19                	je     c0104e25 <default_check+0x3e1>
c0104e0c:	68 02 6b 10 c0       	push   $0xc0106b02
c0104e11:	68 fe 67 10 c0       	push   $0xc01067fe
c0104e16:	68 21 01 00 00       	push   $0x121
c0104e1b:	68 13 68 10 c0       	push   $0xc0106813
c0104e20:	e8 b4 b5 ff ff       	call   c01003d9 <__panic>
    free_page(p0);
c0104e25:	83 ec 08             	sub    $0x8,%esp
c0104e28:	6a 01                	push   $0x1
c0104e2a:	ff 75 e8             	pushl  -0x18(%ebp)
c0104e2d:	e8 65 dd ff ff       	call   c0102b97 <free_pages>
c0104e32:	83 c4 10             	add    $0x10,%esp
    assert((p0 = alloc_pages(2)) == p2 + 1);
c0104e35:	83 ec 0c             	sub    $0xc,%esp
c0104e38:	6a 02                	push   $0x2
c0104e3a:	e8 1a dd ff ff       	call   c0102b59 <alloc_pages>
c0104e3f:	83 c4 10             	add    $0x10,%esp
c0104e42:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104e45:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104e48:	83 c0 14             	add    $0x14,%eax
c0104e4b:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0104e4e:	74 19                	je     c0104e69 <default_check+0x425>
c0104e50:	68 20 6b 10 c0       	push   $0xc0106b20
c0104e55:	68 fe 67 10 c0       	push   $0xc01067fe
c0104e5a:	68 23 01 00 00       	push   $0x123
c0104e5f:	68 13 68 10 c0       	push   $0xc0106813
c0104e64:	e8 70 b5 ff ff       	call   c01003d9 <__panic>

    free_pages(p0, 2);
c0104e69:	83 ec 08             	sub    $0x8,%esp
c0104e6c:	6a 02                	push   $0x2
c0104e6e:	ff 75 e8             	pushl  -0x18(%ebp)
c0104e71:	e8 21 dd ff ff       	call   c0102b97 <free_pages>
c0104e76:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104e79:	83 ec 08             	sub    $0x8,%esp
c0104e7c:	6a 01                	push   $0x1
c0104e7e:	ff 75 dc             	pushl  -0x24(%ebp)
c0104e81:	e8 11 dd ff ff       	call   c0102b97 <free_pages>
c0104e86:	83 c4 10             	add    $0x10,%esp

    assert((p0 = alloc_pages(5)) != NULL);
c0104e89:	83 ec 0c             	sub    $0xc,%esp
c0104e8c:	6a 05                	push   $0x5
c0104e8e:	e8 c6 dc ff ff       	call   c0102b59 <alloc_pages>
c0104e93:	83 c4 10             	add    $0x10,%esp
c0104e96:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104e99:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104e9d:	75 19                	jne    c0104eb8 <default_check+0x474>
c0104e9f:	68 40 6b 10 c0       	push   $0xc0106b40
c0104ea4:	68 fe 67 10 c0       	push   $0xc01067fe
c0104ea9:	68 28 01 00 00       	push   $0x128
c0104eae:	68 13 68 10 c0       	push   $0xc0106813
c0104eb3:	e8 21 b5 ff ff       	call   c01003d9 <__panic>
    assert(alloc_page() == NULL);
c0104eb8:	83 ec 0c             	sub    $0xc,%esp
c0104ebb:	6a 01                	push   $0x1
c0104ebd:	e8 97 dc ff ff       	call   c0102b59 <alloc_pages>
c0104ec2:	83 c4 10             	add    $0x10,%esp
c0104ec5:	85 c0                	test   %eax,%eax
c0104ec7:	74 19                	je     c0104ee2 <default_check+0x49e>
c0104ec9:	68 9e 69 10 c0       	push   $0xc010699e
c0104ece:	68 fe 67 10 c0       	push   $0xc01067fe
c0104ed3:	68 29 01 00 00       	push   $0x129
c0104ed8:	68 13 68 10 c0       	push   $0xc0106813
c0104edd:	e8 f7 b4 ff ff       	call   c01003d9 <__panic>

    assert(nr_free == 0);
c0104ee2:	a1 24 af 11 c0       	mov    0xc011af24,%eax
c0104ee7:	85 c0                	test   %eax,%eax
c0104ee9:	74 19                	je     c0104f04 <default_check+0x4c0>
c0104eeb:	68 f1 69 10 c0       	push   $0xc01069f1
c0104ef0:	68 fe 67 10 c0       	push   $0xc01067fe
c0104ef5:	68 2b 01 00 00       	push   $0x12b
c0104efa:	68 13 68 10 c0       	push   $0xc0106813
c0104eff:	e8 d5 b4 ff ff       	call   c01003d9 <__panic>
    nr_free = nr_free_store;
c0104f04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104f07:	a3 24 af 11 c0       	mov    %eax,0xc011af24

    free_list = free_list_store;
c0104f0c:	8b 45 80             	mov    -0x80(%ebp),%eax
c0104f0f:	8b 55 84             	mov    -0x7c(%ebp),%edx
c0104f12:	a3 1c af 11 c0       	mov    %eax,0xc011af1c
c0104f17:	89 15 20 af 11 c0    	mov    %edx,0xc011af20
    free_pages(p0, 5);
c0104f1d:	83 ec 08             	sub    $0x8,%esp
c0104f20:	6a 05                	push   $0x5
c0104f22:	ff 75 e8             	pushl  -0x18(%ebp)
c0104f25:	e8 6d dc ff ff       	call   c0102b97 <free_pages>
c0104f2a:	83 c4 10             	add    $0x10,%esp

    le = &free_list;
c0104f2d:	c7 45 ec 1c af 11 c0 	movl   $0xc011af1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0104f34:	eb 1d                	jmp    c0104f53 <default_check+0x50f>
        struct Page *p = le2page(le, page_link);
c0104f36:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104f39:	83 e8 0c             	sub    $0xc,%eax
c0104f3c:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
c0104f3f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c0104f43:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0104f46:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104f49:	8b 40 08             	mov    0x8(%eax),%eax
c0104f4c:	29 c2                	sub    %eax,%edx
c0104f4e:	89 d0                	mov    %edx,%eax
c0104f50:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104f53:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104f56:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
c0104f59:	8b 45 88             	mov    -0x78(%ebp),%eax
c0104f5c:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0104f5f:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104f62:	81 7d ec 1c af 11 c0 	cmpl   $0xc011af1c,-0x14(%ebp)
c0104f69:	75 cb                	jne    c0104f36 <default_check+0x4f2>
    }
    assert(count == 0);
c0104f6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104f6f:	74 19                	je     c0104f8a <default_check+0x546>
c0104f71:	68 5e 6b 10 c0       	push   $0xc0106b5e
c0104f76:	68 fe 67 10 c0       	push   $0xc01067fe
c0104f7b:	68 36 01 00 00       	push   $0x136
c0104f80:	68 13 68 10 c0       	push   $0xc0106813
c0104f85:	e8 4f b4 ff ff       	call   c01003d9 <__panic>
    assert(total == 0);
c0104f8a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104f8e:	74 19                	je     c0104fa9 <default_check+0x565>
c0104f90:	68 69 6b 10 c0       	push   $0xc0106b69
c0104f95:	68 fe 67 10 c0       	push   $0xc01067fe
c0104f9a:	68 37 01 00 00       	push   $0x137
c0104f9f:	68 13 68 10 c0       	push   $0xc0106813
c0104fa4:	e8 30 b4 ff ff       	call   c01003d9 <__panic>
}
c0104fa9:	90                   	nop
c0104faa:	c9                   	leave  
c0104fab:	c3                   	ret    

c0104fac <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
c0104fac:	55                   	push   %ebp
c0104fad:	89 e5                	mov    %esp,%ebp
c0104faf:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0104fb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
c0104fb9:	eb 04                	jmp    c0104fbf <strlen+0x13>
        cnt ++;
c0104fbb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
c0104fbf:	8b 45 08             	mov    0x8(%ebp),%eax
c0104fc2:	8d 50 01             	lea    0x1(%eax),%edx
c0104fc5:	89 55 08             	mov    %edx,0x8(%ebp)
c0104fc8:	0f b6 00             	movzbl (%eax),%eax
c0104fcb:	84 c0                	test   %al,%al
c0104fcd:	75 ec                	jne    c0104fbb <strlen+0xf>
    }
    return cnt;
c0104fcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0104fd2:	c9                   	leave  
c0104fd3:	c3                   	ret    

c0104fd4 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
c0104fd4:	55                   	push   %ebp
c0104fd5:	89 e5                	mov    %esp,%ebp
c0104fd7:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0104fda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0104fe1:	eb 04                	jmp    c0104fe7 <strnlen+0x13>
        cnt ++;
c0104fe3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0104fe7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104fea:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104fed:	73 10                	jae    c0104fff <strnlen+0x2b>
c0104fef:	8b 45 08             	mov    0x8(%ebp),%eax
c0104ff2:	8d 50 01             	lea    0x1(%eax),%edx
c0104ff5:	89 55 08             	mov    %edx,0x8(%ebp)
c0104ff8:	0f b6 00             	movzbl (%eax),%eax
c0104ffb:	84 c0                	test   %al,%al
c0104ffd:	75 e4                	jne    c0104fe3 <strnlen+0xf>
    }
    return cnt;
c0104fff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105002:	c9                   	leave  
c0105003:	c3                   	ret    

c0105004 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
c0105004:	55                   	push   %ebp
c0105005:	89 e5                	mov    %esp,%ebp
c0105007:	57                   	push   %edi
c0105008:	56                   	push   %esi
c0105009:	83 ec 20             	sub    $0x20,%esp
c010500c:	8b 45 08             	mov    0x8(%ebp),%eax
c010500f:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105012:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105015:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
c0105018:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010501b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010501e:	89 d1                	mov    %edx,%ecx
c0105020:	89 c2                	mov    %eax,%edx
c0105022:	89 ce                	mov    %ecx,%esi
c0105024:	89 d7                	mov    %edx,%edi
c0105026:	ac                   	lods   %ds:(%esi),%al
c0105027:	aa                   	stos   %al,%es:(%edi)
c0105028:	84 c0                	test   %al,%al
c010502a:	75 fa                	jne    c0105026 <strcpy+0x22>
c010502c:	89 fa                	mov    %edi,%edx
c010502e:	89 f1                	mov    %esi,%ecx
c0105030:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105033:	89 55 e8             	mov    %edx,-0x18(%ebp)
c0105036:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
c0105039:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
c010503c:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
c010503d:	83 c4 20             	add    $0x20,%esp
c0105040:	5e                   	pop    %esi
c0105041:	5f                   	pop    %edi
c0105042:	5d                   	pop    %ebp
c0105043:	c3                   	ret    

c0105044 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
c0105044:	55                   	push   %ebp
c0105045:	89 e5                	mov    %esp,%ebp
c0105047:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
c010504a:	8b 45 08             	mov    0x8(%ebp),%eax
c010504d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
c0105050:	eb 21                	jmp    c0105073 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
c0105052:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105055:	0f b6 10             	movzbl (%eax),%edx
c0105058:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010505b:	88 10                	mov    %dl,(%eax)
c010505d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105060:	0f b6 00             	movzbl (%eax),%eax
c0105063:	84 c0                	test   %al,%al
c0105065:	74 04                	je     c010506b <strncpy+0x27>
            src ++;
c0105067:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
c010506b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c010506f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
c0105073:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105077:	75 d9                	jne    c0105052 <strncpy+0xe>
    }
    return dst;
c0105079:	8b 45 08             	mov    0x8(%ebp),%eax
}
c010507c:	c9                   	leave  
c010507d:	c3                   	ret    

c010507e <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
c010507e:	55                   	push   %ebp
c010507f:	89 e5                	mov    %esp,%ebp
c0105081:	57                   	push   %edi
c0105082:	56                   	push   %esi
c0105083:	83 ec 20             	sub    $0x20,%esp
c0105086:	8b 45 08             	mov    0x8(%ebp),%eax
c0105089:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010508c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010508f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c0105092:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105095:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105098:	89 d1                	mov    %edx,%ecx
c010509a:	89 c2                	mov    %eax,%edx
c010509c:	89 ce                	mov    %ecx,%esi
c010509e:	89 d7                	mov    %edx,%edi
c01050a0:	ac                   	lods   %ds:(%esi),%al
c01050a1:	ae                   	scas   %es:(%edi),%al
c01050a2:	75 08                	jne    c01050ac <strcmp+0x2e>
c01050a4:	84 c0                	test   %al,%al
c01050a6:	75 f8                	jne    c01050a0 <strcmp+0x22>
c01050a8:	31 c0                	xor    %eax,%eax
c01050aa:	eb 04                	jmp    c01050b0 <strcmp+0x32>
c01050ac:	19 c0                	sbb    %eax,%eax
c01050ae:	0c 01                	or     $0x1,%al
c01050b0:	89 fa                	mov    %edi,%edx
c01050b2:	89 f1                	mov    %esi,%ecx
c01050b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01050b7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c01050ba:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
c01050bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
c01050c0:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
c01050c1:	83 c4 20             	add    $0x20,%esp
c01050c4:	5e                   	pop    %esi
c01050c5:	5f                   	pop    %edi
c01050c6:	5d                   	pop    %ebp
c01050c7:	c3                   	ret    

c01050c8 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
c01050c8:	55                   	push   %ebp
c01050c9:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c01050cb:	eb 0c                	jmp    c01050d9 <strncmp+0x11>
        n --, s1 ++, s2 ++;
c01050cd:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c01050d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c01050d5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c01050d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01050dd:	74 1a                	je     c01050f9 <strncmp+0x31>
c01050df:	8b 45 08             	mov    0x8(%ebp),%eax
c01050e2:	0f b6 00             	movzbl (%eax),%eax
c01050e5:	84 c0                	test   %al,%al
c01050e7:	74 10                	je     c01050f9 <strncmp+0x31>
c01050e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01050ec:	0f b6 10             	movzbl (%eax),%edx
c01050ef:	8b 45 0c             	mov    0xc(%ebp),%eax
c01050f2:	0f b6 00             	movzbl (%eax),%eax
c01050f5:	38 c2                	cmp    %al,%dl
c01050f7:	74 d4                	je     c01050cd <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
c01050f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01050fd:	74 18                	je     c0105117 <strncmp+0x4f>
c01050ff:	8b 45 08             	mov    0x8(%ebp),%eax
c0105102:	0f b6 00             	movzbl (%eax),%eax
c0105105:	0f b6 d0             	movzbl %al,%edx
c0105108:	8b 45 0c             	mov    0xc(%ebp),%eax
c010510b:	0f b6 00             	movzbl (%eax),%eax
c010510e:	0f b6 c0             	movzbl %al,%eax
c0105111:	29 c2                	sub    %eax,%edx
c0105113:	89 d0                	mov    %edx,%eax
c0105115:	eb 05                	jmp    c010511c <strncmp+0x54>
c0105117:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010511c:	5d                   	pop    %ebp
c010511d:	c3                   	ret    

c010511e <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
c010511e:	55                   	push   %ebp
c010511f:	89 e5                	mov    %esp,%ebp
c0105121:	83 ec 04             	sub    $0x4,%esp
c0105124:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105127:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c010512a:	eb 14                	jmp    c0105140 <strchr+0x22>
        if (*s == c) {
c010512c:	8b 45 08             	mov    0x8(%ebp),%eax
c010512f:	0f b6 00             	movzbl (%eax),%eax
c0105132:	38 45 fc             	cmp    %al,-0x4(%ebp)
c0105135:	75 05                	jne    c010513c <strchr+0x1e>
            return (char *)s;
c0105137:	8b 45 08             	mov    0x8(%ebp),%eax
c010513a:	eb 13                	jmp    c010514f <strchr+0x31>
        }
        s ++;
c010513c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c0105140:	8b 45 08             	mov    0x8(%ebp),%eax
c0105143:	0f b6 00             	movzbl (%eax),%eax
c0105146:	84 c0                	test   %al,%al
c0105148:	75 e2                	jne    c010512c <strchr+0xe>
    }
    return NULL;
c010514a:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010514f:	c9                   	leave  
c0105150:	c3                   	ret    

c0105151 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
c0105151:	55                   	push   %ebp
c0105152:	89 e5                	mov    %esp,%ebp
c0105154:	83 ec 04             	sub    $0x4,%esp
c0105157:	8b 45 0c             	mov    0xc(%ebp),%eax
c010515a:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c010515d:	eb 0f                	jmp    c010516e <strfind+0x1d>
        if (*s == c) {
c010515f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105162:	0f b6 00             	movzbl (%eax),%eax
c0105165:	38 45 fc             	cmp    %al,-0x4(%ebp)
c0105168:	74 10                	je     c010517a <strfind+0x29>
            break;
        }
        s ++;
c010516a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c010516e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105171:	0f b6 00             	movzbl (%eax),%eax
c0105174:	84 c0                	test   %al,%al
c0105176:	75 e7                	jne    c010515f <strfind+0xe>
c0105178:	eb 01                	jmp    c010517b <strfind+0x2a>
            break;
c010517a:	90                   	nop
    }
    return (char *)s;
c010517b:	8b 45 08             	mov    0x8(%ebp),%eax
}
c010517e:	c9                   	leave  
c010517f:	c3                   	ret    

c0105180 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
c0105180:	55                   	push   %ebp
c0105181:	89 e5                	mov    %esp,%ebp
c0105183:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
c0105186:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
c010518d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c0105194:	eb 04                	jmp    c010519a <strtol+0x1a>
        s ++;
c0105196:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
c010519a:	8b 45 08             	mov    0x8(%ebp),%eax
c010519d:	0f b6 00             	movzbl (%eax),%eax
c01051a0:	3c 20                	cmp    $0x20,%al
c01051a2:	74 f2                	je     c0105196 <strtol+0x16>
c01051a4:	8b 45 08             	mov    0x8(%ebp),%eax
c01051a7:	0f b6 00             	movzbl (%eax),%eax
c01051aa:	3c 09                	cmp    $0x9,%al
c01051ac:	74 e8                	je     c0105196 <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
c01051ae:	8b 45 08             	mov    0x8(%ebp),%eax
c01051b1:	0f b6 00             	movzbl (%eax),%eax
c01051b4:	3c 2b                	cmp    $0x2b,%al
c01051b6:	75 06                	jne    c01051be <strtol+0x3e>
        s ++;
c01051b8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c01051bc:	eb 15                	jmp    c01051d3 <strtol+0x53>
    }
    else if (*s == '-') {
c01051be:	8b 45 08             	mov    0x8(%ebp),%eax
c01051c1:	0f b6 00             	movzbl (%eax),%eax
c01051c4:	3c 2d                	cmp    $0x2d,%al
c01051c6:	75 0b                	jne    c01051d3 <strtol+0x53>
        s ++, neg = 1;
c01051c8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c01051cc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
c01051d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01051d7:	74 06                	je     c01051df <strtol+0x5f>
c01051d9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
c01051dd:	75 24                	jne    c0105203 <strtol+0x83>
c01051df:	8b 45 08             	mov    0x8(%ebp),%eax
c01051e2:	0f b6 00             	movzbl (%eax),%eax
c01051e5:	3c 30                	cmp    $0x30,%al
c01051e7:	75 1a                	jne    c0105203 <strtol+0x83>
c01051e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01051ec:	83 c0 01             	add    $0x1,%eax
c01051ef:	0f b6 00             	movzbl (%eax),%eax
c01051f2:	3c 78                	cmp    $0x78,%al
c01051f4:	75 0d                	jne    c0105203 <strtol+0x83>
        s += 2, base = 16;
c01051f6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
c01051fa:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
c0105201:	eb 2a                	jmp    c010522d <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
c0105203:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105207:	75 17                	jne    c0105220 <strtol+0xa0>
c0105209:	8b 45 08             	mov    0x8(%ebp),%eax
c010520c:	0f b6 00             	movzbl (%eax),%eax
c010520f:	3c 30                	cmp    $0x30,%al
c0105211:	75 0d                	jne    c0105220 <strtol+0xa0>
        s ++, base = 8;
c0105213:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105217:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
c010521e:	eb 0d                	jmp    c010522d <strtol+0xad>
    }
    else if (base == 0) {
c0105220:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105224:	75 07                	jne    c010522d <strtol+0xad>
        base = 10;
c0105226:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
c010522d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105230:	0f b6 00             	movzbl (%eax),%eax
c0105233:	3c 2f                	cmp    $0x2f,%al
c0105235:	7e 1b                	jle    c0105252 <strtol+0xd2>
c0105237:	8b 45 08             	mov    0x8(%ebp),%eax
c010523a:	0f b6 00             	movzbl (%eax),%eax
c010523d:	3c 39                	cmp    $0x39,%al
c010523f:	7f 11                	jg     c0105252 <strtol+0xd2>
            dig = *s - '0';
c0105241:	8b 45 08             	mov    0x8(%ebp),%eax
c0105244:	0f b6 00             	movzbl (%eax),%eax
c0105247:	0f be c0             	movsbl %al,%eax
c010524a:	83 e8 30             	sub    $0x30,%eax
c010524d:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105250:	eb 48                	jmp    c010529a <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
c0105252:	8b 45 08             	mov    0x8(%ebp),%eax
c0105255:	0f b6 00             	movzbl (%eax),%eax
c0105258:	3c 60                	cmp    $0x60,%al
c010525a:	7e 1b                	jle    c0105277 <strtol+0xf7>
c010525c:	8b 45 08             	mov    0x8(%ebp),%eax
c010525f:	0f b6 00             	movzbl (%eax),%eax
c0105262:	3c 7a                	cmp    $0x7a,%al
c0105264:	7f 11                	jg     c0105277 <strtol+0xf7>
            dig = *s - 'a' + 10;
c0105266:	8b 45 08             	mov    0x8(%ebp),%eax
c0105269:	0f b6 00             	movzbl (%eax),%eax
c010526c:	0f be c0             	movsbl %al,%eax
c010526f:	83 e8 57             	sub    $0x57,%eax
c0105272:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105275:	eb 23                	jmp    c010529a <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
c0105277:	8b 45 08             	mov    0x8(%ebp),%eax
c010527a:	0f b6 00             	movzbl (%eax),%eax
c010527d:	3c 40                	cmp    $0x40,%al
c010527f:	7e 3c                	jle    c01052bd <strtol+0x13d>
c0105281:	8b 45 08             	mov    0x8(%ebp),%eax
c0105284:	0f b6 00             	movzbl (%eax),%eax
c0105287:	3c 5a                	cmp    $0x5a,%al
c0105289:	7f 32                	jg     c01052bd <strtol+0x13d>
            dig = *s - 'A' + 10;
c010528b:	8b 45 08             	mov    0x8(%ebp),%eax
c010528e:	0f b6 00             	movzbl (%eax),%eax
c0105291:	0f be c0             	movsbl %al,%eax
c0105294:	83 e8 37             	sub    $0x37,%eax
c0105297:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
c010529a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010529d:	3b 45 10             	cmp    0x10(%ebp),%eax
c01052a0:	7d 1a                	jge    c01052bc <strtol+0x13c>
            break;
        }
        s ++, val = (val * base) + dig;
c01052a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c01052a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01052a9:	0f af 45 10          	imul   0x10(%ebp),%eax
c01052ad:	89 c2                	mov    %eax,%edx
c01052af:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01052b2:	01 d0                	add    %edx,%eax
c01052b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
c01052b7:	e9 71 ff ff ff       	jmp    c010522d <strtol+0xad>
            break;
c01052bc:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
c01052bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01052c1:	74 08                	je     c01052cb <strtol+0x14b>
        *endptr = (char *) s;
c01052c3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01052c6:	8b 55 08             	mov    0x8(%ebp),%edx
c01052c9:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
c01052cb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c01052cf:	74 07                	je     c01052d8 <strtol+0x158>
c01052d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01052d4:	f7 d8                	neg    %eax
c01052d6:	eb 03                	jmp    c01052db <strtol+0x15b>
c01052d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
c01052db:	c9                   	leave  
c01052dc:	c3                   	ret    

c01052dd <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
c01052dd:	55                   	push   %ebp
c01052de:	89 e5                	mov    %esp,%ebp
c01052e0:	57                   	push   %edi
c01052e1:	83 ec 24             	sub    $0x24,%esp
c01052e4:	8b 45 0c             	mov    0xc(%ebp),%eax
c01052e7:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
c01052ea:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
c01052ee:	8b 55 08             	mov    0x8(%ebp),%edx
c01052f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
c01052f4:	88 45 f7             	mov    %al,-0x9(%ebp)
c01052f7:	8b 45 10             	mov    0x10(%ebp),%eax
c01052fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
c01052fd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0105300:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c0105304:	8b 55 f8             	mov    -0x8(%ebp),%edx
c0105307:	89 d7                	mov    %edx,%edi
c0105309:	f3 aa                	rep stos %al,%es:(%edi)
c010530b:	89 fa                	mov    %edi,%edx
c010530d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105310:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
c0105313:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105316:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
c0105317:	83 c4 24             	add    $0x24,%esp
c010531a:	5f                   	pop    %edi
c010531b:	5d                   	pop    %ebp
c010531c:	c3                   	ret    

c010531d <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
c010531d:	55                   	push   %ebp
c010531e:	89 e5                	mov    %esp,%ebp
c0105320:	57                   	push   %edi
c0105321:	56                   	push   %esi
c0105322:	53                   	push   %ebx
c0105323:	83 ec 30             	sub    $0x30,%esp
c0105326:	8b 45 08             	mov    0x8(%ebp),%eax
c0105329:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010532c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010532f:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105332:	8b 45 10             	mov    0x10(%ebp),%eax
c0105335:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
c0105338:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010533b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c010533e:	73 42                	jae    c0105382 <memmove+0x65>
c0105340:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105343:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0105346:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105349:	89 45 e0             	mov    %eax,-0x20(%ebp)
c010534c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010534f:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c0105352:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105355:	c1 e8 02             	shr    $0x2,%eax
c0105358:	89 c1                	mov    %eax,%ecx
    asm volatile (
c010535a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c010535d:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105360:	89 d7                	mov    %edx,%edi
c0105362:	89 c6                	mov    %eax,%esi
c0105364:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0105366:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c0105369:	83 e1 03             	and    $0x3,%ecx
c010536c:	74 02                	je     c0105370 <memmove+0x53>
c010536e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0105370:	89 f0                	mov    %esi,%eax
c0105372:	89 fa                	mov    %edi,%edx
c0105374:	89 4d d8             	mov    %ecx,-0x28(%ebp)
c0105377:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c010537a:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
c010537d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
c0105380:	eb 36                	jmp    c01053b8 <memmove+0x9b>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c0105382:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105385:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105388:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010538b:	01 c2                	add    %eax,%edx
c010538d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105390:	8d 48 ff             	lea    -0x1(%eax),%ecx
c0105393:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105396:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
c0105399:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010539c:	89 c1                	mov    %eax,%ecx
c010539e:	89 d8                	mov    %ebx,%eax
c01053a0:	89 d6                	mov    %edx,%esi
c01053a2:	89 c7                	mov    %eax,%edi
c01053a4:	fd                   	std    
c01053a5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c01053a7:	fc                   	cld    
c01053a8:	89 f8                	mov    %edi,%eax
c01053aa:	89 f2                	mov    %esi,%edx
c01053ac:	89 4d cc             	mov    %ecx,-0x34(%ebp)
c01053af:	89 55 c8             	mov    %edx,-0x38(%ebp)
c01053b2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
c01053b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
c01053b8:	83 c4 30             	add    $0x30,%esp
c01053bb:	5b                   	pop    %ebx
c01053bc:	5e                   	pop    %esi
c01053bd:	5f                   	pop    %edi
c01053be:	5d                   	pop    %ebp
c01053bf:	c3                   	ret    

c01053c0 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
c01053c0:	55                   	push   %ebp
c01053c1:	89 e5                	mov    %esp,%ebp
c01053c3:	57                   	push   %edi
c01053c4:	56                   	push   %esi
c01053c5:	83 ec 20             	sub    $0x20,%esp
c01053c8:	8b 45 08             	mov    0x8(%ebp),%eax
c01053cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01053ce:	8b 45 0c             	mov    0xc(%ebp),%eax
c01053d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01053d4:	8b 45 10             	mov    0x10(%ebp),%eax
c01053d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c01053da:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01053dd:	c1 e8 02             	shr    $0x2,%eax
c01053e0:	89 c1                	mov    %eax,%ecx
    asm volatile (
c01053e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01053e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01053e8:	89 d7                	mov    %edx,%edi
c01053ea:	89 c6                	mov    %eax,%esi
c01053ec:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c01053ee:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c01053f1:	83 e1 03             	and    $0x3,%ecx
c01053f4:	74 02                	je     c01053f8 <memcpy+0x38>
c01053f6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c01053f8:	89 f0                	mov    %esi,%eax
c01053fa:	89 fa                	mov    %edi,%edx
c01053fc:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c01053ff:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c0105402:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
c0105405:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
c0105408:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
c0105409:	83 c4 20             	add    $0x20,%esp
c010540c:	5e                   	pop    %esi
c010540d:	5f                   	pop    %edi
c010540e:	5d                   	pop    %ebp
c010540f:	c3                   	ret    

c0105410 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
c0105410:	55                   	push   %ebp
c0105411:	89 e5                	mov    %esp,%ebp
c0105413:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
c0105416:	8b 45 08             	mov    0x8(%ebp),%eax
c0105419:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
c010541c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010541f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
c0105422:	eb 30                	jmp    c0105454 <memcmp+0x44>
        if (*s1 != *s2) {
c0105424:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105427:	0f b6 10             	movzbl (%eax),%edx
c010542a:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010542d:	0f b6 00             	movzbl (%eax),%eax
c0105430:	38 c2                	cmp    %al,%dl
c0105432:	74 18                	je     c010544c <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
c0105434:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105437:	0f b6 00             	movzbl (%eax),%eax
c010543a:	0f b6 d0             	movzbl %al,%edx
c010543d:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105440:	0f b6 00             	movzbl (%eax),%eax
c0105443:	0f b6 c0             	movzbl %al,%eax
c0105446:	29 c2                	sub    %eax,%edx
c0105448:	89 d0                	mov    %edx,%eax
c010544a:	eb 1a                	jmp    c0105466 <memcmp+0x56>
        }
        s1 ++, s2 ++;
c010544c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0105450:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
c0105454:	8b 45 10             	mov    0x10(%ebp),%eax
c0105457:	8d 50 ff             	lea    -0x1(%eax),%edx
c010545a:	89 55 10             	mov    %edx,0x10(%ebp)
c010545d:	85 c0                	test   %eax,%eax
c010545f:	75 c3                	jne    c0105424 <memcmp+0x14>
    }
    return 0;
c0105461:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105466:	c9                   	leave  
c0105467:	c3                   	ret    

c0105468 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
c0105468:	55                   	push   %ebp
c0105469:	89 e5                	mov    %esp,%ebp
c010546b:	83 ec 38             	sub    $0x38,%esp
c010546e:	8b 45 10             	mov    0x10(%ebp),%eax
c0105471:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0105474:	8b 45 14             	mov    0x14(%ebp),%eax
c0105477:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
c010547a:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010547d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0105480:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105483:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
c0105486:	8b 45 18             	mov    0x18(%ebp),%eax
c0105489:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010548c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010548f:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105492:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105495:	89 55 f0             	mov    %edx,-0x10(%ebp)
c0105498:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010549b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010549e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01054a2:	74 1c                	je     c01054c0 <printnum+0x58>
c01054a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01054a7:	ba 00 00 00 00       	mov    $0x0,%edx
c01054ac:	f7 75 e4             	divl   -0x1c(%ebp)
c01054af:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01054b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01054b5:	ba 00 00 00 00       	mov    $0x0,%edx
c01054ba:	f7 75 e4             	divl   -0x1c(%ebp)
c01054bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01054c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01054c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01054c6:	f7 75 e4             	divl   -0x1c(%ebp)
c01054c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01054cc:	89 55 dc             	mov    %edx,-0x24(%ebp)
c01054cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01054d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01054d5:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01054d8:	89 55 ec             	mov    %edx,-0x14(%ebp)
c01054db:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01054de:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
c01054e1:	8b 45 18             	mov    0x18(%ebp),%eax
c01054e4:	ba 00 00 00 00       	mov    $0x0,%edx
c01054e9:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
c01054ec:	72 41                	jb     c010552f <printnum+0xc7>
c01054ee:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
c01054f1:	77 05                	ja     c01054f8 <printnum+0x90>
c01054f3:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c01054f6:	72 37                	jb     c010552f <printnum+0xc7>
        printnum(putch, putdat, result, base, width - 1, padc);
c01054f8:	8b 45 1c             	mov    0x1c(%ebp),%eax
c01054fb:	83 e8 01             	sub    $0x1,%eax
c01054fe:	83 ec 04             	sub    $0x4,%esp
c0105501:	ff 75 20             	pushl  0x20(%ebp)
c0105504:	50                   	push   %eax
c0105505:	ff 75 18             	pushl  0x18(%ebp)
c0105508:	ff 75 ec             	pushl  -0x14(%ebp)
c010550b:	ff 75 e8             	pushl  -0x18(%ebp)
c010550e:	ff 75 0c             	pushl  0xc(%ebp)
c0105511:	ff 75 08             	pushl  0x8(%ebp)
c0105514:	e8 4f ff ff ff       	call   c0105468 <printnum>
c0105519:	83 c4 20             	add    $0x20,%esp
c010551c:	eb 1b                	jmp    c0105539 <printnum+0xd1>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
c010551e:	83 ec 08             	sub    $0x8,%esp
c0105521:	ff 75 0c             	pushl  0xc(%ebp)
c0105524:	ff 75 20             	pushl  0x20(%ebp)
c0105527:	8b 45 08             	mov    0x8(%ebp),%eax
c010552a:	ff d0                	call   *%eax
c010552c:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
c010552f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
c0105533:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0105537:	7f e5                	jg     c010551e <printnum+0xb6>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
c0105539:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010553c:	05 24 6c 10 c0       	add    $0xc0106c24,%eax
c0105541:	0f b6 00             	movzbl (%eax),%eax
c0105544:	0f be c0             	movsbl %al,%eax
c0105547:	83 ec 08             	sub    $0x8,%esp
c010554a:	ff 75 0c             	pushl  0xc(%ebp)
c010554d:	50                   	push   %eax
c010554e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105551:	ff d0                	call   *%eax
c0105553:	83 c4 10             	add    $0x10,%esp
}
c0105556:	90                   	nop
c0105557:	c9                   	leave  
c0105558:	c3                   	ret    

c0105559 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
c0105559:	55                   	push   %ebp
c010555a:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c010555c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0105560:	7e 14                	jle    c0105576 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
c0105562:	8b 45 08             	mov    0x8(%ebp),%eax
c0105565:	8b 00                	mov    (%eax),%eax
c0105567:	8d 48 08             	lea    0x8(%eax),%ecx
c010556a:	8b 55 08             	mov    0x8(%ebp),%edx
c010556d:	89 0a                	mov    %ecx,(%edx)
c010556f:	8b 50 04             	mov    0x4(%eax),%edx
c0105572:	8b 00                	mov    (%eax),%eax
c0105574:	eb 30                	jmp    c01055a6 <getuint+0x4d>
    }
    else if (lflag) {
c0105576:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010557a:	74 16                	je     c0105592 <getuint+0x39>
        return va_arg(*ap, unsigned long);
c010557c:	8b 45 08             	mov    0x8(%ebp),%eax
c010557f:	8b 00                	mov    (%eax),%eax
c0105581:	8d 48 04             	lea    0x4(%eax),%ecx
c0105584:	8b 55 08             	mov    0x8(%ebp),%edx
c0105587:	89 0a                	mov    %ecx,(%edx)
c0105589:	8b 00                	mov    (%eax),%eax
c010558b:	ba 00 00 00 00       	mov    $0x0,%edx
c0105590:	eb 14                	jmp    c01055a6 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
c0105592:	8b 45 08             	mov    0x8(%ebp),%eax
c0105595:	8b 00                	mov    (%eax),%eax
c0105597:	8d 48 04             	lea    0x4(%eax),%ecx
c010559a:	8b 55 08             	mov    0x8(%ebp),%edx
c010559d:	89 0a                	mov    %ecx,(%edx)
c010559f:	8b 00                	mov    (%eax),%eax
c01055a1:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
c01055a6:	5d                   	pop    %ebp
c01055a7:	c3                   	ret    

c01055a8 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
c01055a8:	55                   	push   %ebp
c01055a9:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c01055ab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c01055af:	7e 14                	jle    c01055c5 <getint+0x1d>
        return va_arg(*ap, long long);
c01055b1:	8b 45 08             	mov    0x8(%ebp),%eax
c01055b4:	8b 00                	mov    (%eax),%eax
c01055b6:	8d 48 08             	lea    0x8(%eax),%ecx
c01055b9:	8b 55 08             	mov    0x8(%ebp),%edx
c01055bc:	89 0a                	mov    %ecx,(%edx)
c01055be:	8b 50 04             	mov    0x4(%eax),%edx
c01055c1:	8b 00                	mov    (%eax),%eax
c01055c3:	eb 28                	jmp    c01055ed <getint+0x45>
    }
    else if (lflag) {
c01055c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01055c9:	74 12                	je     c01055dd <getint+0x35>
        return va_arg(*ap, long);
c01055cb:	8b 45 08             	mov    0x8(%ebp),%eax
c01055ce:	8b 00                	mov    (%eax),%eax
c01055d0:	8d 48 04             	lea    0x4(%eax),%ecx
c01055d3:	8b 55 08             	mov    0x8(%ebp),%edx
c01055d6:	89 0a                	mov    %ecx,(%edx)
c01055d8:	8b 00                	mov    (%eax),%eax
c01055da:	99                   	cltd   
c01055db:	eb 10                	jmp    c01055ed <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
c01055dd:	8b 45 08             	mov    0x8(%ebp),%eax
c01055e0:	8b 00                	mov    (%eax),%eax
c01055e2:	8d 48 04             	lea    0x4(%eax),%ecx
c01055e5:	8b 55 08             	mov    0x8(%ebp),%edx
c01055e8:	89 0a                	mov    %ecx,(%edx)
c01055ea:	8b 00                	mov    (%eax),%eax
c01055ec:	99                   	cltd   
    }
}
c01055ed:	5d                   	pop    %ebp
c01055ee:	c3                   	ret    

c01055ef <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
c01055ef:	55                   	push   %ebp
c01055f0:	89 e5                	mov    %esp,%ebp
c01055f2:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
c01055f5:	8d 45 14             	lea    0x14(%ebp),%eax
c01055f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
c01055fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01055fe:	50                   	push   %eax
c01055ff:	ff 75 10             	pushl  0x10(%ebp)
c0105602:	ff 75 0c             	pushl  0xc(%ebp)
c0105605:	ff 75 08             	pushl  0x8(%ebp)
c0105608:	e8 06 00 00 00       	call   c0105613 <vprintfmt>
c010560d:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c0105610:	90                   	nop
c0105611:	c9                   	leave  
c0105612:	c3                   	ret    

c0105613 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
c0105613:	55                   	push   %ebp
c0105614:	89 e5                	mov    %esp,%ebp
c0105616:	56                   	push   %esi
c0105617:	53                   	push   %ebx
c0105618:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c010561b:	eb 17                	jmp    c0105634 <vprintfmt+0x21>
            if (ch == '\0') {
c010561d:	85 db                	test   %ebx,%ebx
c010561f:	0f 84 8e 03 00 00    	je     c01059b3 <vprintfmt+0x3a0>
                return;
            }
            putch(ch, putdat);
c0105625:	83 ec 08             	sub    $0x8,%esp
c0105628:	ff 75 0c             	pushl  0xc(%ebp)
c010562b:	53                   	push   %ebx
c010562c:	8b 45 08             	mov    0x8(%ebp),%eax
c010562f:	ff d0                	call   *%eax
c0105631:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105634:	8b 45 10             	mov    0x10(%ebp),%eax
c0105637:	8d 50 01             	lea    0x1(%eax),%edx
c010563a:	89 55 10             	mov    %edx,0x10(%ebp)
c010563d:	0f b6 00             	movzbl (%eax),%eax
c0105640:	0f b6 d8             	movzbl %al,%ebx
c0105643:	83 fb 25             	cmp    $0x25,%ebx
c0105646:	75 d5                	jne    c010561d <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
c0105648:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
c010564c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
c0105653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105656:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
c0105659:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0105660:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105663:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
c0105666:	8b 45 10             	mov    0x10(%ebp),%eax
c0105669:	8d 50 01             	lea    0x1(%eax),%edx
c010566c:	89 55 10             	mov    %edx,0x10(%ebp)
c010566f:	0f b6 00             	movzbl (%eax),%eax
c0105672:	0f b6 d8             	movzbl %al,%ebx
c0105675:	8d 43 dd             	lea    -0x23(%ebx),%eax
c0105678:	83 f8 55             	cmp    $0x55,%eax
c010567b:	0f 87 05 03 00 00    	ja     c0105986 <vprintfmt+0x373>
c0105681:	8b 04 85 48 6c 10 c0 	mov    -0x3fef93b8(,%eax,4),%eax
c0105688:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
c010568a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
c010568e:	eb d6                	jmp    c0105666 <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
c0105690:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
c0105694:	eb d0                	jmp    c0105666 <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c0105696:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
c010569d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01056a0:	89 d0                	mov    %edx,%eax
c01056a2:	c1 e0 02             	shl    $0x2,%eax
c01056a5:	01 d0                	add    %edx,%eax
c01056a7:	01 c0                	add    %eax,%eax
c01056a9:	01 d8                	add    %ebx,%eax
c01056ab:	83 e8 30             	sub    $0x30,%eax
c01056ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
c01056b1:	8b 45 10             	mov    0x10(%ebp),%eax
c01056b4:	0f b6 00             	movzbl (%eax),%eax
c01056b7:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
c01056ba:	83 fb 2f             	cmp    $0x2f,%ebx
c01056bd:	7e 39                	jle    c01056f8 <vprintfmt+0xe5>
c01056bf:	83 fb 39             	cmp    $0x39,%ebx
c01056c2:	7f 34                	jg     c01056f8 <vprintfmt+0xe5>
            for (precision = 0; ; ++ fmt) {
c01056c4:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
c01056c8:	eb d3                	jmp    c010569d <vprintfmt+0x8a>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
c01056ca:	8b 45 14             	mov    0x14(%ebp),%eax
c01056cd:	8d 50 04             	lea    0x4(%eax),%edx
c01056d0:	89 55 14             	mov    %edx,0x14(%ebp)
c01056d3:	8b 00                	mov    (%eax),%eax
c01056d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
c01056d8:	eb 1f                	jmp    c01056f9 <vprintfmt+0xe6>

        case '.':
            if (width < 0)
c01056da:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01056de:	79 86                	jns    c0105666 <vprintfmt+0x53>
                width = 0;
c01056e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
c01056e7:	e9 7a ff ff ff       	jmp    c0105666 <vprintfmt+0x53>

        case '#':
            altflag = 1;
c01056ec:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
c01056f3:	e9 6e ff ff ff       	jmp    c0105666 <vprintfmt+0x53>
            goto process_precision;
c01056f8:	90                   	nop

        process_precision:
            if (width < 0)
c01056f9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01056fd:	0f 89 63 ff ff ff    	jns    c0105666 <vprintfmt+0x53>
                width = precision, precision = -1;
c0105703:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105706:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105709:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
c0105710:	e9 51 ff ff ff       	jmp    c0105666 <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
c0105715:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
c0105719:	e9 48 ff ff ff       	jmp    c0105666 <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
c010571e:	8b 45 14             	mov    0x14(%ebp),%eax
c0105721:	8d 50 04             	lea    0x4(%eax),%edx
c0105724:	89 55 14             	mov    %edx,0x14(%ebp)
c0105727:	8b 00                	mov    (%eax),%eax
c0105729:	83 ec 08             	sub    $0x8,%esp
c010572c:	ff 75 0c             	pushl  0xc(%ebp)
c010572f:	50                   	push   %eax
c0105730:	8b 45 08             	mov    0x8(%ebp),%eax
c0105733:	ff d0                	call   *%eax
c0105735:	83 c4 10             	add    $0x10,%esp
            break;
c0105738:	e9 71 02 00 00       	jmp    c01059ae <vprintfmt+0x39b>

        // error message
        case 'e':
            err = va_arg(ap, int);
c010573d:	8b 45 14             	mov    0x14(%ebp),%eax
c0105740:	8d 50 04             	lea    0x4(%eax),%edx
c0105743:	89 55 14             	mov    %edx,0x14(%ebp)
c0105746:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
c0105748:	85 db                	test   %ebx,%ebx
c010574a:	79 02                	jns    c010574e <vprintfmt+0x13b>
                err = -err;
c010574c:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
c010574e:	83 fb 06             	cmp    $0x6,%ebx
c0105751:	7f 0b                	jg     c010575e <vprintfmt+0x14b>
c0105753:	8b 34 9d 08 6c 10 c0 	mov    -0x3fef93f8(,%ebx,4),%esi
c010575a:	85 f6                	test   %esi,%esi
c010575c:	75 19                	jne    c0105777 <vprintfmt+0x164>
                printfmt(putch, putdat, "error %d", err);
c010575e:	53                   	push   %ebx
c010575f:	68 35 6c 10 c0       	push   $0xc0106c35
c0105764:	ff 75 0c             	pushl  0xc(%ebp)
c0105767:	ff 75 08             	pushl  0x8(%ebp)
c010576a:	e8 80 fe ff ff       	call   c01055ef <printfmt>
c010576f:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
c0105772:	e9 37 02 00 00       	jmp    c01059ae <vprintfmt+0x39b>
                printfmt(putch, putdat, "%s", p);
c0105777:	56                   	push   %esi
c0105778:	68 3e 6c 10 c0       	push   $0xc0106c3e
c010577d:	ff 75 0c             	pushl  0xc(%ebp)
c0105780:	ff 75 08             	pushl  0x8(%ebp)
c0105783:	e8 67 fe ff ff       	call   c01055ef <printfmt>
c0105788:	83 c4 10             	add    $0x10,%esp
            break;
c010578b:	e9 1e 02 00 00       	jmp    c01059ae <vprintfmt+0x39b>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
c0105790:	8b 45 14             	mov    0x14(%ebp),%eax
c0105793:	8d 50 04             	lea    0x4(%eax),%edx
c0105796:	89 55 14             	mov    %edx,0x14(%ebp)
c0105799:	8b 30                	mov    (%eax),%esi
c010579b:	85 f6                	test   %esi,%esi
c010579d:	75 05                	jne    c01057a4 <vprintfmt+0x191>
                p = "(null)";
c010579f:	be 41 6c 10 c0       	mov    $0xc0106c41,%esi
            }
            if (width > 0 && padc != '-') {
c01057a4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01057a8:	7e 76                	jle    c0105820 <vprintfmt+0x20d>
c01057aa:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
c01057ae:	74 70                	je     c0105820 <vprintfmt+0x20d>
                for (width -= strnlen(p, precision); width > 0; width --) {
c01057b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01057b3:	83 ec 08             	sub    $0x8,%esp
c01057b6:	50                   	push   %eax
c01057b7:	56                   	push   %esi
c01057b8:	e8 17 f8 ff ff       	call   c0104fd4 <strnlen>
c01057bd:	83 c4 10             	add    $0x10,%esp
c01057c0:	89 c2                	mov    %eax,%edx
c01057c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01057c5:	29 d0                	sub    %edx,%eax
c01057c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01057ca:	eb 17                	jmp    c01057e3 <vprintfmt+0x1d0>
                    putch(padc, putdat);
c01057cc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
c01057d0:	83 ec 08             	sub    $0x8,%esp
c01057d3:	ff 75 0c             	pushl  0xc(%ebp)
c01057d6:	50                   	push   %eax
c01057d7:	8b 45 08             	mov    0x8(%ebp),%eax
c01057da:	ff d0                	call   *%eax
c01057dc:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
c01057df:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c01057e3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01057e7:	7f e3                	jg     c01057cc <vprintfmt+0x1b9>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c01057e9:	eb 35                	jmp    c0105820 <vprintfmt+0x20d>
                if (altflag && (ch < ' ' || ch > '~')) {
c01057eb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c01057ef:	74 1c                	je     c010580d <vprintfmt+0x1fa>
c01057f1:	83 fb 1f             	cmp    $0x1f,%ebx
c01057f4:	7e 05                	jle    c01057fb <vprintfmt+0x1e8>
c01057f6:	83 fb 7e             	cmp    $0x7e,%ebx
c01057f9:	7e 12                	jle    c010580d <vprintfmt+0x1fa>
                    putch('?', putdat);
c01057fb:	83 ec 08             	sub    $0x8,%esp
c01057fe:	ff 75 0c             	pushl  0xc(%ebp)
c0105801:	6a 3f                	push   $0x3f
c0105803:	8b 45 08             	mov    0x8(%ebp),%eax
c0105806:	ff d0                	call   *%eax
c0105808:	83 c4 10             	add    $0x10,%esp
c010580b:	eb 0f                	jmp    c010581c <vprintfmt+0x209>
                }
                else {
                    putch(ch, putdat);
c010580d:	83 ec 08             	sub    $0x8,%esp
c0105810:	ff 75 0c             	pushl  0xc(%ebp)
c0105813:	53                   	push   %ebx
c0105814:	8b 45 08             	mov    0x8(%ebp),%eax
c0105817:	ff d0                	call   *%eax
c0105819:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c010581c:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105820:	89 f0                	mov    %esi,%eax
c0105822:	8d 70 01             	lea    0x1(%eax),%esi
c0105825:	0f b6 00             	movzbl (%eax),%eax
c0105828:	0f be d8             	movsbl %al,%ebx
c010582b:	85 db                	test   %ebx,%ebx
c010582d:	74 26                	je     c0105855 <vprintfmt+0x242>
c010582f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105833:	78 b6                	js     c01057eb <vprintfmt+0x1d8>
c0105835:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
c0105839:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010583d:	79 ac                	jns    c01057eb <vprintfmt+0x1d8>
                }
            }
            for (; width > 0; width --) {
c010583f:	eb 14                	jmp    c0105855 <vprintfmt+0x242>
                putch(' ', putdat);
c0105841:	83 ec 08             	sub    $0x8,%esp
c0105844:	ff 75 0c             	pushl  0xc(%ebp)
c0105847:	6a 20                	push   $0x20
c0105849:	8b 45 08             	mov    0x8(%ebp),%eax
c010584c:	ff d0                	call   *%eax
c010584e:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
c0105851:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105855:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105859:	7f e6                	jg     c0105841 <vprintfmt+0x22e>
            }
            break;
c010585b:	e9 4e 01 00 00       	jmp    c01059ae <vprintfmt+0x39b>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
c0105860:	83 ec 08             	sub    $0x8,%esp
c0105863:	ff 75 e0             	pushl  -0x20(%ebp)
c0105866:	8d 45 14             	lea    0x14(%ebp),%eax
c0105869:	50                   	push   %eax
c010586a:	e8 39 fd ff ff       	call   c01055a8 <getint>
c010586f:	83 c4 10             	add    $0x10,%esp
c0105872:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105875:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
c0105878:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010587b:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010587e:	85 d2                	test   %edx,%edx
c0105880:	79 23                	jns    c01058a5 <vprintfmt+0x292>
                putch('-', putdat);
c0105882:	83 ec 08             	sub    $0x8,%esp
c0105885:	ff 75 0c             	pushl  0xc(%ebp)
c0105888:	6a 2d                	push   $0x2d
c010588a:	8b 45 08             	mov    0x8(%ebp),%eax
c010588d:	ff d0                	call   *%eax
c010588f:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
c0105892:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105895:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105898:	f7 d8                	neg    %eax
c010589a:	83 d2 00             	adc    $0x0,%edx
c010589d:	f7 da                	neg    %edx
c010589f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01058a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
c01058a5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c01058ac:	e9 9f 00 00 00       	jmp    c0105950 <vprintfmt+0x33d>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
c01058b1:	83 ec 08             	sub    $0x8,%esp
c01058b4:	ff 75 e0             	pushl  -0x20(%ebp)
c01058b7:	8d 45 14             	lea    0x14(%ebp),%eax
c01058ba:	50                   	push   %eax
c01058bb:	e8 99 fc ff ff       	call   c0105559 <getuint>
c01058c0:	83 c4 10             	add    $0x10,%esp
c01058c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01058c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
c01058c9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c01058d0:	eb 7e                	jmp    c0105950 <vprintfmt+0x33d>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
c01058d2:	83 ec 08             	sub    $0x8,%esp
c01058d5:	ff 75 e0             	pushl  -0x20(%ebp)
c01058d8:	8d 45 14             	lea    0x14(%ebp),%eax
c01058db:	50                   	push   %eax
c01058dc:	e8 78 fc ff ff       	call   c0105559 <getuint>
c01058e1:	83 c4 10             	add    $0x10,%esp
c01058e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01058e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
c01058ea:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
c01058f1:	eb 5d                	jmp    c0105950 <vprintfmt+0x33d>

        // pointer
        case 'p':
            putch('0', putdat);
c01058f3:	83 ec 08             	sub    $0x8,%esp
c01058f6:	ff 75 0c             	pushl  0xc(%ebp)
c01058f9:	6a 30                	push   $0x30
c01058fb:	8b 45 08             	mov    0x8(%ebp),%eax
c01058fe:	ff d0                	call   *%eax
c0105900:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
c0105903:	83 ec 08             	sub    $0x8,%esp
c0105906:	ff 75 0c             	pushl  0xc(%ebp)
c0105909:	6a 78                	push   $0x78
c010590b:	8b 45 08             	mov    0x8(%ebp),%eax
c010590e:	ff d0                	call   *%eax
c0105910:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
c0105913:	8b 45 14             	mov    0x14(%ebp),%eax
c0105916:	8d 50 04             	lea    0x4(%eax),%edx
c0105919:	89 55 14             	mov    %edx,0x14(%ebp)
c010591c:	8b 00                	mov    (%eax),%eax
c010591e:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105921:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
c0105928:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
c010592f:	eb 1f                	jmp    c0105950 <vprintfmt+0x33d>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
c0105931:	83 ec 08             	sub    $0x8,%esp
c0105934:	ff 75 e0             	pushl  -0x20(%ebp)
c0105937:	8d 45 14             	lea    0x14(%ebp),%eax
c010593a:	50                   	push   %eax
c010593b:	e8 19 fc ff ff       	call   c0105559 <getuint>
c0105940:	83 c4 10             	add    $0x10,%esp
c0105943:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105946:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
c0105949:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
c0105950:	0f be 55 db          	movsbl -0x25(%ebp),%edx
c0105954:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105957:	83 ec 04             	sub    $0x4,%esp
c010595a:	52                   	push   %edx
c010595b:	ff 75 e8             	pushl  -0x18(%ebp)
c010595e:	50                   	push   %eax
c010595f:	ff 75 f4             	pushl  -0xc(%ebp)
c0105962:	ff 75 f0             	pushl  -0x10(%ebp)
c0105965:	ff 75 0c             	pushl  0xc(%ebp)
c0105968:	ff 75 08             	pushl  0x8(%ebp)
c010596b:	e8 f8 fa ff ff       	call   c0105468 <printnum>
c0105970:	83 c4 20             	add    $0x20,%esp
            break;
c0105973:	eb 39                	jmp    c01059ae <vprintfmt+0x39b>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
c0105975:	83 ec 08             	sub    $0x8,%esp
c0105978:	ff 75 0c             	pushl  0xc(%ebp)
c010597b:	53                   	push   %ebx
c010597c:	8b 45 08             	mov    0x8(%ebp),%eax
c010597f:	ff d0                	call   *%eax
c0105981:	83 c4 10             	add    $0x10,%esp
            break;
c0105984:	eb 28                	jmp    c01059ae <vprintfmt+0x39b>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
c0105986:	83 ec 08             	sub    $0x8,%esp
c0105989:	ff 75 0c             	pushl  0xc(%ebp)
c010598c:	6a 25                	push   $0x25
c010598e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105991:	ff d0                	call   *%eax
c0105993:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
c0105996:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c010599a:	eb 04                	jmp    c01059a0 <vprintfmt+0x38d>
c010599c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c01059a0:	8b 45 10             	mov    0x10(%ebp),%eax
c01059a3:	83 e8 01             	sub    $0x1,%eax
c01059a6:	0f b6 00             	movzbl (%eax),%eax
c01059a9:	3c 25                	cmp    $0x25,%al
c01059ab:	75 ef                	jne    c010599c <vprintfmt+0x389>
                /* do nothing */;
            break;
c01059ad:	90                   	nop
    while (1) {
c01059ae:	e9 68 fc ff ff       	jmp    c010561b <vprintfmt+0x8>
                return;
c01059b3:	90                   	nop
        }
    }
}
c01059b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
c01059b7:	5b                   	pop    %ebx
c01059b8:	5e                   	pop    %esi
c01059b9:	5d                   	pop    %ebp
c01059ba:	c3                   	ret    

c01059bb <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
c01059bb:	55                   	push   %ebp
c01059bc:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
c01059be:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059c1:	8b 40 08             	mov    0x8(%eax),%eax
c01059c4:	8d 50 01             	lea    0x1(%eax),%edx
c01059c7:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059ca:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
c01059cd:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059d0:	8b 10                	mov    (%eax),%edx
c01059d2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059d5:	8b 40 04             	mov    0x4(%eax),%eax
c01059d8:	39 c2                	cmp    %eax,%edx
c01059da:	73 12                	jae    c01059ee <sprintputch+0x33>
        *b->buf ++ = ch;
c01059dc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059df:	8b 00                	mov    (%eax),%eax
c01059e1:	8d 48 01             	lea    0x1(%eax),%ecx
c01059e4:	8b 55 0c             	mov    0xc(%ebp),%edx
c01059e7:	89 0a                	mov    %ecx,(%edx)
c01059e9:	8b 55 08             	mov    0x8(%ebp),%edx
c01059ec:	88 10                	mov    %dl,(%eax)
    }
}
c01059ee:	90                   	nop
c01059ef:	5d                   	pop    %ebp
c01059f0:	c3                   	ret    

c01059f1 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
c01059f1:	55                   	push   %ebp
c01059f2:	89 e5                	mov    %esp,%ebp
c01059f4:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c01059f7:	8d 45 14             	lea    0x14(%ebp),%eax
c01059fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
c01059fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105a00:	50                   	push   %eax
c0105a01:	ff 75 10             	pushl  0x10(%ebp)
c0105a04:	ff 75 0c             	pushl  0xc(%ebp)
c0105a07:	ff 75 08             	pushl  0x8(%ebp)
c0105a0a:	e8 0b 00 00 00       	call   c0105a1a <vsnprintf>
c0105a0f:	83 c4 10             	add    $0x10,%esp
c0105a12:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0105a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105a18:	c9                   	leave  
c0105a19:	c3                   	ret    

c0105a1a <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
c0105a1a:	55                   	push   %ebp
c0105a1b:	89 e5                	mov    %esp,%ebp
c0105a1d:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
c0105a20:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a23:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105a26:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105a29:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105a2c:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a2f:	01 d0                	add    %edx,%eax
c0105a31:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105a34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
c0105a3b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0105a3f:	74 0a                	je     c0105a4b <vsnprintf+0x31>
c0105a41:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105a47:	39 c2                	cmp    %eax,%edx
c0105a49:	76 07                	jbe    c0105a52 <vsnprintf+0x38>
        return -E_INVAL;
c0105a4b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
c0105a50:	eb 20                	jmp    c0105a72 <vsnprintf+0x58>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
c0105a52:	ff 75 14             	pushl  0x14(%ebp)
c0105a55:	ff 75 10             	pushl  0x10(%ebp)
c0105a58:	8d 45 ec             	lea    -0x14(%ebp),%eax
c0105a5b:	50                   	push   %eax
c0105a5c:	68 bb 59 10 c0       	push   $0xc01059bb
c0105a61:	e8 ad fb ff ff       	call   c0105613 <vprintfmt>
c0105a66:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
c0105a69:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105a6c:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
c0105a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105a72:	c9                   	leave  
c0105a73:	c3                   	ret    
