clc;clear all;close all;
N=10;
bk=round(rand(1,N));
br=10^6;
f=br;
T=1/br;
grid on;
subplot(4,1,1);
stem(bk,'LineWidth',1.5);
title('info bits to be transmittted');
axis([0 11 0 1.5]);

dk=1;
coded=[dk];
for i=1:length(bk);
    temp=~xor(dk,bk(i));
    coded=[coded temp];
    dk=temp;
end

subplot(4,1,2);
stem(coded,'LineWidth',1.5);
grid on;
title('diff encoded sig');
axis([0 11 0 1.5]);

%Modulation
coded_PNRZ=2*coded-1;
mod_sig=[];
t=T/99:T/99:T;
for i=1:length(coded)
    temp=coded_PNRZ(i)*sqrt(2/T)*cos(2*pi*f*t);
    mod_sig=[mod_sig temp];
end

subplot(4,1,3);
tt=T/99:T/99:(T*length(coded));
plot(tt,mod_sig,'LineWidth',1.5);
title('DPSK modulated signal');
grid on;

%Demodulation
rec_sig=mod_sig;
rec_data=[];
for i=1:length(coded)-1
    y_in=rec_sig((i-1)*length(t)+1:i*length(t)).*rec_sig((i)*length(t)+1:(i+1)*length(t));
    y_in_intg=trapz(t,y_in);
    if (y_in_intg>0)
        temp=1;
    else
        temp=0;
    end
    rec_data=[rec_data temp];
end

subplot(4,1,4);
stem(rec_data,'LineWidth',3);
title('Received info bits');
axis([0 11 0 1.5]);

