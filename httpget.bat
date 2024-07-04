
:'@cscript //nologo //e:vbscript "%~f0" %* & @exit /b
'
'	munchovie did this code use as httpget 'http://google.com'
'
on error resume next  
for each p In getobject("winmgmts:\\.\root\cimv2").execquery( replace( "select commandline from Win32_Process where name = 'cscript.exe' and commandline like '%" &  wscript.scriptfullname  &  "%'" , "\", "\\" ), "WQL", &h10 + &h20)
	url = mid( p.commandline, instr( p.commandline, "'" ) + 1, instrrev( p.commandline, "'" )-instr( p.commandline, "'" )-1 )
	for each pair in split( " amp ,&; lt ,<; gt ,>;stdout ,wscript.echo ", ";" )
		url = replace( url, split( pair, "," )(0), split( pair, "," )(1) )
	next
	'wscript.echo "getting " + url

	with CreateObject( "WinHttp.WinHttpRequest.5.1" ) 
		.SetTimeouts 60000, 60000, 1200000, 1200000
 		.open "get", url
		.send 
		
		if ( err.number ) then 
			wscript.echo err.number + " " + err.description 
		else
			wscript.echo .status & vbcrlf
			wscript.echo .ResponseText
		end if
	end with	 
next

 
 
