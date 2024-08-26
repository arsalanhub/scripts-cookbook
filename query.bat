@echo off
setlocal

:: Define your SQL Server instance, database, and output file

:: set USER=sa
:: set PASSWORD=YourPassword
:: Run sqlcmd and export the result to CSV
:: sqlcmd -S %SERVER% -U %USER% -P %PASSWORD% -d %DATABASE% -Q "%~1" -s "," -o "%OUTPUT_FILE%"

set SERVER=cloudqadb.hhaexchange.local\SQL2012
set DATABASE=hhahistory
set OUTPUT_FILE=output.csv
set query="select top 10 * from Audit.History"

sqlcmd -S %SERVER% -d %DATABASE% -Q %query% -s "," -o "%OUTPUT_FILE%"

pause

endlocal
