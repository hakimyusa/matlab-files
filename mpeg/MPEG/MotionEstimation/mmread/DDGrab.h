/***************************************************
This is the header file for the Grabber code.  Include this
in your files.

This code was intended to be used inside of a matlab interface,
but can be used as a generic grabber class for anyone who needs 
one.

Written by Micah Richert.
07/14/2005
**************************************************/

#include "atlbase.h"
#include "dshow.h"
#include "qedit.h"
#include <vector>

using namespace std;
//using namespace stdext;

// since the Audio and Video CB vectors are public we need to make the CB interface public too
class CSampleGrabberCB : public ISampleGrabberCB 
{
public:
	CSampleGrabberCB();
	virtual ~CSampleGrabberCB();

	vector<BYTE*> frames;
	vector<int> frameBytes;
	vector<int> frameNrs;

	// use this to get data format information, ie. bit depth, sampling rate...
	BYTE *pbFormat;

	unsigned int frameNr;
	bool disabled;

	// Fake out any COM ref counting
	//
	STDMETHODIMP_(ULONG) AddRef() { return 2; }
	STDMETHODIMP_(ULONG) Release() { return 1; }
	
	// Fake out any COM QI'ing
	//
	STDMETHODIMP QueryInterface(REFIID riid, void ** ppv);
	
	// We don't implement this one
	//
	STDMETHODIMP SampleCB( double SampleTime, IMediaSample * pSample ){ return 0; }
	
	// The sample grabber is calling us back on its deliver thread.
	// This is NOT the main app thread!
	//
	STDMETHODIMP BufferCB( double dblSampleTime, BYTE * pBuffer, long lBufferSize );
};

// this is the main grabber class.  I think the interfaces and names are fairly self explanatory
class DDGrabber
{
public:
	vector<CSampleGrabberCB*> VideoCBs;
	vector<CSampleGrabberCB*> AudioCBs;

	HRESULT buildGraph(char* filename);
	HRESULT doCapture();
	HRESULT getVideoInfo(unsigned int id, int* width, int* height, int* nrFramesCaptured, int* nrFramesTotal);
	HRESULT getAudioInfo(unsigned int id, int* nrChannels, int* rate, int* bits, int* nrFramesCaptured, int* nrFramesTotal);
	void getCaptureInfo(int* nrVideo, int* nrAudio);
	// data must be freed by caller
	HRESULT getVideoFrame(unsigned int id, int frameNr, char** data, int* nrBytes);
	// data must be freed by caller
	HRESULT getAudioFrame(unsigned int id, int frameNr, char** data, int* nrBytes);
	void setFrames(int* frameNrs, int nrFrames);
	void disableVideo();
	void disableAudio();
	void cleanUp(); // must be called at the end, in order to render anything afterward.
private:
	CComPtr<IGraphBuilder> pGraphBuilder;

	void MyFreeMediaType(AM_MEDIA_TYPE& mt);
	PIN_INFO getPinInfo(IPin* pin);
	IPin* getInputPin(IBaseFilter* filt);
	IPin* getOutputPin(IBaseFilter* filt);
	bool isRenderer(IBaseFilter* filt);
	IPin* connectedToInput(IBaseFilter* filt);
	GUID getMajorType(IBaseFilter* filt);
	HRESULT insertCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer, AM_MEDIA_TYPE* mt, CSampleGrabberCB** grabberCB);
	HRESULT insertVideoCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer);
	HRESULT insertAudioCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer);
	HRESULT changeToNull(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer);
	HRESULT mangleGraph(IGraphBuilder* pGraphBuilder);
};