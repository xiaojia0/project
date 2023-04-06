% find the top and last 10 % of nucle gradient 1

dataname = 'suball_ct-nucle_gradient_1.nii';
     
     img = spm_vol(dataname);
     imgdata = spm_read_vols(img);


     [a,b,c,nVoxel] = FCD_find(dataname,'./'); 
     
     

top_num = round(nVoxel*0.1); % 10% or 5%


cdata = imgdata;
    
 cdata = reshape(cdata,[],1)  ;


[bbb,ccc]=sort(cdata(:),'descend');  % gradient 1 top of 7-17

top_value = bbb(top_num,:);    

last_value = bbb(end-top_num,:);

cdata_top = imgdata;
cdata_last = imgdata;

cdata_top(cdata_top<top_value)=0;
cdata_top(cdata_top~=0)=1;



cdata_last(cdata_last>last_value)=0;
cdata_last(cdata_last~=0)=1;



   img.fname = 'top10_nucle_gradient.nii';% change the name to output

    spm_write_vol(img,cdata_top); 
    
    
    
       img.fname = 'last10_nucle_gradient.nii';% change the name to output

    spm_write_vol(img,cdata_last); 

