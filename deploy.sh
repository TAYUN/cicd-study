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
    if [ ! -d "$APP_DIR/dist" ]; then
        log "错误: 找不到 $APP_DIR/dist 目录"
        log "请确认云效流水线已正确下载制品包到 $APP_DIR"
        exit 1
    fi

    # 清理旧备份（保留最近3个）
    ls -t "$WEB_ROOT"/dist.bak.* 2>/dev/null | tail -n +$((KEEP_BACKUPS + 1)) | xargs rm -rf 2>/dev/null

    # 备份旧版本
    if [ -d "$WEB_ROOT/dist" ]; then
        mv "$WEB_ROOT/dist" "$WEB_ROOT/dist.bak.$(date +%s)"
        log "✅ 已备份旧版本"
    fi

    # 部署新版本
    cp -r "$APP_DIR/dist" "$WEB_ROOT/" || { log "❌ 复制失败！"; exit 1; }
    
    # 设置权限（使用服务器实际的 www 用户）
    chown -R www:www "$WEB_ROOT/dist"
    chmod -R 755 "$WEB_ROOT/dist"
    log "✅ 已设置权限"

    # 健康检查
    if [ -f "$WEB_ROOT/dist/index.html" ]; then
        log "✅ 部署验证通过"
        log "🎉 $APP_NAME 部署成功！"
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