
shiyt16thu@ubuntu:~/Desktop/os/os2019-skkkkky/labcodes/lab6$ make grade
badsegment:              (2.0s)
  -check result:                             OK
  -check output:                             OK
divzero:                 (1.3s)
  -check result:                             OK
  -check output:                             OK
softint:                 (1.2s)
  -check result:                             OK
  -check output:                             OK
faultread:               (1.3s)
  -check result:                             OK
  -check output:                             OK
faultreadkernel:         (1.2s)
  -check result:                             OK
  -check output:                             OK
hello:                   (1.2s)
  -check result:                             OK
  -check output:                             OK
testbss:                 (1.3s)
  -check result:                             OK
  -check output:                             OK
pgdir:                   (1.3s)
  -check result:                             OK
  -check output:                             OK
yield:                   (1.2s)
  -check result:                             OK
  -check output:                             OK
badarg:                  (1.2s)
  -check result:                             OK
  -check output:                             OK
exit:                    (1.2s)
  -check result:                             OK
  -check output:                             OK
spin:                    (1.4s)
  -check result:                             OK
  -check output:                             OK
waitkill:                (1.7s)
  -check result:                             OK
  -check output:                             OK
forktest:                (1.3s)
  -check result:                             OK
  -check output:                             OK
forktree:                (1.3s)
  -check result:                             OK
  -check output:                             OK
matrix:                  (12.9s)
  -check result:                             OK
  -check output:                             OK
priority:                (11.3s)
  -check result:                             OK
  -check output:                             OK
Total Score: 170/170
shiyt16thu@ubuntu:~/Desktop/os/os2019-skkkkky/labcodes/lab6$ 


check_swap() succeeded!
++ setup timer interrupts
kernel_execve: pid = 2, name = "priority".
main: fork ok,now need to wait pids.
child pid 7, acc 1740000, time 1001
child pid 6, acc 1440000, time 1002
child pid 4, acc 724000, time 1003
child pid 5, acc 1076000, time 1004
child pid 3, acc 380000, time 1005
main: pid 3, acc 380000, time 1005
main: pid 4, acc 724000, time 1006
main: pid 5, acc 1076000, time 1006
main: pid 6, acc 1440000, time 1006
main: pid 7, acc 1740000, time 1007
main: wait pids over
stride sched correct result: 1 2 3 4 5
all user-mode processes have quit.
init check memory pass.
kernel panic at kern/process/proc.c:489:
    initproc exit.

