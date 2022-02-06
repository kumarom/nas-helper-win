@ECHO OFF

set TARGET=iqn.2000-01.com.synology:nas.target-1.8c77f9afa75
if not exist Y:\ (
  :: Connect to ISCSI disk
  echo Adding NAS target
  iscsicli QAddTarget %TARGET% NAS
  echo Attaching NAS target
  iscsicli QLoginTarget %TARGET%
  
  
  :: Assign a Drive letter to the disk
  echo Assignning a drive letter to the disk
  echo select disk 1 > %TEMP%\assign-driveletter.dp
  echo select partition 1 >> %TEMP%\assign-driveletter.dp
  echo assign letter y >> %TEMP%\assign-driveletter.dp
  echo exit >> %TEMP%\assign-driveletter.dp
  
  Diskpart /s %TEMP%\assign-driveletter.dp
) else (
  echo Session already exists
)