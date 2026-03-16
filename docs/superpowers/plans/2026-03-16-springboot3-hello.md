# Spring Boot 3 Hello Project Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a runnable Spring Boot 3 Maven project with a Hello Controller and a complete Claude Code best-practices configuration structure.

**Architecture:** Single-module Maven project. REST layer only (no service/repository layers needed for this scope). Claude Code config lives entirely in `.claude/` and project-root files — no application code is modified for config.

**Tech Stack:** Spring Boot 3.2.x, Java 17, Maven, JUnit 5, Spring MVC Test (`@WebMvcTest`)

---

## File Map

| File | Action | Responsibility |
|------|--------|---------------|
| `pom.xml` | Create | Maven build descriptor, dependencies, Java 17 |
| `src/main/java/com/example/learn/LearnApplication.java` | Create | Spring Boot entry point |
| `src/main/resources/application.yml` | Create | Server port, app name |
| `src/test/java/com/example/learn/controller/HelloControllerTest.java` | Create | `@WebMvcTest` tests for both endpoints |
| `src/main/java/com/example/learn/controller/HelloController.java` | Create | `GET /hello` and `GET /hello/{name}` |
| `CLAUDE.md` | Create | Project instructions for Claude Code |
| `CLAUDE.local.md` | Create | Personal preferences template |
| `.gitignore` | Create | Ignore Maven targets, local Claude files |
| `.claude/settings.json` | Create | Shared permissions + hooks |
| `.claude/settings.local.json` | Create | Personal settings template |
| `.claude/rules/code-style.md` | Create | Java/Spring code style rules |
| `.claude/rules/testing.md` | Create | Testing rules |
| `.claude/rules/security.md` | Create | Security rules |
| `.claude/agents/code-reviewer.md` | Create | Java code reviewer sub-agent |
| `.claude/skills/commit-push-pr/SKILL.md` | Create | Commit-push-PR skill |
| `.mcp.json` | Create | MCP server config placeholder |

---

## Chunk 1: Project Foundation

### Task 1: Create pom.xml

**Files:**
- Create: `pom.xml`

- [ ] **Step 1: Create pom.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.3</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>claude-code-learn</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>claude-code-learn</name>
    <description>Spring Boot 3 project for learning Claude Code best practices</description>

    <properties>
        <java.version>17</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

- [ ] **Step 2: Verify Maven resolves dependencies**

Run: `mvn dependency:resolve -q`
Expected: BUILD SUCCESS (no errors)

---

### Task 2: Create application entry point and config

**Files:**
- Create: `src/main/java/com/example/learn/LearnApplication.java`
- Create: `src/main/resources/application.yml`

- [ ] **Step 1: Create LearnApplication.java**

```java
package com.example.learn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class LearnApplication {
    public static void main(String[] args) {
        SpringApplication.run(LearnApplication.class, args);
    }
}
```

- [ ] **Step 2: Create application.yml**

```yaml
server:
  port: 8080

spring:
  application:
    name: claude-code-learn
```

- [ ] **Step 3: Verify compilation**

Run: `mvn compile -q`
Expected: BUILD SUCCESS

- [ ] **Step 4: Commit**

```bash
git add pom.xml src/main/java/com/example/learn/LearnApplication.java src/main/resources/application.yml
git commit -m "chore: initialize Spring Boot 3 Maven project"
```

---

## Chunk 2: Hello Controller (TDD)

### Task 3: Write failing tests first

**Files:**
- Create: `src/test/java/com/example/learn/controller/HelloControllerTest.java`

- [ ] **Step 1: Create HelloControllerTest.java**

```java
package com.example.learn.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(HelloController.class)
class HelloControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void helloWorld_returnsHelloWorldString() throws Exception {
        mockMvc.perform(get("/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello, World!"));
    }

    @Test
    void helloName_returnsGreetingWithName() throws Exception {
        mockMvc.perform(get("/hello/Claude"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello, Claude!"));
    }
}
```

- [ ] **Step 2: Create skeleton controller so test compiles (but fails)**

```java
package com.example.learn.controller;

import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
}
```

- [ ] **Step 3: Run tests to confirm they fail**

Run: `mvn test -Dtest=HelloControllerTest -q`
Expected: FAIL — `No handler found for GET /hello` or `404`

---

### Task 4: Implement HelloController

**Files:**
- Modify: `src/main/java/com/example/learn/controller/HelloController.java`

- [ ] **Step 1: Implement both endpoints**

```java
package com.example.learn.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class HelloController {

    @GetMapping
    public String hello() {
        return "Hello, World!";
    }

    @GetMapping("/{name}")
    public String helloName(@PathVariable String name) {
        return "Hello, " + name + "!";
    }
}
```

- [ ] **Step 2: Run tests to confirm they pass**

Run: `mvn test -Dtest=HelloControllerTest -q`
Expected: BUILD SUCCESS, Tests run: 2, Failures: 0

- [ ] **Step 3: Run full test suite**

Run: `mvn test -q`
Expected: BUILD SUCCESS

- [ ] **Step 4: Commit**

```bash
git add src/
git commit -m "feat: add HelloController with GET /hello and GET /hello/{name}"
```

---

## Chunk 3: Claude Code Configuration

### Task 5: Create CLAUDE.md and .gitignore

**Files:**
- Create: `CLAUDE.md`
- Create: `CLAUDE.local.md`
- Create: `.gitignore`

- [ ] **Step 1: Create CLAUDE.md**

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

- [ ] **Step 2: Create CLAUDE.local.md**

```markdown
# 个人偏好（此文件已加入 .gitignore，不提交到 Git）

# 个人备注
# 在这里添加你的个人工作偏好，例如：
# - 偏好的调试方式
# - 本地环境特有的命令
```

- [ ] **Step 3: Create .gitignore**

```gitignore
# Maven
target/
*.class
*.jar
*.war

# IDE
.idea/
*.iml
.vscode/
*.DS_Store

# Claude Code — 个人配置（不提交）
CLAUDE.local.md
.claude/settings.local.json
.claude/worktrees/
```

- [ ] **Step 4: Commit**

```bash
git add CLAUDE.md .gitignore
git commit -m "chore: add CLAUDE.md and .gitignore"
```

---

### Task 6: Create .claude/settings.json

**Files:**
- Create: `.claude/settings.json`
- Create: `.claude/settings.local.json`

- [ ] **Step 1: Create .claude/settings.json**

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

- [ ] **Step 2: Create .claude/settings.local.json**

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "// comment": "个人设置，已加入 .gitignore"
}
```

- [ ] **Step 3: Commit**

```bash
git add .claude/settings.json
git commit -m "chore: add .claude/settings.json with permissions and hooks"
```

---

### Task 7: Create rules files

**Files:**
- Create: `.claude/rules/code-style.md`
- Create: `.claude/rules/testing.md`
- Create: `.claude/rules/security.md`

- [ ] **Step 1: Create .claude/rules/code-style.md**

```markdown
# Java/Spring 代码风格规范

## 通用
- 使用 Java 17 特性：record、sealed class、text block、switch expression
- 类名 PascalCase，方法名 camelCase，常量 UPPER_SNAKE_CASE
- 每个文件只定义一个顶级类

## Spring 规范
- 使用构造器注入，禁止 @Autowired 字段注入
- Controller 只做参数校验和结果返回，业务逻辑放 Service
- API 路径使用 kebab-case（例：/user-profiles，不用 /userProfiles）
- 全局异常处理使用 @RestControllerAdvice

## DTO
- 优先使用 Java record 定义 DTO
- 请求 DTO 以 Request 结尾，响应 DTO 以 Response 结尾
```

- [ ] **Step 2: Create .claude/rules/testing.md**

```markdown
# 测试规范

## 原则
- 测试先行（TDD）：先写失败的测试，再写实现
- **NEVER**: 不要修改已有测试文件
- **NEVER**: 不要为了让测试通过而削减断言

## Controller 测试
- 使用 @WebMvcTest，不要启动完整上下文
- 每个公共接口至少一个 happy path 测试
- 测试方法命名：`方法名_场景_期望结果`，例：`helloName_withValidName_returnsGreeting`

## 执行
- 运行单个测试：`mvn test -Dtest=ClassName`
- 运行全部测试：`mvn test`
- 提交前必须全部通过
```

- [ ] **Step 3: Create .claude/rules/security.md**

```markdown
# 安全规范

## 禁止事项
- **NEVER**: 代码中硬编码密码、API Key、密钥
- **NEVER**: 在日志中输出敏感信息（密码、token、用户隐私数据）
- **NEVER**: 读取或修改 .env / .env.* 文件

## 输入验证
- 所有外部输入（路径参数、请求体）必须校验
- 使用 @Valid + Bean Validation 注解
- PathVariable 的字符串参数注意长度限制

## 配置
- 敏感配置通过环境变量注入，不写入 application.yml
- 生产环境配置通过 Spring Profiles 隔离
```

- [ ] **Step 4: Commit**

```bash
git add .claude/rules/
git commit -m "chore: add .claude/rules (code-style, testing, security)"
```

---

### Task 8: Create agent and skill

**Files:**
- Create: `.claude/agents/code-reviewer.md`
- Create: `.claude/skills/commit-push-pr/SKILL.md`

- [ ] **Step 1: Create .claude/agents/code-reviewer.md**

```markdown
---
name: code-reviewer
description: 审查 Java/Spring Boot 代码质量、安全问题和最佳实践
tools: Read, Grep, Glob
model: claude-sonnet-4-6
---

你是一名资深 Java/Spring Boot 工程师，专注代码审查。只读代码，不修改文件。

审查时关注：
1. **安全**：SQL 注入、XSS、硬编码密钥、未校验输入
2. **Spring 规范**：是否使用构造器注入、Controller 是否含业务逻辑
3. **代码质量**：重复代码、命名不规范、过长的方法
4. **测试覆盖**：边界情况是否有对应测试

输出格式：
- 🔴 Critical：必须修复
- 🟡 Warning：建议修复
- 🟢 Suggestion：可选优化

每个问题给出：文件路径 + 行号 + 问题描述 + 修复建议。
```

- [ ] **Step 2: Create .claude/skills/commit-push-pr/SKILL.md**

```markdown
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
```

- [ ] **Step 3: Commit**

```bash
git add .claude/agents/ .claude/skills/
git commit -m "chore: add code-reviewer agent and commit-push-pr skill"
```

---

### Task 9: Create .mcp.json and finalize

**Files:**
- Create: `.mcp.json`

- [ ] **Step 1: Create .mcp.json**

```json
{
  "mcpServers": {
    "// comment": "在此添加项目级 MCP 服务器配置，例如 GitHub、Notion 等"
  }
}
```

- [ ] **Step 2: Run full test suite to verify everything still passes**

Run: `mvn test -q`
Expected: BUILD SUCCESS, Tests run: 2, Failures: 0

- [ ] **Step 3: Verify project structure is complete**

Run: `find . -not -path './target/*' -not -path './.git/*' | sort`
Expected: All files from the File Map are present

- [ ] **Step 4: Final commit**

```bash
git add .mcp.json docs/
git commit -m "chore: add .mcp.json placeholder and project docs"
```

---

## Success Criteria Verification

- [ ] `mvn spring-boot:run` starts on port 8080 with no errors
- [ ] `curl localhost:8080/hello` → `Hello, World!`
- [ ] `curl localhost:8080/hello/Claude` → `Hello, Claude!`
- [ ] `mvn test` → BUILD SUCCESS, Tests run: 2, Failures: 0
- [ ] All `.claude/` files exist and are committed to git
