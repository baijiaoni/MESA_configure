function sc_sis8300l_init(m, clksrc)

  % Check Parameter
  if (nargin < 1)
    error('Not enough input arguments.')
  end  

  if ~isa(m, 'mtca4u')
    error('First argument has to be a mtca4u class object.')
  end

  if (nargin < 2)
      clock = 1;
  end
  
  
  % clksrc - front or RTM
  if (nargin >= 2) && (strcmpi(clksrc,'rtm'))
      clock = 0;
  end
  
  m.write('BOARD0','WORD_RESET_N', 0); pause(0.0001);
  
  m.write('BOARD0','WORD_CLK_SEL', 0); pause(0.0001);
  m.write('BOARD0','WORD_CLK_RST', 1); pause(0.0001);
  m.write('BOARD0','WORD_CLK_RST', 0); pause(0.0001);

  % Clock configuration
  m.write('BOARD0','AREA_SPI_DIV', clock, hex2dec('45')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('43'), hex2dec('0A')); pause(0.0001);

  m.write('BOARD0','AREA_SPI_DIV', hex2dec('0C'), hex2dec('3C')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('0C'), hex2dec('3D')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('0C'), hex2dec('3E')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('0C'), hex2dec('3F')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('02'), hex2dec('40')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('02'), hex2dec('41')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('02'), hex2dec('42')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('02'), hex2dec('43')); pause(0.0001);

  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('49')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('4B')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('4D')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('4F')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('51')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('53')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('55')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('80'), hex2dec('57')); pause(0.0001);

%  m.write('BOARD0','AREA_SPI_DIV', hex2dec('81'), hex2dec('5A')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_DIV', hex2dec('01'), hex2dec('5A')); pause(0.0001);

%  m.write('BOARD0','WORD_CLK_MUX', [0, 0, 3, 3]); pause(0.0001);
  m.write('BOARD0','WORD_CLK_MUX', [3, 3, 0, 0]); pause(0.0001);
  m.write('BOARD0','WORD_CLK_SEL', 1);


  % ADC initialization
  m.write('BOARD0','AREA_SPI_ADC', hex2dec('3C'), hex2dec('00')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_ADC', hex2dec('41'), hex2dec('14')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_ADC', hex2dec('00'), hex2dec('0D')); pause(0.0001);
  m.write('BOARD0','AREA_SPI_ADC', hex2dec('01'), hex2dec('FF')); pause(0.0001);
  m.write('BOARD0','WORD_ADC_ENA', 0); pause(0.0001);
  m.write('BOARD0','WORD_ADC_ENA', 1); pause(0.0001);

  m.write('BOARD0','WORD_MLVDS_OE', 96); pause(0.0001);%x2timer mlvds lines emulation
  m.write('BOARD0','WORD_MLVDS_O', 96); pause(0.0001);%x2timer mlvds lines emulation

  m.write('BOARD0','WORD_RESET_N', 1); pause(0.0001);
  
  m.write('BOARD0','WORD_RESET_N', 1); pause(0.0001);
	
  
  % Extra initialization
  SIS8300L_extra_init(m);
end

function SIS8300L_extra_init(m)

% timing			     %1Hz            %16kHz %16kHz %16*9kHz
  m.write('APP0','WORD_TIMING_FREQ',[81250000 8 8 8 8 4958 4958 550])
  m.write('APP0','WORD_TIMING_TRG_SEL',0);
  m.write('APP0','WORD_TIMING_INT_ENA',hex2dec('F1'));%F0 for external trigger

% DAQ
  m.write('APP0','WORD_DAQ_ENABLE',3);
  m.write('APP0','WORD_DAQ_MUX',1,1);

% IQ
sisl_sincos(m);

% ATTN
sisl_set_att(m, bin2dec('11111111'),32);
sisl_set_att(m, bin2dec('100000000'),40);

%CTRL tables init
sisl_ctrl_tables_fill(m, 0);


%VM arb. waveform
m.write('APP0','AREA_DAC_I_MEM',ones(64,1)* 2^15-1);
m.write('APP0','AREA_DAC_Q_MEM',ones(64,1)* 2^15-1);
m.write('BOARD0','WORD_DAC_ENA',1);
m.write('APP0','BIT_DAC_MEM_ENA',0);
m.write('APP0','WORD_FD_AMP_LIMIT_DISABLE',255);
m.write('APP0','WORD_OUT_AMP_LIMIT_ENA',0);
m.write('APP0','WORD_VS_CHAN_ENA', 1);
m.write('APP0','WORD_OUT_ROT_RE',131071);
m.write('APP0','WORD_VS_ROT_RE',131071);
m.write('APP0','WORD_CNTRL_I_LIMIT',131071);
m.write('APP0','WORD_CNTRL_Q_LIMIT',131071);
m.write('APP0','WORD_PROT_ENA_N',1);
m.write('APP0','BIT_FF_ENA',0);
m.write('APP0','BIT_FB_ENA',0);


% RTM init
m.write('DWC8VM10', 'WORD_INTERLOCK', 3);%only with x2timer setup
m.write('DWC8VM10', 'WORD_INTERLOCK', 1);%only without x2timer setup

dwcvm_cm(m);

end

