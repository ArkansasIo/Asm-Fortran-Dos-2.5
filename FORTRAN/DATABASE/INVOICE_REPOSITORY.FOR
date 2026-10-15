module invoice_repository
  use db_types
  use db_driver
  implicit none
  private
  public :: invoice_create, invoice_mark_paid, invoice_find
contains
  subroutine invoice_create(customer_id,total,result)
    integer,intent(in)::customer_id
    real(8),intent(in)::total
    type(db_result),intent(out)::result
    character(len=1024)::sql
    write(sql,'(A,I0,A,F0.2,A)') 'INSERT INTO invoices (customer_id,total,status) VALUES (',customer_id,',',total,",'OPEN')"
    call db_execute(trim(sql),result)
  end subroutine invoice_create
  subroutine invoice_mark_paid(invoice_id,result)
    integer,intent(in)::invoice_id
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0,A)') "UPDATE invoices SET status='PAID',paid_at=CURRENT_TIMESTAMP WHERE id=",invoice_id,''
    call db_execute(trim(sql),result)
  end subroutine invoice_mark_paid
  subroutine invoice_find(invoice_id,result)
    integer,intent(in)::invoice_id
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0)') 'SELECT id,customer_id,total,status,created_at,paid_at FROM invoices WHERE id=',invoice_id
    call db_execute(trim(sql),result)
  end subroutine invoice_find
end module invoice_repository
