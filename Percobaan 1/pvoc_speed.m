load handel;

% Half Speed
yhalf =pvoc(y,1.5,1024);
sound(yhalf);

% Fast Speed
yfast =pvoc(y,3,1024);
sound(yfast);

% Slow Speed
yslow =pvoc(y,.5,1024);

sound(yhalf);
sound(yfast);
sound(yslow);