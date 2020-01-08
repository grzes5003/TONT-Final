function acceleration = differ_acc(record)
%DIFFER_ACC Summary of this function goes here
%   Detailed explanation goes here
    acceleration = (record(1,2) - record(2,2))/(record(1,1) - record(2,1));
end

