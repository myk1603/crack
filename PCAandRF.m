%% convert RGB 3d image into small block
clc;
clear all;
close all;
input_parameters
cracktrainpath = uigetdir(strcat(training_path_JPG),'select path for crack train image');
%Traning Image Vector
I = readIm_K(cracktrainpath,'JPG');
% Image patches into cell structure 
 [patches] = makeImGrid_RGB(I);
%% Select crack patches for RF input form full size RGB image cell structure [9 9]  
ind = [2 3;3 2;4 5 ;4 6 ;4 7 ;4 8 ;4 9 ;5 1 ;5 2 ;5 3 ;5 4 ;5 5;5 9]; 
Im = [];
for m = 1:size(ind,1)
    im_tmp = double(patches{ind(m,1),ind(m,2)}.I);
    R_tmp = im_tmp(:,:,1);
    G_tmp = im_tmp(:,:,2);
    B_tmp = im_tmp(:,:,3);
    im_tmp2 = [R_tmp(:) G_tmp(:) B_tmp(:)];
    Im = [Im;im_tmp2];
end
%% This is Predict function using after Train RF (Test select block patches images using RF)
load B1;
%%
[Yfit,scores] = predict(B1,Im);
Yfit2 = str2num(cell2mat(Yfit));
%Prediction RF output convert into blockwise cell vector
for p = 1:13
patch1{p}=(Yfit2(98304*(p-1)+1:98304*p,1));
patchr = reshape(patch1{p},[256,384]);
patchr1{p} = patchr;
end
%% Binary Logical 2d image for ground truth
cracktrainpath = uigetdir(strcat(validate_path_BMP),'select path for crack train image');
%Traning Image Vector
I = readIm_K(cracktrainpath,'bmp');
% Create block of binary image for ground truth into [9 9]
patchesB = makeImGrid_BW(I);
B2 = patchesB;
%% Replace Prediction label into  Original Ground Truth (B2 is BW image [9 9]) 
 for r = 1:13
     B2{ind(r,1),ind(r,2)} = patchr1{r};
 end
%% Binary Image With Prediction
PredictB3 = reshape(cell2mat(B2),[2304,3456]);
subplot(1,2,1);
imshow(PredictB3);
% Ground Truth Binary Image
subplot(1,2,2);
 GTB4 = reshape(cell2mat(patchesB),[2304,3456]);
imshow(GTB4);

