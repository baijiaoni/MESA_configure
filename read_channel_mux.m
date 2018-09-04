function dataraw=read_channel_mux(m,dsize,daqnr,muxnr,channelnr,enplot )
%******************************
% Input parameters:
% m = mtca4 board
% dsize = data size to read
% daqnr = DAQ number: 0 or 1 (see channels available at each DAQ below)
% muxnr = DAQ multiplexor number. It is not taken into account for DAQ0.
% 0,1 or 2 for DAQ1
% channelnr = 1: dataraw(1,:)<-channel 1 phase dataraw(2,:)<-amplitude  
%             3: dataraw(1,:)<-channel 2 phase dataraw(2,:)<-amplitude
%             5: dataraw(1,:)<-channel 3 phase dataraw(2,:)<-amplitude
%             7: dataraw(1,:)<-channel 4 phase dataraw(2,:)<-amplitude
%             9: dataraw(1,:)<-channel 5 phase dataraw(2,:)<-amplitude
% enplot = 1 to plot data
%
% ******************************
% DAQ0 CHANNELS
% 1 = Rotated Vector Sum (I and Q)
% 2 = Error (I and Q)
% 3 = Output (I and Q)
% 4 = Feedforward (I and Q)
% 5 = Set point (I and Q)
% 6 = Gain proportional (I and Q)
% 7 = Controller output (I and Q)
% 8 = ADC9 and ADC 10
%
%******************************
% DAQ1 CHANNELS
%
% If muxnr = 0
% 1 = I and Q channel 1
% 2 = I and Q channel 2
% 3 = I and Q channel 3
% 4 = I and Q channel 4
% 5 = I and Q channel 5
% 6 = I and Q channel 6
% 7 = I and Q channel 7
% 8 = I and Q channel 8
%
% If muxnr = 1
% 1 = Amplitude and phase channel 1
% 2 = Amplitude and phase channel 2
% 3 = Amplitude and phase channel 3
% 4 = Amplitude and phase channel 4
% 5 = Amplitude and phase channel 5
% 6 = Amplitude and phase channel 6
% 7 = Amplitude and phase channel 7
% 8 = Amplitude and phase channel 8
%
% If muxnr = 2
% 1 = Raw data channels 1 and 2
% 2 = Raw data channels 3 and 4
% 3 = Raw data channels 5 and 6
% 4 = Raw data channels 7 and 8
% 5 = Raw data channels 9 and 10
% 6 = Status (lower word)
% 7 = Vector sum (I and Q)
% 8 = Protection level and Reflection amplitude
%******************************
 if nargin < 5
    enplot =   1;
 end

offset=daqnr*2^24; 
channels=8;
dataraw_tmp=zeros(channels*2,dsize/2);

if daqnr==1
    m.write('APP0','WORD_DAQ_MUX',muxnr,1);
end

a = m.read_dma_raw('BOARD0', 'AREA_DMA', offset, dsize*channels,16);

for i=1:channels*2
	dataraw_tmp(i,:)=typecast(uint16(a(i:channels*2:end)),'int16');
end

dataraw(1,:)=dataraw_tmp(channelnr,:);
dataraw(2,:)=dataraw_tmp(channelnr+1,:);

if enplot==1
    subplot(1,2,1);
    plot(dataraw(2,:));title(['chan' num2str(channelnr)]);
    subplot(1,2,2);
    if daqnr == 1
        if muxnr == 1
            phase=dataraw(1,:)*360/(2^15*2*pi);
            plot(phase);title(['phase' num2str(channelnr)]);
        else
            plot(dataraw(1,:));title(['chan' num2str(channelnr)]);
        end
    else            
        plot(dataraw(1,:));title(['chan' num2str(channelnr)]);
    end
end

pause(0.1);

end
