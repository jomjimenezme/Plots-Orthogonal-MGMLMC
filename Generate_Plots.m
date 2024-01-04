clc; clear all; close all;
width = 10;
height = 10;
size_font = 30;

[l, E250, E250_Def, J501, J501_Def, CoarE250, CoarJ501] = gather_data();
%--------------------------------------------------------------------------
% colors for lines
colors = ['b', 'r', 'g']; 
markers = {'o-', '^-', 's-'}; % Marker styles 




% Plotting E250 
figure;
set(gcf, 'Units', 'inches', 'Position', [0, 0, width, height])

hold on;

for i = 1:length(E250)
    plot(l, E250{i}, markers{i}, 'Color', colors(i), 'LineWidth', 1.5);
end

% Add line at for deflation comparison
yline(E250_Def(3), '--','LineWidth',2.0);
yline(CoarE250, '--','color', [0.3010 0.7450 0.9330], 'LineWidth',2.0);



title('E250 configuration');

xlabel('l');
ylabel('Estimated variance');
lgd=legend('M_l', 'F_l', 'O_l', 'Inexact deflation', 'A^{-1}_L');
lgd.Location = 'east';

% to show only 1, 2, 3, 4
xlim([1, 3]);
xticks([1, 2, 3]);
set(gca, 'FontSize', size_font);
hold off;
saveas(gcf, 'E250.png')





% colors for lines
colors_J501 = colors; 
markers_J501 = markers; 

% Plotting J501 
figure;
set(gcf, 'Units', 'inches', 'Position', [0, 0, width, height])

hold on;

for i = 1:length(J501)
    plot(l, J501{i}, markers_J501{i}, 'Color', colors_J501(i), 'LineWidth', 1.5);
end

% Add line for deflation comparison
yline(J501_Def(3), '--', 'LineWidth',2.0);
yline(CoarJ501, '--', 'color', [0.3010 0.7450 0.9330], 'LineWidth',2.0);


xlabel('l');
ylabel('Estimated variance');
title('J501 configuration');
lgd = legend('M_l', 'F_l', 'O_l', 'Inexact deflation', 'A^{-1}_L');
lgd.Location = 'east';

% to show only 1, 2, 3, 4 on x-axis
xlim([1, 3]);
xticks([1, 2, 3]);
set(gca, 'FontSize', size_font);
hold off;
saveas(gcf, 'J501.png')


pause(3);
close all;
