clc; clear all; close all;
[l, E250, E250_Def, J501, J501_Def, CoarE250, CoarJ501] = gather_data();
%--------------------------------------------------------------------------
% colors for lines
colors = ['b', 'r', 'g']; 
markers = {'o-', '^-', 's-'}; % Marker styles 




% Plotting E250 
figure;
hold on;

for i = 1:length(E250)
    plot(l, E250{i}, markers{i}, 'Color', colors(i), 'LineWidth', 1.5);
end

% Add line at for deflation comparison
yline(E250_Def(3), '--','LineWidth',2.0);
yline(CoarE250, '--','color', [0.3010 0.7450 0.9330], 'LineWidth',2.0);


hold off;
xlabel('l');
ylabel('Estimated variance');
title('E250 configuration');
legend('M_l', 'F_l', 'O_l', 'Inexact deflation', 'A^{-1}_L');

% to show only 1, 2, 3, 4
xlim([1, 3]);
xticks([1, 2, 3]);





% colors for lines
colors_J501 = colors; 
markers_J501 = markers; 

% Plotting J501 
figure;
hold on;

for i = 1:length(J501)
    plot(l, J501{i}, markers_J501{i}, 'Color', colors_J501(i), 'LineWidth', 1.5);
end

% Add line for deflation comparison
yline(J501_Def(3), '--', 'LineWidth',2.0);
yline(CoarJ501, '--', 'color', [0.3010 0.7450 0.9330], 'LineWidth',2.0);

hold off;
xlabel('l');
ylabel('Estimated variance');
title('J501 configuration');
legend('M_l', 'F_l', 'O_l', 'Inexact deflation', 'A^{-1}_L');

% to show only 1, 2, 3, 4 on x-axis
xlim([1, 3]);
xticks([1, 2, 3]);

