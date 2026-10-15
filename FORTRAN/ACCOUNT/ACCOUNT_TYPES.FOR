module account_types
  implicit none
  integer, parameter :: ACCOUNT_OK=0, ACCOUNT_ERROR=1
  integer, parameter :: ACCOUNT_LOCKED=2, ACCOUNT_DISABLED=3
  integer, parameter :: ACCOUNT_NOT_FOUND=4, ACCOUNT_EXISTS=5
  integer, parameter :: ACCOUNT_MAX_NAME=64, ACCOUNT_MAX_EMAIL=256
  integer, parameter :: ACCOUNT_MAX_HASH=256, ACCOUNT_MAX_ROLE=64

  type :: account
     integer(kind=8) :: id=0
     character(len=ACCOUNT_MAX_NAME) :: username=''
     character(len=ACCOUNT_MAX_EMAIL) :: email=''
     character(len=ACCOUNT_MAX_HASH) :: password_hash=''
     character(len=ACCOUNT_MAX_ROLE) :: role='USER'
     logical :: enabled=.true.
     logical :: locked=.false.
     integer :: failed_attempts=0
     integer :: session_count=0
  end type account

  type :: account_session
     integer(kind=8) :: user_id=0
     character(len=128) :: token=''
     integer(kind=8) :: created_epoch=0
     integer(kind=8) :: expires_epoch=0
     logical :: active=.false.
  end type account_session
end module account_types
