---
name: fix-issue
description: 分析并修复 GitHub Issue，自动运行测试并创建 PR
disable-model-invocation: true
---

分析并修复 GitHub Issue: $ARGUMENTS。

1. 使用 `gh issue view $ARGUMENTS` 获取 Issue 详情
2. 理解问题描述，搜索代码库找到相关 Java 文件
3. 实现必要的修改
4. 编写测试用例验证修复（先写测试，再写实现）
5. 运行 `mvn test` 确保所有测试通过
6. 运行 `mvn compile` 确认编译无误
7. 提交代码，消息格式：`fix: <描述> (closes #$ARGUMENTS)`
8. 使用 `gh pr create` 创建 PR，描述中注明 `Closes #$ARGUMENTS`
9. 输出 PR URL
