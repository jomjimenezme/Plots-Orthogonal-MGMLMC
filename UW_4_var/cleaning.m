clc; clear;
% Read the contents of the output.txt file
fileID = fopen('Full_rank.txt', 'r');
fileContent = fscanf(fileID, '%c');
fclose(fileID);
% Split at the beggining with [
entries = strsplit(fileContent, '[');

for i = 2:length(entries)
    % add '[' at the beginning
    entries{i-1} = ['[' entries{i}];
    %disp(entries{i});
end

%get the accumulated traces only:
aux = sscanf(entries{1},'[%d, trace: %d.%d + %d');
acc_traces(1) =  aux(2);%+1i*aux(3);
j=2;

siz = size(entries);
for(l = 0:siz(2))
while (sscanf(entries{j+l},'[%d')~=1 )
    aux= sscanf(entries{j},'[%d, trace: %d.%d + %d');
    acc_traces(j,l+1) = aux(2);%+1i*aux(3);;
    j=j+1;
end
sleep(1);
end

%Get individual traces
sample_size = length(acc_traces);
individual_samples = zeros(1,sample_size)';

%---------We go from acc_traces to traces from hutchinson
for n = 1:sample_size
    individual_samples(n) = n * acc_traces(n) - sum(individual_samples(1:n-1));
end
