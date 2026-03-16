# 项目：claude-code-learn
Spring Boot 3 学习项目，用于实践 Claude Code 最佳实践。
技术栈：Spring Boot 3.2.3、Java 17、Maven

# 构建与测试
- 编译：`mvn compile`
- 测试：`mvn test`
- 单个测试：`mvn test -Dtest=ClassName`
- 打包：`mvn package -DskipTests`
- 运行：`mvn spring-boot:run`

# 架构
- 当前只有 Controller 层，无 Service/Repository
- 包结构：`com.example.learn.<layer>`

# 代码规范
详细规范见 `.claude/rules/`（代码风格、测试、安全）
- 使用构造器注入，不用 @Autowired 字段注入
- API 路径 kebab-case，异常用 @RestControllerAdvice

# 工作流
- **IMPORTANT**: 修改代码后运行 `mvn compile` 确认编译通过
- **IMPORTANT**: 提交前运行 `mvn test` 确认测试通过
- **NEVER**: 不要修改 `src/test/` 下已有的测试文件

# 压缩指令
When compacting, preserve:
- 修改过的文件完整列表
- 测试命令和结果
- 未完成的任务
