# 流水线部署脚本
# 确保目录存在
mkdir -p /home/admin/app
# 解压制品包
tar zxvf /home/admin/app/package.tgz -C /home/admin/app/
# 执行部署
sh /home/admin/app/deploy.sh restart