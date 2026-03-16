---
name: commit-push-pr
description: 一键完成 git add、commit、push 并创建 Pull Request
disable-model-invocation: true
---

为当前变更创建提交并推送，然后创建 PR。执行步骤：

1. 运行 `git status` 查看变更文件列表
2. 运行 `git diff --stat` 确认变更范围
3. 根据变更内容生成符合 Conventional Commits 规范的提交消息
   - feat: 新功能
   - fix: 修复 bug
   - chore: 配置/构建相关
   - docs: 文档
   - test: 测试
4. 运行 `git add -A` 暂存所有变更
5. 运行 `git commit -m "<生成的消息>"`
6. 运行 `git push`
7. 运行 `gh pr create --title "<提交消息>" --body "## Summary\n<变更说明>"` 创建 PR
8. 输出 PR URL

如果 $ARGUMENTS 不为空，将其作为提交消息使用，跳过第 3 步。
