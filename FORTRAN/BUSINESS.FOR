module business
  implicit none
contains
  subroutine system_initialize()
    print '(a)', 'BUSINESS-OS'
    print '(a)', 'ASM + FORTRAN + MySQL'
    print '(a)', 'SYSTEM/360 | 8-BIT | 16-BIT'
    print '(a)', 'CP/M STYLE MENU SYSTEM READY'
  end subroutine

  subroutine command_loop()
    character(len=128) :: cmd
    logical :: running
    running = .true.
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
    case ('1');  call account_menu()
    case ('2');  call customer_menu()
    case ('3');  call inventory_menu()
    case ('4');  call sales_menu()
    case ('5');  call accounting_menu()
    case ('6');  call invoice_menu()
    case ('7');  call ticket_menu()
    case ('8');  call email_menu()
    case ('9');  call report_menu()
    case ('10'); call analytics_menu()
    case ('11'); call calculator_menu()
    case ('12'); call system_menu()
    case ('13','?','HELP','help'); call show_help()
    case ('0','EXIT','exit','QUIT','quit'); running = .false.
    case default
      print '(a)', 'Invalid selection. Press ENTER.'
      read(*,'(A)') choice
    end select
  end subroutine

  subroutine account_menu()
    call submenu_header('ACCOUNT / USERS')
    call menu_action('1','LOGIN')
    call menu_action('2','LOGOUT')
    call menu_action('3','REGISTER USER')
    call menu_action('4','LIST USERS')
    call menu_action('5','ROLES / PERMISSIONS')
    call menu_action('6','SESSIONS')
    call menu_action('7','AUDIT')
    call wait_back()
  end subroutine

  subroutine customer_menu()
    call submenu_header('CUSTOMERS')
    call menu_action('1','ADD CUSTOMER')
    call menu_action('2','LIST CUSTOMERS')
    call menu_action('3','SEARCH CUSTOMER')
    call menu_action('4','EDIT CUSTOMER')
    call menu_action('5','CUSTOMER TICKETS')
    call menu_action('6','CUSTOMER EMAIL')
    call wait_back()
  end subroutine

  subroutine inventory_menu()
    call submenu_header('INVENTORY')
    call menu_action('1','LIST PRODUCTS')
    call menu_action('2','ADD PRODUCT')
    call menu_action('3','RECEIVE STOCK')
    call menu_action('4','ADJUST STOCK')
    call menu_action('5','SEARCH PRODUCTS')
    call menu_action('6','LOW STOCK')
    call menu_action('7','INVENTORY VALUE')
    call wait_back()
  end subroutine

  subroutine sales_menu()
    call submenu_header('SALES')
    call menu_action('1','NEW SALE')
    call menu_action('2','LIST SALES')
    call menu_action('3','SEARCH SALE')
    call menu_action('4','CUSTOMER SALES')
    call menu_action('5','CANCEL SALE')
    call menu_action('6','SALES TOTALS')
    call wait_back()
  end subroutine

  subroutine accounting_menu()
    call submenu_header('ACCOUNTING')
    call menu_action('1','GENERAL LEDGER')
    call menu_action('2','ACCOUNTS RECEIVABLE')
    call menu_action('3','ACCOUNTS PAYABLE')
    call menu_action('4','BALANCE')
    call menu_action('5','JOURNAL ENTRIES')
    call menu_action('6','CASH FLOW')
    call wait_back()
  end subroutine

  subroutine invoice_menu()
    call submenu_header('INVOICES')
    call menu_action('1','NEW INVOICE')
    call menu_action('2','LIST INVOICES')
    call menu_action('3','VIEW INVOICE')
    call menu_action('4','PRINT INVOICE')
    call menu_action('5','EMAIL INVOICE')
    call menu_action('6','PAYMENT')
    call menu_action('7','VOID INVOICE')
    call wait_back()
  end subroutine

  subroutine ticket_menu()
    call submenu_header('SUPPORT / TICKETS')
    call menu_action('1','NEW TICKET')
    call menu_action('2','LIST TICKETS')
    call menu_action('3','SEARCH TICKETS')
    call menu_action('4','OPEN TICKET')
    call menu_action('5','ASSIGN TICKET')
    call menu_action('6','STATUS')
    call menu_action('7','ADD NOTE')
    call wait_back()
  end subroutine

  subroutine email_menu()
    call submenu_header('EMAIL')
    call menu_action('1','INBOX')
    call menu_action('2','SENT')
    call menu_action('3','COMPOSE')
    call menu_action('4','REPLY')
    call menu_action('5','FORWARD')
    call menu_action('6','SEARCH')
    call menu_action('7','ATTACHMENTS')
    call wait_back()
  end subroutine

  subroutine report_menu()
    call submenu_header('REPORTS')
    call menu_action('1','SALES REPORT')
    call menu_action('2','INVENTORY REPORT')
    call menu_action('3','ACCOUNTING REPORT')
    call menu_action('4','INVOICE REPORT')
    call menu_action('5','TICKET REPORT')
    call menu_action('6','EMAIL REPORT')
    call menu_action('7','CUSTOM REPORT')
    call wait_back()
  end subroutine

  subroutine analytics_menu()
    call submenu_header('ANALYTICS')
    call menu_action('1','BAR CHART')
    call menu_action('2','LINE CHART')
    call menu_action('3','PIE CHART')
    call menu_action('4','AREA CHART')
    call menu_action('5','SCATTER CHART')
    call menu_action('6','HISTOGRAM')
    call menu_action('7','FINANCIAL DASHBOARD')
    call wait_back()
  end subroutine

  subroutine calculator_menu()
    call submenu_header('BUSINESS CALCULATOR')
    call menu_action('1','PROFIT')
    call menu_action('2','MARGIN')
    call menu_action('3','ROI')
    call menu_action('4','TAX')
    call menu_action('5','LOAN')
    call menu_action('6','BREAK-EVEN')
    call menu_action('7','CASH FLOW')
    call wait_back()
  end subroutine

  subroutine system_menu()
    call submenu_header('SYSTEM / SETTINGS')
    call menu_action('1','SYSTEM/360 MODE')
    call menu_action('2','8-BIT MODE')
    call menu_action('3','16-BIT DOS MODE')
    call menu_action('4','DATABASE')
    call menu_action('5','NETWORK')
    call menu_action('6','CONFIGURATION')
    call menu_action('7','SYSTEM STATUS')
    call wait_back()
  end subroutine

  subroutine show_help()
    print '(a)', 'CP/M NAVIGATION:'
    print '(a)', 'NUMBER = SELECT MENU ITEM'
    print '(a)', '0/B    = BACK FROM SUBMENU'
    print '(a)', 'MAIN   = RETURN TO MAIN MENU'
    print '(a)', '?/HELP = HELP'
    print '(a)', 'EXIT   = EXIT BUSINESS-OS'
    call wait_back()
  end subroutine

  subroutine submenu_header(title)
    character(len=*), intent(in) :: title
    call clear_screen()
    print '(a)', '============================================='
    print '(a)', ' ' // trim(title)
    print '(a)', '============================================='
  end subroutine

  subroutine menu_action(number, label)
    character(len=*), intent(in) :: number, label
    print '(a)', ' ' // trim(number) // '. ' // trim(label)
  end subroutine

  subroutine wait_back()
    character(len=128) :: choice
    do
      write(*,'(a)',advance='no') 'COMMAND [0=BACK, M=MAIN, ?=HELP]: '
      read(*,'(A)') choice
      select case (trim(adjustl(choice)))
      case ('0','B','b','MAIN','main')
        return
      case ('?','HELP','help')
        print '(a)', 'Select an item by number. 0 or B returns to the previous menu.'
      case default
        print '(a)', 'Menu item dispatcher: ' // trim(adjustl(choice))
      end select
    end do
  end subroutine

  subroutine clear_screen()
    print '(a)', char(27)//'[2J'//char(27)//'[H'
  end subroutine

  subroutine show_help_legacy()
    call show_help()
  end subroutine

  subroutine system_shutdown()
    print '(a)', 'SYSTEM SHUTDOWN.'
  end subroutine
end module business
