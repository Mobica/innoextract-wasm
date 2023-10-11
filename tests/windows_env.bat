curl https://www.autoitscript.com/files/autoit3/autoit-v3.zip --output %USERPROFILE%\Downloads\autoit-v3.zip
cd %USERPROFILE%\Downloads
tar -xf autoit-v3.zip
setx path "%PATH%;%cd%\install"