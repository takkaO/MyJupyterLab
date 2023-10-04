@echo off
rem https://www.idnet.co.jp/column/page_187.html
setlocal

for /f "usebackq" %%X in (`docker-compose ps -q`) do set DCPS=%%X
if ""%DCPS%%""=="""" (goto __LAUNCH__) else (goto __SHUTDOWN__)

:__LAUNCH__
echo Launch...
docker-compose up -d
goto __END__

:__SHUTDOWN__
echo Shutdown...
docker-compose down
goto __END__

:__END__