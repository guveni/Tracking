clear;
close all;

d = load('data1.mat');
dat1 = d.dat;
d = load('data2.mat');
dat2 = d.dat;
d = load('data3.mat');
dat3 = d.dat;

figure(1);
hold on;
for i=1:size(dat1,1)
   if( dat1(i,3) == 1)
       plot(dat1(i,1),dat1(i,2),'bx')
   else
       plot(dat1(i,1),dat1(i,2),'rx')
   end
end
hold off;

figure(2);
hold on;
for i=1:size(dat2,1)
   if( dat2(i,3) == 1)
       plot(dat2(i,1),dat2(i,2),'bx')
   else
       plot(dat2(i,1),dat2(i,2),'rx')
   end
end
hold off;

figure(3);
hold on;
for i=1:size(dat3,1)
   if( dat3(i,3) == 1)
       plot(dat3(i,1),dat3(i,2),'bx')
   else
       plot(dat3(i,1),dat3(i,2),'rx')
   end
end
hold off;

