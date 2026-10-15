module sales_service
  implicit none
  type :: sales_order
     integer(kind=8)::id=0
     integer(kind=8)::customer_id=0
     real(8)::subtotal=0.0d0
     real(8)::tax=0.0d0
     real(8)::total=0.0d0
     character(len=32)::status='OPEN'
  end type sales_order
contains
  subroutine sales_calculate(subtotal,tax_rate,tax,total)
    real(8),intent(in)::subtotal,tax_rate
    real(8),intent(out)::tax,total
    tax=subtotal*tax_rate; total=subtotal+tax
  end subroutine sales_calculate
  subroutine sales_cancel(order)
    type(sales_order),intent(inout)::order
    order%status='CANCELLED'
  end subroutine sales_cancel
end module sales_service
