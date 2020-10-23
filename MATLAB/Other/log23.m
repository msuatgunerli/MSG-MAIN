clc
clear
%t = 1:10;
%x(1)=1;
%for i=1:9
%  x(i+1) = 1+x(i);
%end
%figure,plot(t,x);
%disp(x(10))

t = 1:99;
x(1)=2;
for i=1:98
    x(i+1) = (log(x(i)-1))/(log(1-1/x(i)))
end
figure,plot(t,x);
disp(2x(98))