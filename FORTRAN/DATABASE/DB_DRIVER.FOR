module db_driver
  use db_types
  implicit none
  private
  public :: db_open, db_close, db_ping, db_execute, db_begin, db_commit, db_rollback

  logical, save :: connected=.false.
  type(db_config), save :: active_config

contains
  subroutine db_open(cfg, result)
    type(db_config), intent(in) :: cfg
    type(db_result), intent(out) :: result
    active_config=cfg
    connected=.true.
    result%status=DB_OK
    result%message='Database connection initialized.'
  end subroutine db_open

  subroutine db_close(result)
    type(db_result), intent(out) :: result
    connected=.false.
    result%status=DB_OK
    result%message='Database connection closed.'
  end subroutine db_close

  subroutine db_ping(result)
    type(db_result), intent(out) :: result
    result%status=merge(DB_OK,DB_ERROR,connected)
    if (connected) then
       result%message='Database connection is alive.'
    else
       result%message='Database is not connected.'
    end if
  end subroutine db_ping

  subroutine db_execute(sql, result)
    character(len=*), intent(in) :: sql
    type(db_result), intent(out) :: result
    if (.not.connected) then
       result%status=DB_ERROR
       result%message='DB_EXECUTE: no active connection.'
       return
    end if
    if (len_trim(sql)==0) then
       result%status=DB_ERROR
       result%message='DB_EXECUTE: empty SQL statement.'
       return
    end if
    ! Production adapter boundary: bind this routine to MySQL C API/ODBC.
    result%status=DB_OK
    result%affected_rows=0
    result%message='SQL accepted by database abstraction layer.'
  end subroutine db_execute

  subroutine db_begin(result)
    call db_execute('START TRANSACTION',result)
  end subroutine db_begin

  subroutine db_commit(result)
    call db_execute('COMMIT',result)
  end subroutine db_commit

  subroutine db_rollback(result)
    call db_execute('ROLLBACK',result)
  end subroutine db_rollback
end module db_driver
