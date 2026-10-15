module analytics_service
  implicit none
contains
  subroutine sum_values(values,n,total)
    integer,intent(in)::n
    real(8),intent(in)::values(n)
    real(8),intent(out)::total
    total=sum(values)
  end subroutine sum_values
  real(8) function average_values(values,n)
    integer,intent(in)::n
    real(8),intent(in)::values(n)
    if(n<=0) then; average_values=0.0d0; else; average_values=sum(values)/real(n,8); end if
  end function average_values
end module analytics_service
