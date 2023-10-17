curl https://www.autoitscript.com/files/autoit3/autoit-v3.zip -outfile $Env:userprofile\Downloads\autoit-v3.zip
cd $Env:userprofile\Downloads
tar -xf autoit-v3.zip

$oldPath=(Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name PATH).Path
$newPath=$oldPath+"$Env:userprofile\Downloads\install"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name PATH -Value $newPath
