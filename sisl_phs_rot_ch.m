function sisl_phs_rot_ch(m, offset1,offset2,offset3, amp)

%amp scale factor

%normalization to 2^16
norm=2^16;

%offset is always zero
offset_array=zeros(1,24);
ch=1;
offset_array(ch*3-2)=offset1;
offset_array(ch*3-1)=offset1;
offset_array(ch*3)=offset1;

ch=2;
offset_array(ch*3-2)=offset2;
offset_array(ch*3-1)=offset2;
offset_array(ch*3)=offset2;

ch=3;
offset_array(ch*3-2)=offset3;
offset_array(ch*3-1)=offset3;
offset_array(ch*3)=offset3;

%sincav 
sin_tab = amp*norm*sin((0:23)*2*pi/3 + offset_array*pi/180);
cos_tab = amp*norm*cos((0:23)*2*pi/3 + offset_array*pi/180);

m.write('APP0','WORD_IQ_COS',cos_tab);
m.write('APP0','WORD_IQ_SIN',sin_tab);

end
