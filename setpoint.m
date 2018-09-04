function setpoint(m)

%amp scale factor
amp=2040;
%normalization to 2^16
norm=1;

%offset is always zero

%sincav 

sin_tab = amp*norm*sin(2*pi/6+(0:1024)*2*pi/3);
cos_tab = amp*norm*cos(2*pi/6+(0:1024)*2*pi/3);

%m.write('APP0','AREA_SP_I',cos_tab);
%m.write('APP0','AREA_SP_Q',sin_tab);

m.write('APP0','AREA_SP_I',1000);
m.write('APP0','AREA_SP_Q',1000);

