module customer_repository
  use db_types
  use db_driver
  implicit none
  private
  public :: customer_create, customer_update, customer_delete, customer_search
contains
  subroutine customer_create(name,email,phone,result)
    character(len=*),intent(in)::name,email,phone
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "INSERT INTO customers (name,email,phone) VALUES ('"//trim(name)//"','"//trim(email)//"','"//trim(phone)//"')"
    call db_execute(trim(sql),result)
  end subroutine customer_create
  subroutine customer_update(id,name,email,phone,result)
    integer,intent(in)::id
    character(len=*),intent(in)::name,email,phone
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A,I0,A)') "UPDATE customers SET name='"//trim(name)//"',email='"//trim(email)//"',phone='"//trim(phone)//"' WHERE id=",id,""
    call db_execute(trim(sql),result)
  end subroutine customer_update
  subroutine customer_delete(id,result)
    integer,intent(in)::id
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0)') 'DELETE FROM customers WHERE id=',id
    call db_execute(trim(sql),result)
  end subroutine customer_delete
  subroutine customer_search(term,result)
    character(len=*),intent(in)::term
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "SELECT id,name,email,phone FROM customers WHERE name LIKE '%"//trim(term)//"%' OR email LIKE '%"//trim(term)//"%' ORDER BY name"
    call db_execute(trim(sql),result)
  end subroutine customer_search
end module customer_repository
