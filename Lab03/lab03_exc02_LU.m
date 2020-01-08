function [m_x] = lab03_exc02_LU(m_A,m_b)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [N, M]= size(m_A);
    m_L = eye(N);
    
    m_U = uper(m_A,m_L);
    m_L = lower(m_A,m_U);
    
    % m_y = m_L\m_b;
    % m_x = m_U\m_y;
    
    % solve Ly=b
    %m_y = zeros(N,1);
    m_y(1) = m_b(1);
    for i = 2:N
        m_y(i) = m_b(i);
        for j = 1:i-1
             m_y(i) = m_y(i) - m_L(i,j) * m_y(j);
        end
    end
    
    % solve Ux=y
    %m_x = zeros(N,1);
    m_x(N) = m_y(N)/m_U(N,N);
    for i = N-1:1
        m_x(i) = m_y(i);
        for j = i+1:N
            m_x(i) = m_x(i) - m_U(i,j)*m_x(j);
        end
        m_x(i) = m_x(i)/m_U(i,i);
    end
end

function [m_U] = uper(m_A,m_L)
    [N, M]= size(m_A);
    for i=1:N
        for j=i:N
            m_U(i,j)=m_A(i,j);
            for k=1:(i-1)
                m_U(i,j)=m_U(i,j)-m_L(i,k)*m_U(k,j);
            end
        end
    end
end

function [m_L] = lower(m_A,m_U)
    [N, M]= size(m_A);
    for i=1:N
        for j=i+1:N
            m_L(j,i)=m_A(j,i);
            for k=1:(i-1)
                m_L(j,i)=m_L(j,i)-m_L(j,k)*m_U(k,i);
            end
            m_L(j,i)=m_L(j,i)/m_U(i,i);
        end
    end
end