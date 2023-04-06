#map the ROI use the wb_command 

wb_command -volume-to-surface-mapping Marmoset_ceb_lobe.nii.gz rh.pial_scale008_shifti_sm_005.surf.gii Marmoset_ceb_lobe_map_005.func.gii -ribbon-constrained rh.orig_scale008_shifti_sm_005.surf.gii rh.pial_scale008_shifti_sm_005.surf.gii  -volume-roi Marmoset_ceb_lobe.nii.gz

#map the ROI use the freesurfer(better)

export SUBJECTS_DIR=/mnt/surfface_item/iso008
source ~/.bashrc

3dresample -orient RSP  -prefix Marmoset_ceb_lobe2_RSP.nii.gz -insert Marmoset_ceb_lobe2.nii.gz 
3drefit -xorigin_raw 0 -yorigin_raw 0 -zorigin_raw 0 Marmoset_ceb_lobe2_RSP.nii.gz 
3drefit -xorigin 13.96 -yorigin 11.96 -zorigin 19.16 Marmoset_ceb_lobe2_RSP.nii.gz 
mri_convert  Marmoset_ceb_lobe2_RSP.nii.gz Marmoset_ceb_lobe2_RSP01.nii.gz -iis 0.1 -ijs 0.1 -iks 0.1

cd surf/
mv rh.pial rh.pial_or
mv rh.orig rh.orig_or

mris_convert rh.pial_scale008_shifti_sm.surf.gii rh.pial
mris_convert rh.orig_scale008_shifti_sm.surf.gii rh.orig

mri_vol2surf --src Marmoset_ceb_lobe2_RSP01.nii.gz --out Marmoset_ceb_lobe2_RSP01.shape.gii --regheader marmoset --hemi rh



