function pi_controller(m,P_gain_I,P_gain_Q,I_gain_I,I_gain_Q)

m.write('APP0','WORD_CNTRL_I_LIMIT',2^18-1);
m.write('APP0','WORD_CNTRL_Q_LIMIT',2^18-1);

m.write('DWC8VM10','WORD_ADC_RD_ENA',1); pause(0.0001);
%when BIT_DAC_MEM_ENA=0, the DAC uses the I, Q data from the control master
m.write('APP0','BIT_DAC_MEM_ENA',0); pause(0.0001);
%bit 1st-8th are used for the selection of the attenuator for Down converter 1-8 and the 9th bit is used for the VM, the 10th is used for the DAC
m.write('DWC8VM10','WORD_ATT_SEL',256); pause(0.0001);

m.write('APP0','BIT_FB_ENA',1); pause(0.0001);
m.write('APP0','WORD_GC_I',P_gain_I); pause(0.0001);
m.write('APP0','WORD_GC_Q',P_gain_Q); pause(0.0001);
m.write('APP0','WORD_GI_I',I_gain_I); pause(0.0001);
m.write('APP0','WORD_GI_Q',I_gain_Q); pause(0.0001);
