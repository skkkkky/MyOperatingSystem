
shiyt16thu@ubuntu:~/Desktop/os/os2019-skkkkky/labcodes/lab6$ make grade
badsegment:              (1.4s)
  -check result:                             OK
  -check output:                             OK
divzero:                 (1.3s)
  -check result:                             OK
  -check output:                             OK
softint:                 (1.3s)
  -check result:                             OK
  -check output:                             OK
faultread:               (1.2s)
  -check result:                             OK
  -check output:                             OK
faultreadkernel:         (1.3s)
  -check result:                             OK
  -check output:                             OK
hello:                   (1.3s)
  -check result:                             OK
  -check output:                             OK
testbss:                 (1.3s)
  -check result:                             OK
  -check output:                             OK
pgdir:                   (1.3s)
  -check result:                             OK
  -check output:                             OK
yield:                   (1.3s)
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
waitkill:                (1.9s)
  -check result:                             OK
  -check output:                             OK
forktest:                (1.3s)
  -check result:                             OK
  -check output:                             OK
forktree:                (1.3s)
  -check result:                             OK
  -check output:                             OK
matrix:                  (11.9s)
  -check result:                             OK
  -check output:                             OK
priority:                (11.3s)
  -check result:                             WRONG
   -e !! error: missing 'sched class: stride_scheduler'
   !! error: missing 'stride sched correct result: 1 2 3 4 5'

  -check output:                             OK
Total Score: 163/170
Makefile:314: recipe for target 'grade' failed
make: *** [grade] Error 1

