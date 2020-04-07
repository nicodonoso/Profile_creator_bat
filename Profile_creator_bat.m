function [] = Profile_creator_bat(x,y,depth,write,name,folder)
%This function has been created by J. Oberreuter and programed by Nicolás Donoso at CECs laboratory
% It creates profiles of bathymetry.
% it should be execute as: Profile_creator_bat(x,y,depth,1,'archivo_borrar.txt','/home/nico/Documents/cecs/lsg/batimetria_lago_cecs')
% Profile_creator_bat(x,y,depth,write or don't [1 or 0],name file['archivo_borrar.txt'],Path to file ['/home/nico/Documents/cecs/lsg/batimetria_lago_cecs'])
% if you want write output_file.csv or Profile_creator_bat(x,y,depth,0) 
% 
 % Pre check of data
if length(x) ~= length(y) || length(x) ~= length(depth) || length(y) ~= length(depth)
   disp('Size of input vectors are not equal! ')
   disp('Stop execute!!! ;(')
   return
end

figure;
plot(x,y,'*r');
axis equal;
grid on;

%vector distancia
x_del=x(2:end)-x(1:end-1);
y_del=y(2:end)-y(1:end-1);
dist=sqrt(x_del.^2+y_del.^2);
dist0=[0 dist];
dist=cumsum(dist0);

figure;
plot(dist,depth,'r-*');
grid on;

%curve fiting
fun01=fit(dist',depth','poly1');
fun02=fit(dist',depth','linearinterp');
fun03=fit(dist',depth','cubicinterp');
fun04=fit(dist',depth','smoothingspline');
fun05=fit(dist',depth','pchipinterp');% OJO

figure;
plot(fun01,dist,depth,'b*');
set(gca,'Ydir','reverse');
title('poly1');
grid on;

figure;
plot(fun02,dist,depth,'b*');
set(gca,'Ydir','reverse');
title('linearinterp');
grid on;

figure;
plot(fun03,dist,depth,'b*');
set(gca,'Ydir','reverse');
title('cubicinterp');
grid on;

figure;
plot(fun04,dist,depth,'b*');
set(gca,'Ydir','reverse');
title('smoothingspline');
grid on;

figure;
plot(fun05,dist,depth,'b*');
set(gca,'Ydir','reverse');
title('pchipinterp');
grid on;

%crear puntos intermedios entre puntos de control
n=length(x);
figure;

Xnew=[];
Ynew=[];

for i=1:n-1
    %i
    xnew=linspace(x(i),x(i+1),floor(dist0(i+1)));
    ynew=linspace(y(i),y(i+1),floor(dist0(i+1)));
    length(xnew);
    Xnew=[Xnew;xnew'];
    Ynew=[Ynew;ynew'];
plot(xnew,ynew,'.','Color',rand(3,1)), hold on;
set(gca,'Ydir','normal');
axis equal;
end

%Nuevo vector de distancia
X_del=Xnew(2:end)-Xnew(1:end-1);
Y_del=Ynew(2:end)-Ynew(1:end-1);
Dist=sqrt(X_del.^2+Y_del.^2);
Dist0=[0;Dist];
Dist=cumsum(Dist0);


%Evaluar funcion
depth_interp=feval(fun05,Dist);

figure;
plot(Dist,depth_interp);
set(gca,'Ydir','reverse');
grid on;
title('pchipinterp!');

if write == 1
    %disp(folder)
    cd(folder);
    dlmwrite(name,[Xnew Ynew depth_interp],'delimiter',',','precision','%10.5f');
    donde = pwd;
    disp([name,' has been created at: ',pwd]);
else
    disp('File has not been created... because input parameter write !=1');
end

