---
name: pr
description: 为当前已推送的分支创建格式化的 Pull Request
disable-model-invocation: true
---

为当前分支创建 Pull Request（假设代码已提交并推送）。

1. 运行 `git log main..HEAD --oneline` 获取提交历史
2. 运行 `git diff main --stat` 获取变更统计
3. 根据提交历史和变更内容，编写：
   - PR 标题：简洁描述变更（< 70 字符）
   - PR 描述：变更内容 + 测试方式 + 关联 Issue（如有）
4. 使用 `gh pr create --title "<标题>" --body "<描述>"` 创建 PR
5. 输出 PR URL
