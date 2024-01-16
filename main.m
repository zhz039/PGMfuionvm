  ha = tightPlots(2, 2, 15, [2 1], [0.4 1], [0.6 0.7], [0.8 0.3], 'centimeters');
  f = [1 5 10 15]; x = 0:0.05:10;
  for i = 1:length(f)
      y = sin(f(i) * x);
      axes(ha(i)); plot(x, y)
  end
  set(ha(1:4), 'fontname', 'Times', 'fontsize', 10)
  set(ha(1:2), 'xticklabel', '');
  set([ha(2) ha(4)], 'yticklabel', '');
  axes(ha(1));  title('Title 1');
  axes(ha(2));  title('Title 2');

%   print(gcf, 'Example1.png', '-dpng', '-r200', '-opengl');
%   print(gcf, 'Example1.eps', '-depsc2', '-painters', '-loose');
%   print(gcf, 'Example1.pdf', '-dpdf', '-painters', '-loose');


%%
ha = tightPlots(4, 3, 24, [2 2], [1.0 0.8], [3 1.5], [2.5 3], 'centimeters');
fontsize = 12;

% (a1) 
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

checkerboard_overlap = I_lr;
checkerboard_overlap(151:350,151:350) = I_hr(151:350,151:350);
axes(ha(1));
imagesc(checkerboard_overlap,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal','FontSize', fontsize);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
xlabel('\bf (a1)');
ylabel('South-North (km)');
colormap(flipud(jet));
rectangle('Position',[30,30,40,40],'FaceColor','none','EdgeColor','r','LineWidth',3);
set(gca,'TickDir','out');

% (a2)
[Longitude, Latitude] = meshgrid(10:10:90,10:10:90);
Longitude = reshape(Longitude.',1,[]);
Latitude = reshape(Latitude.',1,[]);
axes(ha(2));
% rectangle('Position',[min_lon-0.005 min_lat-0.005 max_lon-min_lon+0.01 max_lat-min_lat+0.015],'EdgeColor','b','linewidth',3); hold on;
for i=1:length(Longitude)
    for j=i:length(Longitude)
        plot1 = plot([Longitude(i), Longitude(j)],[Latitude(i), Latitude(j)], 'k','LineWidth',0.1);
        plot1.Color(4) = 0.2;
        hold on;
    end
end
plot(Longitude, Latitude,'^','MarkerFaceColor','r','MarkerEdgeColor','k','markersize',9,'LineWidth',0.1); hold off;
xlim([0 100]);
ylim([0 100]);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (a2)');
% ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (a3)
load checkerboard_seg.mat
axes(ha(3));
imagesc(seg,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'colormap',flipud(gray));
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (a3)');
% ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (a4)
checkerboard_fusion_1 = imgaussfilt(checkerboard_overlap, 1);
axes(ha(4));
imagesc(checkerboard_fusion_1,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal');
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
xlabel('\bf (a4)');
ylabel('South-North (km)');
set(gca,'colormap',flipud(jet));
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (a5)
checkerboard_fusion_1 = imgaussfilt(checkerboard_overlap, 2.5);
axes(ha(5));
imagesc(checkerboard_fusion_1,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal');
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (a5)');
% ylabel('South-North (km)');
set(gca,'colormap',flipud(jet));
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (a6)
checkerboard_fusion_1 = imgaussfilt(checkerboard_overlap, 4);
axes(ha(6));
imagesc(checkerboard_fusion_1,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'YDir','normal');
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (a6)');
% ylabel('South-North (km)');
set(gca,'colormap',flipud(jet));
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');




% (b1)
load 1Hz_map_smoothed.mat
load Ridgecrest_LR.mat
I_overlap = I_lr;
I_overlap(53:244,57:280) = pre1;

axes(ha(7));
imagesc(I_overlap,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]); hold on;
set(gca,'colormap',flipud(jet));
set(gca,'YDir','normal');
set(gca,'clim',[1.5,3.5]);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
xlabel('\bf (b1)');
ylabel('South-North (km)');
set(gca,'colormap',flipud(jet));
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (b2)
stat_info = readtable('gmap-stations.csv');
Longitude = [stat_info.Longitude(533:563); stat_info.Longitude(144:5:389); stat_info.Longitude(1:2:63)];
Latitude = [stat_info.Latitude(533:563); stat_info.Latitude(144:5:389); stat_info.Latitude(1:2:63)];

% station_loc = zeros([size(Longitude,1),2]);
% station_loc(:,1) = Longitude;
% station_loc(:,2) = Latitude;
% save('station_loc.mat','station_loc');
% min_lon = -117.85;
% max_lon = -117.3;
% min_lat = 35.5;
% max_lat  = 35.9;

axes(ha(8));
% rectangle('Position',[min_lon-0.005 min_lat-0.005 max_lon-min_lon+0.01 max_lat-min_lat+0.015],'EdgeColor','b','linewidth',3); hold on;
for i=1:length(Longitude)
    for j=i:length(Longitude)
        plot1 = plot([Longitude(i), Longitude(j)],[Latitude(i), Latitude(j)], 'k');
        plot1.Color(4) = 0.1;
        hold on;
    end
end

plot(Longitude, Latitude,'^','MarkerFaceColor','r','MarkerEdgeColor','k','markersize',9,'LineWidth',0.1); hold off;
% xlim([-118 -117.2]);
% ylim([35.4 36]);
% xticks([-118:0.2:-117.2]);
% yticks([35.4:0.2:36]);
% xlim([0 100]);
% ylim([0 100]);
set(gca, 'xtick',-118:0.4:-117.2);
set(gca, 'ytick',35.4:0.3:36);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (b2)');
% ylabel('South-North (km)');
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (b3)
min_lon = 0;
max_lon = 100;
min_lat = 0;
max_lat  = 100;

load Ridgecrest_fusion.mat
axes(ha(9));
class_number=6;
potential=0.9;
maxIter=50;
seg=ICM(imgaussfilt(Ridgecrest_fusion_1,4),class_number,potential,maxIter);
imagesc(seg,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'colormap',flipud(gray));
set(gca,'YDir','normal');
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel('\bf (b3)');
% ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (b4)
axes(ha(10));
imagesc(imgaussfilt(Ridgecrest_fusion_1,6),'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'YDir','normal');
set(gca,'colormap',flipud(jet));
set(gca,'clim',[1.5,3.5]);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
% set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
xlabel(['West-East (km)', newline,'\bf (b4)']);
ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (b5)
axes(ha(11));
imagesc(Ridgecrest_fusion_3,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'YDir','normal');
set(gca,'colormap',flipud(jet));
set(gca,'clim',[1.5,3.5]);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
% set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel(['West-East (km)', newline,'\bf (b5)']);
% ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');

% (b6)
axes(ha(12));
imagesc(Ridgecrest_fusion_2,'XData', [min_lon, max_lon], 'YData', [max_lat, min_lat]);
set(gca,'YDir','normal');
set(gca,'colormap',flipud(jet));
set(gca,'clim',[1.5,3.5]);
set(gca, 'xtick',0:50:100);
set(gca, 'ytick',0:50:100);
% set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
xlabel(['West-East (km)', newline,'\bf (b6)']);
% ylabel('South-North (km)');
box on
set(gca,'FontSize',fontsize);
set(gca,'TickDir','out');



% h = axes(fig,'visible','off');
% c = colorbar(h,'Position',[0.93 0.168 0.022 0.7]);
% colormap(c,'jet')

% print(gcf, 'results_merged_2.png', '-dpng', '-r200', '-image');
