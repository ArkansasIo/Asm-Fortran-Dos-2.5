module db_pool
  use db_types
  implicit none
  private
  public :: db_pool_type, pool_initialize, pool_acquire, pool_release, pool_shutdown

  type :: db_pool_type
     type(db_connection), allocatable :: connections(:)
     logical, allocatable :: busy(:)
     integer :: size = 0
  end type db_pool_type
contains
  subroutine pool_initialize(pool, cfg, count, status)
    type(db_pool_type), intent(out) :: pool
    type(db_config), intent(in) :: cfg
    integer, intent(in) :: count
    integer, intent(out) :: status
    integer :: i
    if (count <= 0) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    allocate(pool%connections(count), pool%busy(count))
    pool%size=count
    pool%busy=.false.
    do i=1,count
       pool%connections(i)%config=cfg
       pool%connections(i)%connected=.false.
       pool%connections(i)%last_error=DB_OK
    end do
    status=DB_OK
  end subroutine pool_initialize

  subroutine pool_acquire(pool, connection, index, status)
    type(db_pool_type), intent(inout) :: pool
    type(db_connection), pointer, intent(out) :: connection
    integer, intent(out) :: index
    integer, intent(out) :: status
    integer :: i
    nullify(connection)
    index=0
    do i=1,pool%size
       if (.not.pool%busy(i)) then
          pool%busy(i)=.true.
          connection=>pool%connections(i)
          index=i
          status=DB_OK
          return
       end if
    end do
    status=DB_ERROR
  end subroutine pool_acquire

  subroutine pool_release(pool,index,status)
    type(db_pool_type), intent(inout) :: pool
    integer, intent(in) :: index
    integer, intent(out) :: status
    if (index < 1 .or. index > pool%size) then
       status=DB_INVALID_ARGUMENT
       return
    end if
    pool%busy(index)=.false.
    status=DB_OK
  end subroutine pool_release

  subroutine pool_shutdown(pool)
    type(db_pool_type), intent(inout) :: pool
    if (allocated(pool%connections)) deallocate(pool%connections)
    if (allocated(pool%busy)) deallocate(pool%busy)
    pool%size=0
  end subroutine pool_shutdown
end module db_pool
