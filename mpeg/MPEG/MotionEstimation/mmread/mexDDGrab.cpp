/***************************************************
This is the matlab interface code to the grabber code.
It just wraps the grabber functions and does some error
conversion.

Written by Micah Richert.
07/14/2005
**************************************************/

#include "mex.h"
#include "DDGrab.h"

TCHAR str[200]; // 

TCHAR* message(HRESULT hr)
{
	if (hr == S_OK)
	{
		return "";
	} else {
		if (AMGetErrorText(hr,str,200) != 0) return str;
		return "Unknown error";
	}
}

DDGrabber DDG;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	if (nrhs < 1 || !mxIsChar(prhs[0])) mexErrMsgTxt("First parameter must be the command (a string)");

	char cmd[100];
	mxGetString(prhs[0],cmd,100);

	if (!_stricmp("buildGraph",cmd))
	{
		if (nrhs < 2 || !mxIsChar(prhs[1])) mexErrMsgTxt("buildGraph: second parameter must be the filename (as a string)");
		if (nlhs > 0) mexErrMsgTxt("buildGraph: there are no outputs");
		int filenamelen = mxGetN(prhs[1])+1;
		char* filename = new char[filenamelen];
		if (!filename) mexErrMsgTxt("buildGraph: out of memory");
		mxGetString(prhs[1],filename,filenamelen);

		char* errmsg =  message(DDG.buildGraph(filename));
		free(filename);

		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);
		plhs[0] = NULL;
	} else if (!_stricmp("doCapture",cmd)) {
		if (nlhs > 0) mexErrMsgTxt("doCapture: there are no outputs");
		char* errmsg =  message(DDG.doCapture());
		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);
		plhs[0] = NULL;
	} else if (!_stricmp("getVideoInfo",cmd)) {
		if (nrhs < 2 || !mxIsNumeric(prhs[1])) mexErrMsgTxt("getVideoInfo: second parameter must be the video stream id (as a number)");
		if (nlhs > 4) mexErrMsgTxt("getVideoInfo: there are only 4 output values: widht, height, nrFramesCaptured, nrFramesTotal");

		unsigned int id = mxGetScalar(prhs[1]);
		int width,height,nrFramesCaptured,nrFramesTotal;
		char* errmsg =  message(DDG.getVideoInfo(id, &width, &height, &nrFramesCaptured, &nrFramesTotal));

		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);

		if (nlhs >= 1) {plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[0])[0] = width; }
		if (nlhs >= 2) {plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[1])[0] = height; }
		if (nlhs >= 3) {plhs[2] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[2])[0] = nrFramesCaptured; }
		if (nlhs >= 4) {plhs[3] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[3])[0] = nrFramesTotal; }
	} else if (!_stricmp("getAudioInfo",cmd)) {
		if (nrhs < 2 || !mxIsNumeric(prhs[1])) mexErrMsgTxt("getAudioInfo: second parameter must be the audio stream id (as a number)");
		if (nlhs > 5) mexErrMsgTxt("getAudioInfo: there are only 5 output values: nrChannels, rate, bits, nrFramesCaptured, nrFramesTotal");

		unsigned int id = mxGetScalar(prhs[1]);
		int nrChannels,rate,bits,nrFramesCaptured,nrFramesTotal;
		char* errmsg =  message(DDG.getAudioInfo(id, &nrChannels, &rate, &bits, &nrFramesCaptured, &nrFramesTotal));

		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);

		if (nlhs >= 1) {plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[0])[0] = nrChannels; }
		if (nlhs >= 2) {plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[1])[0] = rate; }
		if (nlhs >= 3) {plhs[2] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[2])[0] = bits; }
		if (nlhs >= 4) {plhs[3] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[3])[0] = nrFramesCaptured; }
		if (nlhs >= 5) {plhs[4] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[4])[0] = nrFramesTotal; }
	} else if (!_stricmp("getCaptureInfo",cmd)) {
		if (nlhs > 2) mexErrMsgTxt("getCaptureInfo: there are only 2 output values: nrVideo, nrAudio");

		int nrVideo, nrAudio;
		DDG.getCaptureInfo(&nrVideo, &nrAudio);

		if (nlhs >= 1) {plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[0])[0] = nrVideo; }
		if (nlhs >= 2) {plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL); mxGetPr(plhs[1])[0] = nrAudio; }
	} else if (!_stricmp("getVideoFrame",cmd)) {
		if (nrhs < 3 || !mxIsNumeric(prhs[1]) || !mxIsNumeric(prhs[2])) mexErrMsgTxt("getVideoFrame: second parameter must be the audio stream id (as a number) and third parameter must be the frame number");
		if (nlhs > 1) mexErrMsgTxt("getVideoFrame: there are only 1 output value: data");

		unsigned int id = mxGetScalar(prhs[1]);
		int frameNr = mxGetScalar(prhs[2]);
		char* data;
		int nrBytes;
		int dims[] = {1,1};
		char* errmsg =  message(DDG.getVideoFrame(id, frameNr, &data, &nrBytes));

		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);

		dims[0] = nrBytes;
		plhs[0] = mxCreateNumericArray(2, dims, mxUINT8_CLASS, mxREAL); // empty 2d matrix
		memcpy(mxGetPr(plhs[0]),data,nrBytes);
		free(data);
	} else if (!_stricmp("getAudioFrame",cmd)) {
		if (nrhs < 3 || !mxIsNumeric(prhs[1]) || !mxIsNumeric(prhs[2])) mexErrMsgTxt("getAudioFrame: second parameter must be the audio stream id (as a number) and third parameter must be the frame number");
		if (nlhs > 1) mexErrMsgTxt("getAudioFrame: there are only 1 output value: data");

		unsigned int id = mxGetScalar(prhs[1]);
		int frameNr = mxGetScalar(prhs[2]);
		char* data;
		int nrBytes;
		int dims[] = {1,1};
		char* errmsg =  message(DDG.getAudioFrame(id, frameNr, &data, &nrBytes));

		if (strcmp("",errmsg)) mexErrMsgTxt(errmsg);

		dims[0] = nrBytes;
		plhs[0] = mxCreateNumericArray(2, dims, mxUINT8_CLASS, mxREAL); // empty 2d matrix
		memcpy(mxGetPr(plhs[0]),data,nrBytes);
		free(data);
	} else if (!_stricmp("setFrames",cmd)) {
		if (nrhs < 2 || !mxIsDouble(prhs[1])) mexErrMsgTxt("setFrames: second parameter must be the frame numbers (as doubles)");
		if (nlhs > 0) mexErrMsgTxt("setFrames: there are no outputs");
		int nrFrames = mxGetN(prhs[1]) * mxGetM(prhs[1]);
		int* frameNrs = new int[nrFrames];
		if (!frameNrs) mexErrMsgTxt("setFrames: out of memory");
		double* data = mxGetPr(prhs[1]);
		for (int i=0; i<nrFrames; i++) frameNrs[i] = data[i];

		DDG.setFrames(frameNrs, nrFrames);
		plhs[0] = NULL;
	} else if (!_stricmp("disableVideo",cmd)) {
		if (nlhs > 0) mexErrMsgTxt("disableVideo: there are no outputs");
		DDG.disableVideo();
		plhs[0] = NULL;
	} else if (!_stricmp("disableAudio",cmd)) {
		if (nlhs > 0) mexErrMsgTxt("disableAudio: there are no outputs");
		DDG.disableAudio();
		plhs[0] = NULL;
	} else if (!_stricmp("cleanUp",cmd)) {
		if (nlhs > 0) mexErrMsgTxt("cleanUp: there are no outputs");
		DDG.cleanUp();
		plhs[0] = NULL;
	}
}