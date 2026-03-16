# Design: Spring Boot 3 Hello Project with Claude Code Best Practices

**Date:** 2026-03-16
**Status:** Approved

---

## Overview

A Spring Boot 3 learning project that demonstrates the complete Claude Code best practices configuration structure alongside a minimal Hello Controller implementation.

**Goals:**
- Learn Claude Code best practices through a real, runnable project
- Establish a complete `.claude/` configuration structure for future reference
- Implement a simple Spring Boot 3 REST API as the application scaffold

---

## Project Structure

```
claude-code-learn/
├── CLAUDE.md                      # 项目指令（构建命令、规范）
├── CLAUDE.local.md                # 个人偏好（gitignore）
├── .gitignore
├── .claude/
│   ├── settings.json              # 权限白名单、Hooks
│   ├── settings.local.json        # 个人设置（gitignore）
│   ├── rules/
│   │   ├── code-style.md          # Java/Spring 代码风格
│   │   ├── testing.md             # 测试规范
│   │   └── security.md            # 安全要求
│   ├── agents/
│   │   └── code-reviewer.md       # Java 代码审查子代理
│   ├── skills/
│   │   └── commit-push-pr/
│   │       └── SKILL.md           # 一键提交推送创建PR
│   └── worktrees/                 # gitignore
├── .mcp.json                      # MCP 配置（占位）
├── pom.xml
└── src/
    ├── main/java/com/example/learn/
    │   ├── LearnApplication.java
    │   └── controller/
    │       └── HelloController.java
    ├── main/resources/
    │   └── application.yml
    └── test/java/com/example/learn/
        └── controller/
            └── HelloControllerTest.java
```

---

## Spring Boot Application

**Tech Stack:**
- Spring Boot 3.2.x
- Java 17
- Maven
- GroupId: `com.example.learn`

**Dependencies:**
- `spring-boot-starter-web`
- `spring-boot-starter-test`

**API Endpoints:**
| Method | Path | Response |
|--------|------|----------|
| GET | `/hello` | `"Hello, World!"` |
| GET | `/hello/{name}` | `"Hello, {name}!"` |

**Testing:**
- `@WebMvcTest` for HelloController
- Validates HTTP status 200 and response body for both endpoints

---

## CLAUDE.md Content

```markdown
# 项目：claude-code-learn
Spring Boot 3 学习项目，用于实践 Claude Code 最佳实践。

# 构建与测试
- 编译：`mvn compile`
- 测试：`mvn test`
- 单个测试：`mvn test -Dtest=ClassName`
- 打包：`mvn package -DskipTests`
- 运行：`mvn spring-boot:run`

# 代码规范
- 包结构：`com.example.learn.<layer>`（controller/service/repository）
- 使用构造器注入，不用 @Autowired 字段注入
- API 路径使用 kebab-case
- 异常统一用 @RestControllerAdvice 处理

# 工作流
- **IMPORTANT**: 修改代码后运行 `mvn compile` 确认编译通过
- **IMPORTANT**: 提交前运行 `mvn test` 确认测试通过
- **NEVER**: 不要修改 `src/test/` 下已有的测试文件
```

---

## .claude/settings.json

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": [
      "Bash(mvn compile)",
      "Bash(mvn test *)",
      "Bash(mvn package *)",
      "Bash(mvn spring-boot:run)",
      "Bash(mvn dependency:resolve *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(git push *)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Bash(rm -rf *)",
      "Bash(curl *)"
    ]
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | grep -E '\\.java$' | xargs -I{} echo 'Modified: {}'"
          }
        ]
      }
    ]
  },
  "env": {
    "CLAUDE_CODE_EFFORT_LEVEL": "high"
  }
}
```

---

## Rules Files Summary

- **code-style.md**: Java 17 features, constructor injection, kebab-case API paths, record types for DTOs
- **testing.md**: `@WebMvcTest` for controllers, JUnit 5, no mocking unless necessary
- **security.md**: No hardcoded secrets, validate inputs, use Spring Security defaults

## Agents Summary

- **code-reviewer.md**: Read-only Java code reviewer focused on Spring best practices, security, and performance

## Skills Summary

- **commit-push-pr/SKILL.md**: Automates `git add → commit → push → gh pr create` workflow

---

## Success Criteria

1. `mvn spring-boot:run` starts successfully on port 8080
2. `GET /hello` returns `"Hello, World!"` with HTTP 200
3. `GET /hello/Claude` returns `"Hello, Claude!"` with HTTP 200
4. `mvn test` passes all tests
5. All `.claude/` configuration files are in place and functional
