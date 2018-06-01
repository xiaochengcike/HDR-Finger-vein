clear all;
close all;

metafile = {'img_evaltests/dataset4/segment4meta.png'};
[img_h,img_w] = size(imread( cell2mat(metafile)));

files = {
        'img_evaltests/dataset5/segment (21).png_cropped.png', ...
        'img_evaltests/dataset5/segment (20).png_cropped.png', ...
        'img_evaltests/dataset5/segment (19).png_cropped.png', ...
        'img_evaltests/dataset5/segment (18).png_cropped.png', ...
        'img_evaltests/dataset5/segment (17).png_cropped.png', ...
        'img_evaltests/dataset5/segment (16).png_cropped.png', ...
        'img_evaltests/dataset5/segment (15).png_cropped.png', ...
        'img_evaltests/dataset5/segment (14).png_cropped.png', ...
        'img_evaltests/dataset5/segment (13).png_cropped.png', ...
        'img_evaltests/dataset5/segment (12).png_cropped.png', ...
        'img_evaltests/dataset5/segment (11).png_cropped.png', ...
        'img_evaltests/dataset5/segment (10).png_cropped.png', ...
         'img_evaltests/dataset5/segment (9).png_cropped.png', ...
         'img_evaltests/dataset5/segment (8).png_cropped.png', ...
         'img_evaltests/dataset5/segment (7).png_cropped.png', ...
         'img_evaltests/dataset5/segment (6).png_cropped.png', ...
         'img_evaltests/dataset5/segment (5).png_cropped.png', ...
         'img_evaltests/dataset5/segment (4).png_cropped.png', ...
         'img_evaltests/dataset5/segment (3).png_cropped.png', ...
         'img_evaltests/dataset5/segment (2).png_cropped.png', ...
         'img_evaltests/dataset5/segment (1).png_cropped.png', ...
         }; 

% files = {
%         'img_evaltests/dataset1/segment_cropped (1).png', ...
%         'img_evaltests/dataset1/segment_cropped (2).png', ...
%         'img_evaltests/dataset1/segment_cropped (3).png',...  
%          'img_evaltests/dataset1/segment_cropped (4).png',...
%          %'img_evaltests/dataset1/segment_cropped (5).png'...
%          }; 

exposure_min = 1;
exposure_max = 255;
expTimes = cell(1,numel(files));
expNormalized = cell(1,numel(files));
images = cell(1,numel(files));

figure;
montage(files);


%% single scalar relative exposure value per image 

for i = 1:numel(files) 
    path = cell2mat(files(i)); 
    img = imread(path); 
    images{i} = img;
  %expTimes(i) = mean(img(:)); 
  %expTimes{i} = img;
  expTimes{i}=zeros(size(img));
  expTimes{i}(:)= mean(img(:)); 
  expNormalized{i} = expTimes{i}./expTimes{i}(1);
%   expNormalized{i} = expNormalized{i} .* expNormalized{i};
%   expNormalized{i} = expNormalized{i} .* expNormalized{i};
%   expNormalized{i} = expNormalized{i} .* expNormalized{i};
end 

%montage(files) 
hdr = makehdr_mod_cell(metafile,images,'RelativeExposure',expNormalized,'MinimumLimit',exposure_min,'MaximumLimit',exposure_max);
%hdr = makehdr_mod_cell(metafile,images,'RelativeExposure',expNormalized);
%rgb = localtonemap(hdr,'EnhanceContrast', 1); 
rgb = tonemap(hdr);
%rgb = uint8(255*mat2gray(hdr));
figure; 
subplot(2,1,1),imshow(rgb);
imwrite(rgb,'img_evaltests/dataset5/hdr_global.png');

%% compare with moving average approach

for i = 1:numel(files) 
    path = cell2mat(files(i)); 
    img = imread(path); 
    %expTimes(i) = mean(img(:)); 
    %expTimes{i} = img;
    expTimes{i}=zeros(size(img));
    expTimes{i}= movmean(img,75,1);
    expNormalized{i} = expTimes{i}./expTimes{i}(1);
end 

hdr = makehdr_mod_cell(metafile,images,'RelativeExposure',expNormalized,'MinimumLimit',exposure_min,'MaximumLimit',exposure_max);
rgb = tonemap(hdr);  
%rgb = uint8(255*mat2gray(hdr));
%subplot(2,1,2),imshow(rgb);
imwrite(rgb,'img_evaltests/dataset5/hdr_75,1.png');

%% compare with moving average approach

for i = 1:numel(files) 
    path = cell2mat(files(i)); 
    img = imread(path); 
    %expTimes(i) = mean(img(:)); 
    %expTimes{i} = img;
    expTimes{i}=zeros(size(img));
    expTimes{i}= movmean(img,[1 5]);
    expNormalized{i} = expTimes{i}./expTimes{i}(1);
end 

hdr = makehdr_mod_cell(metafile,images,'RelativeExposure',expNormalized,'MinimumLimit',exposure_min,'MaximumLimit',exposure_max);
rgb = tonemap(hdr);  
%rgb = uint8(255*mat2gray(hdr));
subplot(2,1,2),imshow(rgb);
imwrite(rgb,'img_evaltests/dataset5/hdr_[1 5].png');

figure;
path = cell2mat(files(1)); 
img = imread(path); 
adjust = imadjust(img);
imshow(adjust);
imwrite(adjust,'img_evaltests/dataset5/imadjust_result.png');
