% Testing Mpeg1-Layer2 Encoder with:
%   1 - little stereo
%   2 - full stereo
%   3 - surround sound


% Task to do:
%   1 - generate sources and save as wav/matlab file
%   2 - load orginal data and wav files
%   3 - calculate the correlations
switch 2
case 1
  dataLength = 2^19;
  
  % Little stereo
  Lls = randUniform(1,dataLength,-1,1)*0.9;
  Rls = Lls;
  Lls = Lls + randUniform(1,dataLength,-1,1)*0.1;
  Rls = Rls + randUniform(1,dataLength,-1,1)*0.1;

  % Full stereo
  Lfs = randUniform(1,dataLength,-1,1);
  Rfs = randUniform(1,dataLength,-1,1);

  % Generating the sources to be mixed
  %   Left, Right, Center, Surround
  L = randUniform(1,dataLength,-1,1);
  R = randUniform(1,dataLength,-1,1);
  C = randUniform(1,dataLength,-1,1);
  S = randUniform(1,dataLength,-1,1);

  % Encoder:
  %   1 - "simple": 0/180 degree phase shift methode
  %   2 - "correct": +-90 degree phase shift mehtode
  LTsimple = L+C/sqrt(2)+S/sqrt(2);
  RTsimple = R+C/sqrt(2)-S/sqrt(2);

  Sp90 = -imag(hilbert(S));
  LT = L+C/sqrt(2)+Sp90/sqrt(2);
  RT = R+C/sqrt(2)-Sp90/sqrt(2);
  
  save('D:\Temp\mp2test\mp2test_org.mat','Lls','Rls','Lfs','Rfs','L','R','C','S','Sp90','LT','RT','LTsimple','RTsimple');

  testSignalLS = normMatrix([Lls;Rls],'mean','max','row')*0.95;
  wavwrite(testSignalLS',44100,'D:\Temp\mp2test\little_stereo_org.wav');
  testSignalFS = normMatrix([Lfs;Rfs],'mean','max','row')*0.95;
  wavwrite(testSignalFS',44100,'D:\Temp\mp2test\full_stereo_org.wav');
  testSignalSurround = normMatrix([LT;RT],'mean','max','row')*0.95;
  wavwrite(testSignalSurround',44100,'D:\Temp\mp2test\surround_org.wav');
  testSignalSurroundSimple = normMatrix([LTsimple;RTsimple],'mean','max','row')*0.95;
  wavwrite(testSignalSurroundSimple',44100,'D:\Temp\mp2test\surround_simple_org.wav');
  
case 2
  dataToCompareLength = 44100*5;
  
  % Read the data...
  load('D:\Temp\mp2test\mp2test_org.mat');

  % Little Stereo
  Lls_s = [];
  Lls_js = [];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s128.wav')';
  [xycorr,lags] = xcorrelation(mp2(1,10000:20000),Lls(10000:20000),3000);
  [c,i] = max(xycorr);
  offset = lags(i)

  mp2 = wavread('D:\Temp\mp2test\little_stereo_s64.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s96.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s128.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s160.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s192.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s256.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_s384.wav')';
  Lls_s = [Lls_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];

  mp2 = wavread('D:\Temp\mp2test\little_stereo_js64.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js96.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js128.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js160.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js192.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js256.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\little_stereo_js384.wav')';
  Lls_js = [Lls_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];

  
  % Full Stereo
  Lfs_s = [];
  Lfs_js = [];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s128.wav')';
  [xycorr,lags] = xcorrelation(mp2(1,10000:20000),Lfs(10000:20000),3000);
  [c,i] = max(xycorr);
  offset = lags(i)

  mp2 = wavread('D:\Temp\mp2test\full_stereo_s64.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s96.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s128.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s160.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s192.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s256.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_s384.wav')';
  Lfs_s = [Lfs_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];

  mp2 = wavread('D:\Temp\mp2test\full_stereo_js64.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js96.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js128.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js160.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js192.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js256.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  mp2 = wavread('D:\Temp\mp2test\full_stereo_js384.wav')';
  Lfs_js = [Lfs_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  
  
  % Surround "correct"
  L_s = [];
  L_js = [];
  C_s = [];
  C_js = [];
  S_s = [];
  S_js = [];
  mp2 = wavread('D:\Temp\mp2test\surround_s128.wav')';
  [xycorr,lags] = xcorrelation(mp2(1,10000:20000),LT(10000:20000),3000);
  [c,i] = max(xycorr);
  offset = lags(i)

  mp2 = wavread('D:\Temp\mp2test\surround_s64.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s96.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s128.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s160.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s192.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s256.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_s384.wav')';
  L_s = [L_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_s = [C_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_s = [S_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
               mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
        
  mp2 = wavread('D:\Temp\mp2test\surround_js64.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js96.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js128.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js160.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js192.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js256.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_js384.wav')';
  L_js = [L_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  C_js = [C_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  S_js = [S_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                 mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  

  % Surround "simple"
  Lsimple_s = [];
  Lsimple_js = [];
  Csimple_s = [];
  Csimple_js = [];
  Ssimple_s = [];
  Ssimple_js = [];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s128.wav')';
  [xycorr,lags] = xcorrelation(mp2(1,10000:20000),LT(10000:20000),3000);
  [c,i] = max(xycorr);
  offset = lags(i)

  mp2 = wavread('D:\Temp\mp2test\surround_simple_s64.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s96.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s128.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s160.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s192.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s256.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_s384.wav')';
  Lsimple_s = [Lsimple_s; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_s = [Csimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_s = [Ssimple_s; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                           mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];

  mp2 = wavread('D:\Temp\mp2test\surround_simple_js64.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js96.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js128.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js160.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js192.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js256.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  mp2 = wavread('D:\Temp\mp2test\surround_simple_js384.wav')';
  Lsimple_js = [Lsimple_js; mp2(1,50001+offset:50000+dataToCompareLength+offset)];
  Csimple_js = [Csimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)+...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
  Ssimple_js = [Ssimple_js; (mp2(1,50001+offset:50000+dataToCompareLength+offset)-...
                             mp2(2,50001+offset:50000+dataToCompareLength+offset))/sqrt(2)];
                       

  % Reference signals
  Lls = Lls(50001:50000+dataToCompareLength);
  Lfs = Lfs(50001:50000+dataToCompareLength);
  L = L(50001:50000+dataToCompareLength);
  R = R(50001:50000+dataToCompareLength);
  C = C(50001:50000+dataToCompareLength);
  Sp90 = Sp90(50001:50000+dataToCompareLength);
  LT = LT(50001:50000+dataToCompareLength);
  RT = RT(50001:50000+dataToCompareLength);
  Lr = LT;
  Cr = (LT+RT)/sqrt(2);
  Sr = (LT-RT)/sqrt(2);
  LTsimple = LTsimple(50001:50000+dataToCompareLength);
  RTsimple = RTsimple(50001:50000+dataToCompareLength);
  Lsimpler = LTsimple;
  Csimpler = (LTsimple+RTsimple)/sqrt(2);
  Ssimpler = (LTsimple-RTsimple)/sqrt(2);
  
  
case 3
  
  % frequency window of 300Hz and a step of 50Hz
  coeffWindowSize = 300*5;
  step = 50*5;
  numberOfWindows = ((dataToCompareLength/2)-coeffWindowSize)/step+1;
  freq = ((0:1:numberOfWindows-1)*50+300)/1000;


  figure(1);
  % Lets calculate the correlation for "little stereo" (stereo/joint stereo)
  corrLSs = zeros(7,numberOfWindows);
  corrLSjs = zeros(7,numberOfWindows);
  fLls = fft(Lls);
  for bitrate = 1:7
    fLls_s = fft(Lls_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLls(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLls_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLSs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fLls_js = fft(Lls_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLls(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLls_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLSjs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,1);
  plot(freq,corrLSs(1,:),'-r',freq,corrLSs(2,:),'-g',freq,corrLSs(3,:),'-b',freq,corrLSs(4,:),'-c',...
       freq,corrLSs(5,:),'-m',freq,corrLSs(6,:),'-y',freq,corrLSs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('little stereo - stereo');
  grid on;
  subplot(3,2,2);
  plot(freq,corrLSjs(1,:),'-r',freq,corrLSjs(2,:),'-g',freq,corrLSjs(3,:),'-b',freq,corrLSjs(4,:),'-c',...
       freq,corrLSjs(5,:),'-m',freq,corrLSjs(6,:),'-y',freq,corrLSjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('little stereo - joint stereo');
  grid on;
  

  
  % Lets calculate the correlation for "full stereo" (joint stereo/stereo)
  corrFSs = zeros(7,numberOfWindows);
  corrFSjs = zeros(7,numberOfWindows);
  fLfs = fft(Lfs);
  for bitrate = 1:7
    fLfs_s = fft(Lfs_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLfs(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLfs_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrFSs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fLfs_js = fft(Lfs_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLfs(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLfs_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrFSjs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,3);
  plot(freq,corrFSs(1,:),'-r',freq,corrFSs(2,:),'-g',freq,corrFSs(3,:),'-b',freq,corrFSs(4,:),'-c',...
       freq,corrFSs(5,:),'-m',freq,corrFSs(6,:),'-y',freq,corrFSs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('full stereo - stereo');
  grid on;
  subplot(3,2,4);
  plot(freq,corrFSjs(1,:),'-r',freq,corrFSjs(2,:),'-g',freq,corrFSjs(3,:),'-b',freq,corrFSjs(4,:),'-c',...
       freq,corrFSjs(5,:),'-m',freq,corrFSjs(6,:),'-y',freq,corrFSjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('full stereo - joint stereo');
  grid on;

  
  % Lets calculate the correlation for "surround" (joint stereo/stereo)
  corrSs = zeros(7,numberOfWindows);
  corrSjs = zeros(7,numberOfWindows);
  fS = fft(Sr);
  for bitrate = 1:7
    fS_s = fft(S_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fS(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fS_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrSs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fS_js = fft(S_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fS(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fS_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrSjs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,5);
  plot(freq,corrSs(1,:),'-r',freq,corrSs(2,:),'-g',freq,corrSs(3,:),'-b',freq,corrSs(4,:),'-c',...
       freq,corrSs(5,:),'-m',freq,corrSs(6,:),'-y',freq,corrSs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - stereo');
  grid on;
  subplot(3,2,6);
  plot(freq,corrSjs(1,:),'-r',freq,corrSjs(2,:),'-g',freq,corrSjs(3,:),'-b',freq,corrSjs(4,:),'-c',...
       freq,corrSjs(5,:),'-m',freq,corrSjs(6,:),'-y',freq,corrSjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - joint stereo');
  grid on;


  % Lets calculate the correlation for "left", "center" and "surround" (joint stereo/stereo)
  figure(2);
  corrLs = zeros(7,numberOfWindows);
  corrLjs = zeros(7,numberOfWindows);
  fL = fft(Lr);
  for bitrate = 1:7
    fL_s = fft(L_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fL(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fL_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fL_js = fft(L_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fL(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fL_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLjs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,1);
  plot(freq,corrLs(1,:),'-r',freq,corrLs(2,:),'-g',freq,corrLs(3,:),'-b',freq,corrLs(4,:),'-c',...
       freq,corrLs(5,:),'-m',freq,corrLs(6,:),'-y',freq,corrLs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('left - stereo');
  grid on;
  subplot(3,2,2);
  plot(freq,corrLjs(1,:),'-r',freq,corrLjs(2,:),'-g',freq,corrLjs(3,:),'-b',freq,corrLjs(4,:),'-c',...
       freq,corrLjs(5,:),'-m',freq,corrLjs(6,:),'-y',freq,corrLjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('left - joint stereo');
  grid on;
  
  
  corrCs = zeros(7,numberOfWindows);
  corrCjs = zeros(7,numberOfWindows);
  fC = fft(Cr);
  for bitrate = 1:7
    fC_s = fft(C_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fC(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fC_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrCs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fC_js = fft(C_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fC(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fC_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrCjs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,3);
  plot(freq,corrCs(1,:),'-r',freq,corrCs(2,:),'-g',freq,corrCs(3,:),'-b',freq,corrCs(4,:),'-c',...
       freq,corrCs(5,:),'-m',freq,corrCs(6,:),'-y',freq,corrCs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('center - stereo');
  grid on;
  subplot(3,2,4);
  plot(freq,corrCjs(1,:),'-r',freq,corrCjs(2,:),'-g',freq,corrCjs(3,:),'-b',freq,corrCjs(4,:),'-c',...
       freq,corrCjs(5,:),'-m',freq,corrCjs(6,:),'-y',freq,corrCjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('center - joint stereo');
  grid on;
  

  subplot(3,2,5);
  plot(freq,corrSs(1,:),'-r',freq,corrSs(2,:),'-g',freq,corrSs(3,:),'-b',freq,corrSs(4,:),'-c',...
       freq,corrSs(5,:),'-m',freq,corrSs(6,:),'-y',freq,corrSs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - stereo');
  grid on;
  subplot(3,2,6);
  plot(freq,corrSjs(1,:),'-r',freq,corrSjs(2,:),'-g',freq,corrSjs(3,:),'-b',freq,corrSjs(4,:),'-c',...
       freq,corrSjs(5,:),'-m',freq,corrSjs(6,:),'-y',freq,corrSjs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - joint stereo');
  grid on;
  

  % Lets calculate the correlation for "left", "center" and "surround" (joint stereo/stereo) of "simple"
  figure(3);
  corrLsimples = zeros(7,numberOfWindows);
  corrLsimplejs = zeros(7,numberOfWindows);
  fLsimple = fft(Lsimpler);
  for bitrate = 1:7
    fLsimple_s = fft(Lsimple_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLsimple_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLsimples(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fLsimple_js = fft(Lsimple_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fLsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fLsimple_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrLsimplejs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,1);
  plot(freq,corrLsimples(1,:),'-r',freq,corrLsimples(2,:),'-g',freq,corrLsimples(3,:),'-b',freq,corrLsimples(4,:),'-c',...
       freq,corrLsimples(5,:),'-m',freq,corrLsimples(6,:),'-y',freq,corrLsimples(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('left - stereo');
  grid on;
  subplot(3,2,2);
  plot(freq,corrLsimplejs(1,:),'-r',freq,corrLsimplejs(2,:),'-g',freq,corrLsimplejs(3,:),'-b',freq,corrLsimplejs(4,:),'-c',...
       freq,corrLsimplejs(5,:),'-m',freq,corrLsimplejs(6,:),'-y',freq,corrLsimplejs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('left - joint stereo');
  grid on;
  
  
  corrCs = zeros(7,numberOfWindows);
  corrCjs = zeros(7,numberOfWindows);
  fCsimple = fft(Csimpler);
  for bitrate = 1:7
    fCsimple_s = fft(Csimple_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fCsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fCsimple_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrCsimples(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fCsimple_js = fft(Csimple_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fCsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fCsimple_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrCsimplejs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,3);
  plot(freq,corrCsimples(1,:),'-r',freq,corrCsimples(2,:),'-g',freq,corrCsimples(3,:),'-b',freq,corrCsimples(4,:),'-c',...
       freq,corrCsimples(5,:),'-m',freq,corrCsimples(6,:),'-y',freq,corrCsimples(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('center - stereo');
  grid on;
  subplot(3,2,4);
  plot(freq,corrCsimplejs(1,:),'-r',freq,corrCsimplejs(2,:),'-g',freq,corrCsimplejs(3,:),'-b',freq,corrCsimplejs(4,:),'-c',...
       freq,corrCsimplejs(5,:),'-m',freq,corrCsimplejs(6,:),'-y',freq,corrCsimplejs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('center - joint stereo');
  grid on;

  
  corrSsimples = zeros(7,numberOfWindows);
  corrSsimplejs = zeros(7,numberOfWindows);
  fSsimple = fft(Ssimpler);
  for bitrate = 1:7
    fSsimple_s = fft(Ssimple_s(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fSsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fSsimple_s(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrSsimples(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
    fSsimple_js = fft(Ssimple_js(bitrate,:));
    numberOfWindow = 1;
    for startFreq = 0:step:(dataToCompareLength/2)-coeffWindowSize
      X = fSsimple(startFreq+1:startFreq+coeffWindowSize);
      X = X-mean(X);
      Y = fSsimple_js(startFreq+1:startFreq+coeffWindowSize);
      Y = Y-mean(Y);
      corrSsimplejs(bitrate,numberOfWindow) = sum(conj(X).*Y+X.*conj(Y))/sqrt(sum(X.*conj(X))*sum(Y.*conj(Y)))/2;
      numberOfWindow = numberOfWindow + 1;
    end
  end
  subplot(3,2,5);
  plot(freq,corrSsimples(1,:),'-r',freq,corrSsimples(2,:),'-g',freq,corrSsimples(3,:),'-b',freq,corrSsimples(4,:),'-c',...
       freq,corrSsimples(5,:),'-m',freq,corrSsimples(6,:),'-y',freq,corrSsimples(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - stereo');
  grid on;
  subplot(3,2,6);
  plot(freq,corrSsimplejs(1,:),'-r',freq,corrSsimplejs(2,:),'-g',freq,corrSsimplejs(3,:),'-b',freq,corrSsimplejs(4,:),'-c',...
       freq,corrSsimplejs(5,:),'-m',freq,corrSsimplejs(6,:),'-y',freq,corrSsimplejs(7,:),'-k');
  set(gca,'XLim',[0 22],'YLim',[-0.2 1]);
  xlabel('Frequency [kHz]');
  ylabel('correlation [1]');
  title('surround - joint stereo');
  grid on;

  
  
  %fprintf('Correlation between [L;R;C;Sp90;LT;RT] and [Lr;Rr;Cr;Sr;LTc;RTc]:\n');
  %disp(correlation([L;R;C;Sp90;LT;RT],[Lr;Rr;Cr;Sr;LTc;RTc]));
end


