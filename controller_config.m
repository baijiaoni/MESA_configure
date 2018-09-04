function controller_config(m)

m.write('APP0','AREA_SP_Q',zeros(16384,1));
m.write('APP0','BIT_FF_ENA',0);
m.write('APP0','BIT_FF_CORR_ENA',0);
m.write('APP0','BIT_SP_CORR_ENA',0);
m.write('APP0','BIT_FB_ENA',1); %works only for proportional
m.write('APP0','WORD_Q_SIGN', 0);
m.write('APP0','WORD_OUT_ROT_RE',0);
m.write('APP0','WORD_OUT_ROT_IM',0);
m.write('APP0','WORD_VS_ROT_RE',0);
m.write('APP0','WORD_VS_ROT_IM',0);
m.write('APP0','WORD_DAC_OFFSET',0);
m.write('APP0','WORD_DAC_OFFSET',0);
m.write('APP0','WORD_DAC_ENA',1);
m.write('APP0','WORD_GAIN_CORR',0);
m.write('APP0','WORD_OUT_AMP_LIMIT',2^18-1);
m.write('APP0','WORD_CNTRL_I_LIMIT',2^18-1);
m.write('APP0','WORD_CNTRL_Q_LIMIT',2^18-1);
m.write('APP0','WORD_MIMO_ENA',0);
m.write('APP0','WORD_MIMO_COEF_VALID',0);
m.write('APP0','WORD_OUT_AMP_LIMIT_ENA',0);
% I gain
m.write('APP0','WORD_GC_I',0);
m.write('APP0','WORD_GC_Q',0); 
% P gain
m.write('APP0','AREA_GP_I',ones(16384,1));
m.write('APP0','AREA_GP_Q',ones(16384,1));


end

