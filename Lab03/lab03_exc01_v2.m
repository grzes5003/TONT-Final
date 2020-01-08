function [b] = lab03_exc01_v2(A,b)
    [N, M] = size(A);
    for i=1:N
        temp = A(i,i); % Kolejne elementy diagonalne
        A(i,1:N) = A(i,1:N)/temp; % Dzielimy elementy ka�dego wiersza macierzy A przez element diagonalny
        b(i,1) = b(i,1)/temp; % Dzielimy elementy macierzy b przez element diagonalny
        for j=1:N
            temp = A(j,i); % Kolejne elementy w wierszu nale�y wyzerowa�
            if j~=i % Gdy jeste�my poza diagonal�
                A(j,1:N) = A(j,1:N) - temp*A(i,1:N); % Zeruj element w macierzy A
                b(j,1) = b(j,1) - temp*b(i,1); % Zaktualizuj element w macierzy b
            end
        end
    end
end

