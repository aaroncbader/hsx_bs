module options_module

  implicit none

  character*200 :: namelist_file='flf.namelist'
  character*20 :: field_type='coils'
  integer :: coil_type
  integer :: general_option = 1
  integer :: use_diffusion=0
  integer :: follow_type = 1
  integer :: diffusion_species=0
  integer :: output_coils=0, varD=0
  integer :: log_freq=1
  double precision :: dpar1, dpar2
  double precision :: d_perp, temperature, boozer_step, boozer_phi
  double precision :: varDgamma=1.0, varDB0=1.0


end module options_module
