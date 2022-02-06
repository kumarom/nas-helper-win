@ECHO OFF

if exist Y:\ (
  :: Assign a Drive letter to the disk
  echo Unmounting the Disk
  echo select disk 1 > %TEMP%\unassign-driveletter.dp
  echo select partition 1 >> %TEMP%\unassign-driveletter.dp
  echo remove >> %TEMP%\unassign-driveletter.dp
  echo exit >> %TEMP%\unassign-driveletter.dp
  Diskpart /s %TEMP%\unassign-driveletter.dp
)

echo Searching for Session ID
FOR /F "TOKENS=1* DELIMS=:" %%G IN ('"iscsicli sessionList dummy | findstr /B Session"') DO (
  echo Found session ID %%H
  echo Logout and disconnect
  iscsicli LogoutTarget %%H
)