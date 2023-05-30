_start:
  li  a0, 'A'
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
  wfi
