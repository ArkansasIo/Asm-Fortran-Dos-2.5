module report_engine
  implicit none
  type :: report_request
     character(len=64)::name=''
     character(len=32)::format='TEXT'
     integer::limit=100
  end type report_request
contains
  subroutine report_prepare(request,status)
    type(report_request),intent(inout)::request
    integer,intent(out)::status
    if (len_trim(request%name)==0) then; status=1; return; end if
    if (request%limit<1) request%limit=100
    status=0
  end subroutine report_prepare
end module report_engine
