/***************************************************
This is the main Grabber code.  It builds the Direct Show graphs 
and then inserts SampleGrabbers right before the renderers.  It 
then changes all of the renderers to NullRenderers.  This code 
supports any number of audio or video streams.  Raw midi streams
are not supported -- I didn't think I should bother.

This code was intended to be used inside of a matlab interface,
but can be used as a generic grabber class for anyone who needs 
one.

Written by Micah Richert.
07/14/2005
**************************************************/

#include "DDGrab.h"

GUID NULLGUID = {0};

CSampleGrabberCB::CSampleGrabberCB()
{
	pbFormat = NULL;
	frameNr = 0;
	disabled = FALSE;
}

CSampleGrabberCB::~CSampleGrabberCB()
{
	if (pbFormat) free(pbFormat);
	for (int f=0;f<frames.size();f++) if (frames[f]) free(frames[f]);
}

// Fake out any COM QI'ing
//
STDMETHODIMP CSampleGrabberCB::QueryInterface(REFIID riid, void ** ppv)
{
	if (!ppv) return E_POINTER;
	
	if( riid == IID_ISampleGrabberCB || riid == IID_IUnknown ) 
	{
		*ppv = (void *) static_cast<ISampleGrabberCB*> ( this );
		return NOERROR;
	}	

	return E_NOINTERFACE;
}

// The sample grabber is calling us back on its deliver thread.
// This is NOT the main app thread!
//
STDMETHODIMP CSampleGrabberCB::BufferCB( double dblSampleTime, BYTE * pBuffer, long lBufferSize )
{
	if (disabled) return 0;

	if (!pBuffer) return E_POINTER;

	frameNr++;

	bool foundNr = false;
	for (int i=0;i<frameNrs.size();i++) if (frameNrs[i] == frameNr) foundNr = true;

	if (frameNrs.size() == 0 || foundNr)
	{
		BYTE* tmp = new BYTE[lBufferSize];
		if (!tmp) return E_OUTOFMEMORY;

		memcpy(tmp,pBuffer,lBufferSize);
		frames.push_back(tmp);
		frameBytes.push_back(lBufferSize);
	}

	return 0;
}

void DDGrabber::cleanUp()
{
	IEnumFilters* filterList;
	IBaseFilter* filt;
	ULONG tmp;
	int i;

	for (i=0; i<VideoCBs.size(); i++) delete VideoCBs[i];
	for (i=0; i<AudioCBs.size(); i++) delete AudioCBs[i];

	VideoCBs.clear();
	AudioCBs.clear();

	if (!FAILED(pGraphBuilder->EnumFilters(&filterList)))
	{
		filterList->Reset();
		while (filterList->Next(1, &filt, &tmp) == S_OK)
		{
			filt->Release();
		}	
		filterList->Release();
	}
	pGraphBuilder = NULL;
}

void DDGrabber::MyFreeMediaType(AM_MEDIA_TYPE& mt)
{
	if (mt.cbFormat != 0)
	{
		CoTaskMemFree((PVOID)mt.pbFormat);
		mt.cbFormat = 0;
		mt.pbFormat = NULL;
	}
	if (mt.pUnk != NULL)
	{
		// Unecessary because pUnk should not be used, but safest.
		mt.pUnk->Release();
		mt.pUnk = NULL;
	}
}

PIN_INFO DDGrabber::getPinInfo(IPin* pin)
{
	PIN_INFO	info = {0};

	if (pin)
	{
		if (!FAILED(pin->QueryPinInfo(&info)))
		{
			info.pFilter->Release();
		}
	}

	return info;
}

IPin* DDGrabber::getInputPin(IBaseFilter* filt)
{
	IPin* pin = NULL;
	IEnumPins* pinList;
	ULONG tmp;
	
	if (!filt) return NULL;

	//get the input
	if (!FAILED(filt->EnumPins(&pinList)))
	{
		pinList->Reset();
		while (pinList->Next(1, &pin, &tmp) == S_OK && getPinInfo(pin).dir != PINDIR_INPUT);
		pinList->Release();

		if (getPinInfo(pin).dir != PINDIR_INPUT) return NULL;
	}

	return pin;
}

IPin* DDGrabber::getOutputPin(IBaseFilter* filt)
{
	IPin* pin = NULL;
	IEnumPins* pinList;
	ULONG tmp;

	if (!filt) return NULL;

	//get the output
	if (!FAILED(filt->EnumPins(&pinList)))
	{
		pinList->Reset();
		while (pinList->Next(1, &pin, &tmp) == S_OK && getPinInfo(pin).dir != PINDIR_OUTPUT);
		pinList->Release();
	
		if (getPinInfo(pin).dir != PINDIR_OUTPUT) return NULL;
	}

	return pin;
}

bool DDGrabber::isRenderer(IBaseFilter* filt)
{
	if (!filt) return false;

	IEnumPins*	pinList;
	int nrOutput = 0;
	int nrInput = 0;
	IPin*		pin = NULL;
	ULONG		tmp;

	if (FAILED(filt->EnumPins(&pinList))) return false;
	pinList->Reset();
	while (pinList->Next(1, &pin, &tmp) == S_OK)
	{
		if (getPinInfo(pin).dir == PINDIR_OUTPUT) nrOutput++;
		else nrInput++;
	}
	pinList->Release();

	#ifdef _DEBUG
		FILTER_INFO info;
		filt->QueryFilterInfo(&info);
		char str[100];
		WideCharToMultiByte( CP_ACP, 0, info.achName, -1, str, 100, NULL, NULL );
		_RPT0(_CRT_WARN,str);
		_RPT2(_CRT_WARN," %d %d\n", nrOutput, nrInput);
	#endif

	return nrOutput == 0 && nrInput == 1;  // the only filters that have no outputs are renderers
}

IPin* DDGrabber::connectedToInput(IBaseFilter* filt)
{
	if (!filt) return NULL;

	IPin* inPin;
	IPin* outPin;

	inPin = getInputPin(filt);
	if (!inPin) return NULL;

	if (FAILED(inPin->ConnectedTo(&outPin))) return NULL;
	return outPin;
}

GUID DDGrabber::getMajorType(IBaseFilter* filt)
{
	if (!filt) return NULLGUID;

	IPin* inPin;
	inPin = getInputPin(filt);
	if (!inPin) return NULLGUID;
	
	AM_MEDIA_TYPE mt = {0};
//	ZeroMemory(&MediaType,sizeof(MediaType));
	if (FAILED(inPin->ConnectionMediaType(&mt))) return NULLGUID;
	
	GUID ret = mt.majortype;
	MyFreeMediaType(mt);

	return ret;
}

HRESULT DDGrabber::getVideoInfo(unsigned int id, int* width, int* height, int* nrFramesCaptured, int* nrFramesTotal)
{
	if (!width || !height || !nrFramesCaptured || !nrFramesTotal) return E_POINTER;

	if (id >= VideoCBs.size()) return E_NOINTERFACE;
	CSampleGrabberCB* CB = VideoCBs[id];

	if (!CB) return E_POINTER;

	if (CB->frameNr == 0)
	{
		*width = 0;
		*height = 0;
	} else {
		VIDEOINFOHEADER * h = (VIDEOINFOHEADER*) CB->pbFormat;
		if (!h) return E_POINTER;
		*width  = h->bmiHeader.biWidth;
		*height = h->bmiHeader.biHeight;
	}
	*nrFramesCaptured = CB->frames.size();
	*nrFramesTotal = CB->frameNr;

	return S_OK;
}

HRESULT DDGrabber::getAudioInfo(unsigned int id, int* nrChannels, int* rate, int* bits, int* nrFramesCaptured, int* nrFramesTotal)
{
	if (!nrChannels || !rate || !bits || !nrFramesCaptured || !nrFramesTotal) return E_POINTER;

	if (id >= AudioCBs.size()) return E_NOINTERFACE;
	CSampleGrabberCB* CB = AudioCBs[id];

	if (!CB) return E_POINTER;

	if (CB->frameNr == 0)
	{
		*nrChannels = 0;
		*rate = 0;
		*bits = 0;
	} else {
		WAVEFORMATEX * h = (WAVEFORMATEX*) CB->pbFormat;
		if (!h) return E_POINTER;
		*nrChannels = h->nChannels;
		*rate = h->nSamplesPerSec;
		*bits = h->wBitsPerSample;
	}
	*nrFramesCaptured = CB->frames.size();
	*nrFramesTotal = CB->frameNr;

	return S_OK;
}

void DDGrabber::getCaptureInfo(int* nrVideo, int* nrAudio)
{
	if (!nrVideo || !nrAudio) return;

	*nrVideo = (VideoCBs.size()>0&&VideoCBs[0]&&VideoCBs[0]->disabled)?0:VideoCBs.size();
	*nrAudio = (AudioCBs.size()>0&&AudioCBs[0]&&AudioCBs[0]->disabled)?0:AudioCBs.size();
}

// data must be freed by caller
HRESULT DDGrabber::getVideoFrame(unsigned int id, int frameNr, char** data, int* nrBytes)
{
	if (!data || !nrBytes) return E_POINTER;

	if (id >= VideoCBs.size()) return E_NOINTERFACE;
	CSampleGrabberCB* CB = VideoCBs[id];
	if (!CB) return E_POINTER;
	if (CB->frameNr == 0) return E_NOINTERFACE;
	if (frameNr < 0 || frameNr >= CB->frames.size()) return E_NOINTERFACE;

	BYTE* tmp = CB->frames[frameNr];
	if (!tmp) return E_NOINTERFACE;

	*nrBytes = CB->frameBytes[frameNr];
	*data = new char[*nrBytes];
	if (!*data) return E_OUTOFMEMORY;
	memcpy(*data,tmp,*nrBytes);
	free(tmp);
	CB->frames[frameNr] = NULL;

	return S_OK;
}

// data must be freed by caller
HRESULT DDGrabber::getAudioFrame(unsigned int id, int frameNr, char** data, int* nrBytes)
{
	if (!data || !nrBytes) return E_POINTER;

	if (id >= AudioCBs.size()) return E_NOINTERFACE;
	CSampleGrabberCB* CB = AudioCBs[id];
	if (!CB) return E_POINTER;
	if (CB->frameNr == 0) return E_NOINTERFACE;
	if (frameNr < 0 || frameNr >= CB->frames.size()) return E_NOINTERFACE;

	BYTE* tmp = CB->frames[frameNr];
	if (!tmp) return E_NOINTERFACE;

	*nrBytes = CB->frameBytes[frameNr];
	*data = new char[*nrBytes];
	if (!*data) return E_OUTOFMEMORY;
	memcpy(*data,tmp,*nrBytes);
	free(tmp);
	CB->frames[frameNr] = NULL;

	return S_OK;
}

void DDGrabber::setFrames(int* frameNrs, int nrFrames)
{
	if (!frameNrs) return;
	
	for (int i=0; i < VideoCBs.size(); i++)
	{
		CSampleGrabberCB* CB = VideoCBs[i];
		if (CB)
		{
			CB->frames.clear();
			CB->frameNr = 0;
			CB->frameNrs.clear();
			for (int i=0; i<nrFrames; i++) CB->frameNrs.push_back(frameNrs[i]);
		}
	}

	// the meaning of frames doesn't make much sense for audio...
}

void DDGrabber::disableVideo()
{
	for (int i=0; i < VideoCBs.size(); i++)
	{
		if (VideoCBs[i]) VideoCBs[i]->disabled = true;
	}
}

void DDGrabber::disableAudio()
{
	for (int i=0; i < AudioCBs.size(); i++)
	{
		if (AudioCBs[i]) AudioCBs[i]->disabled = true;
	}
}

HRESULT DDGrabber::changeToNull(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer)
{
	HRESULT hr;

	if (!pGraphBuilder || !pRenderer) return E_POINTER;

	IPin* outPin = connectedToInput(pRenderer);
	if (!outPin) return E_NOINTERFACE;

	// Add the Null Renderer filter to the graph.
	IBaseFilter *pNull;
	if (FAILED(hr = ::CoCreateInstance(CLSID_NullRenderer,NULL,CLSCTX_INPROC_SERVER,IID_IBaseFilter, (void**)&pNull))) return hr;
	if (FAILED(hr = pGraphBuilder->AddFilter(pNull, L"NullRender"))) return hr;
	if (FAILED(hr = outPin->Disconnect())) return hr;

	IPin* inPin = getInputPin(pNull);
	if (!inPin) return E_NOINTERFACE;

	#ifdef _DEBUG
		FILTER_INFO info;
		pRenderer->QueryFilterInfo(&info);
		char str[100];
		WideCharToMultiByte( CP_ACP, 0, info.achName, -1, str, 100, NULL, NULL );
		_RPT0(_CRT_WARN,str);
		_RPT0(_CRT_WARN," Removed\n");
	#endif

	if (FAILED(hr = pGraphBuilder->RemoveFilter(pRenderer))) return hr;

	hr = pGraphBuilder->Connect(outPin,inPin);
	return hr;
}

HRESULT DDGrabber::insertCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer, AM_MEDIA_TYPE* mt, CSampleGrabberCB** grabberCB)
{
	HRESULT hr;

	if (!pGraphBuilder || !pRenderer || !mt || !grabberCB) return E_POINTER;

	IPin* rendererPin = getInputPin(pRenderer);
	IPin* upStreamPin = connectedToInput(pRenderer);
	if (!upStreamPin || !rendererPin) return E_NOINTERFACE;

 	// Create the "Grabber filter"
	CComPtr<IBaseFilter>	pGrabberBaseFilter;
	CComPtr<ISampleGrabber> pSampleGrabber;
	if (FAILED(hr = ::CoCreateInstance(CLSID_SampleGrabber,NULL,CLSCTX_INPROC_SERVER,IID_IBaseFilter, (LPVOID *)&pGrabberBaseFilter))) return hr;
	pGrabberBaseFilter->QueryInterface(IID_ISampleGrabber, (void**)&pSampleGrabber);
	if (pSampleGrabber == NULL) return E_NOINTERFACE;
	if (FAILED(hr = pGraphBuilder->AddFilter(pGrabberBaseFilter,L"Grabber"))) return hr;
	if (FAILED(hr = pSampleGrabber->SetMediaType(mt))) return hr;

	IPin* grabberInPin = getInputPin(pGrabberBaseFilter);
	if (!grabberInPin) return E_NOINTERFACE;

	if (FAILED(hr = upStreamPin->Disconnect())) return hr;
	if (FAILED(hr = rendererPin->Disconnect())) return hr;

	if (FAILED(hr = pGraphBuilder->Connect(upStreamPin,grabberInPin))) return hr;

	IPin* grabberOutPin = getOutputPin(pGrabberBaseFilter);
	if (!grabberOutPin) return E_NOINTERFACE;
	if (FAILED(hr = pGraphBuilder->Connect(grabberOutPin,rendererPin))) return hr;
	
	if (FAILED(hr = pSampleGrabber->SetBufferSamples(FALSE))) return hr;

	*grabberCB = new CSampleGrabberCB();
	if (!*grabberCB) return E_OUTOFMEMORY;
	CComQIPtr< ISampleGrabberCB, &IID_ISampleGrabberCB> CB(*grabberCB);

	if (FAILED(hr = pSampleGrabber->SetCallback( CB, 1 ))) return hr;
	if (FAILED(hr = pSampleGrabber->GetConnectedMediaType(mt))) return hr;

	// I don't know how long this pointer will stay valid... so copy it
	if ((*grabberCB)->pbFormat) free((*grabberCB)->pbFormat);
	(*grabberCB)->pbFormat = new BYTE[mt->cbFormat];
	if (!(*grabberCB)->pbFormat) return E_OUTOFMEMORY;
	memcpy((*grabberCB)->pbFormat,mt->pbFormat,mt->cbFormat);

	return hr;
}

HRESULT DDGrabber::insertVideoCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer)
{
	AM_MEDIA_TYPE mt = {0};
	CSampleGrabberCB* grabberCB;

	if (!pGraphBuilder || !pRenderer) return E_POINTER;

//	ZeroMemory(&mt, sizeof(AM_MEDIA_TYPE));
	mt.majortype = MEDIATYPE_Video;
	mt.subtype = MEDIASUBTYPE_RGB24;
	mt.formattype = FORMAT_VideoInfo; 

	HRESULT hr = insertCapture(pGraphBuilder, pRenderer, &mt, &grabberCB);
	if (!FAILED(hr))
	{
		VideoCBs.push_back(grabberCB);
		MyFreeMediaType(mt);
	}

	return hr;
}

HRESULT DDGrabber::insertAudioCapture(IGraphBuilder* pGraphBuilder, IBaseFilter* pRenderer)
{
	AM_MEDIA_TYPE mt = {0};
	CSampleGrabberCB* grabberCB;

	if (!pGraphBuilder || !pRenderer) return E_POINTER;

//	ZeroMemory(&mt, sizeof(AM_MEDIA_TYPE));
	mt.majortype = MEDIATYPE_Audio;
	mt.subtype = MEDIASUBTYPE_PCM;
	mt.formattype = FORMAT_WaveFormatEx;

	HRESULT hr = insertCapture(pGraphBuilder, pRenderer, &mt, &grabberCB);
	if (!FAILED(hr))
	{
		AudioCBs.push_back(grabberCB);
		MyFreeMediaType(mt);
	}

	return hr;
}

HRESULT DDGrabber::mangleGraph(IGraphBuilder* pGraphBuilder)
{
	if (!pGraphBuilder) return E_POINTER;

	IEnumFilters* filterList;
	IBaseFilter* filt;
	vector<IBaseFilter*> renderers; // if there is an audio and a video stream then we could have two renderers
	ULONG tmp;
	HRESULT hr;

	if (FAILED(hr = pGraphBuilder->EnumFilters(&filterList))) return hr;
	filterList->Reset();
	while (filterList->Next(1, &filt, &tmp) == S_OK)
	{
		if (isRenderer(filt)) renderers.push_back(filt);
	}	
	filterList->Release();

	for (int i=0; i<renderers.size(); i++)
	{
		if (MEDIATYPE_Video == getMajorType(renderers[i]))
		{
			if (FAILED(hr = insertVideoCapture(pGraphBuilder,renderers[i]))) return hr;
		} else if (MEDIATYPE_Audio == getMajorType(renderers[i])) {
			if (FAILED(hr = insertAudioCapture(pGraphBuilder,renderers[i]))) return hr;
		} else {
			_RPT0(_CRT_WARN,"Renderer type not recognized.\n");
		}

		if (FAILED(hr = changeToNull(pGraphBuilder,renderers[i]))) return hr;
	}

	return S_OK;
}

HRESULT DDGrabber::buildGraph(char* filename)
{
	if (!filename) return E_POINTER;
	
	WCHAR uniFilename[MAX_PATH];
	HRESULT hr;

	MultiByteToWideChar(CP_ACP, 0, filename, -1, uniFilename, MAX_PATH);

	// Create the graph builder
	pGraphBuilder = NULL;
	if (FAILED(hr = ::CoCreateInstance(CLSID_FilterGraph, NULL, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, (void**)&pGraphBuilder))) return hr;

	if (FAILED(hr = pGraphBuilder->RenderFile(uniFilename,NULL))) return hr;
		
	// insert the Capture CBs, and change the Renderers to Null
	if (FAILED(hr = mangleGraph(pGraphBuilder))) return hr;

	return hr;
}

HRESULT DDGrabber::doCapture()
{
	HRESULT hr;
	CComPtr<IMediaControl> pMediaControl;
	CComPtr<IMediaEvent> pMediaEventEx;
	CComPtr<IMediaFilter> pMediaFilter;
	long evCode;
	
	pGraphBuilder->QueryInterface(IID_IMediaControl, (void **)&pMediaControl);
	pGraphBuilder->QueryInterface(IID_IMediaEvent, (void **)&pMediaEventEx);
	pGraphBuilder->QueryInterface(IID_IMediaFilter, (void **)&pMediaFilter);

	if (pMediaControl == NULL || pMediaEventEx == NULL || pMediaFilter == NULL) return E_NOINTERFACE;

	//turn off the clock, so that it will run as fast as possible
	pMediaFilter->SetSyncSource(NULL);

	// Run the graph and wait for completion.
	if (FAILED(hr = pMediaControl->Run())) return hr;

	if (FAILED(hr = pMediaEventEx->WaitForCompletion(INFINITE, &evCode))) return hr;

	return S_OK;
}