module business_api_types
  implicit none
  integer,parameter :: API_OK=0
  integer,parameter :: API_ERROR=1
  integer,parameter :: API_UNAUTHORIZED=2
  integer,parameter :: API_FORBIDDEN=3
  integer,parameter :: API_NOT_FOUND=4
  integer,parameter :: API_VALIDATION=5
  integer,parameter :: API_DATABASE=6
  integer,parameter :: API_CONFLICT=7
  integer,parameter :: API_MAX_TOKEN=256
  integer,parameter :: API_MAX_MESSAGE=512
  type :: api_response
     integer :: status=API_OK
     integer :: http_status=200
     integer(kind=8) :: object_id=0
     character(len=API_MAX_MESSAGE) :: message=''
     character(len=API_MAX_TOKEN) :: session_token=''
  end type api_response
  type :: api_context
     integer(kind=8) :: user_id=0
     character(len=64) :: role=''
     character(len=API_MAX_TOKEN) :: session_token=''
     logical :: authenticated=.false.
  end type api_context
end module business_api_types
