clc; clear;
% Read the contents of the output.txt file
fileID = fopen('Full_rank.txt', 'r');
fileContent = fscanf(fileID, '%c');
fclose(fileID);
% Split the entries based on the counter going back to 1
entries = strsplit(fileContent, '[');
for i = 2:length(entries)
    % add '[' at the beginning
    entries{i} = ['[' entries{i}];
    disp(entries{i});
end




expr = 'trace: \d*.\d*';
expr_ima = '[-+]?\d+\.\d+,';
matches = regexp(entries,expr,'match');
matches_ima = regexp(entries,expr_ima,'match');
matches_ima = strrep(matches_ima, '+', '');



siz =size(entries);
for j =2:siz(2)
        traces(j) = str2double(erase(entries{j},'trace: ')) ...
            +1i*str2double(entries{j});
end