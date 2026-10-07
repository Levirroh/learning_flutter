@echo off
REM Gera a pasta Android usando o Flutter instalado na maquina do estudante.
flutter create --platforms=android .
if errorlevel 1 exit /b 1
flutter pub get
pause
