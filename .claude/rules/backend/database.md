---
paths:
  - "src/main/java/**/repository/**/*.java"
  - "src/main/java/**/entity/**/*.java"
  - "src/main/resources/db/**"
---

# 数据库规范

## Entity 设计
- 使用 @Entity + @Table(name = "snake_case_name") 明确表名
- 主键使用 @GeneratedValue(strategy = GenerationType.IDENTITY)
- 审计字段统一继承 BaseEntity（createdAt、updatedAt）
- **NEVER**: Entity 中不放业务逻辑，只放字段映射

## Repository
- 继承 JpaRepository，利用方法命名派生查询
- 复杂查询用 @Query + JPQL，避免原生 SQL（除性能瓶颈场景）
- 分页查询返回 Page<T>，不返回 List

## Migration
- 使用 Flyway 管理 schema 变更，脚本命名：`V{版本}__{描述}.sql`
- **NEVER**: 不要修改已执行的 migration 文件
- **NEVER**: 不要在代码中拼接 SQL 字符串（防 SQL 注入）

## 性能
- N+1 问题：关联查询用 @EntityGraph 或 JOIN FETCH
- 大数据量分页用游标分页（keyset pagination），不用 OFFSET
