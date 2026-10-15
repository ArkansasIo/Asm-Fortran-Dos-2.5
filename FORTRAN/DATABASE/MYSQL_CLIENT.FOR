module mysql_client
  use iso_c_binding
  use db_types
  implicit none
  private
  public :: mysql_client_init, mysql_client_connect, mysql_client_close
  public :: mysql_client_execute, mysql_client_begin, mysql_client_commit
  public :: mysql_client_rollback, mysql_client_connected, mysql_client_error

  interface
     function mysql_native_c_init() bind(C) result(rc)
       import c_int
       integer(c_int) :: rc
     end function
     function mysql_native_c_connect(host,user,password,database,port,timeout,tls) bind(C) result(rc)
       import c_char,c_int
       character(kind=c_char),dimension(*) :: host,user,password,database
       integer(c_int),value :: port,timeout,tls
       integer(c_int) :: rc
     end function
     function mysql_native_c_status() bind(C) result(rc)
       import c_int
       integer(c_int) :: rc
     end function
     function mysql_native_c_execute(sql,length,affected,insert_id) bind(C) result(rc)
       import c_char,c_int,c_long_long,c_long_long
       character(kind=c_char),dimension(*) :: sql
       integer(c_long_long),value :: length
       integer(c_long_long) :: affected
       integer(c_long_long) :: insert_id
       integer(c_int) :: rc
     end function
     function mysql_native_c_begin() bind(C) result(rc)
       import c_int
       integer(c_int) :: rc
     end function
     function mysql_native_c_commit() bind(C) result(rc)
       import c_int
       integer(c_int) :: rc
     end function
     function mysql_native_c_rollback() bind(C) result(rc)
       import c_int
       integer(c_int) :: rc
     end function
     function mysql_native_c_error() bind(C) result(p)
       import c_ptr
       type(c_ptr) :: p
     end function
     subroutine mysql_native_c_close() bind(C)
     end subroutine
  end interface

contains
  subroutine make_c_string(value,out)
    character(len=*),intent(in) :: value
    character(kind=c_char),allocatable,intent(out) :: out(:)
    integer :: i,n
    n=len_trim(value)
    allocate(out(0:n))
    do i=1,n
       out(i)=value(i:i)
    end do
    out(n+1)=c_null_char
  end subroutine

  subroutine mysql_client_init(result)
    type(db_result),intent(out) :: result
    if (mysql_native_c_init() == 0) then
       result%status=DB_OK
       result%message='MySQL client initialized.'
    else
       result%status=DB_ERROR
       result%message='MySQL client initialization failed.'
    end if
  end subroutine

  subroutine mysql_client_connect(host,user,password,database,port,timeout,tls,result)
    character(len=*),intent(in) :: host,user,password,database
    integer,intent(in) :: port,timeout,tls
    type(db_result),intent(out) :: result
    character(kind=c_char),allocatable :: h(:),u(:),p(:),d(:)
    call make_c_string(host,h); call make_c_string(user,u)
    call make_c_string(password,p); call make_c_string(database,d)
    if (mysql_native_c_connect(h,u,p,d,int(port,c_int),int(timeout,c_int),int(tls,c_int)) == 0) then
       result%status=DB_OK; result%message='Connected to MySQL.'
    else
       result%status=DB_ERROR; result%message='MySQL connection failed.'
    end if
    deallocate(h,u,p,d)
  end subroutine

  subroutine mysql_client_close(result)
    type(db_result),intent(out) :: result
    call mysql_native_c_close()
    result%status=DB_OK
    result%message='MySQL connection closed.'
  end subroutine

  logical function mysql_client_connected()
    mysql_client_connected=mysql_native_c_status() /= 0
  end function

  subroutine mysql_client_execute(sql,result)
    character(len=*),intent(in) :: sql
    type(db_result),intent(out) :: result
    character(kind=c_char),allocatable :: csql(:)
    integer(c_long_long) :: affected,insert_id
    integer(c_int) :: rc
    call make_c_string(sql,csql)
    affected=0_c_long_long; insert_id=0_c_long_long
    rc=mysql_native_c_execute(csql,int(len_trim(sql),c_long_long),affected,insert_id)
    result%status=merge(DB_OK,DB_ERROR,rc==0)
    result%affected_rows=affected
    result%insert_id=insert_id
    if (rc==0) then
       result%message='MySQL statement executed.'
    else
       result%message='MySQL statement failed.'
    end if
    deallocate(csql)
  end subroutine

  subroutine mysql_client_begin(result)
    type(db_result),intent(out) :: result
    if (mysql_native_c_begin()==0) then
       result%status=DB_OK; result%message='Transaction started.'
    else
       result%status=DB_ERROR; result%message='Transaction start failed.'
    end if
  end subroutine

  subroutine mysql_client_commit(result)
    type(db_result),intent(out) :: result
    if (mysql_native_c_commit()==0) then
       result%status=DB_OK; result%message='Transaction committed.'
    else
       result%status=DB_ERROR; result%message='Transaction commit failed.'
    end if
  end subroutine

  subroutine mysql_client_rollback(result)
    type(db_result),intent(out) :: result
    if (mysql_native_c_rollback()==0) then
       result%status=DB_OK; result%message='Transaction rolled back.'
    else
       result%status=DB_ERROR; result%message='Transaction rollback failed.'
    end if
  end subroutine

  subroutine mysql_client_error(result)
    type(db_result),intent(out) :: result
    type(c_ptr) :: p
    p=mysql_native_c_error()
    if (c_associated(p)) then
       result%status=DB_ERROR
       result%message='MySQL client reported an error.'
    else
       result%status=DB_ERROR
       result%message='MySQL client error unavailable.'
    end if
  end subroutine
end module mysql_client
