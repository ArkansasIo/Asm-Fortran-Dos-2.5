module mysql_native
  use iso_c_binding
  use db_types
  implicit none
  private
  public :: mysql_native_initialize, mysql_native_shutdown
  public :: mysql_native_execute, mysql_native_begin
  public :: mysql_native_commit, mysql_native_rollback
  public :: mysql_native_is_connected

  interface
     function mysql_abi_init() bind(C,name='mysql_abi_init') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_init
     function mysql_abi_shutdown() bind(C,name='mysql_abi_shutdown') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_shutdown
     function mysql_abi_status() bind(C,name='mysql_abi_status') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_status
     function mysql_abi_execute(sql) bind(C,name='mysql_abi_execute') result(rc)
       import c_int,c_char
       character(kind=c_char),dimension(*) :: sql
       integer(c_int) :: rc
     end function mysql_abi_execute
     function mysql_abi_begin() bind(C,name='mysql_abi_begin') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_begin
     function mysql_abi_commit() bind(C,name='mysql_abi_commit') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_commit
     function mysql_abi_rollback() bind(C,name='mysql_abi_rollback') result(rc)
       import c_int
       integer(c_int) :: rc
     end function mysql_abi_rollback
  end interface

contains

  subroutine mysql_native_initialize(result)
    type(db_result),intent(out) :: result
    if (mysql_abi_init() == 0) then
       result%status=DB_OK
       result%message='Native MySQL ABI initialized.'
    else
       result%status=DB_ERROR
       result%message='Native MySQL ABI initialization failed.'
    end if
  end subroutine mysql_native_initialize

  subroutine mysql_native_shutdown(result)
    type(db_result),intent(out) :: result
    if (mysql_abi_shutdown() == 0) then
       result%status=DB_OK
       result%message='Native MySQL ABI shutdown complete.'
    else
       result%status=DB_ERROR
       result%message='Native MySQL ABI shutdown failed.'
    end if
  end subroutine mysql_native_shutdown

  logical function mysql_native_is_connected()
    mysql_native_is_connected = mysql_abi_status() /= 0
  end function mysql_native_is_connected

  subroutine mysql_native_execute(sql,result)
    character(len=*),intent(in) :: sql
    type(db_result),intent(out) :: result
    character(kind=c_char),allocatable :: c_sql(:)
    integer :: i,n
    n=len_trim(sql)
    if (n == 0) then
       result%status=DB_INVALID_ARGUMENT
       result%message='Empty SQL statement.'
       return
    end if
    allocate(c_sql(0:n))
    do i=1,n
       c_sql(i)=sql(i:i)
    end do
    c_sql(n+1)=c_null_char
    if (mysql_abi_execute(c_sql) == 0) then
       result%status=DB_OK
       result%message='SQL accepted by native database ABI.'
    else
       result%status=DB_ERROR
       result%message='Native database execution failed.'
    end if
    deallocate(c_sql)
  end subroutine mysql_native_execute

  subroutine mysql_native_begin(result)
    type(db_result),intent(out) :: result
    if (mysql_abi_begin() == 0) then
       result%status=DB_OK
       result%message='Transaction started.'
    else
       result%status=DB_ERROR
       result%message='Could not start transaction.'
    end if
  end subroutine mysql_native_begin

  subroutine mysql_native_commit(result)
    type(db_result),intent(out) :: result
    if (mysql_abi_commit() == 0) then
       result%status=DB_OK
       result%message='Transaction committed.'
    else
       result%status=DB_ERROR
       result%message='Could not commit transaction.'
    end if
  end subroutine mysql_native_commit

  subroutine mysql_native_rollback(result)
    type(db_result),intent(out) :: result
    if (mysql_abi_rollback() == 0) then
       result%status=DB_OK
       result%message='Transaction rolled back.'
    else
       result%status=DB_ERROR
       result%message='Could not roll back transaction.'
    end if
  end subroutine mysql_native_rollback

end module mysql_native
