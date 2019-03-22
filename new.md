++ setup timer interrupts
0: @ring 0
0:  cs = 8
0:  ds = 10
0:  es = 10
0:  ss = 10
+++ switch to  user  mode +++
1: @ring 3
1:  cs = 1b
1:  ds = 23
1:  es = 23
1:  ss = 23
+++ switch to kernel mode +++
2: @ring 0
2:  cs = 8
2:  ds = 10
2:  es = 10
2:  ss = 10
shiyt16thu@ubuntu:~/Desktop/os/os2019-skkkkky/labcodes/lab1$ make grade
Check Output:            (2.1s)
  -check ring 0:                             OK
  -check switch to ring 3:                   OK
  -check switch to ring 0:                   OK
  -check ticks:                              OK
Total Score: 40/40

