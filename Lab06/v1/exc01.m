clear all
close all
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["year", "avr", "min", "max"];
opts.VariableTypes = ["double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable("../LoudnessWarNumbers.csv", opts);

year = tbl.year;
avr = tbl.avr;
max = tbl.max;
min = tbl.min;

clear opts tbl

%% plots


%% avr
[a1 b1] = regresion( [ year avr ] ); %#ok<NCOMMA>

figure(1)
scatter(year, avr)
hold on
plot(year, arrayfun( @(x) a1*x+b1 , [ year ] ) )

%% max
[a2 b2] = regresion( [ year max ] ); %#ok<NCOMMA>

figure(2)
scatter(year, max)
hold on
plot(year, arrayfun( @(x) a2*x+b2 , [ year ] ) )

%% min
[a3 b3] = regresion( [ year min ] ); %#ok<NCOMMA>

figure(3)
scatter(year, min)
hold on
plot(year, arrayfun( @(x) a3*x+b3 , [ year ] ) )

%% functions
function s = summ(in, s)
    if size(in,1) == 0
        return
    end
    s = summ(in(2:end,1), s + in(1,1));
end

function [ a b ] = regresion(in) %#ok<NCOMMA> % format [ x y ]
   N = size(in(:,1),1);
   a = ( summ(in(:,2).*in(:,1),0)/N - (summ(in(:,1),0)/N*summ(in(:,2),0)/N) ) / ( summ(in(:,1).^2,0)/N - (summ(in(:,1),0)/N)^2 );
   b = summ(in(:,2),0)/N - a*summ(in(:,1),0)/N;
end
