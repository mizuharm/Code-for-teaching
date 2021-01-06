%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hearing Fourier series approximation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   1. Plot and listen to audio of trumpet playing a note
%   2. Use FFT to visualize peaks of certain Fourier modes
%   3. Truncate in the frequency space to get a ``compressed'' file
%   4. Use iFFT to plot and listen to compressed trumpet sound 
%
%   Data from:
%   University Of Washington Dept. of Electrical Engineering, 
%   Fourier Series and Gibbs Phenomenon. 
%   OpenStax CNX. Oct 25, 2008 
%   http://cnx.org/contents/8ef92951-be1e-40f4-a50a-a307785a0608@21. 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('trumpet.mat');
    
Y = fft(trumpet);                            % take the FFT of trumpet
Fs = 11025;                                 % sampling rate
Ymag = abs(Y);                              % take the magnitude of Y
f= Fs*(1:length(trumpet))/length(trumpet); %frequency domain
t = 1/Fs*1:length(trumpet);                 %time domain
                  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Original sound
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    sound(trumpet,Fs)

    fig = figure(1);
    set(gcf, 'Position', [200,50, 800, 600])

    subplot(2,2,1)
    plot(t(1:500),trumpet(1:500))
    title('Sound wave of original trumpet')
    xlabel('Time (ms)')
    ylabel('u(t)')
    
    subplot(2,2,2)
    plot(f(1:floor(end/2)), Ymag(1:floor(end/2)));
    title('Full Fourier')
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')
   
    
    
    pause(3.5)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Truncated sound
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    num = 10000; %Where to cutoff; integer between 1 and 33075

    y = zeros(length(Y),1);
    y(1:num) = Y(1:num);

    trumpet2 = ifft(y);
    trumpet2 = trumpet2/min(max(trumpet2),max(-trumpet2)); %scale to [-1,1]

    sound(real(trumpet2),Fs)
        
    subplot(2,2,3)
    plot(t(1:500),real(trumpet2(1:500)))
    title('Sound wave of compressed trumpet')
    xlabel('Time (ms)')
    ylabel('u(t)')

    subplot(2,2,4)
    plot(f(1:floor(end/2)),abs(y(1:floor(end/2))))
    title('Truncated Fourier')
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')
