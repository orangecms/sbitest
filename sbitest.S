_start:
  auipc sp, 0x1
  addi  sp, sp, 1024

  li  a0, 'A'
# li  t0, 0x04140000
# sw  a0, 0(t0)
  li  a7, 0x01
  ecall
  li  a0, ' '
  li  a7, 0x01
  ecall
  li  a0, 'T'
  li  a7, 0x01
  ecall
  li  a0, 'E'
  li  a7, 0x01
  ecall
  li  a0, 'S'
  li  a7, 0x01
  ecall
  li  a0, 'T'
  li  a7, 0x01
  ecall
  li  a0, '\n'
  li  a7, 0x01
  ecall
  li  a0, '\r'
  li  a7, 0x01
  ecall

  # disable interrupts
  csrwi sip, 0
  csrwi sie, 0

  # set trap handler
  la  t0, trap_handler
  csrw stvec, t0

  # enable S-mode interrupts
  csrsi sstatus, 1 << 1

.align 4
_loop:
  # set timer: current time + large number, a second or so from now on
  rdtime t0
  li t1, 8000000
  add a0, t0, t1
  li  a6, 0
  li  a7, 0x54494D45
  ecall
  
  # enable S-mode timer
  li t1, 1 << 5
  csrs sie, t1
  wfi

  li  a0, 'L'
  li  a7, 0x01
  ecall
  li  a0, 'O'
  li  a7, 0x01
  ecall
  li  a0, 'O'
  li  a7, 0x01
  ecall
  li  a0, 'P'
  li  a7, 0x01
  ecall
  li  a0, '\n'
  li  a7, 0x01
  ecall
  li  a0, '\r'
  li  a7, 0x01
  ecall

  j   _loop

.align 4
trap_handler:
  # save registers
  addi    sp,sp,-144
  sd      ra,136(sp)
  sd      t0,128(sp)
  sd      t1,120(sp)
  sd      t2,112(sp)
  sd      s0,104(sp)
  sd      a0,96(sp)
  sd      a1,88(sp)
  sd      a2,80(sp)
  sd      a3,72(sp)
  sd      a4,64(sp)
  sd      a5,56(sp)
  sd      a6,48(sp)
  sd      a7,40(sp)
  sd      t3,32(sp)
  sd      t4,24(sp)
  sd      t5,16(sp)
  sd      t6,8(sp)
  addi    s0,sp,144

  li t0, 1 << 5
  csrc sip, t0
  # disable timer from now on, we reenable it in the loop
  csrc sie, t0

  li  a0, 'I'
  li  a7, 0x01
  ecall
  li  a0, 'N'
  li  a7, 0x01
  ecall
  li  a0, 'T'
  li  a7, 0x01
  ecall
  li  a0, 'E'
  li  a7, 0x01
  ecall
  li  a0, 'R'
  li  a7, 0x01
  ecall
  li  a0, 'R'
  li  a7, 0x01
  ecall
  li  a0, 'U'
  li  a7, 0x01
  ecall
  li  a0, 'P'
  li  a7, 0x01
  ecall
  li  a0, 'T'
  li  a7, 0x01
  ecall
  li  a0, '\n'
  li  a7, 0x01
  ecall
  li  a0, '\r'
  li  a7, 0x01
  ecall

  # restore registers
  nop
  ld      ra,136(sp)
  ld      t0,128(sp)
  ld      t1,120(sp)
  ld      t2,112(sp)
  ld      s0,104(sp)
  ld      a0,96(sp)
  ld      a1,88(sp)
  ld      a2,80(sp)
  ld      a3,72(sp)
  ld      a4,64(sp)
  ld      a5,56(sp)
  ld      a6,48(sp)
  ld      a7,40(sp)
  ld      t3,32(sp)
  ld      t4,24(sp)
  ld      t5,16(sp)
  ld      t6,8(sp)
  addi    sp,sp,144

  sret
