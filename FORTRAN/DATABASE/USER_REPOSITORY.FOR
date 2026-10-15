module user_repository
  use db_types
  use db_driver
  implicit none
  private
  public :: user_create, user_find_by_email
contains
  subroutine user_create(username,email,password_hash,result)
    character(len=*),intent(in)::username,email,password_hash
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "INSERT INTO users (username,email,password_hash) VALUES ('"//trim(username)//"','"//trim(email)//"','"//trim(password_hash)//"')"
    call db_execute(trim(sql),result)
  end subroutine user_create
  subroutine user_find_by_email(email,result)
    character(len=*),intent(in)::email
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "SELECT id,username,email,password_hash FROM users WHERE email='"//trim(email)//"' LIMIT 1"
    call db_execute(trim(sql),result)
  end subroutine user_find_by_email
end module user_repository
