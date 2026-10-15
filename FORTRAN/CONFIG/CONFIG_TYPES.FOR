module config_types
  implicit none
  integer, parameter :: CFG_MAX_VALUE=512
  type :: config_entry
     character(len=128) :: key=''
     character(len=CFG_MAX_VALUE) :: value=''
  end type config_entry
  type :: system_config
     character(len=32) :: mode='360'
     character(len=128) :: system_name='ASM-FORTRAN-DOS'
     integer :: port=3000
     logical :: network_enabled=.true.
     logical :: database_enabled=.true.
     character(len=128) :: database_config='CONFIG/DATABASE.CFG'
  end type system_config
end module config_types
