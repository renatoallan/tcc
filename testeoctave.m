for i=1:15
  disp("cu desgracado");
endfor 

if (2+2 < 0)
  disp("cu");
else
  disp("buceta");
endif

a=1;


for i=1:15
 a = a+i;
salva(i)= a;
endfor
save d.mat salva
