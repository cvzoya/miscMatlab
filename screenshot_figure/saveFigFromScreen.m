function saveFigFromScreen(filename)
% Resize the CURRENT figure to the full screen size, take a screenshot of
% it, and save it in/as the specified filename; good for MATLAB plots that
% don't come out right unless resized. A screenshot of the plot will
% preserve this size.
% Zoya Gavrilov, Jan. 7, 2013

set(gcf,'Position',get(0,'Screensize')); 
pause(1)
img = capture_screen();
f = figure(); imshow(img(120:end-20,:,:))
print(filename,'-depsc2')
close(f)
