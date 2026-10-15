module business
  implicit none
contains
  subroutine system_initialize()
    print '(a)', 'BUSINESS-OS'
    print '(a)', 'ASM + FORTRAN + MySQL'
    print '(a)', 'SYSTEM/360 | 8-BIT | 16-BIT'
  end subroutine

  subroutine command_loop()
    character(len=128) :: cmd
    logical :: running
    running = .true.
    do while (running)
      write(*,'(a)',advance='no') 'C:\BUSINESS> '
      read(*,'(A)',end=100) cmd
      select case (trim(adjustl(cmd)))
      case ('EXIT','exit')
        running = .false.
      case ('HELP','help')
        call show_help()
      case ('CUSTOMER','customer')
        print '(a)', 'CUSTOMER: ADD LIST SEARCH EDIT TICKETS EMAIL'
      case ('INVENTORY','inventory')
        print '(a)', 'INVENTORY: LIST ADD RECEIVE ADJUST SEARCH'
      case ('INVOICE','invoice')
        print '(a)', 'INVOICE: NEW LIST VIEW PRINT EMAIL PAYMENT'
      case ('TICKET','ticket')
        print '(a)', 'TICKET: NEW LIST SEARCH OPEN ASSIGN STATUS NOTE'
      case ('EMAIL','email')
        print '(a)', 'EMAIL: INBOX SENT COMPOSE REPLY FORWARD SEARCH'
      case ('CALC','calc')
        print '(a)', 'CALC: PROFIT MARGIN ROI TAX LOAN BREAK-EVEN'
      case ('REPORT','report')
        print '(a)', 'REPORT: SALES INVENTORY ACCOUNTING TICKETS EMAIL'
      case ('ANALYTICS','analytics')
        print '(a)', 'ANALYTICS: BAR LINE PIE AREA SCATTER HISTOGRAM'
      case default
        print '(a)', 'Unknown command. Type HELP.'
      end select
    end do
100 continue
  end subroutine

  subroutine show_help()
    print '(a)', 'CUSTOMER INVENTORY SALES ACCOUNTING INVOICE'
    print '(a)', 'TICKET EMAIL REPORT ANALYTICS CALC USER SYSTEM EXIT'
  end subroutine

  subroutine system_shutdown()
    print '(a)', 'SYSTEM SHUTDOWN.'
  end subroutine
end module business
