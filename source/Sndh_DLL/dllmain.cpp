// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

#include "AtariAudio/SndhFile.h"

typedef	void SNDH_MUSIC;

extern "C" __declspec(dllexport) SNDH_MUSIC * SNDH_Init();
extern "C" __declspec(dllexport) bool SNDH_Load(SNDH_MUSIC * music,const void* rawSndhFile, int sndhFileSize, uint32_t hostReplayRate);
extern "C" __declspec(dllexport) bool SNDH_InitSubSong(SNDH_MUSIC * music,int subSongId);
extern "C" __declspec(dllexport) int SNDH_AudioRender(SNDH_MUSIC * music,int16_t * buffer, int count, uint32_t * pSampleViewInfo);

SNDH_MUSIC* SNDH_Init()
{
    return (SNDH_MUSIC*)(new SndhFile);
}

bool SNDH_Load(SNDH_MUSIC* music, const void* rawSndhFile, int sndhFileSize, uint32_t hostReplayRate) {
    SndhFile* pMusic = (SndhFile*)music;
    return pMusic->Load(rawSndhFile, sndhFileSize, hostReplayRate);
}

bool SNDH_InitSubSong(SNDH_MUSIC* music,int subSongId) {
    SndhFile* pMusic = (SndhFile*)music;
    return pMusic->InitSubSong(subSongId);
}

int SNDH_AudioRender(SNDH_MUSIC* music,int16_t* buffer, int count, uint32_t* pSampleViewInfo = NULL) {
    SndhFile* pMusic = (SndhFile*)music;
    return pMusic->AudioRender(buffer, count, pSampleViewInfo);
}

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

