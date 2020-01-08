function [m_x] = lab03_exc01_gauss(m_A,m_b)
%lab03_exc01_gauss Do the gauss
    % TODO which is which
    [ N , M ] = size(m_A);
    m_Ab = [ m_A m_b ];
    
    % exception aii -eq 0
    pivot(m_Ab);
    
    for it = 1:N
        % divide row by akk
        m_Ab(it,:) = m_Ab(it,:)./m_Ab(it,it);
        for rest = it+1:M
            % subt rest rows
            m_Ab(rest,:) = m_Ab(rest,:) - ( m_Ab(it,:).*m_Ab(it,it) );
        end
    end
    % return last column of matrix
    m_x = m_Ab(:,M+1);
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
