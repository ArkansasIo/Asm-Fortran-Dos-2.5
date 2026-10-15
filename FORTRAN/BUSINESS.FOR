module business
  use db_types
  use db_driver
  use menu_actions
  implicit none
  logical, save :: database_ready=.false.
contains
  subroutine system_initialize()
    type(db_config) :: cfg
    type(db_result) :: result
    print '(a)', 'BUSINESS-OS'
    print '(a)', 'ASM + FORTRAN + MySQL'
    print '(a)', 'SYSTEM/360 | 8-BIT | 16-BIT'
    print '(a)', 'CP/M STYLE MENU SYSTEM READY'
    call db_open(cfg,result)
    database_ready=(result%status==DB_OK)
    if (database_ready) then
      print '(a)', 'DATABASE ADAPTER: READY'
    else
      print '(a)', 'DATABASE ADAPTER: OFFLINE'
    end if
  end subroutine

  subroutine command_loop()
    logical :: running
    running=.true.
    do while (running)
      call main_menu(running)
    end do
  end subroutine

  subroutine main_menu(running)
    logical, intent(inout) :: running
    character(len=128) :: choice
    call clear_screen()
    print '(a)', '============================================='
    print '(a)', '          BUSINESS-OS MAIN MENU'
    print '(a)', '============================================='
    print '(a)', ' 1. ACCOUNT / USERS'
    print '(a)', ' 2. CUSTOMERS'
    print '(a)', ' 3. INVENTORY'
    print '(a)', ' 4. SALES'
    print '(a)', ' 5. ACCOUNTING'
    print '(a)', ' 6. INVOICES'
    print '(a)', ' 7. SUPPORT / TICKETS'
    print '(a)', ' 8. EMAIL'
    print '(a)', ' 9. REPORTS'
    print '(a)', '10. ANALYTICS'
    print '(a)', '11. CALCULATOR'
    print '(a)', '12. SYSTEM / SETTINGS'
    print '(a)', '13. HELP'
    print '(a)', ' 0. EXIT'
    print '(a)', '---------------------------------------------'
    write(*,'(a)',advance='no') 'SELECT: '
    read(*,'(A)') choice
    select case (trim(adjustl(choice)))
    case ('1'); call account_menu()
    case ('2'); call customer_menu()
    case ('3'); call inventory_menu()
    case ('4'); call sales_menu()
    case ('5'); call accounting_menu()
    case ('6'); call invoice_menu()
    case ('7'); call ticket_menu()
    case ('8'); call email_menu()
    case ('9'); call report_menu()
    case ('10'); call analytics_menu()
    case ('11'); call calculator_menu()
    case ('12'); call system_menu()
    case ('13','?','HELP','help'); call show_help()
    case ('0','EXIT','exit','QUIT','quit'); running=.false.
    case default
      print '(a)', 'Invalid selection.'
      call pause_menu()
    end select
  end subroutine

  subroutine account_menu()
    character(len=128)::choice
    do
      call submenu_header('ACCOUNT / USERS')
      print '(a)', '1. LOGIN'
      print '(a)', '2. LOGOUT'
      print '(a)', '3. REGISTER USER'
      print '(a)', '4. LIST USERS'
      print '(a)', '5. ROLES / PERMISSIONS'
      print '(a)', '6. SESSIONS'
      print '(a)', '7. AUDIT'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0' .or. trim(adjustl(choice))=='B' .or. trim(adjustl(choice))=='b') return
      print '(a)', 'ACCOUNT action selected: '//trim(adjustl(choice))
      call pause_menu()
    end do
  end subroutine

  subroutine customer_menu()
    character(len=128)::choice
    do
      call submenu_header('CUSTOMERS')
      print '(a)', '1. ADD CUSTOMER'
      print '(a)', '2. LIST CUSTOMERS'
      print '(a)', '3. SEARCH CUSTOMER'
      print '(a)', '4. EDIT CUSTOMER'
      print '(a)', '5. CUSTOMER TICKETS'
      print '(a)', '6. CUSTOMER EMAIL'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0' .or. trim(adjustl(choice))=='B' .or. trim(adjustl(choice))=='b') return
      call dispatch_customer(trim(adjustl(choice)))
    end do
  end subroutine

  subroutine inventory_menu()
    character(len=128)::choice
    do
      call submenu_header('INVENTORY')
      print '(a)', '1. LIST PRODUCTS'
      print '(a)', '2. ADD PRODUCT'
      print '(a)', '3. RECEIVE STOCK'
      print '(a)', '4. ADJUST STOCK'
      print '(a)', '5. SEARCH PRODUCTS'
      print '(a)', '6. LOW STOCK'
      print '(a)', '7. INVENTORY VALUE'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0' .or. trim(adjustl(choice))=='B' .or. trim(adjustl(choice))=='b') return
      call dispatch_inventory(trim(adjustl(choice)))
    end do
  end subroutine

  subroutine sales_menu()
    character(len=128)::choice
    do
      call submenu_header('SALES')
      print '(a)', '1. NEW SALE'
      print '(a)', '2. LIST SALES'
      print '(a)', '3. SEARCH SALE'
      print '(a)', '4. CUSTOMER SALES'
      print '(a)', '5. CANCEL SALE'
      print '(a)', '6. SALES TOTALS'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0') return
      print '(a)', 'SALES action selected: '//trim(adjustl(choice))
      call pause_menu()
    end do
  end subroutine

  subroutine accounting_menu()
    character(len=128)::choice
    do
      call submenu_header('ACCOUNTING')
      print '(a)', '1. GENERAL LEDGER'
      print '(a)', '2. ACCOUNTS RECEIVABLE'
      print '(a)', '3. ACCOUNTS PAYABLE'
      print '(a)', '4. BALANCE'
      print '(a)', '5. JOURNAL ENTRIES'
      print '(a)', '6. CASH FLOW'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0') return
      print '(a)', 'ACCOUNTING action selected: '//trim(adjustl(choice))
      call pause_menu()
    end do
  end subroutine

  subroutine invoice_menu()
    character(len=128)::choice
    do
      call submenu_header('INVOICES')
      print '(a)', '1. NEW INVOICE'
      print '(a)', '2. LIST INVOICES'
      print '(a)', '3. VIEW INVOICE'
      print '(a)', '4. PRINT INVOICE'
      print '(a)', '5. EMAIL INVOICE'
      print '(a)', '6. PAYMENT'
      print '(a)', '7. VOID INVOICE'
      print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0') return
      call dispatch_invoice(trim(adjustl(choice)))
    end do
  end subroutine

  subroutine ticket_menu()
    call simple_menu('SUPPORT / TICKETS','1. NEW TICKET','2. LIST TICKETS','3. SEARCH TICKETS','4. OPEN TICKET','5. ASSIGN TICKET','6. STATUS','7. ADD NOTE')
  end subroutine

  subroutine email_menu()
    call simple_menu('EMAIL','1. INBOX','2. SENT','3. COMPOSE','4. REPLY','5. FORWARD','6. SEARCH','7. ATTACHMENTS')
  end subroutine

  subroutine report_menu()
    call simple_menu('REPORTS','1. SALES REPORT','2. INVENTORY REPORT','3. ACCOUNTING REPORT','4. INVOICE REPORT','5. TICKET REPORT','6. EMAIL REPORT','7. CUSTOM REPORT')
  end subroutine

  subroutine analytics_menu()
    call simple_menu('ANALYTICS','1. BAR CHART','2. LINE CHART','3. PIE CHART','4. AREA CHART','5. SCATTER CHART','6. HISTOGRAM','7. FINANCIAL DASHBOARD')
  end subroutine

  subroutine calculator_menu()
    character(len=128)::choice
    do
      call submenu_header('BUSINESS CALCULATOR')
      print '(a)', '1. PROFIT'; print '(a)', '2. MARGIN'; print '(a)', '3. ROI'
      print '(a)', '4. TAX'; print '(a)', '5. LOAN'; print '(a)', '6. BREAK-EVEN'
      print '(a)', '7. CASH FLOW'; print '(a)', '0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0') return
      call dispatch_calculator(trim(adjustl(choice)))
    end do
  end subroutine

  subroutine system_menu()
    call simple_menu('SYSTEM / SETTINGS','1. SYSTEM/360 MODE','2. 8-BIT MODE','3. 16-BIT DOS MODE','4. DATABASE','5. NETWORK','6. CONFIGURATION','7. SYSTEM STATUS')
  end subroutine

  subroutine simple_menu(title,a,b,c,d,e,f,g)
    character(len=*),intent(in)::title,a,b,c,d,e,f,g
    character(len=128)::choice
    do
      call submenu_header(title)
      print '(a)',trim(a); print '(a)',trim(b); print '(a)',trim(c); print '(a)',trim(d)
      print '(a)',trim(e); print '(a)',trim(f); print '(a)',trim(g); print '(a)','0. BACK'
      write(*,'(a)',advance='no') 'SELECT: '; read(*,'(A)') choice
      if (trim(adjustl(choice))=='0') return
      print '(a)',trim(title)//' action selected: '//trim(adjustl(choice))
      call pause_menu()
    end do
  end subroutine

  subroutine show_help()
    call submenu_header('HELP')
    print '(a)', 'NUMBER = SELECT MENU ITEM'
    print '(a)', '0/B = BACK'
    print '(a)', 'M/MAIN = MAIN MENU'
    print '(a)', '?/HELP = HELP'
    print '(a)', 'EXIT = EXIT BUSINESS-OS'
    call pause_menu()
  end subroutine

  subroutine submenu_header(title)
    character(len=*),intent(in)::title
    call clear_screen()
    print '(a)','============================================='
    print '(a)',' '//trim(title)
    print '(a)','============================================='
  end subroutine

  subroutine pause_menu()
    character(len=8)::key
    write(*,'(a)',advance='no') 'Press ENTER to continue...'; read(*,'(A)') key
  end subroutine

  subroutine clear_screen()
    print '(a)',char(27)//'[2J'//char(27)//'[H'
  end subroutine

  subroutine system_shutdown()
    type(db_result)::result
    if (database_ready) call db_close(result)
    print '(a)','SYSTEM SHUTDOWN.'
  end subroutine
end module business
