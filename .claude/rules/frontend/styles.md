---
paths:
  - "src/main/resources/static/**/*.{css,scss}"
  - "frontend/src/**/*.{css,scss,module.css}"
---

# 样式规范

## 命名
- 使用 BEM 命名：`.block__element--modifier`
- CSS Modules 场景用 camelCase：`styles.userCard`
- 不用全局样式（除 reset/base）

## 布局
- 优先 Flexbox 和 Grid，不用 float
- 响应式用 mobile-first：先写小屏，再用 min-width 覆盖

## 变量
- 颜色、间距、字体统一用 CSS 变量（`--color-primary`）
- **NEVER**: 不在组件样式中硬编码颜色值，用变量引用

## 性能
- 避免深层选择器（超过 3 层）
- 动画使用 transform/opacity，不用 top/left（触发重排）
