% Get some audio
load handel;

% Pitch up a Fifth
ypvoc =pvoc(y, 0.66666);
ypitch = resample(ypvoc,2,3); % NB: 0.666 = 2/3
sound(y,Fs);
sound(ypitch, Fs);
sound(y(1:length(ypitch)) + ypitch, Fs);