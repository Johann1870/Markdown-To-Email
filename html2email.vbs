'	This will convert an html file to the body of an 
' email and launch that email in Outlook.
'
'	This file is meant to be run from the command line
' or a batch file.
'
'	It takes two arguments in the form of the path of the
' html file and the Subject Line.
'
'	This will not accept UTF-8 encoding because the
' FileSystemObject only encodes ASCII. When using with
' pandoc, be sure to use the --ascii switch.
'
'	The 'To' field needs to be set in the code or could
' be set as a 3rd argument. Likewise for 'CC' and 'BCC'.
'
'	The .Display can be changed to .Send to
' automatically send the email.
'
'Example
'		html2email.vbs C:\folder\file.html subjectline
'


On Error Resume Next
'	Yes I know. Bad practice.

Dim htmlfile
Dim fso, ts, OutApp, OutMail

Set objArgs = Wscript.Arguments
htmlfile = objArgs(0)
strSubject = "Recipe Suggestion " & objArgs(1)
Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.GetFile(htmlfile).OpenAsTextStream(1, -2)
	HTMLtoString = ts.readall
		ts.close
	HTMLtoString = Replace(HTMLtoString, "align=center x:publishsource=", "align=left x:publishsource=")
Set ts = Nothing
Set fso = Nothing

Set OutApp = CreateObject("Outlook.Application")
Set OutMail = OutApp.CreateItem(0)
	With OutMail
		.To = "pat@cuizina.com"
		.CC = ""
		.BCC = "jonathan@cuizina.com"
		.Subject = strSubject
		.HTMLBody = HTMLtoString
		'.Send   'or use .Display
		.Display
	End With
Set OutMail = Nothing
Set OutApp = Nothing