---
paths:
  - "src/**/*.java"
  - "src/main/resources/**"
---

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
