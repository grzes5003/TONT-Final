function dxyz = calc_dxyz( lat, lon, hei )

R = 6371*1000;                % promieñ Ziemi: km --> m
if(0)
   Np = length( lat );
   dxyz = zeros(Np-1,1);
   for k = 1 : Np-1
       a = sin( (lat(k+1)-lat(k))/2 ).^2 + cos(lat(k))*cos(lat(k+1))*sin( (lon(k+1)-lon(k))/2 ).^2;
       c = 2*atan2( sqrt(a),sqrt(1-a) );
       dxyz(k) = sqrt( (R * c)^2 + (hei(k+1)-hei(k))^2 );
   end
else
   a = sin( diff(lat)/2 ).^2 + cos(lat(1:end-1)).*cos(lat(2:end)).*sin( diff(lon)/2 ).^2;
   c = 2*atan2( sqrt(a),sqrt(1-a) );
   dxyz = sqrt( (R*c).^2 + diff(hei).^2 );
end

    
    
