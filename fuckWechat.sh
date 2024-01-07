#!/bin/bash

# 目标监控目录
WATCHED_DIR="/Users/jordan_qd/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/a04c27f1307b84a058a7ff33f7897785/Message/MessageTemp"

# 文件被移动到的目录
DESTINATION_DIR="/Users/jordan_qd/Downloads"

# 开始递归监控目录
fswatch -o "$WATCHED_DIR" | while read f; do
  # 查找所有名为File的目录，并对其中的每个文件执行操作
  find "$WATCHED_DIR" -type d -name "File" | while read file_dir; do
    for entry in "$file_dir"/*
    do
      if [ -f "$entry" ]; then # 确保它是一个文件
        echo "Detected new file $entry, moving to $DESTINATION_DIR"
        mv "$entry" "$DESTINATION_DIR" # 移动文件
      fi
    done
  done
done
