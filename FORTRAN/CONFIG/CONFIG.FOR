module config
  use config_types
  implicit none
  private
  public :: config_load, config_get, config_set
contains
  subroutine config_load(path, cfg, status)
    character(len=*), intent(in) :: path
    type(system_config), intent(out) :: cfg
    integer, intent(out) :: status
    integer :: unit, ios
    character(len=1024) :: line
    character(len=128) :: key
    character(len=512) :: value
    integer :: p
    cfg=system_config()
    status=0
    open(newunit=unit,file=trim(path),status='old',action='read',iostat=ios)
    if (ios/=0) then
       status=1
       return
    end if
    do
       read(unit,'(A)',iostat=ios) line
       if (ios/=0) exit
       line=adjustl(line)
       if (len_trim(line)==0 .or. line(1:1)=='#' .or. line(1:1)==';') cycle
       p=index(line,'=')
       if (p<=1) cycle
       key=adjustl(trim(line(:p-1)))
       value=adjustl(trim(line(p+1:)))
       call config_set(cfg,trim(key),trim(value))
    end do
    close(unit)
  end subroutine config_load

  subroutine config_set(cfg,key,value)
    type(system_config), intent(inout) :: cfg
    character(len=*), intent(in) :: key,value
    select case(trim(key))
    case('MODE'); cfg%mode=trim(value)
    case('SYSTEM_NAME'); cfg%system_name=trim(value)
    case('PORT'); read(value,*,err=100) cfg%port
    case('NETWORK_ENABLED'); read(value,*,err=100) cfg%network_enabled
    case('DATABASE_ENABLED'); read(value,*,err=100) cfg%database_enabled
    case('DATABASE_CONFIG'); cfg%database_config=trim(value)
    end select
100 continue
  end subroutine config_set

  function config_get(cfg,key) result(value)
    type(system_config), intent(in) :: cfg
    character(len=*), intent(in) :: key
    character(len=512) :: value
    value=''
    select case(trim(key))
    case('MODE'); value=trim(cfg%mode)
    case('SYSTEM_NAME'); value=trim(cfg%system_name)
    case('PORT'); write(value,'(I0)') cfg%port
    case('NETWORK_ENABLED'); write(value,'(L1)') cfg%network_enabled
    case('DATABASE_ENABLED'); write(value,'(L1)') cfg%database_enabled
    case('DATABASE_CONFIG'); value=trim(cfg%database_config)
    end select
  end function config_get
end module config
