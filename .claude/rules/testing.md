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
