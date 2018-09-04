function sc_rf_sp_table(m, val)

	%SP IQ table update masks
	maskwr = bin2dec('1110011111');
	maskrd = bin2dec('1111111111');

	m.write('APP0', 'BIT_CTL_TABLES_BUF', maskwr);
	m.write('APP0','AREA_SP_I',ones(16384,1)' * val);
	m.write('APP0','AREA_SP_Q',ones(16384,1)' * val);
	m.write('APP0','BIT_CTL_TABLES_BUF', maskrd);

end
