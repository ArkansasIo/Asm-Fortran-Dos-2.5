module db_resultset
  use db_types
  implicit none
  private
  public :: db_row, db_resultset_type, resultset_open, resultset_next, resultset_close

  type :: db_row
     character(len=256), allocatable :: values(:)
  end type db_row

  type :: db_resultset_type
     type(db_row), allocatable :: rows(:)
     integer :: cursor=0
     integer :: row_count=0
     logical :: open=.false.
  end type db_resultset_type
contains
  subroutine resultset_open(rs, count, columns, status)
    type(db_resultset_type), intent(out) :: rs
    integer, intent(in) :: count, columns
    integer, intent(out) :: status
    integer :: i
    if (count<0 .or. columns<1) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    allocate(rs%rows(count))
    do i=1,count
       allocate(rs%rows(i)%values(columns))
       rs%rows(i)%values=''
    end do
    rs%row_count=count; rs%cursor=0; rs%open=.true.; status=DB_OK
  end subroutine resultset_open

  logical function resultset_next(rs, row)
    type(db_resultset_type), intent(inout) :: rs
    type(db_row), pointer, intent(out) :: row
    nullify(row)
    resultset_next=.false.
    if (.not.rs%open) return
    if (rs%cursor>=rs%row_count) return
    rs%cursor=rs%cursor+1
    row=>rs%rows(rs%cursor)
    resultset_next=.true.
  end function resultset_next

  subroutine resultset_close(rs)
    type(db_resultset_type), intent(inout) :: rs
    integer :: i
    if (allocated(rs%rows)) then
       do i=1,size(rs%rows)
          if (allocated(rs%rows(i)%values)) deallocate(rs%rows(i)%values)
       end do
       deallocate(rs%rows)
    end if
    rs%cursor=0; rs%row_count=0; rs%open=.false.
  end subroutine resultset_close
end module db_resultset
