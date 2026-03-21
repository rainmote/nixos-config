#!/usr/bin/env bash

# 配置区
API_URL="https://wallhaven.cc/api/v1/search?q=resolution:3840x2160&sorting=random&atleast=4k"
SAVE_DIR="$HOME/Pictures/Wallpapers/4K_Auto"
mkdir -p "$SAVE_DIR"

# 检查 swww 守护进程是否运行
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon & 
    sleep 1
fi

while true; do
    # 1. 从 API 获取随机 4K 图片链接
    img_url=$(curl -s "$API_URL" | jq -r '.data[0].path')

    if [ "$img_url" != "null" ]; then
        img_name=$(basename "$img_url")
        target_path="$SAVE_DIR/$img_name"

        # 2. 下载图片（如果本地不存在）
        if [ ! -f "$target_path" ]; then
            curl -s -o "$target_path" "$img_url"
        fi

        # 3. 使用 swww 切换壁纸（带特效）
        # transition-type 可选: fps, step, center, outer, wipe, wave, grow, any
        swww img "$target_path" \
            --transition-type grow \
            --transition-pos 0.85,0.85 \
            --transition-step 90 \
            --transition-duration 2

        # 4. 每隔 30 分钟更换一次
        sleep 86400
    else
        # 如果网络请求失败，等待 1 分钟后重试
        sleep 60
    fi
done
