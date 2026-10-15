module account_service
  use account_types
  use db_types
  use db_driver
  implicit none
  private
  public :: account_register, account_login, account_logout, account_disable
contains
  subroutine account_register(username,email,password_hash,result)
    character(len=*),intent(in)::username,email,password_hash
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "INSERT INTO users (username,email,password_hash,enabled,locked) VALUES ('"//trim(username)//"','"//trim(email)//"','"//trim(password_hash)//"',1,0)"
    call db_execute(trim(sql),result)
  end subroutine account_register

  subroutine account_login(username,password_hash,result)
    character(len=*),intent(in)::username,password_hash
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "SELECT id,username,email,role,enabled,locked FROM users WHERE username='"//trim(username)//"' AND password_hash='"//trim(password_hash)//"' AND enabled=1 AND locked=0 LIMIT 1"
    call db_execute(trim(sql),result)
  end subroutine account_login

  subroutine account_logout(user_id,result)
    integer(kind=8),intent(in)::user_id
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0,A)') 'UPDATE users SET last_logout=CURRENT_TIMESTAMP WHERE id=',user_id,''
    call db_execute(trim(sql),result)
  end subroutine account_logout

  subroutine account_disable(user_id,result)
    integer(kind=8),intent(in)::user_id
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0)') 'UPDATE users SET enabled=0 WHERE id=',user_id
    call db_execute(trim(sql),result)
  end subroutine account_disable
end module account_service
