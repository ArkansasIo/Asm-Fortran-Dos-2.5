program business_os
  use business
  implicit none
  call system_initialize()
  call command_loop()
  call system_shutdown()
end program business_os
