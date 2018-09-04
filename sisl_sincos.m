function sisl_sincos(m, offsetExt)

%amp scale factor
amp=1;
%normalization to 2^16
norm=2^16;

%offset is always zero

%sincav 
sin_tab = amp*norm*sin((0:23)*2*pi/3);
cos_tab = amp*norm*cos((0:23)*2*pi/3);

m.write('APP0','WORD_IQ_COS',cos_tab);
m.write('APP0','WORD_IQ_SIN',sin_tab);

%bypass filter
m.write('APP0','WORD_IIR_COEF0',65535,2);
m.write('APP0','WORD_IIR_COEF1',65535,2);
m.write('APP0','WORD_IIR_COEF2',65535,2);
m.write('APP0','WORD_IIR_COEF3',65535,2);
m.write('APP0','WORD_IIR_COEF4',65535,2);
m.write('APP0','WORD_IIR_COEF5',65535,2);
m.write('APP0','WORD_IIR_COEF6',65535,2);
m.write('APP0','WORD_IIR_COEF7',65535,2);
m.write('APP0','WORD_IIR_COEF8',65535,2);
m.write('APP0','WORD_IIR_COEF9',65535,2);

m.write('APP0','WORD_IIR_COEF_VALID',1);

