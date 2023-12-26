clc;clear all;close all;
N=10;
x_ip= round(rand(1,N));
Tb=0.0001;

x_bit=[];
nb=100;
for n=1:1:N
    if x_ip(n)==1
        x_bitt=ones(1,nb);
    else x_ip(n)==0
       x_bitt=zeros(1,nb);
    end
    x_bit=[x_bit x_bitt];
end

t1=Tb/nb:Tb/nb:nb*N*(Tb/nb);
f1=figure(1);
set(f1,'color',[1 1 1]);
subplot(3,1,1);
plot(t1,x_bit,'LineWidth',2);grid on;
axis([0 Tb*N -0.5 1.5]);
xlabel('time');
ylabel('amplitude');
title('ip signal as digital signal');

%Modulation
Ac=5;
mc=4;
fc=mc*(1/Tb);
fi1=0;
fi2=pi;
t2=Tb/nb:Tb/nb:Tb;
t2L=length(t2);
x_mod=[];
for (i=1:1:N)
    if (x_ip(i)==1)
        x_mod0=Ac*cos(2*pi*fc*t2+fi1);
    else
        x_mod0=Ac*cos(2*pi*fc*t2+fi2);
    end
    x_mod=[x_mod x_mod0];
end

t3=Tb/nb:Tb/nb:Tb*N;
subplot(3,1,2);
plot(t3,x_mod);
xlabel('time');
ylabel('amplitude');
title('BPSK modulation');

x=x_mod;
h=1;
w=0;
y=h.*x+w;

%Demodulation
y_dem=[];
for n=t2L:t2L:length(y)
    t=Tb/nb:Tb/nb:Tb;
    c=cos(2*pi*fc*t);
    y_dem0=c.*y((n-(t2L-1)):n);
    t4=Tb/nb:Tb/nb:Tb;
    z=trapz(t4,y_dem0);
    A_dem=round((2*z/Tb));
    if (A_dem>Ac/2)
        A=1;
    else
        A=0;
    end
    y_dem=[y_dem A];
end
x_out=y_dem;

xx_bit=[];
for n=1:length(x_out);
    if x_out(n)==1
        xx_bitt=ones(1,nb);
    else x_out(n)==0
        xx_bitt=zeros(1,nb);
    end
    xx_bit=[xx_bit xx_bitt];
end

t4=Tb/nb:Tb/nb:nb*length(x_out)*(Tb/nb);
subplot(3,1,3);
plot(t4,xx_bit,'LineWidth',2);grid on;
axis([0 Tb*length(x_out) -0.5 1.5]);
xlabel('time')
ylabel('amplitude')
title('op signal as digital signal')




