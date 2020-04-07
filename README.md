# Profile_creator_bat
This matlab function creates profiles of bathymetry in stereographyc antartic coordinates.

This function has been created by J. Oberreuter and programed by Nicolás Donoso.

It creates profiles of bathymetry.

It should be execute as: 
Profile_creator_bat(x,y,depth,1,'archivo_borrar.txt','/home/nico/Documents/cecs/lsg/batimetria')

Profile_creator_bat(x,y,depth,write or don't [1 or 0],name file['archivo_borrar.txt'],Path to save files ['/home/nico/Documents/'])
If you do not want write output_file.csv use Profile_creator_bat(x,y,depth,0)

in batch mode should be use as:

z(1).x     = [-1175563.1272, -1174357.68, -1171952.46, -1169686.98, -1167853.609];
z(1).y     = [45911.68508, 46788.23, 48474.47, 50381.48, 52473.767];
z(1).depth = [0, 79.79, 186.76, 301.43,0];
         
         for j=1:length(z)
             Profile_creator_bat(z(j).x,z(j).y,z(j).depth,1,['costilla_Repetir_bat_run1_1_recta_central_medio',num2str(j),'.txt'],'/home/nico/Documents/cecs/lsg/rombax_run1/Repetir_bat_run1')
             close all;
             disp('perfil nº: ')
             disp(j)
         end
