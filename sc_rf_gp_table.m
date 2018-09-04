function sc_rf_gp_table(m, vali, valq)

	%GP IQ table update masks
	maskwr = bin2dec('0011111111');
	maskrd = bin2dec('1111111111');

	m.write('APP0', 'BIT_CTL_TABLES_BUF', maskwr);
	m.write('APP0','AREA_GP_I',ones(16384,1)' * vali);
	m.write('APP0','AREA_GP_Q',ones(16384,1)' * valq);
	m.write('APP0','BIT_CTL_TABLES_BUF', maskrd);

end
