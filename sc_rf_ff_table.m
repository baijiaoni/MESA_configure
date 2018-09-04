function sc_rf_ff_table(m, val)

	%FF IQ table update masks
	maskwr = bin2dec('1111111100');
	maskrd = bin2dec('1111111111');

	m.write('APP0', 'BIT_CTL_TABLES_BUF', maskwr);
	m.write('APP0','AREA_FF_I',ones(16384,1)' * val);
	m.write('APP0','AREA_FF_Q',ones(16384,1)' * val);
	m.write('APP0','BIT_CTL_TABLES_BUF', maskrd);
end
