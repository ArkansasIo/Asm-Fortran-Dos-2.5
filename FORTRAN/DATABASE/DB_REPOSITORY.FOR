module db_repository
  use db_types
  use db_driver
  implicit none
  private
  public :: db_insert, db_update, db_delete, db_select

contains
  subroutine db_insert(table_name, columns, values, result)
    character(len=*), intent(in) :: table_name, columns, values
    type(db_result), intent(out) :: result
    character(len=DB_MAX_SQL) :: sql
    write(sql,'(A)') 'INSERT INTO '//trim(table_name)//' ('//trim(columns)//') VALUES ('//trim(values)//')'
    call db_execute(trim(sql),result)
  end subroutine db_insert

  subroutine db_update(table_name, assignments, predicate, result)
    character(len=*), intent(in) :: table_name, assignments, predicate
    type(db_result), intent(out) :: result
    character(len=DB_MAX_SQL) :: sql
    write(sql,'(A)') 'UPDATE '//trim(table_name)//' SET '//trim(assignments)//' WHERE '//trim(predicate)
    call db_execute(trim(sql),result)
  end subroutine db_update

  subroutine db_delete(table_name, predicate, result)
    character(len=*), intent(in) :: table_name, predicate
    type(db_result), intent(out) :: result
    character(len=DB_MAX_SQL) :: sql
    write(sql,'(A)') 'DELETE FROM '//trim(table_name)//' WHERE '//trim(predicate)
    call db_execute(trim(sql),result)
  end subroutine db_delete

  subroutine db_select(table_name, columns, predicate, result)
    character(len=*), intent(in) :: table_name, columns, predicate
    type(db_result), intent(out) :: result
    character(len=DB_MAX_SQL) :: sql
    if (len_trim(predicate)>0) then
       write(sql,'(A)') 'SELECT '//trim(columns)//' FROM '//trim(table_name)//' WHERE '//trim(predicate)
    else
       write(sql,'(A)') 'SELECT '//trim(columns)//' FROM '//trim(table_name)
    end if
    call db_execute(trim(sql),result)
  end subroutine db_select
end module db_repository
