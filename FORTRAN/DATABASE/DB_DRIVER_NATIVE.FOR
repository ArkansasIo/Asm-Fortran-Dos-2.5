module db_driver_native
  use db_types
  use mysql_client
  implicit none
  private
  public :: db_native_open, db_native_close, db_native_ping
  public :: db_native_execute, db_native_begin, db_native_commit, db_native_rollback
contains
  subroutine db_native_open(cfg,result)
    type(db_config),intent(in) :: cfg
    type(db_result),intent(out) :: result
    call mysql_client_init(result)
    if (result%status /= DB_OK) return
    call mysql_client_connect(trim(cfg%host),trim(cfg%username),trim(cfg%password), &
         trim(cfg%database),cfg%port,10,1,result)
  end subroutine

  subroutine db_native_close(result)
    type(db_result),intent(out) :: result
    call mysql_client_close(result)
  end subroutine

  subroutine db_native_ping(result)
    type(db_result),intent(out) :: result
    if (mysql_client_connected()) then
       result%status=DB_OK
       result%message='Native MySQL connection is active.'
    else
       result%status=DB_NOT_CONNECTED
       result%message='Native MySQL connection is not active.'
    end if
  end subroutine

  subroutine db_native_execute(sql,result)
    character(len=*),intent(in) :: sql
    type(db_result),intent(out) :: result
    if (.not.mysql_client_connected()) then
       result%status=DB_NOT_CONNECTED
       result%message='Native database is not connected.'
       return
    end if
    call mysql_client_execute(sql,result)
  end subroutine

  subroutine db_native_begin(result)
    type(db_result),intent(out) :: result
    call mysql_client_begin(result)
  end subroutine

  subroutine db_native_commit(result)
    type(db_result),intent(out) :: result
    call mysql_client_commit(result)
  end subroutine

  subroutine db_native_rollback(result)
    type(db_result),intent(out) :: result
    call mysql_client_rollback(result)
  end subroutine
end module db_driver_native
