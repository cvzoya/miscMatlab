function mov = readVideo(vidpath)
% return a stuct with all the images
% based on: http://www.mathworks.com/help/matlab/ref/videoreaderclass.html
% last edited Zoya Gavrilov 12/01/12

xyloObj = VideoReader(vidpath);

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

% Preallocate movie structure.
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);

% Read one frame at a time.
for k = 1 : nFrames
    mov(k).cdata = read(xyloObj, k);
end

% Play back the movie once at the video's frame rate.
% hf = figure;
% set(hf, 'position', [150 150 vidWidth vidHeight])
% movie(hf, mov, 1, xyloObj.FrameRate);