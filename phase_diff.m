function phase_diff(m,dsize,channelnr1,channelnr2,enplot )
%22.08.2018
%this function is used to calculate the phase difference between channelnr1 and channelnr2
%channelnr 1 channel 1
%           2 channel 2
%           3 channel 3
%           4 channel 4
%           5 channel 5 ...

 if nargin < 5
    enplot =   1;
 end

daqnr=1;
muxnr=1;
%dsize=64;
offset=daqnr*2^24; 
channels=8;
dataraw_tmp=zeros(channels*2,dsize/2);
s=0;
if daqnr==1
    m.write('APP0','WORD_DAQ_MUX',muxnr,1);
end

a = m.read_dma_raw('BOARD0', 'AREA_DMA', offset, dsize*channels,16);

for i=1:channels*2
	dataraw_tmp(i,:)=typecast(uint16(a(i:channels*2:end)),'int16');
end

dataraw(1,:)=dataraw_tmp((channelnr1-1)*2+1,:);
dataraw(2,:)=dataraw_tmp((channelnr2-1)*2+1,:);

if enplot==1
    subplot(1,3,1);
    phase1=dataraw(1,:)*360/(2^15*2*pi);
    plot(phase1);title(['phase of CH' num2str(channelnr1)]);
end

pause(0.1);

if enplot==1
    subplot(1,3,2);
    phase2=dataraw(2,:)*360/(2^15*2*pi);
    plot(phase2);title(['phase of CH' num2str(channelnr2)]);
end

pause(0.1);

subplot(1,3,3);
plot(abs(abs(phase2)-abs(phase1)));title(['phase diff between' num2str(channelnr1) 'and' num2str(channelnr2)]);

pause(0.1);

for j=1:dsize/2
    s = s+abs(abs(phase2(j))-abs(phase1(j)))/dsize*2;
end

sprintf('Average phase difference between channel %d and channel %d is %.2f degree', channelnr1, channelnr2, s)

end
