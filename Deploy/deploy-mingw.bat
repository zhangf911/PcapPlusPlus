set /p LATEST_RELEASE=<Deploy\latest_release.version
for /f %%i in ('C:\MinGW\bin\g++ -dumpversion') do set COMPILER_VERSION=%%i
set DIST_DIR_NAME=PcapPlusPlus-%LATEST_RELEASE%-windows-%compiler%-gcc-%COMPILER_VERSION%

move Dist %DIST_DIR_NAME%

move %DIST_DIR_NAME%\mk\PcapPlusPlus.mk %DIST_DIR_NAME%\mk\temp.mk
echo PCAPPLUSPLUS_HOME := Drive:/your/PcapPlusPlus/folder> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
echo MINGW_HOME := Drive:/MinGW/folder>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
echo WINPCAP_HOME := Drive:/WpdPack/folder>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
if "%compiler%"=="mingw32" echo MSYS_HOME := $(MINGW_HOME)/msys/1.0>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
if "%compiler%"=="mingw-w64" echo MSYS_HOME := Drive:/MSYS/folder>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
more +1 %DIST_DIR_NAME%\mk\temp.mk>> %DIST_DIR_NAME%\mk\PcapPlusPlus.mk
del %DIST_DIR_NAME%\mk\temp.mk

xcopy Deploy\README.release.win.mingw %DIST_DIR_NAME%\README.release
del %DIST_DIR_NAME%\mk\platform.mk

7z a -r %DIST_DIR_NAME%.zip %DIST_DIR_NAME%\

curl --upload-file %DIST_DIR_NAME%.zip https://transfer.sh/%DIST_DIR_NAME%.zip