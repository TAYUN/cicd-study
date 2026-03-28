#!/bin/bash

# 部署脚本 - 适配宝塔面板环境
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

    # 检查构建产物是否存在
    if [ ! -f "$APP_DIR/index.html" ]; then
        log "❌ 错误: 找不到 $APP_DIR/index.html"
        log "请确认制品包已正确解压"
        exit 1
    fi

    # 清理旧备份（保留最近 N 个）
    ls -t "$WEB_ROOT"/app.bak.* 2>/dev/null | tail -n +$((KEEP_BACKUPS + 1)) | xargs rm -rf 2>/dev/null

    # 备份旧版本
    if [ -d "$WEB_ROOT/app" ]; then
        BACKUP_NAME="$WEB_ROOT/app.bak.$(date +%s)"
        mv "$WEB_ROOT/app" "$BACKUP_NAME"
        log "📦 已备份旧版本: $BACKUP_NAME"
    fi

    # 部署新版本
    mkdir -p "$WEB_ROOT/app" || { log "❌ 创建目录失败"; exit 1; }
    cp -r "$APP_DIR"/* "$WEB_ROOT/app/" || { log "❌ 复制失败"; exit 1; }
    
    # 设置权限
    chown -R www:www "$WEB_ROOT/app"
    chmod -R 755 "$WEB_ROOT/app"
    log "✅ 已设置权限"

    # 健康检查
    if [ -f "$WEB_ROOT/app/index.html" ]; then
        log "✅ 部署验证通过"
        log "🎉 $APP_NAME 部署成功！"
        log "🌐 访问地址: http://你的服务器IP/app/"
    else
        log "❌ 部署失败: index.html 不存在"
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