
! Open up the beginning of all the EMC3 divertor files and read out the sizes.
! Then allocate a large divertor array which includes all the information and
! is sized to the largest divertor.

! There are large inefficiencies if one divertor is smaller than others
subroutine alloc_div(filenames, num_files)

  use div_module

  implicit none

  integer :: num_files, i, filenum, tor_points, div_segs, tor_max, seg_max
  character*72 :: dummy
  character*144, dimension(num_files) :: filenames
  character*144 :: filename

  filenum = 21

  tor_max = 0
  seg_max = 0


  ! Check to make sure some files were passed
  if (num_files .eq. 0) then
     print *,'No divertors to include'
     return
  end if

  ! Allocate the arrays that let us know how many divertor
  ! segments there are for each divertor.
  allocate(div_tor_num(num_files))
  allocate(div_seg_num(num_files))

  ! Go through all the files and assign the values to the appropriate segments
  do i =1,num_files
     open(filenum, file=trim(filenames(i)), status='old', form='formatted')
     ! first line is a dummy variable
     read(filenum,*) dummy
     ! this is all we need
     read(filenum,*) tor_points, div_segs
     close(filenum)
     
     ! put them into the arrays
     div_tor_num(i) = tor_points
     div_seg_num(i) = div_segs

     ! set the max values for allocating the divertors
     if (tor_points .gt. tor_max) then
        tor_max = tor_points
     end if
     if (div_segs .gt. seg_max) then
        seg_max = div_segs
     end if
  end do

  if ((seg_max .eq. 0) .or. (tor_max .eq. 0)) then
     print *,'No divertor plates found in the files!'
     div_number = 0
     return
  end if
  
  div_number = num_files
  ! Finally allocate the divertor array
  allocate(divertor(num_files, tor_max, seg_max, 2))
  allocate(div_tor_vals(num_files, tor_max))

end subroutine alloc_div


! Load in all the div values
subroutine load_div(filenames)

  use div_module
  character*144, dimension(div_number) :: filenames
  character*72 :: dummy

  integer :: i,j,k,filenum,d1,d2,d3
  real :: t,r,z, d4, d5
  
  filenum = 21

  do i = 1,div_number
     open(filenum, file=trim(filenames(i)), status='old', form='formatted')
     read(filenum, *) dummy
     ! These are unneeded dummy variables
     read(filenum, *) d1,d2,d3,d4,d5
     do j=1,div_tor_num(i)
        !read in the tor value
        read(filenum,*) t
        div_tor_vals(i,j) = t
        do k=1,div_seg_num(i)
           read(filenum,*) r,z
           divertor(i,j,k,1) = r
           divertor(i,j,k,2) = z
        end do
     end do
     close(filenum)
  end do

end subroutine load_div

subroutine deallocate_div()
  use div_module
  deallocate(div_tor_num)
  deallocate(div_seg_num)
  deallocate(divertor)
  deallocate(div_tor_vals)
end subroutine deallocate_div

subroutine inside_div

end subroutine inside_div