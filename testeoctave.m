for i=1:15
  disp("cu desgracado");
endfor 

if (2+2 < 0)
  disp("cu");
elseif
  disp("buceta");
endif

a=1;

salva = zeros(15,1)
for i=1:15
a = a+i;
salva(i,1) = a;
endfor
save d.mat salva;
