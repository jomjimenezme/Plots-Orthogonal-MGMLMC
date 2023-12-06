clear all; close all;clc;
% Your data
[tunning_non_deflated,tunning_deflated] = tunning_data();


% Extract T values
N_tv = [36, 32, 28, 24];

% Extract S values
N_s = [10, 8, 6];

% Plotting each method
methods = {'Full', 'Orthogonal', 'Oblique'};
markers = {'o-', '*-', 'diamond-'}; % Marker styles 
colors = ['b', 'r', 'g']; 

%lims = {[0 18], [1.2 1.6],  [2 16]};
lims = {[0 25], [0 2.5],  [0 25]};

figure;
for i = 1:3
    
    subplot(1, 3, i);
    hold on;
    
    for j = 1:length(N_s)
        plot(N_tv, tunning_non_deflated((j-1)*4+1:j*4, i), markers{j}, 'DisplayName',...
        strcat('N_{s}=', num2str(N_s(j))),...
        'MarkerSize', 8, 'Color', colors(j),'LineWidth', 2.0);
    end
    
    hold off;
    ylim(1E6.*lims{i});
    title(sprintf('%s Operator', methods{i}));
    xlabel('N_{tv}');
    ylabel('Variance');
    legend;
    grid on;
end

% Adding a main title to the entire figure
bigTitle = sgtitle('Variance for Different Operators at Finest level');
set(bigTitle, 'FontSize', 14, 'FontWeight', 'bold'); % Adjust title properties as needed




lims = {[0.1 0.25],[1 2.5],[1 2.5]}% [0 18],  [0 18]};
figure;
for i = 1:3
    
    subplot(1, 3, i);
    hold on;
    
    for j = 1:length(N_s)
        plot(N_tv, tunning_deflated((j-1)*4+1:j*4, i), markers{j}, 'DisplayName',...
        strcat('N_{s}=', num2str(N_s(j))),...
        'MarkerSize', 8, 'Color', colors(j),'LineWidth', 2.0);
    end
    
    hold off;
    title(sprintf('%s Operator', methods{i}));
    xlabel('N_{tv}');
    ylabel('Variance');
    ylim(1E6.*lims{i})
    legend;
    grid on;
end

% Adding a main title to the entire figure
bigTitle = sgtitle('Variance for DEFLATED Different Operators at Finest level');
set(bigTitle, 'FontSize', 14, 'FontWeight', 'bold'); % Adjust title properties as needed

