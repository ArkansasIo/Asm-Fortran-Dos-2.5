module account_auth
  use account_permissions
  implicit none
  integer,parameter :: AUTH_OK=0, AUTH_FAILED=1, AUTH_LOCKED=2
contains
  logical function authorize(role,required_mask)
    character(len=*),intent(in)::role
    integer,intent(in)::required_mask
    authorize=permission_allowed(role,required_mask)
  end function authorize
  logical function lock_required(failed_attempts,max_attempts)
    integer,intent(in)::failed_attempts,max_attempts
    lock_required=failed_attempts >= max_attempts
  end function lock_required
end module account_auth
