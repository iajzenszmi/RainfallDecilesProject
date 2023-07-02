program rainfall_deciles
    use procedures
    implicit none
    integer, parameter :: dp = kind(0.d0)
    integer, parameter :: MAXN = 10000
    real(dp), dimension(:), allocatable :: rainfall
    integer :: i, N, lo1
    character(len=100) :: line, filename
    character(len=10) :: field
    integer :: ios
    lo1 = 1
    print *, 'Enter the filename: '
    read *, filename

    ! Open the file and count the lines
    open(unit=10, file=filename, status="old", action="read")
    N = 0
    do
        read(10, "(A)", iostat=ios) line
        if (ios /= 0) exit
        N = N + 1
    end do
    close(10)

    ! Allocate the array
    allocate(rainfall(N))

    ! Re-open the file and read the data
    open(unit=10, file=filename, status="old", action="read")
    do i=1,N
        read(10, "(A)", iostat=ios) line
        read(line, *, iostat=ios) rainfall(i)
        if (ios /= 0) exit
    end do
    close(10)

    ! Sort the data
    call quicksort(rainfall, lo1, N)
    

    ! Print the deciles
    do i=1,9
        print *, "Decile ", i, ": ", rainfall(N*i/10)
    end do

    deallocate(rainfall)
end program rainfall_deciles

module procedures
implicit none
contains

recursive subroutine quicksort(x, lo, hi) 
    implicit none
    integer, parameter :: dp = kind(0.d0)
    integer, intent(in) :: lo, hi
    real(dp), dimension(:), intent(inout) :: x
    integer :: p 

    if (lo < hi) then
        p = partition(x, lo, hi)
        call quicksort(x, lo, p-1)
        call quicksort(x, p+1, hi)
    end if
end subroutine quicksort

function partition(x, lo, hi) result(p)
    implicit none    
    integer, parameter :: dp = kind(0.d0)   
    integer, intent(in) :: lo, hi
    real(dp), dimension(:), intent(inout) :: x
    integer :: p, i, j
    real(dp) :: pivot

    pivot = x(hi)
    p = lo
    do i=lo,hi-1
        if (x(i) <= pivot) then
            call swap(x(p), x(i))
            p = p + 1
        end if
    end do
    call swap(x(p), x(hi))

    return
end function partition

subroutine swap(a, b)
    implicit none    
    integer, parameter :: dp = kind(0.d0)   
    real(dp), intent(inout) :: a, b
    real(dp) :: temp
    temp = a
    a = b
    b = temp
end subroutine swap

end module
