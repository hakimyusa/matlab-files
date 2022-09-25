function [video, audio] = mmread(filename, frames, disableVideo, disableAudio)
% function [video, audio] = mmread(filename, frames, disableVideo, disableAudio)
% mmread reads virtually any media file.  If Windows Media Play can play
% it, so should mmread.  It uses the Window's DirectX infrastructure to
% render the media, so other OSs are out of luck.
%
% INPUT
% filename      input file to read (mpg, avi, wmv, asf, wav, mp3, ...)
% frames        specifies which video frames to capture, default [] for all
% disableVideo  disables ALL video capturing, to save memory or time
% disableAudio  disables ALL audio capturing, to save memory or time
%
% OUTPUT
% video is a struct with the following fields:
%   width           width of the video frames
%   height          height of the video frames
%   nrFramesTotal   the total number of frames in the movie regardless to
%                   how many were captured
%   frames          a struct array with the following fields:
%       cdata       [height X width X 3] uint8 matricies
%       colormap    always empty
%
% audio is a struct with the following fields:
%   nrChannels      the number of channels in the audio stream (1 or 2)
%   rate            sampling rate of the audio, ex. 44100
%   bits            bit depth of the samples (8 or 16)
%   data            the real data of the whole audio stream.  This can be
%                   played using wavplay.
%   nrFramesTotal   Audio comes in packets or frames when captured, the
%   frames          division of the audio into frames may or may not make
%                   sense.  Probably not of great use.  Stored as uint8s.
%
% If there is no video or audio stream the corresponding structure will be
% empty.
%
% Specifying frames does not effect audio capturing.  If you want only a
% subsection of the audio you will need to extract it from the matrix
% yourself.
%
% If there are multiple video or audio streams, then the structure will be
% of length > 1.  For example: audio(1).data and audio(2).data.
%
% EXAMPLES
% [video, audio] = mmread('chimes.wav');
% wavplay(audio.data,audio.rate);
%
% video = mmread('mymovie.mpg');
% movie(video.frames);
%
% video = mmread('mymovie.mpg',1:10); %get only the first 10 frames
%
% video = mmread('mymovie.mpg',[],false,true); %read all frames, disable audio
%
% Written by Micah Richert

if nargin < 4
    disableAudio = false;
    if nargin < 3
        disableVideo = false;
        if nargin < 2
            frames = [];
        end
    end
end

try
    mexDDGrab('buildGraph',filename);
    mexDDGrab('setFrames',frames);
    if (disableVideo) mexDDGrab('disableVideo'); end;
    if (disableAudio || nargout < 2) mexDDGrab('disableAudio'); end;
    mexDDGrab('doCapture');
    
    [nrVideoStreams, nrAudioStreams] = mexDDGrab('getCaptureInfo');
    
    video = struct('width',{},'height',{},'nrFramesTotal',{},'frames',{});
    audio = struct('nrChannels',{},'rate',{},'bits',{},'nrFramesTotal',{},'data',{},'frames',{});
    
    % loop through getting all of the video data from each stream
    for i=1:nrVideoStreams
        [width, height, nrFramesCaptured, nrFramesTotal] = mexDDGrab('getVideoInfo',i-1);
        video(i).width = width;
        video(i).height = height;
        video(i).nrFramesTotal = nrFramesTotal;
        video(i).frames = struct('cdata',repmat({[]},1,nrFramesCaptured),'colormap',repmat({[]},1,nrFramesCaptured));
        for f=1:nrFramesCaptured
            data = mexDDGrab('getVideoFrame',i-1,f-1);
            % the data ordering is wrong for matlab images, so permute it
            tmp = permute(reshape(data, 3, width, height),[3 2 1]);
            video(i).frames(f).cdata = tmp(end:-1:1,:,3:-1:1); % the images are also upside down and colors were backwards.
        end
    end
    
    % loop through getting all of the audio data from each stream
    for i=1:nrAudioStreams
        [nrChannels, rate, bits, nrFramesCaptured, nrFramesTotal] = mexDDGrab('getAudioInfo',i-1);
        audio(i).nrChannels = nrChannels;
        audio(i).rate = rate;
        audio(i).bits = bits;
        audio(i).nrFramesTotal = nrFramesTotal;
        audio(i).frames = cell(1,nrFramesCaptured);
        for f=1:nrFramesCaptured
            data = mexDDGrab('getAudioFrame',i-1,f-1);
            audio(i).frames{f} = data;
        end
        % combine the data across frames
        d = double(cat(1,audio(i).frames{:}));
        % convert to 16 bit if need be
        if (bits == 16) d = d(1:2:end)+d(2:2:end)*256; end;
        % make the data signed
        d(d>2^(bits-1)) = d(d>2^(bits-1)) - 2^bits;
        % reshape and rescale the data so that it is nrChannels x Samples
        % and -1.0 to 1.0.  This should be the same output as wavread.
        audio(i).data = reshape(d/2^(bits-1),nrChannels,length(d)/nrChannels)';
    end
    
    mexDDGrab('cleanUp');
catch
    err = lasterror;
    mexDDGrab('cleanUp');
    rethrow(err);
end