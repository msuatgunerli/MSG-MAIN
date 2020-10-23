X = (1:1:33)
x = linspace(1,33)
A = table2array(PTT);
Hafta = transpose(A(:,1));
Basak = transpose(A(:,2));
Trabz = transpose(A(:,3));
Sivas = transpose(A(:,4));
Galat = transpose(A(:,5));
Alany = transpose(A(:,6));
Fener = transpose(A(:,7));
Antal = transpose(A(:,8));
Gazia = transpose(A(:,9));
Kasim = transpose(A(:,10));
Gozte = transpose(A(:,11));
Gencl = transpose(A(:,12));
Konya = transpose(A(:,13));
Deniz = transpose(A(:,14));
Rizes = transpose(A(:,15));
YMala = transpose(A(:,16));
Kayse = transpose(A(:,17));
AGucu = transpose(A(:,18));


%GalatF = polyfit(Hafta,Galat,15);
%GalatV = polyval(GalatF,x);
%plot(x,GalatV)
%hold on 
%plot(Hafta,Galat,'o')

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'testAnimated.gif';

for i = 1:4:19
  
    GalatF = polyfit(Hafta,Galat,i);
    GalatV = polyval(GalatF,x);
    
    plot(x,GalatV)
    hold on
    plot(Hafta,Galat,'ok')
    hold on
    
    drawnow
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if i == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end 
  end

