chcp 65001
@echo off
@title git快捷工具-by yaunsine
@echo ################################################################################
@echo ## git快捷工具-by yaunsine(https://github.com/yaunsine/git-win-console)     ##
@echo ################################################################################

:menu
echo  ======================================
echo "1、首次配置远程仓库链接"
echo "2、修改配置远程仓库链接"
echo "3、一键提交代码（仅支持master分支，默认提交信息为update）"
echo "4、加载文件进暂存区"
echo "5、提交并填写提交信息"
echo "6、查看add信息"
echo "7、查看commit信息"
echo "8、推送已提交内容到远程仓库"
echo "9、更新代码"
echo "11、clone代码"
echo "12、更新代码"
echo "13、查看当前分支"
echo "14、切换分支"
echo "15、配置socks5代理端口"
echo "16、清除socks5代理端口"
echo "17、查看全局配置"
echo "0、退出程序"
echo  ======================================

set /p command="请输入指令:> "
if "%command%"=="1" goto addOrigin
if "%command%"=="2" goto updateOrigin
if "%command%"=="3" goto autoPush
if "%command%"=="4" goto addToStash
if "%command%"=="5" goto commitAndWrite
if "%command%"=="6" goto showStatus
if "%command%"=="7" goto showCommit
if "%command%"=="8" goto pushBranch
if "%command%"=="9" goto initGit
if "%command%"=="11" goto cloneGit
if "%command%"=="12" goto pullGit
if "%command%"=="13" goto showBranch
if "%command%"=="14" goto checkoutBranch
if "%command%"=="15" goto proxyPort
if "%command%"=="16" goto unsetProxyPort
if "%command%"=="17" goto showConfig
if "%command%"=="0" goto exitSys
echo "错误：输入的指令无效，请重试"
goto menu

:showConfig
git config --global --list
goto menu

:proxyPort
set /p pport="请输入代理端口:> "
git config --global http.proxy socks5://127.0.0.1:%pport%
git config --global https.proxy socks5://127.0.0.1:%pport%
goto menu

:unsetProxyPort
git config --global --unset http.proxy
git config --global --unset https.proxy
goto menu

:cloneGit
set /p originUrl="请输入远程仓库链接:> "
git clone %originUrl%
goto menu

:pullGit
set /p originUrl="请输入远程仓库链接:> "
set /p branchName="请输入分支名称:> "
if "%branchName%"=="" (set branchName="master")
git pull %originUrl% %branchName%
goto menu

:showBranch
git branch
goto menu

:checkoutBranch
set /p branchName="请输入分支名称:> "
if "%branchName%"=="" (set branchName="master")
git checkout %branchName%
goto menu

:autoPush
git add .
git commit -m "update"
git push origin master
goto menu

:addOrigin
set /p originUrl="请输入远程仓库链接: "
git remote add origin %originUrl%
goto menu

:updateOrigin
set /p originUrlNew="请输入更改后的远程仓库链接:> "
git remote set-url origin %originUrlNew%
goto menu

:addToStash
set /p updatefilenames="输入需要暂存的文件（默认为全部）:> "
if "%updatefilenames%"=="" (set updatefilenames=".")
git add %updatefilenames%
echo 暂存成功.
goto menu

:commitAndWrite
set /p commitMsg="输入提交信息（默认为update）:> "
if "%commitMsg%"=="" (set commitMsg="update")
git commit -m "%commitMsg%"
goto menu

:pushBranch
set /p branchName="输入分支（默认为master）:> "
if "%branchName%"=="" (set branchName="master")
git push origin %branchName%
goto menu

:showStatus
git status
goto menu

:showCommit
git log
goto menu

:initGit
git init
goto menu

:exitSys
pause