function velocity = differ(record) % input: 
%DIFF Summary of this function goes here
%   Detailed explanation goes here
    % do biegunowych 
    R = 6371000;
    
    s1 = [ record(1,2) record(1,3) ].*(pi/180);
    s2 = [ record(2,2) record(2,3) ].*(pi/180);
    
    s1 = [ s1 record(1,4) ];
    s2 = [ s2 record(1,4) ];
    
    xyz1 = [ R*cos(s1(1,1))*cos(s1(1,2)) R*cos(s1(1,1))*sin(s1(1,2)) R*sin(s1(1,1)) ];
    xyz2 = [ R*cos(s2(1,1))*cos(s2(1,2)) R*cos(s2(1,1))*sin(s2(1,2)) R*sin(s2(1,1)) ]; 
    
    % leng = sqrt( (record(1,2)-record(2,2))^2 + (record(1,3)-record(2,3))^2 + (record(1,4)-record(2,4))^2 );
    % velocity = distance( xyz1(1,1), xyz2(1,1), xyz1(1,2), xyz2(1,2), xyz1(1,3), xyz2(1,3) )/abs(record(1,1)-record(2,1));
    velocity = sqrt((xyz1 - xyz2)*(xyz1 - xyz2)')/abs(record(1,1)-record(2,1));
end

