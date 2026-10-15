module accounting_service
  implicit none
  type :: ledger_entry
     integer(kind=8)::id=0
     integer(kind=8)::account_id=0
     real(8)::debit=0.0d0
     real(8)::credit=0.0d0
     character(len=256)::description=''
  end type ledger_entry
contains
  real(8) function balance(entry)
    type(ledger_entry),intent(in)::entry
    balance=entry%debit-entry%credit
  end function balance
  logical function balanced(debits,credits)
    real(8),intent(in)::debits,credits
    balanced=abs(debits-credits)<0.000001d0
  end function balanced
end module accounting_service
