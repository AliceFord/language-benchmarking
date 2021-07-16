module mainmod
contains
    subroutine fillArray (a, n)      
        implicit none      

        logical, dimension (5), intent (out) :: a
        integer, intent (in) :: n
        
        integer :: i     
        do i = 1, n        
            a(i) = .true.
        end do  
        
    end subroutine fillArray 

    subroutine primeSieve(n, rval)
        implicit none
        integer, intent (in) :: n
        integer, allocatable, intent (inout) :: rval(:)
        integer :: p
        integer :: i
        integer :: rvalCounter

        logical :: prime(n+1)

        call fillArray(prime, n+1)

        p = 2
        do while (p * p <= n)
            if (prime(p)) then
                do i = p * 2, n+1, p
                    prime(i) = .false.
                end do
            end if
            p = p + 1
        end do

        prime(1) = .false.

        allocate(rval(n))

        rvalCounter = 1
        do i = 1, n+1
            if (prime(i)) then
                rval(rvalCounter) = i;
                rvalCounter = rvalCounter + 1
            end if
        end do

        rval = rval(1:rvalCounter-1)

        return
        
    end subroutine primeSieve
end module mainmod

program main
    use mainmod
    implicit none

    integer, allocatable :: sieve(:)

    print *, "s"
    call primeSieve(100000000, sieve)
    if (size(sieve) .ne. 5761455) then
        print *, "Prime sieve failed!"
    else
        print *, "f"
    end if ! Error handling in fortran
    
end program main