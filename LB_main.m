

I0 = imresize(imread('fig1.png'),0.5);
I1 = im2double(rgb2ind(I0,jet));
I1 = I1 - min(I1(:));
I1 = 1 - I1 / (max(I1(:))-min(I1(:)));
I1 = I1 * 0.35 +0.625;

pre0 = imnoise(I1,'gaussian',0,0);
pre0 = imgaussfilt(pre0,4);
% pre1 = imresize(pre1,[22,26]);
% pre1 = kron(pre1,ones(2,2));

imagesc(pre0);
colormap(flipud(jet));
%caxis([1.5 3.5]);
cb = colorbar();
title(cb,'(km/s)');
%colorbar off
% xlabel('Range(km)');
% ylabel('Range(km)');

%%

I2 = im2double(rgb2gray(imresize(imread('fig2.png'),[314,275])));
I2 = I2 - min(I2(:));
I2 = 1 - I2 / (max(I2(:))- min(I2(:))) -0.5;
I2 = I2 * 0.4 + 0.87 ;

pre1 = imnoise(I2,'gaussian',0,0.1);
pre1 = imgaussfilt(pre1,14);
% pre1 = imresize(pre1,[22,26]);
% pre1 = kron(pre1,ones(2,2));

imagesc(pre1);
colormap(flipud(jet));
caxis([0.65 0.95]);

%%
figure()
I3 = pre1;
I3(20:293,20:254) = pre0;
imagesc(I3);
colormap(flipud(jet));
caxis([0.65 0.95]);

%%
figure()
I4 = imgaussfilt(I3,10);
imagesc(I4);
colormap(flipud(jet));
caxis([0.65 0.95]);

%%
figure()
I5 = imgaussfilt(I3,7);
imagesc(I5);
colormap(flipud(jet));
caxis([0.65 0.95]);
