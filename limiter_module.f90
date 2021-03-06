module limiter_module

  implicit none
  integer, allocatable, dimension(:) :: limiter_size
  integer :: num_limiters, lim_minstep=0
  real :: lim_halfwidth=0.01

  real, allocatable, dimension(:,:,:) :: limiter
  real, allocatable, dimension(:,:) :: lim_bvector, lim_baxis
  character*72, dimension(:), allocatable :: lim_files

end module limiter_module
