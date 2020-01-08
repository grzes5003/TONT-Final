function [b] = lab03_exc01_gauss_v2(A,b)
    [N,] = size(A);
    
    for i=1:N
        temp = A(i,i); 
        A(i,1:N) = A(i,1:N)/temp; 
        b(i,1) = b(i,1)/temp; 
        for j=1:N
            temp = A(j,i); 
            if j~=i 
                A(j,1:N) = A(j,1:N) - temp*A(i,1:N); 
                b(j,1) = b(j,1) - temp*b(i,1); 
            end
        end
    end
end

function [m_Ab_prim] = pivot(m_Ab)
%pivot  Function possibly can crash
%       if row already switched is switched
%       one more time by other row
    [ N,  ] = size(m_Ab);
    
    % find possible exception
    for it = 1:N
        if m_Ab(it,it) == 0
            for n = 1:N
                if n == it
                    continue
                end
                
                if m_Ab(n,it) ~= 0
                   % swap row
                   tmp1 = m_Ab(n,:);
                   % not sure if working
                   m_Ab(it,:) = tmp1;
                   break
                end
                
                if n == N
                    % throw exception
                    ME = MException('Cant solve matrix with Gaussian method');
                    throw(ME)
                end
            end
        end
    end
    m_Ab_prim = m_Ab;
end

