clear all
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["rawX", "rawY", "rawZ", "timestampsensorType", "Var5"];
opts.SelectedVariableNames = ["rawX", "rawY", "rawZ", "timestampsensorType"];
opts.VariableTypes = ["double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var5", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var5", "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["rawX", "rawY", "rawZ"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["rawX", "rawY", "rawZ"], "ThousandsSeparator", ",");

% Import the data
accellogs = readtable("accel_logs.csv", opts);

clear opts

%%

velocity = trap([], @integral, table2array(accellogs));

figure(1)
plot(table2array(accellogs(1:end-3,4))', velocity')


%%

function out = integral(x, y, z, t)
    % out = [sum(x*m'),sum(y*m'),sum(z*m')].*(t(1,3)-t(1,1));
    % out = arrayfun( @(n) sum(n*[1/2,1,1/2]'), [x,y,z].*(t(3,1)-t(1,1)) );
    
    out = [ sum( (x.*(t(3,1)-t(1,1)))' *[1/2,1,1/2]'), sum( (y.*(t(3,1)-t(1,1)))' *[1/2,1,1/2]'), sum( (z.*(t(3,1)-t(1,1)))'*[1/2,1,1/2]') ];
end

function out = integral_p(xyz, t)
    % out = [sum(x*m'),sum(y*m'),sum(z*m')].*(t(1,3)-t(1,1));
    out = arrayfun( @(n) sum(n*[1/2,1,1/2]'), xyz.*(t(3,1)-t(1,1)) );
    % out = [ xyz.*(t(3,1)-t(1,1) ]
end

function out = trap(out, funct, in)
    if size(in, 1) == 3; return; end
    out = [ out; funct( in(1:3,1), in(1:3,2), in(1:3,3), in(1:3,4)); trap(out, funct, in(2:end,:)) ];
end
