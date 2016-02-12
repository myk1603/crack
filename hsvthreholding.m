clc ;
clear all;
close all;
a = imread('wallcrack.jpg');  %read image
imshow(a);
red = a(:,:,1);
green = a (:,:,2);
blue = a(:,:,3);
imshow(red)
imshow(green)
imshow(blue)
d = impixel (a);     %use to get the pixel value of desired object

out = red>25 & red<60 & green>20 & green<50 & blue<40 & blue>23
imshow (out);

%out2 = imfill(out,'holes');
%imshow (out2)
%out3 = bwmorph (out,'erode');
%imshow = (out3)
%imshow = (out2)
out5 = bwmorph (out,'dilate',1);
%increase the pixel at corner
imshow (out)
imshow (out5)
%out4 = imfill(out3,'holes');
%imshow(out4)






