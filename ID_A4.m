%% Generate ID file (A4)
% 1英寸(in)=25.4毫米(mm) 
% A4纸尺寸   210mm×297mm % 600dpi: 4961x7016
% 身份证尺寸 85.6mm×54.0mm×1.0mm % 600dpi: 2022x1276
% Xu Yi, 2018

%%
close all; clear; clc;

%%
dpi = 600;
inch2mm = 25.4;

ID_row = round(54 /inch2mm *dpi);
ID_column = round(85.6 /inch2mm *dpi);
A4_row = round(297 /inch2mm *dpi);
A4_column = round(210 /inch2mm *dpi);

% 读取图片
imFront_origin = imread('1.jpg');
imBack_origin = imread('2.jpg');

% Resize the image, specifying that the output image have 'ID_row' rows.
% Bicubic interpolation (the default).
imFront = imresize(imFront_origin, [ID_row NaN], 'bicubic');
imBack = imresize(imBack_origin, [ID_row NaN], 'bicubic');
imFront_size = size(imFront);
imBack_size = size(imBack);

% 新建一张白纸
Img = ones(A4_row, A4_column, 3, 'uint8')*256; % 256色

% 放入身份证正反面
A4_row_Front_start = round( A4_row/4 - ID_row/2 );
A4_row_Front_end = A4_row_Front_start + ID_row -1;
A4_row_Back_start = round( A4_row_Front_start + A4_row/2 );
A4_row_Back_end = A4_row_Back_start + ID_row -1;
A4_column_start = round( A4_column/2 - ID_column/2 );
A4_column_end_F = A4_column_start + imFront_size(2) -1;
A4_column_end_B = A4_column_start + imBack_size(2) -1;
Img(A4_row_Front_start:A4_row_Front_end, A4_column_start:A4_column_end_F, :)...
    = imFront;
Img(A4_row_Back_start:A4_row_Back_end, A4_column_start:A4_column_end_B, :)...
    = imBack;

% 输出
imwrite(Img,'ID_A4.png')
