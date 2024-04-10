clc
clear
close all

load('MLPtrain')

int_images = {'altar_ex.jpg','apse2.jpg','bell_tower_ex.jpg'}
title_name= {'altar','apse','bell tower'}

img=imread(int_images{2});
img1=im2double(img);
resized_image = imresize(img1, [24, 24]);

O=MLPnet(resized_image(:))
[~, maxIndex] = max(O);
figure(1)
imshow(img)
title(title_name{maxIndex})