clear all
close all

load('CTD_10_6_binned.mat')
load('BVF_components_10_6.mat')
load('CTD_21_7_binned_and_BVF')
load('latlong.mat')

transect_distance = zeros(10, 1);
for i = 2 : 10
    transect_distance(i) = distance(lat(1), long(1), lat(i), long(i), [6378.137 0.0818191910428158]);
end

pcolor_data = zeros(10, 55);
for i = 1 : 10
    pcolor_data(i, 1 : size(eval(strcat('N2_T_10_6_',num2str(i))), 1)) = eval(strcat('N2_T_10_6_',num2str(i)))';
end

[transect_distance_sorted, sortIdx] = sortrows(transect_distance, 'ascend');
pcolor_data_sorted = zeros(10, 55);
for i = 1 : 10
    pcolor_data_sorted(i, :) = pcolor_data(sortIdx(i), :);
end
pcolor_data_sorted(pcolor_data_sorted == 0) = NaN;

distance_21_7 = distance(lat(1), long(1), 50.25, -4.22, [6378.137 0.0818191910428158]);
pcolor_data_21_7 = zeros(55, 1);
pcolor_data_21_7(1 : size(N2_T_21_7, 1)) = N2_T_21_7;
pcolor_data_21_7(pcolor_data_21_7 == 0) = NaN;

figure(1)
hold on
subplot(1, 2, 1)
[M, c] = contourf(transect_distance_sorted, 1.5 : 55.5, pcolor_data_sorted');
set(gca, 'YDir', 'reverse')
colormap jet
xlabel('Distance roughly SW from 50.31 N, 4.14 W [km]')
ylabel('Depth [m]')
text(1, 50, 'June 10')
caxis([-3e-4 15e-4])
subplot(1, 2, 2)
contourf(1 : 2, 1.5 : 55.5, (ones(2, 55).*pcolor_data_21_7')', [c.LevelList]);
colormap jet
caxis([-3e-4 15e-4])
set(gca, 'YDir', 'reverse')
set(gca, 'YTick', [])
xticks([1.5])
xticklabels({round(distance_21_7, 1)})
h = colorbar;
ylabel(h, 'Temperature component of buoyancy frequency squared [s^-^2]')
text(1, 50, 'July 21')

figure(2)
hold on
subplot(1, 2, 1)
im = image(transect_distance_sorted, 1.5 : 55.5, pcolor_data_sorted', 'CDataMapping', 'scaled');
set(gca, 'YDir', 'reverse')
colormap jet
xlabel('Distance roughly SW from 50.31 N, 4.14 W [km]')
ylabel('Depth [m]')
text(1, 50, 'June 10')
caxis([-3e-4 15e-4])
set(im, 'AlphaData', ~isnan(pcolor_data_sorted'))
subplot(1, 2, 2)
im2 = image(1 : 2, 1.5 : 55.5, (ones(2, 55).*pcolor_data_21_7')', 'CDataMapping', im.CDataMapping);
colormap jet
caxis([-3e-4 15e-4])
set(gca, 'YDir', 'reverse')
set(gca, 'YTick', [])
xticks([1.5])
xticklabels({round(distance_21_7, 1)})
h = colorbar;
ylabel(h, 'Temperature component of buoyancy frequency squared [s^-^2]')
text(1, 50, 'July 21')
set(im2, 'AlphaData', ~isnan((ones(2, 55).*pcolor_data_21_7')'))

% figure(3)
% hold on
% subplot(1, 2, 1)
% s = pcolor(transect_distance, 1 : 55, pcolor_data_sorted');
% set(s, 'AlphaData', ~isnan(pcolor_data_sorted'))
% set(gca, 'YDir', 'reverse')
% caxis([min(min(pcolor_data_sorted)) max(max(pcolor_data_sorted))])
% colormap jet
% xlabel('Distance roughly SW from 50.31 N, 4.14 W [km]')
% ylabel('Depth [m]')
% text(1, 50, 'June 10')
% caxis([34.5 35.2])
% subplot(1, 2, 2)
% s2 = pcolor(1 : 2, 1 : 55, (ones(2, 55).*pcolor_data_21_7')');
% colormap jet
% caxis([34.5 35.2])
% set(gca, 'YDir', 'reverse')
% set(gca, 'YTick', [])
% xticks([1.5])
% xticklabels({round(distance_21_7, 1)})
% h = colorbar;
% ylabel(h, 'Absolute Temperature [PSU]')
% text(1, 50, 'July 21')
% set(s2, 'AlphaData', ~isnan((ones(2, 55).*pcolor_data_21_7')'))

% Note: 1.5 : 55.5 is for N2 only; others should be 1 : 55
% Also add 'binned' back for others