module build_info
  implicit none
  character(len=*), parameter :: PROJECT_NAME   = 'Asm-Fortran-Dos-2.5'
  character(len=*), parameter :: BUILD_NAME     = 'Business-OS-2.5'
  character(len=*), parameter :: BUILD_VERSION  = '2.5.0'
  character(len=*), parameter :: BUILD_ID       = 'ASM-FORTRAN-DOS-250001'
  integer, parameter :: BUILD_NUMBER = 250001
  character(len=*), parameter :: DEVELOPER_NAME = 'ArkansasIo'
  character(len=*), parameter :: DEVELOPER_ID   = 'ARKANSASIO'
  character(len=*), parameter :: RELEASE_CHANNEL = 'development'
  character(len=*), parameter :: TARGET_NAME = 'ASM-FORTRAN-DOS'
  character(len=*), parameter :: ARCHITECTURE = 'x86-64'
  character(len=*), parameter :: BUILD_DATE = '2026-10-15'
contains
  subroutine print_build_info()
    print '(A)', '========================================'
    print '(A)', trim(PROJECT_NAME)
    print '(A,A)', 'Build Name:     ', trim(BUILD_NAME)
    print '(A,A)', 'Version:        ', trim(BUILD_VERSION)
    print '(A,A)', 'Build ID:       ', trim(BUILD_ID)
    print '(A,I0)', 'Build Number:   ', BUILD_NUMBER
    print '(A,A)', 'Developer:      ', trim(DEVELOPER_NAME)
    print '(A,A)', 'Developer ID:   ', trim(DEVELOPER_ID)
    print '(A,A)', 'Channel:        ', trim(RELEASE_CHANNEL)
    print '(A,A)', 'Target:         ', trim(TARGET_NAME)
    print '(A,A)', 'Architecture:   ', trim(ARCHITECTURE)
    print '(A,A)', 'Build Date:     ', trim(BUILD_DATE)
    print '(A)', '========================================'
  end subroutine print_build_info
end module build_info
