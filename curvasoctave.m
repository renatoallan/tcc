clear all
close all
clc

%vav = 4.624;
velocidade = 4.624;
n = 1698/60;
d=0.26;

%j = vav/(n*d);
contapd = 0;
%5196
pot = 5196;
%va = 4.624;
rho=1025.9;
va = 1.028:0.1:2.028;


%pd = 0.5:0.1:1.4;
pd = 0.5:0.1:1.4;
%aeao = [0.4;0.55;0.7;0.85;1];  %MUDAR SEMPRE ESSE VALOR!!
aeao=0.55;
z = 3:1:3;




C_kt = [0.008805;-0.204554;0.166351;0.158114;-0.147581;-0.481497;0.415437;0.014404;-0.053005;0.014348;0.060683;-0.012589;0.010969;-0.133698;0.006384;-0.001327;0.168496;-0.050721;0.085456;-0.050448;0.010465;-0.006483;-0.008417;0.016842;-0.001023;-0.031779;0.018604;-0.004108;-0.000607;-0.004982;0.002598;-0.000561;-0.001637;-0.000329;0.000117;0.000691;0.004217;0.000057;-0.001466];
s_kt = [0;1;0;0;2;1;0;0;2;0;1;0;1;0;0;2;3;0;2;3;1;2;0;1;3;0;1;0;0;1;2;3;1;1;2;0;0;3;0];
t_kt = [0;0;1;2;0;1;2;0;0;1;1;0;0;3;6;6;0;0;0;0;6;6;3;3;3;3;0;2;0;0;0;0;2;6;6;0;3;6;3];
u_kt = [0;0;0;0;1;1;1;0;0;0;0;1;1;0;0;0;1;2;2;2;2;2;0;0;0;1;2;2;0;0;0;0;0;0;0;1;1;1;2];
v_kt = [0;0;0;0;0;0;0;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;1;1;1;1;2;2;2;2;2;2;2;2;2;2;2];

C_kq = [0.003794;0.008865;-0.032241;0.003448;-0.040881;-0.108009;-0.088538;0.188561;-0.003709;0.005137;0.020945;0.004743;-0.007234;0.004384;-0.026940;0.055808;0.016189;0.003181;0.015896;0.047173;0.019628;-0.050278;-0.030055;0.041712;-0.039772;-0.003500;-0.010685;0.001109;-0.000314;0.003599;-0.001421;-0.003836;0.012680;-0.003183;0.003343;-0.001835;0.000112;-0.000030;0.000270;0.000833;0.001553;0.000303;-0.000184;-0.000425;0.000087;-0.000466;0.000055];
s_kq = [0;2;1;0;0;1;2;0;1;0;1;2;2;1;0;3;0;1;0;1;3;0;3;2;0;0;3;3;0;3;0;1;0;2;0;1;3;3;1;2;0;0;0;0;3;0;1];
t_kq = [0;0;1;2;1;1;1;2;0;1;1;1;0;1;2;0;3;3;0;0;0;1;1;2;3;6;0;3;6;0;6;0;2;3;6;1;2;6;0;0;2;6;0;3;3;6;6];
u_kq = [0;0;0;0;1;1;1;1;0;0;0;0;1;1;1;1;1;1;2;2;2;2;2;2;2;2;0;0;0;1;1;2;2;2;2;0;0;0;1;1;1;1;2;2;2;2;2];
v_kq = [0;0;0;0;0;0;0;0;1;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;0;0;1;1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2;2;2;2;2];

%toras
%{
x55(1)=3.2342;
y55(1)= 0.74;

x07(1)=3.2342;
y07(1)=0.72;

x1(1)=3.2342;
y1(1)=0.705;
%}
%fim das toras

a04=1;
a55=1;
a07=1;
a85=1;
a1=1;
tr = 1;


erro_pd05=999;
erro_pd06=999;
erro_pd07=999;
erro_pd08=999;
erro_pd09=999;
erro_pd10=999;
erro_pd11=999;
erro_pd12=999;
erro_pd13=999;
erro_pd14=999;
contn =0;

num_interacoes = 0;
aux = 1;

j = 0:0.01:1.5;
maxeficiencia = -1;
jafoi=0;

for i=1:length(z)
    for o=1:length(aeao)
        for qw=1:length(va)
            for s=1:length(pd)
                
                clear x07 y07 x55 y55 x1 y1
                for a=1:length(j)
                    
                    soma_kt = 0;
                    soma_kq = 0;
                    soma_dkt = 0;
                    soma_dkq = 0;
                    
                    for n=1:length(C_kt)
                        soma_kt = soma_kt + C_kt(n)*j(a)^s_kt(n)*pd(s)^t_kt(n)*aeao(o)^u_kt(n)*z(i)^v_kt(n);
                    endfor
                    
                    reyn = 6*va(qw)/(1.004*10^-6);
                    
                    if(reyn>2000000)
                        C_dkt = [0.000353485;-0.00333758;-0.00478125;0.000257792;0.0000643192;-0.0000110636;-0.0000276305;0.0000954000;0.0000032049];
                        reyn_dkt = [1; 1; 1; (log10(reyn)-0.301)^2; (log10(reyn)-0.301); (log10(reyn)-0.301)^2;(log10(reyn)-0.301)^2;(log10(reyn)-0.301);(log10(reyn)-0.301)];
                        z_dkt = [1;1;1;1;1;1;z(i);z(i);z(i)^2];
                        aeao_dkt = [1;aeao(o);aeao(o);aeao(o);1;1;aeao(o);aeao(o);aeao(o)];
                        pd_dkt = [1;1;pd(s);1;pd(s)^6;pd(s)^6;1;pd(s);pd(s)^3];
                        j_dkt = [1;j(a)^2;j(a);j(a)^2;j(a)^2;j(a)^2;j(a)^2;j(a);j(a)];
                        
                        for po=1:length(C_dkt)
                            soma_dkt = soma_dkt + C_dkt(po)*reyn_dkt(po)*z_dkt(po)*aeao_dkt(po)*pd_dkt(po)*j_dkt(po);
                        endfor
                        soma_kt = soma_kt + soma_dkt;
                    endif
                    
                    
                    
                    for w=1:length(C_kq)
                        soma_kq = soma_kq + C_kq(w)*j(a)^s_kq(w)*pd(s)^t_kq(w)*aeao(o)^u_kq(w)*z(i)^v_kq(w);
                    endfor
                    
                    if(reyn > 2000000)
                        C_dkq = [-0.0005914120;0.0069689800;-0.0000666654;0.0160818000;-0.0009380910;-0.0005959300;0.0000782099;0.0000052199;-0.0000008853;0.0000230171;-0.0000018434;-0.0040025200;0.0002209150];
                        reyn_dkq = [1;1;1;1;(log10(reyn)-0.301);(log10(reyn)-0.301);(log10(reyn)-0.301)^2;(log10(reyn)-0.301);(log10(reyn)-0.301)^2;(log10(reyn)-0.301);(log10(reyn)-0.301)^2;(log10(reyn)-0.301);(log10(reyn)-0.301)^2];
                        z_dkq = [1;1; z(i); 1; 1;1;1;z(i);z(i);z(i);z(i);1;1];
                        aeao_dkq = [1;1;1;aeao(o)^2;1;1;1;aeao(o);aeao(o);1;1;aeao(o)^2;aeao(o)^2];
                        pd_dkq = [1;pd(s);pd(s)^6;1;pd(s);pd(s)^2;pd(s)^2;1;pd(s);pd(s)^6;pd(s)^6;1;1];
                        j_dkq =[1;1;1;1;1;1;1;j(a)^2;j(a);1;1;1;1];
                        
                        for po=1:length(C_dkq)
                            soma_dkq = soma_dkq + C_dkq(po)*reyn_dkq(po)*z_dkq(po)*aeao_dkq(po)*pd_dkq(po)*j_dkq(po);
                        endfor
                    endif
                    soma_kq = soma_kq + soma_dkq;
                    
                    erro = 0.0001;
                    
                    %if (abs(kq_temp-soma_kq)<erro)%
                    
                    if (~(soma_kq < 0 ) && ~(soma_kt < 0))
                        %{
                            x04(a04) = k_temp^0.2;
                            y04(a04)= pd(s);
                            a04 = a04+1;
                        %}
                        
                        
                        x07(a07) = j(a);
                        y07(a07)= soma_kq;
                        a07 = a07+1;
                        
                        x55(a55) = j(a);
                        y55(a55) = soma_kt;
                        a55 = a55+1;
                        
                        x1(a1)=j(a);
                        y1(a1)= (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                        a1 = a1 + 1;
                        
                        k_temp = pot*n^2/(2*3.1415*1025.9*va(qw)^5);
                        
                        
                        tr = 1;
                        for lz = 0:0.0001:1
                            kq_temp = k_temp*lz^5;
                            
                            plotarjalt(tr) = lz;
                            plotarkqalt(tr) = kq_temp;
                            
                            tr = tr + 1;
                            
                            
                            if(abs(kq_temp-soma_kq) < 0.0001)
                                if(pd(s) == 0.5)
                                    
                                    if(abs(kq_temp-soma_kq) < erro_pd05 && abs(j(a)-lz) < 0.01)
                                        erro_pd05 = abs(kq_temp-soma_kq);
                                        j_pd05 = lz;
                                        pd05 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (pd(s) == 0.6)
                                    if(abs(kq_temp-soma_kq) < erro_pd06 && abs(j(a)-lz) < 0.01)
                                        erro_pd06 = abs(kq_temp-soma_kq);
                                        j_pd06 = lz;
                                        pd06 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (pd(s) == 0.7)
                                    if(abs(kq_temp-soma_kq) < erro_pd07 && abs(j(a)-lz) < 0.01)
                                        erro_pd07 = abs(kq_temp-soma_kq);
                                        j_pd07 = lz;
                                        pd07 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (pd(s) == 0.8)
                                    if(abs(kq_temp-soma_kq) < erro_pd08 && abs(j(a)-lz) < 0.01)
                                        erro_pd08 = abs(kq_temp-soma_kq);
                                        j_pd08 = lz;
                                        pd08 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (pd(s) == 0.9)
                                    if(abs(kq_temp-soma_kq) < erro_pd09 && abs(j(a)-lz) < 0.01)
                                        
                                        erro_pd09 = abs(kq_temp-soma_kq);
                                        j_pd09 = lz;
                                        pd09 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (abs(pd(s)-1.000)<0.00001)
                                    if(abs(kq_temp-soma_kq) < erro_pd10 && abs(j(a)-lz) < 0.01)
                                        
                                        erro_pd10 = abs(kq_temp-soma_kq);
                                        j_pd10 = lz;
                                        pd10 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (abs(pd(s)-1.100)<0.00001)
                                    if(abs(kq_temp-soma_kq) < erro_pd11 && abs(j(a)-lz) < 0.01)
                                        erro_pd11 = abs(kq_temp-soma_kq);
                                        j_pd11 = lz;
                                        pd11 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (abs(pd(s)-1.200)<0.00001)
                                    if(abs(kq_temp-soma_kq) < erro_pd12 && abs(j(a)-lz) < 0.01)
                                        erro_pd12 = abs(kq_temp-soma_kq);
                                        j_pd12 = lz;
                                        pd12 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (abs(pd(s)-1.300)<0.00001)
                                    if(abs(kq_temp-soma_kq) < erro_pd13 && abs(j(a)-lz) < 0.01)
                                        erro_pd13 = abs(kq_temp-soma_kq);
                                        j_pd13 = lz;
                                        pd13 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                elseif (abs(pd(s)-1.400)<0.00001)
                                    if(abs(kq_temp-soma_kq) < erro_pd14 && abs(j(a)-lz) < 0.01)
                                        erro_pd14 = abs(kq_temp-soma_kq);
                                        j_pd14 = lz;
                                        pd14 = pd(s);
                                        eficiencia = (soma_kt/soma_kq)*(j(a)/(2*3.1415));
                                        if(eficiencia > maxeficiencia)
                                            maxeficiencia = eficiencia;
                                            j_maxeficiencia = lz;
                                            pd_maxeficiencia = pd(s);
                                            kt_maxeficiencia = soma_kt;
                                            kq_maxeficiencia = soma_kq;
                                            va_maxeficiencia = va(qw);
                                            k_maxeficiencia = k_temp^0.2;
                                        endif
                                    endif
                                endif
                            endif
                        endfor
                        %end
                        
                        
                        
                        
                        %end
                        %aux = aux + 1;
                        
                        %plot(x07, y07,'-r');
                        %hold on
                        
                        %plot(x55, y55,'-b');
                        %hold on
                        
                        % plot(x1, y1,'-k');
                        % hold on
                    endif
                endfor
                
            endfor
            disp("---------------------------------");
            disp(maxeficiencia);
            disp(j_maxeficiencia);
            disp(pd_maxeficiencia);
            disp(kt_maxeficiencia);
            disp(kq_maxeficiencia);
            disp(va_maxeficiencia);
            disp(k_maxeficiencia);
            disp("---------------------------------");
            maxeficiencia = -1 ;
            j_maxeficiencia = 0;
            pd_maxeficiencia = 0;
            kt_maxeficiencia = 0;
            kq_maxeficiencia = 0;
            va_maxeficiencia = 0;
            k_maxeficiencia = 0;
            %plot(plotarjalt, plotarkqalt,'-g');
            %hold on
        endfor
        
    endfor
    
endfor





%{
plot(x04, y04, '-o');
xlabel('k^{0.2}')
ylabel('Razão Passo-Diâmetro') % y-axis label
hold on
plot(x55, y55, '-^');
hold on
%}

%{
hold on
plot(x85, y85, '-*');
hold on
plot(x1, y1, '-s');
legend('Ae/A0=0.4','Ae/A0=0.55','Ae/A0=0.7','Ae/A0=0.85','Ae/A0=1','Location','northeast')
%}



%{
j_pd05
pd05
j_pd06
pd06
j_pd07
pd07
j_pd08
pd08
j_pd09
pd09
j_pd10
pd10
j_pd11
pd11
j_pd12
pd12
j_pd13
pd13
j_pd14
pd14
%}
