---
paths:
  - "src/main/java/**/*.java"
---

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
