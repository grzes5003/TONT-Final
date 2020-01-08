function out = inter_zero(in, Xi, Yi, N)
%INTER_ZERO Summary of this function goes here
%   Detailed explanation goes here
    out = zeros(N,N);

    for i=1:N
        for j=1:N
            if (Xi(i,j)>=1 & Yi(i,j)>=1 & Xi(i,j)<=200 & Yi(i,j)<=200)
                out(i,j) = in( round(Xi(i,j)), round(Yi(i,j)) ); % Przypisz najbliższe wartości
            else
                out(i,j)=255; % Pozostaw kolor biały tam, gdzie poza zakresem
            end
        end
    end
end

