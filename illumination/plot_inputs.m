close all;
dataset = 'dataset5';
metafile = {strcat('img_evaltests/',dataset,'/segment_cropped (1).png')};
[img_h,img_w] = size(imread( cell2mat(metafile)));

plot = false;

files = {
        
        strcat('img_evaltests/',dataset,'/segment_cropped (2).png'); ...
        strcat('img_evaltests/',dataset,'/segment_cropped (3).png');...  
        strcat('img_evaltests/',dataset,'/segment_cropped (4).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (5).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (6).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (7).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (8).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (9).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (10).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (11).png'), ...
        strcat('img_evaltests/',dataset,'/segment_cropped (12).png'); ...
        %strcat('img_evaltests/',dataset,'/segment_cropped (13).png');...  
        strcat('img_evaltests/',dataset,'/segment_cropped (14).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (15).png'),...
        strcat('img_evaltests/',dataset,'/segment_cropped (16).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (17).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (18).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (19).png'),...
        strcat('img_evaltests/',dataset,'/segment_cropped (20).png');...
        %strcat('img_evaltests/',dataset,'/segment_cropped (21).png');...
        strcat('img_evaltests/',dataset,'/segment_cropped (1).png'); ...
         %'img_evaltests/dataset1/segment_cropped (5).png'...
         }; 

images = cell(1,numel(files));

if(plot)
    figure;
    montage(files,'Size', [NaN 1]);
end

figure
cmap = hsv(numel(files));
for i = 1:numel(files) 
    path = cell2mat(files(i)); 
    img = imread(path); 
    images{i} = img;
    
    histogram(images{i},0:1:255,'facecolor',cmap(i,:),'facealpha',.5,'edgecolor','none')
    hold on
end 

%box off
axis tight
%legend boxoff