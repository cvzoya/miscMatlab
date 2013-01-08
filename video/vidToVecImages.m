function vidToVecImages(indir,outdir,k,ext,togray)
% Takes as input a directory of videos (indir), a frame rate k, an
% output directory (outdir), a video extention (e.g. 'mpg','mov',etc.);
% vectorizes every k^th frame of each video (if togray = 0, then all 3 
% color channels are separately saved; otherwise, images are grayscaled
% before being vectorized). The vectorized images are then put into a data
% matrix allData which gets saved in a mat file with the same name as the 
% input video.

% prerequisites: readVideo must be in the matlab path

% created Zoya Gavrilov 12/01/12

if nargin < 4, error('Not enough input arguments.'); end
if nargin < 5, togray = 1; end

if ~exist(outdir, 'dir')
  mkdir(outdir);
end
%%
fnames = dir(fullfile(indir,['*.',ext]));
nfiles = length(fnames);

% for each video file, generate a separate vectorized image data matrix
for j = 1:nfiles
    
    vidpath = fullfile(indir,fnames(j).name);
    sprintf('On file %d of %d: %s',j,nfiles,vidpath)
    
    mov = readVideo(vidpath);
    nFrames = numel(mov);
    
    % preallocate data matrix to hold vectorized images
    imSize = size(mov(1).cdata);
    if togray
        allData = zeros(nFrames,imSize(1)*imSize(2));
    else
        allData = zeros(nFrames,imSize(1)*imSize(2),3);
    end
    
    % vectorize images and store in allData
    for i = 1:k:nFrames
        if togray
            I = rgb2gray(mov(i).cdata);
            allData(i,:) = I(:)';
        else
            for c = 1:3
                I = mov(i).cdata(:,:,c);
                allData(i,:,c) = I(:)';
            end
        end
    end
    
    % save in mat file with name corresponding to video name
    [~, name] = fileparts(vidpath); 
    sprintf('Saving %s',name)
    save(fullfile(outdir,name),'allData','imSize') 
    
end

sprintf('DONE!')