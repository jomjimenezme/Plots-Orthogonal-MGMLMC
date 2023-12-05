function [l, E250, E250_Def, J501, J501_Def, CoarE250, CoarJ501] = gather_data()
%levels
l= [1, 2, 3];%, 4];
% Data for E250
ME250 = [182, 19, 3];%, 389];
FE250 = [15, 20, 94];%, 386];
OE250 = [104, 12, 6];%, 386];
CoarE250 = 285000000;
%Deflation
E250_Def = [446, 396, 338];
E250N_Def = [32, 64, 128];
% Create a cell array to store the data for each operator
E250 = {ME250, FE250, OE250};


% Data for J501
MJ501 = [42, 8, 3 ];%,7];
FJ501 = [2, 0.8, 0.6];%,6];
OJ501 = [28, 3, 1];% 6];
J501 = {MJ501, FJ501, OJ501};
CoarJ501= 7000000;
%Deflation
J501_Def = [51, 50, 47];
J501N_Def = [32, 64, 128];

for i = 1:numel(E250)
    E250{i} = E250{i} * 1E6;
    J501{i} = J501{i} * 1E6;
end
E250_Def = E250_Def*1E6;
J501_Def = J501_Def*1E6;
end