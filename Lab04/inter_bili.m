function out = inter_bili(in, Xi, Yi, N)
%INTER_BILI Summary of this function goes here
%   Detailed explanation goes here

    for i=1:N
        for j=1:N
            if (Xi(i,j)>=1 & Yi(i,j)>=1 & Xi(i,j)<=200 & Yi(i,j)<=200) % Rozmiary obrazka
                % brightness os neigbours
                Q12 = in(i-1,j-1);
                Q11 = in(i+1, j-1);
                Q22 = in(i-1, j+1);
                Q21 = in(i+1, j+1);
                
                P = Q12 * 
            else
                out(i,j)=255; % Pozostaw kolor biały tam, gdzie poza zakresem
            end
        end
    end
end

% Q11(i,j)= ( in (floor(Xi(i,j)), floor(Yi(i,j))) ) * ( ceil(Xi(i,j))-Xi(i,j) ) * ( ceil(Yi(i,j))-Yi(i,j) );


