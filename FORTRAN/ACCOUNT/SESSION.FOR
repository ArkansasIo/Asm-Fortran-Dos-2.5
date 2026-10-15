module account_session_service
  use account_types
  implicit none
  integer,parameter :: SESSION_OK=0, SESSION_INVALID=1, SESSION_EXPIRED=2
contains
  subroutine session_create(user_id,token,now_epoch,ttl,status)
    integer(kind=8),intent(in)::user_id,now_epoch,ttl
    character(len=*),intent(out)::token
    integer,intent(out)::status
    write(token,'(A,I0,A,I0)') 'LOCAL-',user_id,'-',now_epoch
    status=SESSION_OK
  end subroutine session_create
  logical function session_valid(session,now_epoch)
    type(account_session),intent(in)::session
    integer(kind=8),intent(in)::now_epoch
    session_valid=session%active .and. now_epoch < session%expires_epoch
  end function session_valid
  subroutine session_revoke(session,status)
    type(account_session),intent(inout)::session
    integer,intent(out)::status
    session%active=.false.; status=SESSION_OK
  end subroutine session_revoke
end module account_session_service
