function sisl_set_att( m, maskExt, valExt)
%SISL_SET_ATT Summary of this function goes here
%   Detailed explanation goes here

mask = bin2dec('111111111'); 
val = 32;
    
if nargin == 3 
    mask = maskExt;
    val = valExt;
end

 m.write('DWC8VM10','WORD_ATT_SEL',mask);pause(0.1) ;
 m.write('DWC8VM10','WORD_ATT_VAL',val);pause(0.1) ;

end

