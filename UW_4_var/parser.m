clc; clear;
filetext = fileread('mpi_192-out.24448588');
expr = 'trace: \d*.\d*';
matches = regexp(filetext,expr,'match');


siz = size(matches);
for i =1:siz(2)
    traces(i) = str2double(erase(matches{i},'trace: '));
end


sample = traces(1:499)';
sample = [sample(1); sample];


n_samples = length(sample);
individual_samples = zeros(1,n_samples)';



% ------ Calculate individual sample values

for n = 1:n_samples
    individual_samples(n) = n * sample(n) - sum(individual_samples(1:n-1));
end


[v,dv,ddv]=get_variance(individual_samples)


%%
a=rand(100000000,1);
me= mean(a)
va = var(a)
va_va= var(var(a))
[v,dv,ddv]=get_variance(a)