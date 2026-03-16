---
paths:
  - "src/main/resources/static/**/*.{jsx,tsx}"
  - "frontend/src/**/*.{jsx,tsx}"
---

# React 规范

## 组件
- 使用函数式组件 + Hooks，不用 Class 组件
- 组件文件名 PascalCase：`UserCard.tsx`
- 每个文件只导出一个主组件

## State 管理
- 局部状态用 useState/useReducer
- 跨组件共享状态用 Context 或状态管理库（Zustand 优先）
- **NEVER**: 不在组件外部直接修改 state

## 副作用
- 异步操作放在 useEffect，依赖数组要完整
- 清理函数必须 return（定时器、订阅等）

## 性能
- 列表渲染必须有稳定的 key（不用 index 作为 key，除非列表不变）
- 大组件用 React.memo 避免不必要重渲染
