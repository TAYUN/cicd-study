#!/bin/bash

# 部署脚本 - 适配当前服务器环境
# 用法: sh deploy.sh [start|restart]

APP_NAME="cicd-study"
APP_DIR="/home/admin/app"
WEB_ROOT="/www/server/nginx/html"
KEEP_BACKUPS=3

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

start() {
    log "开始部署 $APP_NAME..."

    # 检查制品包是否存在
    if [ ! -f "$APP_DIR/index.html" ]; then
        log "错误: 找不到 $APP_DIR/index.html 文件"
        log "请确认云效流水线已正确下载制品包到 $APP_DIR"
        exit 1
    fi

    # 清理旧备份（保留最近3个）
    ls -t "$WEB_ROOT"/app.bak.* 2>/dev/null | tail -n +$((KEEP_BACKUPS + 1)) | xargs rm -rf 2>/dev/null

    # 备份旧版本
    if [ -d "$WEB_ROOT/app" ]; then
        mv "$WEB_ROOT/app" "$WEB_ROOT/app.bak.$(date +%s)"
        log "✅ 已备份旧版本"
    fi

    # 部署新版本（直接从 APP_DIR 复制，无需 dist 子目录）
    mkdir -p "$WEB_ROOT/app"
    cp -r "$APP_DIR"/* "$WEB_ROOT/app/" || { log "❌ 复制失败！"; exit 1; }
    
    # 设置权限（使用服务器实际的 www 用户）
    chown -R www:www "$WEB_ROOT/app"
    chmod -R 755 "$WEB_ROOT/app"
    log "✅ 已设置权限"

    # 健康检查
    if [ -f "$WEB_ROOT/app/index.html" ]; then
        log "✅ 部署验证通过"
        log "🎉 $APP_NAME 部署成功！"
        log "🌐 访问地址: http://$(curl -s ifconfig.me 2>/dev/null || echo '服务器IP')/app/"
    else
        log "❌ 部署失败：index.html 不存在"
        exit 1
    fi
}

case "$1" in
    start|restart)
        start
        ;;
    *)
        echo "用法: $0 {start|restart}"
        exit 1
        ;;
esac