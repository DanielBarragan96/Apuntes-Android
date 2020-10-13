cd "%CD%"
set misc_dir=E:\Projects\Android\misc
set /P name="Project name: "
call flutter create %name%
cd %name%
call python %misc_dir%\update_sdk.py
call xcopy %misc_dir%\open_vscode.bat %CD%\
code .