md "C:\TOOL"

wget "https://fir3.net/zipc" -outfile "C:\TOOL\MZT_TOOL.zip"

Expand-Archive -LiteralPath 'C:\TOOL\MZT_TOOL.zip' -DestinationPath 'C:\TOOL'

del 'C:\TOOL\MZT_TOOL.zip'

Start-Process -FilePath "C:\TOOL\MZT_TOOL.exe" -Verb RunAs





