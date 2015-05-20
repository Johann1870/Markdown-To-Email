::Stages File (Moves from Working to Stage folder)
::Set the path of your repository to PATH1
::If this is on a UNC path, use the PUSHD and POPD commands.
::Takes argument of the name of the file to be staged
::Don't include the file extension
::
::Example:
::			Stage 98005SM
::
::This will stage the file.
::
@ECHO OFF
ECHO (C) J. Ditzel & ECHO.May 2015
SETLOCAL

	SET CURD=%CD%
	SET arg1=%1
	SET arg1=%arg1%.md
	SET PATH1=J:\rec\notes

	PUSHD J:\
	CD %PATH1%\Working
		MOVE %arg1% %PATH1%\Stage\%arg1%
	POPD
	CD %CURD%
ENDLOCAL
@ECHO ON