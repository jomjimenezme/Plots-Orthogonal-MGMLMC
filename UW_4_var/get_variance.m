%%
%  Usage : [v,dv,ddv]=get_variance(randn(1000,1));
%
%  Calculate the variance of the data array Nx1
%   error is giving by "dv"
%  
%
%%
function[v,dv,ddv]=get_variance(data)
%[v,dv,ddv]=UWerr([data.^2 data],0,[],1,@vars);
[v,dv,ddv]=UWerr([conj(data).*data data],0,[],1,@vars2);
end


function[y]=vars(x)
y=x(1)-x(2)^2;
end


function[y]=vars2(a)
y=a(1)-a(2)'*a(2);
end