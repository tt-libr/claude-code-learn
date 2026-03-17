---
name: review
description: 审查当前分支相对于 main 的所有变更，输出按严重度分类的问题列表
---

审查当前分支相对于 main 的所有变更。

1. 运行 `git diff main --name-only` 列出变更文件
2. 运行 `git diff main` 查看完整 diff
3. 逐个审查变更文件，重点检查：
   - 安全漏洞（SQL 注入、XSS、硬编码密钥）
   - 性能问题（N+1 查询、不必要的循环）
   - 错误处理是否完整
   - 边界情况是否覆盖
   - 代码风格一致性（构造器注入、kebab-case API 路径）
4. 运行 `mvn compile` 确认编译通过
5. 按严重度输出审查结果：
   - 🔴 Critical：必须修复
   - 🟡 Warning：建议修复
   - 🟢 Suggestion：可选优化
