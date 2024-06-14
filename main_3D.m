%% superimposed model --- interplated to the same resolution
ha = tightPlots(1, 2, 24, [2 2], [1.0 0.8], [3 1.5], [2.5 3], 'centimeters');
fontsize = 12;
load checkerboard_map.mat
I=double(kron(checkerboard_map(1:2:100,1:2:100),ones(10)));
I_lr = I-0.5;
h = fspecial('gaussian',50,13);
ds = [h,-h;-h,h];
ds = ds / max(max(ds));
I_hr = kron(ones(5),ds) + 2.5;

min_lon = 0;
max_lon = 100;
min_lat = 0;
max_lat  = 100;
class_number=6;
potential=0.9;
maxIter=50;

overlap_model = I_lr;
overlap_model(151:350,151:350) = I_hr(151:350,151:350);

figure(1)
load checkerboard_seg.mat
imagesc(seg,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'colormap',flipud(gray));
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[0 50 100])
set(gca,'yticklabel',[0 50 100])
ylabel('South-North (km)');
ylabel('West-East (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

figure(2)
imagesc(overlap_model,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal','FontSize', fontsize);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

%% Example after 10 iterations:
load 3D_map.mat
load 3D_tomo_map.mat

LR_model = map;
HR_model = tomo_map;
confidence_weight = 0.8;  % Confidence control parameter
num_iterations = 10;  % Number of iterations for smoothing
beta = 0.9;  % Smoothness control parameter
kernel_size = 3;

% Call the GMRF smoothing function
smoothed_model = pgm_smoothing(LR_model, HR_model, confidence_weight, beta, num_iterations, kernel_size);

% smoothed_model = pgm_smoothing(overlap_model, confidence_weight, num_iterations);

% Display the results
figure();
set(gcf,'Position',[100 100 900 500])
subplot(1,2,1)
imagesc(overlap_model,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal','FontSize', fontsize);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');
title('Superimposed Model');
colormap(flipud(jet));
subplot(1,2,2), 
imagesc(smoothed_model,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal','FontSize', fontsize);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');
title('Smoothed Model with PGM');
colormap(flipud(jet));

