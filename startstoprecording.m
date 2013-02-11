
% this matlab script calls Mac's AppleScripts to start and stop a computer
% screen recording session;

pathToScripts = '/Users/zoya/Documents/appleScripts';
startScript = 'startScreenRec.scpt';
stopScript = 'stopScreenRec.scpt';

startScript = fullfile(pathToScripts,startScript);
stopScript = fullfile(pathToScripts,stopScript);

system(sprintf('osascript %s',startScript))

% DO SOMETHING HERE
pause(3);
% -----------------

system(sprintf('osascript %s',stopScript))