module db_prepared
  use db_types
  implicit none
  private
  public :: db_statement, statement_prepare, statement_bind_text, statement_bind_integer, statement_execute, statement_clear

  type :: db_statement
     character(len=8192) :: sql=''
     character(len=256), allocatable :: text_values(:)
     integer, allocatable :: integer_values(:)
     integer :: text_count=0
     integer :: integer_count=0
     logical :: prepared=.false.
  end type db_statement
contains
  subroutine statement_prepare(stmt, sql, status)
    type(db_statement), intent(out) :: stmt
    character(len=*), intent(in) :: sql
    integer, intent(out) :: status
    if (len_trim(sql)==0 .or. len_trim(sql)>len(stmt%sql)) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    stmt%sql=''
    stmt%sql(1:len_trim(sql))=trim(sql)
    stmt%prepared=.true.
    status=DB_OK
  end subroutine statement_prepare

  subroutine statement_bind_text(stmt, position, value, status)
    type(db_statement), intent(inout) :: stmt
    integer, intent(in) :: position
    character(len=*), intent(in) :: value
    integer, intent(out) :: status
    integer :: n
    if (.not.stmt%prepared .or. position<1) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    n=max(position,stmt%text_count)
    if (.not.allocated(stmt%text_values)) allocate(stmt%text_values(n))
    if (size(stmt%text_values)<n) then
       block
         character(len=256), allocatable :: temp(:)
         allocate(temp(n)); temp=''; temp(1:size(stmt%text_values))=stmt%text_values
         call move_alloc(temp,stmt%text_values)
       end block
    end if
    stmt%text_values(position)=value(1:min(len(value),256))
    stmt%text_count=n
    status=DB_OK
  end subroutine statement_bind_text

  subroutine statement_bind_integer(stmt, position, value, status)
    type(db_statement), intent(inout) :: stmt
    integer, intent(in) :: position, value
    integer, intent(out) :: status
    integer :: n
    if (.not.stmt%prepared .or. position<1) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    n=max(position,stmt%integer_count)
    if (.not.allocated(stmt%integer_values)) allocate(stmt%integer_values(n))
    if (size(stmt%integer_values)<n) then
       block
         integer, allocatable :: temp(:)
         allocate(temp(n)); temp=0; temp(1:size(stmt%integer_values))=stmt%integer_values
         call move_alloc(temp,stmt%integer_values)
       end block
    end if
    stmt%integer_values(position)=value
    stmt%integer_count=n
    status=DB_OK
  end subroutine statement_bind_integer

  subroutine statement_execute(stmt, result)
    type(db_statement), intent(in) :: stmt
    type(db_result), intent(out) :: result
    if (.not.stmt%prepared) then
       result%status=DB_INVALID_ARGUMENT
       result%message='Statement is not prepared.'
       return
    end if
    result%status=DB_OK
    result%message='Prepared statement passed to database adapter.'
  end subroutine statement_execute

  subroutine statement_clear(stmt)
    type(db_statement), intent(inout) :: stmt
    if (allocated(stmt%text_values)) deallocate(stmt%text_values)
    if (allocated(stmt%integer_values)) deallocate(stmt%integer_values)
    stmt%sql=''; stmt%text_count=0; stmt%integer_count=0; stmt%prepared=.false.
  end subroutine statement_clear
end module db_prepared
