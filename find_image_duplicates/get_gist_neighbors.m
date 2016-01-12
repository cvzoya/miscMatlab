% This function can be used for calculating Gist image neighbors in order
% to look for (partial) image duplicates, for instance.

imdir = 'Targets/tower/';
imfiles = dir(fullfile(imdir,'*.jpg'));

%% Get Gist neighbors

% Gist parameters
param.imageSize = [256 256]; 
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;

% compute the Gist descriptor for each image and store in Matrix G
G = [];
for i = 1:length(imfiles)
    fprintf('%d of %d\n',i,length(imfiles))
    img = imread(fullfile(imdir,imfiles(i).name));
    [gist, param] = LMgist(img, '', param);
    G = [G ; gist];
end

% compute the Euclidean distance between pairs of Gist descriptors in G
D = pdist2(G,G);

%% if instead you would like to compare all images in one directory to all
% images in another directory, uncomment this cell

% imdir2 = '';
% imfiles2 = '';

% G2 = [];
% for i = 1:length(imfiles2)
%     fprintf('%d of %d\n',i,length(imfiles2))
%     img = imread(fullfile(imdir2,imfiles2(i).name));
%     [gist, param] = LMgist(img, '', param);
%     G2 = [G2 ; gist];
% end

% compute the Euclidean distance between Gist descriptors in G2 to Gist
% descriptors in G

%D = pdist2(G2,G);


%% Display the Gist neighbors

Nneibs = 5;

figure;
for i = 1:size(G,1)
    subplot(1,Nneibs+1,1); imshow(fullfile(imdir,imfiles(i).name));
    [~,ind] = sort(D(:,i),'ascend');
    for ii = 1:Nneibs
       subplot(1,Nneibs+1,1+ii); imshow(fullfile(imdir,imfiles(ind(ii+1)).name)); 
       % use the next line instead of comparing images from 2 different directories 
       % subplot(1,Nneibs+1,1+ii); imshow(fullfile(imdir,imfiles(ind(ii)).name));
    end
    fprintf('%d of %d\n',i,size(G,1));
    pause;
end

