% https://en.wikipedia.org/wiki/Moment_matrix
% https://en.wikipedia.org/wiki/Ordinary_least_squares

close all
clear all
i1=imread('../Krata1.jpg');
i1g=double(rgb2gray(i1));
[sx, sy]=size(i1g);
cx=sx/2; cy=sy/2;

% wyszukanie przeci�� linii
wzorzec=[
    0 0 0 1 1 1 0 0 0
    0 0 0 1 1 1 0 0 0
    0 0 0 1 1 1 0 0 0
    1 1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1 1
    0 0 0 1 1 1 0 0 0
    0 0 0 1 1 1 0 0 0
    0 0 0 1 1 1 0 0 0];

ic=normxcorr2(wzorzec,i1g);
ig=ic<-0.7;
ig=bwmorph(ig,'shrink',Inf);
[ix,iy]=find(ig>0); % wsp�rz�dne przeci�� linii
r=sqrt((ix-cx).^2+(iy-cy).^2); % promie� do �rodka obrazu
[rs,i]=sort(r);
% ustalenie punkt�w odniesienia (siatki regularnej)
x0=ix(i(1)); y0=iy(i(1));
dx=abs(ix(i(1))-ix(i(4)))-1;
dy=abs(iy(i(1))-iy(i(4)))-3;
jx=x0+dx*[-4:1:5];
jy=y0+dy*[-6:1:7];
[jX, jY]=meshgrid(jx,jy);
jx=jX'; jx=jx(:); % wsp�rz�dne przeci�� linii dla obrazu wzorcowego
jy=jY'; jy=jy(:);

rm=sqrt((jx-cx).^2+(jy-cy).^2); % promie� do �rodka obrazu
[rms,j]=sort(rm);
imshow(ig), hold on
plot(cy,cx,'r+') % punkt centralny
plot(jY,jX,'bo') % punkty odniesienia
% identyfikacja modelu algorytmem LS
% rs % target
% rms % 
A = reg(rs,rms);
A = A(2:end);
A2 = regresja(rs, rms);
% figure, plot(rms,rs,'b.', rms,R(2:end)','g-', [0 3e2],[0 3e2],'r-')
% prostowanie obrazka
xx=1:sx;
yy=1:sy;
[XX,YY]=meshgrid(xx,yy);
RR=sqrt((XX-cx).^2+(YY-cy).^2);
RRr=RR*A(1)+RR.^2*A(2)+RR.^3*A(3);
RRu=RRr./RR;
i1r=interp2(i1g,(YY-cy).*RRu+cy,(XX-cx).*RRu+cx);
figure,
subplot(2,1,1),imagesc(i1g)
subplot(2,1,2),imagesc(i1r)
colormap gray


function a = reg(r, rm) % format out[ a1 a2 a3 ] in[x y]
    X = [];
    R = r;
    for i=1:length(r)
        x = [ 1 r(i) r(i)^2 r(i)^3 ];
        X = [ X ; x ];
    end
    r = X;
    % XtX
    % stopien 3 wiec k do 3
    % deb_XtX = gram(X,'o');
    XtX(1,1) = 3;
    for k=2:4
        for i=2:4
            XtX(i,k) = sum(r(:,k).*r(:,i));
        end
        XtX(k,1) = sum(r(:,k));
        XtX(1,k) = sum(r(:,k));
    end
    
    Xty(1,1) = sum(rm(:,1));
    for k=1:3
        Xty(k+1,1) = sum(r(:,k).*rm(:,1));
    end
    
    a = inv(XtX)*Xty;
    
    
    figure(10)
    scatter(rm,R,5,'filled')
    hold on
    plot(R, R*a(2)+R.^2*a(3)+R.^3*a(4))
end

function a = regresja(r, rm)
    X = [ ones(length(r),1) r r.^2 r.^3 ];
    a = inv(X * X')*(X*rm');
end
%     XtX = zeros(length(r),4);
%     for k=2:4
%         for i=1:length(r)
%             if k > 1
%                 XtX(i,k) = sum(r(:,k).^(k+i-1));
%             end
%             
%         end
%     end