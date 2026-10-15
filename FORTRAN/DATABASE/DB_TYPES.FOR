module db_types
  implicit none
  integer, parameter :: DB_OK=0, DB_ERROR=1, DB_NOT_CONNECTED=2
  integer, parameter :: DB_INVALID_ARGUMENT=3, DB_TRANSACTION_ERROR=4
  integer, parameter :: DB_MAX_HOST=128, DB_MAX_DB=128, DB_MAX_USER=128
  integer, parameter :: DB_MAX_PASSWORD=256, DB_MAX_SQL=8192

  type :: db_config
     character(len=DB_MAX_HOST) :: host='127.0.0.1'
     integer :: port=3306
     character(len=DB_MAX_DB) :: database='business_os'
     character(len=DB_MAX_USER) :: username='business'
     character(len=DB_MAX_PASSWORD) :: password=''
     integer :: connect_timeout=10
     logical :: tls_enabled=.true.
  end type db_config

  type :: db_connection
     type(db_config) :: config
     logical :: connected=.false.
     logical :: transaction_active=.false.
     integer(kind=8) :: native_handle=0
     integer :: last_error=DB_OK
  end type db_connection

  type :: db_result
     integer :: status=DB_OK
     integer :: affected_rows=0
     integer :: insert_id=0
     integer :: row_count=0
     character(len=512) :: message=''
  end type db_result
end module db_types
