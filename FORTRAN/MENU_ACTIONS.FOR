module menu_actions
  use db_types
  use customer_repository
  use inventory_repository
  use invoice_repository
  implicit none
contains
  subroutine dispatch_customer(choice)
    character(len=*), intent(in) :: choice
    character(len=256) :: name,email,phone,term
    integer :: id
    type(db_result) :: result
    select case (trim(adjustl(choice)))
    case ('1')
      call prompt_text('Customer name: ',name)
      call prompt_text('Email: ',email)
      call prompt_text('Phone: ',phone)
      call customer_create(trim(name),trim(email),trim(phone),result)
      call report_result('ADD CUSTOMER',result)
    case ('2')
      call customer_search('',result)
      call report_result('LIST CUSTOMERS',result)
    case ('3')
      call prompt_text('Search name/email: ',term)
      call customer_search(trim(term),result)
      call report_result('SEARCH CUSTOMER',result)
    case ('4')
      call prompt_integer('Customer ID: ',id)
      call prompt_text('New name: ',name)
      call prompt_text('New email: ',email)
      call prompt_text('New phone: ',phone)
      call customer_update(id,trim(name),trim(email),trim(phone),result)
      call report_result('EDIT CUSTOMER',result)
    case ('5')
      print '(a)', 'Customer ticket integration is routed through the ticket service.'
    case ('6')
      print '(a)', 'Customer email integration is routed through the email service.'
    case default
      call invalid_action()
    end select
    call pause_screen()
  end subroutine

  subroutine dispatch_inventory(choice)
    character(len=*), intent(in) :: choice
    character(len=256) :: name,sku,term
    integer :: id,quantity
    real(8) :: price
    type(db_result) :: result
    select case (trim(adjustl(choice)))
    case ('1','5')
      call prompt_text('Product name/SKU search (blank=list): ',term)
      call product_search(trim(term),result)
      call report_result('PRODUCT SEARCH',result)
    case ('2')
      call prompt_text('Product name: ',name)
      call prompt_text('SKU: ',sku)
      call prompt_real('Price: ',price)
      call prompt_integer('Quantity: ',quantity)
      call product_create(trim(name),trim(sku),price,quantity,result)
      call report_result('ADD PRODUCT',result)
    case ('3')
      call prompt_integer('Product ID: ',id)
      call prompt_integer('Quantity received: ',quantity)
      call stock_add(id,quantity,result)
      call report_result('RECEIVE STOCK',result)
    case ('4')
      call prompt_integer('Product ID: ',id)
      call prompt_integer('Quantity to remove: ',quantity)
      call stock_remove(id,quantity,result)
      call report_result('ADJUST STOCK',result)
    case ('6')
      print '(a)', 'LOW STOCK report is routed through the inventory reporting service.'
    case ('7')
      print '(a)', 'INVENTORY VALUE report is routed through the analytics service.'
    case default
      call invalid_action()
    end select
    call pause_screen()
  end subroutine

  subroutine dispatch_invoice(choice)
    character(len=*), intent(in) :: choice
    integer :: customer_id,invoice_id
    real(8) :: total
    type(db_result) :: result
    select case (trim(adjustl(choice)))
    case ('1')
      call prompt_integer('Customer ID: ',customer_id)
      call prompt_real('Invoice total: ',total)
      call invoice_create(customer_id,total,result)
      call report_result('NEW INVOICE',result)
    case ('2')
      print '(a)', 'Invoice listing will use the invoice reporting query.'
    case ('3')
      call prompt_integer('Invoice ID: ',invoice_id)
      call invoice_find(invoice_id,result)
      call report_result('VIEW INVOICE',result)
    case ('4')
      call prompt_integer('Invoice ID: ',invoice_id)
      print '(a,i0)', 'PRINT INVOICE ID=',invoice_id
    case ('5')
      call prompt_integer('Invoice ID: ',invoice_id)
      print '(a,i0)', 'EMAIL INVOICE ID=',invoice_id
    case ('6')
      call prompt_integer('Invoice ID: ',invoice_id)
      call invoice_mark_paid(invoice_id,result)
      call report_result('PAYMENT',result)
    case ('7')
      call prompt_integer('Invoice ID: ',invoice_id)
      print '(a,i0)', 'VOID INVOICE ID=',invoice_id
    case default
      call invalid_action()
    end select
    call pause_screen()
  end subroutine

  subroutine dispatch_calculator(choice)
    character(len=*), intent(in) :: choice
    real(8) :: a,b,c
    select case (trim(adjustl(choice)))
    case ('1')
      call prompt_real('Revenue: ',a); call prompt_real('Cost: ',b)
      print '(a,f12.2)', 'PROFIT = ',a-b
    case ('2')
      call prompt_real('Revenue: ',a); call prompt_real('Cost: ',b)
      if (a /= 0.0d0) then
        print '(a,f12.4)', 'MARGIN = ',(a-b)/a
      else
        print '(a)', 'MARGIN = undefined (revenue is zero).'
      end if
    case ('3')
      call prompt_real('Gain: ',a); call prompt_real('Investment: ',b)
      if (b /= 0.0d0) then
        print '(a,f12.4)', 'ROI = ',(a/b)*100.0d0
      else
        print '(a)', 'ROI = undefined (investment is zero).'
      end if
    case ('4')
      call prompt_real('Amount: ',a); call prompt_real('Tax rate (0.13 = 13%): ',b)
      print '(a,f12.2)', 'TAX = ',a*b
      print '(a,f12.2)', 'TOTAL = ',a+(a*b)
    case ('5')
      call prompt_real('Principal: ',a); call prompt_real('Annual rate: ',b)
      call prompt_real('Years: ',c)
      print '(a)', 'Loan calculation parameters accepted.'
      print '(a,f12.2)', 'Simple interest = ',a*b*c
    case ('6')
      call prompt_real('Fixed costs: ',a); call prompt_real('Price/unit: ',b)
      call prompt_real('Variable cost/unit: ',c)
      if (b /= c) then
        print '(a,f12.2)', 'BREAK-EVEN UNITS = ',a/(b-c)
      else
        print '(a)', 'Break-even is undefined when price equals variable cost.'
      end if
    case ('7')
      print '(a)', 'Cash-flow analysis is routed through the accounting service.'
    case default
      call invalid_action()
    end select
    call pause_screen()
  end subroutine

  subroutine report_result(operation,result)
    character(len=*), intent(in) :: operation
    type(db_result), intent(in) :: result
    print '(a)', '---------------------------------------------'
    print '(a)', trim(operation)
    print '(a,i0)', 'STATUS: ',result%status
    print '(a,i0)', 'AFFECTED ROWS: ',result%affected_rows
    print '(a,i0)', 'INSERT ID: ',result%insert_id
    print '(a)', 'MESSAGE: '//trim(result%message)
    print '(a)', '---------------------------------------------'
  end subroutine

  subroutine prompt_text(label,value)
    character(len=*), intent(in) :: label
    character(len=*), intent(out) :: value
    write(*,'(a)',advance='no') trim(label)
    read(*,'(A)') value
  end subroutine

  subroutine prompt_integer(label,value)
    character(len=*), intent(in) :: label
    integer, intent(out) :: value
    integer :: ios
    character(len=128) :: raw
    do
      write(*,'(a)',advance='no') trim(label)
      read(*,'(A)') raw
      read(raw,*,iostat=ios) value
      if (ios == 0) exit
      print '(a)', 'Enter a valid integer.'
    end do
  end subroutine

  subroutine prompt_real(label,value)
    character(len=*), intent(in) :: label
    real(8), intent(out) :: value
    integer :: ios
    character(len=128) :: raw
    do
      write(*,'(a)',advance='no') trim(label)
      read(*,'(A)') raw
      read(raw,*,iostat=ios) value
      if (ios == 0) exit
      print '(a)', 'Enter a valid number.'
    end do
  end subroutine

  subroutine invalid_action()
    print '(a)', 'That menu action is not available yet.'
  end subroutine

  subroutine pause_screen()
    character(len=8) :: key
    write(*,'(a)',advance='no') 'Press ENTER to continue...'
    read(*,'(A)') key
  end subroutine
end module menu_actions
