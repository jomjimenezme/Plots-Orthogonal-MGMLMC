clear all; close all;clc;
width = 20;
height = 6;
size_font = 18;
size_line = 2.0;
% Your data
[tunning_non_deflated,tunning_deflated] = tunning_data();


% Extract T values
N_tv = [36, 32, 28, 24];

% Extract S values
N_s = [10, 8, 6];

% Plotting each method
methods = {'Full-Rank', 'Orthogonal', 'Oblique'};
markers = {'o-', '*-', 'diamond-'}; % Marker styles 
colors = ['b', 'r', 'g']; 

max_val = max([tunning_non_deflated(:); tunning_deflated(:)]);
min_val = min([tunning_non_deflated(:); tunning_deflated(:)]);

figure;
set(gcf, 'Units', 'inches', 'Position', [0, 0, width, height])
for i = 1:3
    set(gca, 'FontSize', size_font);
    subplot(1, 3, i);
    hold on;
    
    for j = 1:length(N_s)
        plot(N_tv, tunning_non_deflated((j-1)*4+1:j*4, i), markers{j}, 'DisplayName',...
        strcat('N_{s}=', num2str(N_s(j))),...
        'MarkerSize', 8, 'Color', colors(j),'LineWidth', size_line);
    end
    
    
    set(gca, 'YScale', 'log');  
    ylim([min_val, max_val]);    title(sprintf('%s Operator', methods{i}));
    xlabel('N_{tv}');
    ylabel('Estimated Variance');
    lgd = legend;
    grid on;
    set(gca, 'FontSize', size_font);
    hold off;
end

% Adding a main title to the entire figure
%bigTitle = sgtitle('Variance for Different Operators at Finest level');
%set(bigTitle, 'FontSize', size_font, 'FontWeight', 'bold'); % Adjust title properties as needed
saveas(gcf, 'non-deflated.png')



lims = {[0.1 0.25],[1 2.5],[1 2.5]}% [0 18],  [0 18]};
figure;
set(gcf, 'Units', 'inches', 'Position', [0, 0, width, height])
for i = 1:3
    
    subplot(1, 3, i);
    hold on;
    
    for j = 1:length(N_s)
        plot(N_tv, tunning_deflated((j-1)*4+1:j*4, i), markers{j}, 'DisplayName',...
        strcat('N_{s}=', num2str(N_s(j))),...
        'MarkerSize', 8, 'Color', colors(j),'LineWidth', size_line);
    end
    
    hold off;
    title(sprintf('%s Operator', methods{i}));
    xlabel('N_{tv}');
    ylabel('Estimated Variance');
    ylim(1E6.*lims{i})
    lgd = legend;
    if i==3
        lgd.Location = 'southeast';
    end
    grid on;
    set(gca, 'FontSize', size_font);
end

% Adding a main title to the entire figure
%bigTitle = sgtitle('Variance for DEFLATED Different Operators at Finest level');
%set(bigTitle, 'FontSize', size_font, 'FontWeight', 'bold'); % Adjust title properties as needed
saveas(gcf, 'Deflated.png')



pause(3)
close all;