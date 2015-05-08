:: * Commits File (Moves from Stage to Commit, converts to HTML,
::  places the HTML file in the Published folder, and creates
::  an email with the body as the html.
::
:: * REQUIRES 'html2email.vbs' in the same directory to work.
::
:: * REQUIRES that the 'pandoc.exe' is in the local folder
::  of the User\AppData\Local\Pandoc. (Note: It is *not* required
::  to be installed. Merely placing the .exe file in a
::  folder named Pandoc under User\AppData will suffice)
::
:: * Set the path of your repository to PATH1
::
:: * If this is on a UNC path, use the PUSHD and POPD commands.
::
:: * Takes argument of the name of the file being committed.
::  Don't include the file extension
::
:: Example:
::			Commit 98005SM
::
:: * This commits the file. The .md file remains in the Commit folder
::  and the html file will be in the Published folder
::
@ECHO OFF

SETLOCAL
	SET Path=%PATH%;%USERPROFILE%\AppData\Local\Pandoc
	SET CURD=%CD%
	SET arg1=%1
	SET arg2=%arg1%.md
	SET PATH1=J:\rec\notes
	SET SUBJ=Recipe Suggestion %arg1%
	
	PUSHD J:\
	CD %PATH1%\Stage	
		COPY %arg2% %PATH1%\Commit\%arg2%
::------------------------------------------------	
	CD %PATH1%\Commit
		PANDOC %arg2% -f markdown -t html --ascii -s -o %PATH1%\Published\%arg1%.html
		html2email.vbs %PATH1%\Published\%arg1%.html %arg1%
	POPD
	CD %CURD%
ENDLOCAL
@ECHO ON
