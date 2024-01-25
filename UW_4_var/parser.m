clc; clear; format long
filetext = fileread('mpi_192-out.24448588');
%filetext = fileread('test.out');
original_var = 29789694*500/499;
original_trace = 155264207.663641+1i*221.514461;
expr = 'trace: \d*.\d*';
expr_ima = '[-+]?\d+\.\d+,';
expr_counter = '\[\d+';

matches = regexp(filetext,expr,'match');
matches_ima = strrep(regexp(filetext,expr_ima,'match'), '+', '');
matches_counter = strrep(regexp(filetext,expr_counter,'match'), '[','');

%casting to double
complete = 1;
siz = size(matches);

if(complete == 1)
    entries = str2double(erase(matches, 'trace: ')) + 1i * str2double(matches_ima);
else
    entries = str2double(erase(matches,'trace: '));

end
counter = int64(str2double(matches_counter));

% Find indices where counter is equal to 1
op_counter = find(counter == 1);

nr_op=size(op_counter,2);
sample_size = 1;
global_counter = 1;
for op=2:nr_op
    avd = counter(sample_size:op_counter(op)-1);
    sample_size = op_counter(op)-op_counter(op-1);
    fprintf('sample_size \t%d\n',sample_size);

    acc_trace = entries(global_counter:sample_size+global_counter)';
    individual_samples = zeros(1,sample_size)';

    %---------We go from acc_traces to traces from hutchinson
    for n = 1:sample_size
        individual_samples(n) = n * acc_trace(n) - sum(individual_samples(1:n-1));
    global_counter= global_counter+1;
    end

    %---------Compute Trace and Variance
    tr = mean(individual_samples);
    var_MATLAB = var(individual_samples);
    if(op==2)
        disp('relative_error for Trace')
        disp((original_trace-tr)/original_trace)

        disp('relative_error for Variance')
        disp((original_var-var_MATLAB)/original_var)

        %disp('original_var')
        %disp(original_var)

        %disp('MATLAB_var')
        %disp(var_MATLAB)

    end

    [v,dv,ddv]=get_variance(individual_samples);
    interv = [v - dv, v + dv]


    %with fourth moments:
    var_MATLAB = var(individual_samples);
    fourth_moment = sum(abs( individual_samples - tr ).^4)/(sample_size);
    fourth_moment_f = 2* var(individual_samples)*var(individual_samples)/(sample_size-1);
    st= sqrt(fourth_moment);
    st_f= sqrt(fourth_moment_f);
    inter_four = [var_MATLAB - st/sqrt(sample_size), var_MATLAB + st/sqrt(sample_size)]



    fprintf("Operator %d completed\n",op)
end
display("end")



