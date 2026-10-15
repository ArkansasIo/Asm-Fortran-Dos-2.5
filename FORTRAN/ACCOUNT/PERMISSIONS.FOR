module account_permissions
  implicit none
  integer,parameter :: PERM_NONE=0
  integer,parameter :: PERM_READ=1
  integer,parameter :: PERM_WRITE=2
  integer,parameter :: PERM_DELETE=4
  integer,parameter :: PERM_ADMIN=8
contains
  integer function role_mask(role)
    character(len=*),intent(in)::role
    select case(trim(role))
    case('SUPERADMIN'); role_mask=15
    case('ADMIN'); role_mask=15
    case('MANAGER'); role_mask=7
    case('ACCOUNTANT'); role_mask=3
    case default; role_mask=1
    end select
  end function role_mask
  logical function permission_allowed(role,required_mask)
    character(len=*),intent(in)::role
    integer,intent(in)::required_mask
    permission_allowed=iand(role_mask(role),required_mask)==required_mask
  end function permission_allowed
end module account_permissions
