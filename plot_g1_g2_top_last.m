
% extract the top 10% cor of gradient and plot G1 G2 fro motor and nonmotor

G1 = gifti('sub_all_mean_cor_gradient1.func.gii_masked.func.gii');  % all scatter
G2 = gifti('sub_all_mean_cor_gradient2.func.gii_masked.func.gii');


% G1t = gifti('sub_all_mean_cor_gradient1_lobe_7-17.shape.gii');  % the 7-17 top grad1
% G2t = gifti('sub_all_mean_cor_gradient2_lobe_1-6.shape.gii');  % the 7-17 top grad2 in ct-ceb but 1-6 in cen inner
% 
% G1l = gifti('sub_all_mean_cor_gradient1_lobe_1-6.shape.gii');  % the 1-6 last grad1 
%                                                                                            


motor = gifti('Marmoset_ceb_lobe2_RSP01_fs_lobe1-6.shape.gii');
nonmotor = gifti('Marmoset_ceb_lobe2_RSP01_fs_lobe7-17.shape.gii');



 cdata = G1.cdata; 
 cdata1 = G2.cdata; 
 cdata2 = G1.cdata; 


vertex = 286308;

top_num = round(vertex*0.1); % 10% or 5%


[b,c]=sort(cdata(:),'descend');  % gradient 1 top 
cdata(c(top_num + 1:end))=0 ;

[b,c]=sort(cdata1(:),'descend');  % gradient 2 top 
cdata1(c(top_num + 1:end))=0 ;  


[b,c]=sort(cdata2(:));      % gradient 1 last
cdata2(c(top_num + 1:end))=0 ;


cdata_all = cdata + cdata1 + cdata2;

cdata_motor = cdata_all .* motor.cdata;

cdata_nonmotor = cdata_all .* nonmotor.cdata;


% % save 
  gg2 = gifti('sub_all_mean_cor_gradient1.func.gii_masked.func.gii');
%  
%  gg2.cdata = cdata;
%  saveg(gg2,'ceb_g1_top10.func.gii');
%  
% %   gg2.cdata = cdata1;
% %  saveg(gg2,'ceb_7_17_g2_top10.func.gii');
% %  
% %   
  gg2.cdata = cdata1;
 

 saveg(gg2,'ceb_g2_top10_nnn.func.gii');
 
 
 
%   gg2.cdata = cdata2;
%  saveg(gg2,'ceb_g1_last10.func.gii');
                
G12 = [G2.cdata,G1.cdata];


gradient_in_euclidean(G12);


scatter(G2.cdata,G1.cdata,'filled','k');
% hold on;
% hold off;
c1 = cdata_motor;
c1(c1~=0)=10;

c2 = cdata_nonmotor;
c2(c2~=0)=20;



cccc = mean([c1,c2],2);

scatter(G2.cdata,G1.cdata,[],cccc,'filled');

xlabel('Gradient2');
ylabel('Gradient1');

