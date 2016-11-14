WebDav完全可以当成一个网络共享的文件服务器使用！

# 1. 修改了两个配置文件
# 2. 创建web访问用户的用户名和口令
# 3. 创建了两个目录，并且设置了管理权限

# 切换目录
$ cd /etc/apache2
$ sudo vim httpd.conf
# 查找httpd-dav.conf
/httpd-dav.conf
"删除行首#"
# 将光标定位到行首
0
# 删除行首的注释
x
# 保存退出
:wq
# 切换目录
$ cd /etc/apache2/extra
# 备份文件（只要备份一次就行）
$ sudo cp httpd-dav.conf httpd-dav.conf.bak
# 编辑配置文件
$ sudo vim httpd-dav.conf
"将Digest修改为Basic"
# 查找Digest
/Digest
# 进入编辑模式
i
# 返回到命令行模式
ESC
# 保存退出
:wq
# 切换目录，可以使用鼠标拖拽的方式
$ cd 保存put脚本的目录
# 以管理员权限运行put配置脚本
$ sudo ./put

设置两次密码: 123456


注意：要在Mac 10.10配置Web-dav还需要在httpd.conf中打开以下三个模块

LoadModule dav_module libexec/apache2/mod_dav.so
LoadModule dav_fs_module libexec/apache2/mod_dav_fs.so
LoadModule auth_digest_module libexec/apache2/mod_auth_digest.so
