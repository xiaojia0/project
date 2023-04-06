## make pial

mris_make_surfaces  -max 50000  -r ${r} -max_csf 0.1  -min_gray_at_csf_border 1   -orig_white orig -orig_pial orig   -noaseg   -noaparc -mgz -T1 fake_T1_sm2 ${subject} rh

## make the surface to ori


mris_convert rh.pial rh.pial.surf.gii
mris_convert rh.orig rh.orig.surf.gii

ConvertSurface -i rh.orig.surf.gii -o rh.orig_scale008.gii -xmat_1D scale0.8.1D
ConvertSurface -i rh.pial.surf.gii -o rh.pial_scale008.gii -xmat_1D scale0.8.1D

3dcopy wm.nii.gz test_wm.nii.gz

3drefit -xdel 0.08 -ydel 0.08 -zdel 0.08 -keepcen test_wm.nii.gz


@Align_Centers -cm -base wm_or.nii.gz -dset test_wm.nii.gz

ConvertSurface -i rh.orig_scale008.gii -o rh.orig_scale008_shifti.gii -ixmat_1D test_wm_shft.1D
ConvertSurface -i rh.pial_scale008.gii -o rh.pial_scale008_shifti.gii -ixmat_1D test_wm_shft.1D


##smooth
