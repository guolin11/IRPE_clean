%% Loading spectra
clear all,clc
tic()
chemin = '/home/guolin/Desktop/IRPE_clean/Data/CNRS/';
S=importdata([chemin,'imaging_CNRS.txt']);
R=importdata([chemin,'ref_CNRS.txt']);

thetas=unique(S.data(:,3));
nech=length(thetas);
Y_CNRS_before=reshape(S.data(:,4),size(S.data,1)/nech,nech);
R_y=R.data(:,3);

%% Baseline correction
Y_CNRS=fintegral(Y_CNRS_before);

%% Construct PSF from reference
PSF=fref(R_y);

%% Tricomi transform
b = tricomi(Y_CNRS);

%% Backprojection
n=800;
It= backproj(b,thetas,n);

%% Deconvolution
It=(It-min(min(It)))/(max(max(It))-min(min(It)));
It_blind=deconvblind(It,PSF,30);

%% Plot image
subplot(1,2,1)
imagesc(rot90(It))
title('Before deconvolution');
subplot(1,2,2)
imagesc(rot90(It_blind))
title('New code');
colormap gray
toc()
%%
subplot(4,2,1)
imagesc(rot90(It_plant_old))
title('smooth');
subplot(4,2,2)
imagesc(rot90(It_plant_old_nosmooth))
title('without smooth');
subplot(4,2,3)
imagesc(rot90(It_poker_old))
title('smooth');
subplot(4,2,4)
imagesc(rot90(It_poker_old_nosmooth))
title('without smooth');
subplot(4,2,5)
imagesc(rot90(It_CNRS_old))
title('smooth');
subplot(4,2,6)
imagesc(rot90(It_CNRS_old_nosmooth))
title('without smooth');
subplot(4,2,7)
imagesc(rot90(It_CNES_old,3))
title('smooth');
subplot(4,2,8)
imagesc(rot90(It_CNES_nosmooth,3))
title('without smooth');
colormap gray
