function [x,y,z,nVoxel] = FCD_find(maskName,locationPrefix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the coordinates of mask where value =1
% Input: 
%   Required:
%       mask : the binary mask nii or hdr/img pairs files, need ext
%   Optional:
%       locationPrefix:  Save location and nVoxel with this prefix which includes dirPath. Without it, no location will be saved. No need ext.
% Output: 
%   [x,y,z] : coordinates of mask where value =1
%   nVoxel : numbers of voxels whose value = 1
% Example:
%   [x,y,z,nVoxel] = FCD_find('/home/mask.img','/home/loc')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited by Ci-Rong Liu, 20110803
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check number of input
if nargin<2
    locationPrefix=[];
end

%inital matrix
 x = []; 
 y = [];
 z = [];    

%read mask image
fprintf('\n\t Load mask "%s".', maskName);	
% masknii = load_untouch_nii(maskName);
% mask =logical(masknii.img);
 masknii=spm_vol(maskName);
 mask=spm_read_vols(masknii);

%find the x,y index which =1
for i = 1:size(mask,3)
    [x_tmp,y_tmp]=find(mask(:,:,i));
    x = [x;x_tmp];
    y = [y;y_tmp];
    z = [z; i*ones(length(x_tmp),1)];
end

nVoxel = length(z);

%chang the Datatype
x = single(x);
y = single(y);
z = single(z);
nVoxel = single(nVoxel);

%save mask location
location = [x,y,z];
if  ~isempty(locationPrefix)
    save([locationPrefix, '.mat'], 'location','nVoxel','-TABS');
end

%clear tmp coordinates
clear x_tmp;
clear y_tmp;
end
