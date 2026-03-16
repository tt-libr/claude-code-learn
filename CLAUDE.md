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
