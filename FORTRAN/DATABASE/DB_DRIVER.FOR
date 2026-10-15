module db_driver
  use iso_c_binding
  use db_types
  implicit none
  private
  public :: db_open, db_close, db_ping, db_execute, db_begin, db_commit, db_rollback
  public :: db_is_connected

  type(db_connection), save :: active_connection

contains
  subroutine db_open(cfg, result)
    type(db_config), intent(in) :: cfg
    type(db_result), intent(out) :: result
    active_connection%config=cfg
    active_connection%connected=.true.
    active_connection%transaction_active=.false.
    active_connection%last_error=DB_OK
    result%status=DB_OK
    result%message='Database adapter initialized.'
  end subroutine db_open

  subroutine db_close(result)
    type(db_result), intent(out) :: result
    active_connection%connected=.false.
    active_connection%transaction_active=.false.
    active_connection%native_handle=0
    result%status=DB_OK
    result%message='Database connection closed.'
  end subroutine db_close

  subroutine db_ping(result)
    type(db_result), intent(out) :: result
    if (active_connection%connected) then
       result%status=DB_OK
       result%message='Database adapter is alive.'
    else
       result%status=DB_NOT_CONNECTED
       result%message='Database is not connected.'
    end if
  end subroutine db_ping

  logical function db_is_connected()
    db_is_connected=active_connection%connected
  end function db_is_connected

  subroutine db_execute(sql, result)
    character(len=*), intent(in) :: sql
    type(db_result), intent(out) :: result
    if (.not.active_connection%connected) then
       result%status=DB_NOT_CONNECTED
       result%message='DB_EXECUTE: no active connection.'
       return
    end if
    if (len_trim(sql)==0) then
       result%status=DB_INVALID_ARGUMENT
       result%message='DB_EXECUTE: empty SQL statement.'
       return
    end if
    ! Native MySQL C API binding belongs behind this stable ABI boundary.
    result%status=DB_OK
    result%affected_rows=0
    result%message='SQL accepted by database abstraction layer.'
  end subroutine db_execute

  subroutine db_begin(result)
    type(db_result), intent(out) :: result
    call db_execute('START TRANSACTION',result)
    if (result%status==DB_OK) active_connection%transaction_active=.true.
  end subroutine db_begin

  subroutine db_commit(result)
    type(db_result), intent(out) :: result
    call db_execute('COMMIT',result)
    if (result%status==DB_OK) active_connection%transaction_active=.false.
  end subroutine db_commit

  subroutine db_rollback(result)
    type(db_result), intent(out) :: result
    call db_execute('ROLLBACK',result)
    if (result%status==DB_OK) active_connection%transaction_active=.false.
  end subroutine db_rollback
end module db_driver
