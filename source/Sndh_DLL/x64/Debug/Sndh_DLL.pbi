
;bool SNDH_Load(const void* rawSndhFile, int sndhFileSize, uint32_t hostReplayRate);
;bool SNDH_InitSubSong(int subSongId);
;int SNDH_AudioRender(int16_t * buffer, int count, uint32_t * pSampleViewInfo);

PrototypeC SNDH_Load(*rawSndhFile,sndhFileSize.i,hostReplayRate.i) : Global SNDH_Load.SNDH_Load
PrototypeC SNDH_InitSubSong(subSongId.i) : Global SNDH_InitSubSong.SNDH_InitSubSong
PrototypeC SNDH_AudioRender(*buffer,count.i,*pSampleViewInfo = 0) : Global SNDH_AudioRender.SNDH_AudioRender

If OpenLibrary(0,"Sndh_DLL.dll")
  
  Debug("OPENED: Sndh_DLL.dll")
  SNDH_Load = GetFunction(0, "SNDH_Load")
  SNDH_InitSubSong = GetFunction(0, "SNDH_InitSubSong")
  SNDH_AudioRender = GetFunction(0, "SNDH_AudioRender")
  
  ;Decade_Demo-Main_Menu.sndh
  ;ReadData()
  file.s = "Decade_Demo-Main_Menu.sndh"
  filesize.l = FileSize(file)
  If OpenFile(0,file)
    Debug("OPENED: "+file)    
    *memfilebuf_ptr = AllocateMemory(filesize)
    *memsndhbuf_ptr = AllocateMemory(44100*4)
    ReadData(0,*memfilebuf_ptr,filesize)    
    CloseFile(0)
    ; next passed to SNDH ??
    Debug "SNDH_Load() - Result?"
    Debug SNDH_Load(*membuf_ptr,filesize,44100)
    
    SNDH_AudioRender(*memsndhbuf_ptr,1)
    
    ShowMemoryViewer(*memsndhbuf_ptr,44100*2)
    
  EndIf
    
  CloseLibrary(0)
Else
  Debug("FAILED: Open Sndh_DLL.dll")  
EndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; CursorPosition = 24
; FirstLine = 2
; EnableXP
; DPIAware