module business_api_dispatch
  use business_api_types
  implicit none
  private
  public :: api_dispatch
contains
  subroutine api_dispatch(ctx,command,response)
    type(api_context),intent(in)::ctx
    character(len=*),intent(in)::command
    type(api_response),intent(out)::response
    response=api_response()
    if (.not.ctx%authenticated) then
       response%status=API_UNAUTHORIZED
       response%http_status=401
       response%message='Authentication required.'
       return
    end if
    select case(trim(command))
    case('CUSTOMER'); response%message='Customer service selected.'
    case('INVENTORY'); response%message='Inventory service selected.'
    case('SALES'); response%message='Sales service selected.'
    case('ACCOUNTING'); response%message='Accounting service selected.'
    case('INVOICE'); response%message='Invoice service selected.'
    case('TICKET'); response%message='Ticket service selected.'
    case('EMAIL'); response%message='Email service selected.'
    case('REPORT'); response%message='Reporting service selected.'
    case('CALCULATOR'); response%message='Business calculator selected.'
    case default
       response%status=API_NOT_FOUND
       response%http_status=404
       response%message='Business API command not found.'
    end select
  end subroutine api_dispatch
end module business_api_dispatch
