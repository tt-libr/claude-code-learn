---
paths:
  - "src/main/java/**/controller/**/*.java"
---

# API 设计规范

## URL 设计
- 路径使用名词复数：`/users`，不用 `/getUsers`
- 路径使用 kebab-case：`/user-profiles`，不用 `/userProfiles`
- 嵌套资源最多两层：`/users/{id}/orders`，避免更深层嵌套

## HTTP 语义
- GET：查询，不产生副作用
- POST：创建资源，返回 201 + Location header
- PUT：全量更新，幂等
- PATCH：部分更新
- DELETE：删除，返回 204

## 响应格式
- 成功：直接返回数据或空 204
- 错误：统一用 @RestControllerAdvice 返回结构化错误体
- 分页：返回包含 `content`、`totalElements`、`page`、`size` 的对象

## Controller 职责
- 只做：参数校验、调用 Service、返回响应
- **NEVER**: Controller 中写业务逻辑或直接操作数据库
