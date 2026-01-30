#!/bin/bash
set -e

CONFIG_DIR="/root/.openclaw"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
CONFIG_EXAMPLE="$CONFIG_DIR/config.yaml.example"

# 确保目录存在（兼容空卷挂载）
mkdir -p "$CONFIG_DIR"

# 如果配置文件不存在，复制示例配置
if [ ! -f "$CONFIG_FILE" ]; then
    echo "📝 首次运行，创建默认配置文件..."
    if [ -f "$CONFIG_EXAMPLE" ]; then
        cp "$CONFIG_EXAMPLE" "$CONFIG_FILE"
        echo "⚠️  请编辑配置文件并填入你的 API Key: $CONFIG_FILE"
    else
        cat > "$CONFIG_FILE" <<'EOF'
# OpenClaw Docker 配置占位文件
# 请根据实际需求填写或使用环境变量配置。
# 文档: https://openclaw.ai/docs
EOF
        echo "⚠️  未找到示例配置，已创建占位文件: $CONFIG_FILE"
    fi
fi

# 确保目录存在
mkdir -p "$CONFIG_DIR/logs"
mkdir -p "$CONFIG_DIR/data"
mkdir -p "$CONFIG_DIR/skills"

# 打印启动信息
echo ""
echo "🦞 OpenClaw Docker Container"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "配置目录: $CONFIG_DIR"
echo "日志目录: $CONFIG_DIR/logs"
echo "技能目录: $CONFIG_DIR/skills"
echo "网关端口: 18789"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 执行传入的命令
exec "$@"
