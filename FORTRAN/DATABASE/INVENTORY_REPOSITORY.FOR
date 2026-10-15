module inventory_repository
  use db_types
  use db_driver
  implicit none
  private
  public :: product_create, stock_add, stock_remove, product_search
contains
  subroutine product_create(name,sku,price,quantity,result)
    character(len=*),intent(in)::name,sku
    real(8),intent(in)::price
    integer,intent(in)::quantity
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A,F0.2,A,I0,A)') "INSERT INTO products (name,sku,price,quantity) VALUES ('"//trim(name)//"','"//trim(sku)//"',",price,",",quantity,")"
    call db_execute(trim(sql),result)
  end subroutine product_create
  subroutine stock_add(product_id,quantity,result)
    integer,intent(in)::product_id,quantity
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0,A,I0)') 'UPDATE products SET quantity=quantity+',quantity,' WHERE id=',product_id
    call db_execute(trim(sql),result)
  end subroutine stock_add
  subroutine stock_remove(product_id,quantity,result)
    integer,intent(in)::product_id,quantity
    type(db_result),intent(out)::result
    character(len=512)::sql
    write(sql,'(A,I0,A,I0,A)') 'UPDATE products SET quantity=quantity-',quantity,' WHERE id=',product_id,' AND quantity >= 0'
    call db_execute(trim(sql),result)
  end subroutine stock_remove
  subroutine product_search(term,result)
    character(len=*),intent(in)::term
    type(db_result),intent(out)::result
    character(len=8192)::sql
    write(sql,'(A)') "SELECT id,name,sku,price,quantity FROM products WHERE name LIKE '%"//trim(term)//"%' OR sku LIKE '%"//trim(term)//"%' ORDER BY name"
    call db_execute(trim(sql),result)
  end subroutine product_search
end module inventory_repository
