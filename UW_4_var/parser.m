clc; clear;
filetext = fileread('mpi_192-out.24448588');
%filetext = fileread('test.out');
original_var = 29789694*500/499;
original_trace = 155264207.663641+i*221.514461;
expr = 'trace: \d*.\d*';
expr_ima = '[-+]?\d+\.\d+,';
matches = regexp(filetext,expr,'match');
matches_ima = regexp(filetext,expr_ima,'match');
matches_ima = strrep(matches_ima, '+', '');

%casting to double
complete = 0;
siz = size(matches);

if(complete==1)
    for j =1:siz(2)
        traces(j) = str2double(erase(matches{j},'trace: ')) ...
            +1i*str2double(matches_ima{j});
    end
else
    
    for j =1:siz(2)
        traces(j) = str2double(erase(matches{j},'trace: '));
    end
end

%-----------Taking the first 500 values
acc_trace = traces(1:499)';
acc_trace = [traces(1); acc_trace]; %accounts for first sample
sample_size = length(acc_trace);
individual_samples = zeros(1,sample_size)';

%---------We go from acc_traces to traces from hutchinson
for n = 1:sample_size
    individual_samples(n) = n * acc_trace(n) - sum(individual_samples(1:n-1));
end

var(individual_samples)

jackknife_means = zeros(1, sample_size);

for j = 1:sample_size
    data_leave_one_out = individual_samples([1:j-1, j+1:end]);
   
    jackknife_means(j) = mean(data_leave_one_out);
end


jackknife_var_of_variance = ( (sample_size-1) / sample_size ) * var(jackknife_means)*sample_size;




st= sqrt(jackknife_var_of_variance);
int_jack = [original_var - st/sqrt(sample_size), original_var + st/sqrt(sample_size)]










%---------Compute Trace and Variance
tr = mean(individual_samples);


var_MATLAB = var(individual_samples);
fourth_moment = sum(abs( individual_samples - tr ).^4)/(sample_size);



%fourth_moment = ((sample_size-1)/sample_size) *2*var(individual_samples)*var(individual_samples)/sample_size
fourth_moment_f = 2* var(individual_samples)*var(individual_samples)/(sample_size-1);

st= sqrt(fourth_moment)
st_f= sqrt(fourth_moment_f)
format long
int = [var_MATLAB - st/sqrt(sample_size), var_MATLAB + st/sqrt(sample_size)];




%[v,dv,ddv]=get_variance(individual_samples);

disp('relative_error for Trace')
disp((original_trace-tr)/original_trace)

disp('relative_error for Variance')
disp((original_var-var_MATLAB)/original_var)

disp('original_var')
disp(original_var)

disp('MATLAB_var')
disp(var_MATLAB)

%disp('Jack-knife Var')
%disp(v)



%%
a=rand(100000000,1);
me= mean(a);
va = var(a);
va_va= var(var(a));
[v,dv,ddv]=get_variance(a);