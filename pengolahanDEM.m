close all
clear
clc

%% properti yang akan diubah
folderFile = 'Contoh Data';
namaFile='DEMNAS_1017-31_v1.0';

FolderOut= 'Gambar';
namaGambar1 ='DEMNAS MATLAB';
namaGambar2 = 'SURF DEMNAS';
titel='DEMNAS UTARA PULAU BINTAN';
tipeGambar = 'tif';

namaFont = 'Arial';
ukuranLabel=14;
ukuranTitle=18;

%% input data
load coast
[data, referensi]=geotiffread([folderFile '/' namaFile '.tif']);
DEM=flipud(data);

%% 
%Bujur
batasLong=referensi.XWorldLimits;
interval=referensi.CellExtentInWorldX;
Bujur=batasLong(1)+interval/2 : interval : batasLong(2);

%Lintang
batasLat=referensi.YWorldLimits;
interval=referensi.CellExtentInWorldY;
Lintang=batasLat(1)+interval/2:interval:batasLat(2);

%% Pembuatan Grid
[X,Y]=meshgrid(Bujur,Lintang);

%% grafik
figure('Units','Normalized','Position',[0 0 1 1])
contourf(X,Y,DEM)
hold on
plot(long,lat,'k')

grid on
axis equal
axis([batasLong,batasLat])
colormap jet
colorbar

xlabel('Bujur (\circ)','FontName',namaFont,...
    'FontSize',ukuranLabel,'FontWeight','Bold')
ylabel('Lintang (\circ)','FontName',namaFont,...
    'FontSize',ukuranLabel,'FontWeight','Bold')
title(upper(titel),'FontName',...
    namaFont,'FontSize',ukuranTitle)
%saveas(gcf,'Gambar/Peta DEMNAS.png')

Frame    = getframe(gcf);
imwrite(Frame.cdata,[FolderOut '/' namaGambar1 '.' tipeGambar], tipeGambar)


%% surface
gambar
surf(X,Y,DEM)
shading interp
hold on
contour3(X,Y,DEM,'k','showtext','on')

Frame    = getframe(gcf);
imwrite(Frame.cdata,[FolderOut '/' namaGambar2 '.' tipeGambar], tipeGambar)
