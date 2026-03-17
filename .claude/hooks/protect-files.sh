#!/bin/bash
# PreToolUse Hook: 阻止编辑受保护的文件
# 退出码 2 = 阻止操作，stderr 发给 Claude

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# 受保护的文件/目录模式
PROTECTED_PATTERNS=(
    "src/test/"   # 测试文件不允许修改（CLAUDE.md NEVER 规则的硬性保障）
    ".env"        # 环境变量文件
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILE_PATH" == *"$pattern"* ]]; then
        echo "受保护文件，禁止编辑: $FILE_PATH (规则: $pattern)" >&2
        exit 2
    fi
done

exit 0
