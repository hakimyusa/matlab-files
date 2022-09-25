% Get some audio
load handel;

% Pitch up an octave
ypvoc =pvoc(y, 0.5);
ypitch = resample(ypvoc,1,2);
sound(y,Fs);
sound(ypitch, Fs);
sound(y(1:length(ypitch)) + ypitch, Fs);