clear all

%% import 

opts = delimitedTextImportOptions("NumVariables", 5);

opts.DataLines = [1, Inf];
opts.Delimiter = ";";

opts.VariableNames = ["time", "szerokosc", "dlugosc", "wysokosc", "dokladnosc"];
opts.VariableTypes = ["double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

pozycje = readtable("pozycje.txt", opts);

pozycje = table2array(pozycje);
clear opts

%%  answ
out = [];
out2 = [];

% tab with all velocities
out = [ velo(out, pozycje) ; pozycje(1:end-1,1)' ] ;
mean(out(1,:))
out2 = acce(out2, out);
mean(out2)

dist = out_distance(0,pozycje);

figure(1)
plot(out2,pozycje(1:end-2,1)')

%% functions

function out = velo(out_, in)
    if size(in,1) == 1
        out = out_;
        return
    end
    out = [ out_, differ( [ in(1,:) ; in(2,:) ] ), velo(out_, in(2:end,:) ) ];
end

function out = acce(out_, in)
    if size(in,2) == 1
        out = out_;
        return
    end
    out = [ out_, (in(1,2) - in(1,1))/(in(2,2) - in(2,1)), acce(out_, in(:,2:end) ) ];
end

function out = out_distance(out_, in)
    if size(in,1) == 1
        out = out_;
        return
    end
    out = out_ + distance( [ in(1,:) ; in(2,:) ] ) + out_distance(out_, in(2:end,:));
end
