% Get some audio
load handel;

% Pitch down an octave
ypvoc =pvoc(y, 2);
ypitch = resample(ypvoc,2,1);
sound(y,Fs);
sound(ypitch, Fs);
sound(y + ypitch(1:length(y)), Fs);