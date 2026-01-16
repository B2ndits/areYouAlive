# AreYouAlive - 生命安全签到应用

一款基于 HarmonyOS 开发的生命安全签到应用，帮助用户定期记录生存状态，并在长时间未签到时自动通知紧急联系人。

## 📱 项目简介

AreYouAlive 是一款关注用户生命安全的签到应用。当用户超过 48 小时未签到时，应用将自动向预设的紧急联系人发送求救短信，包含用户最后签到的时间和位置信息，为可能发生的意外情况提供及时预警。

## ✨ 核心功能

### 1. 用户签到
- 支持一键快速签到
- 自动记录签到时间和地理位置（经纬度）
- 本地保存签到历史记录

### 2. 48小时监控
- 后台定时任务，每小时自动检测签到状态
- 超过 48 小时未签到时自动触发报警
- 利用 HarmonyOS WorkScheduler 实现持久化后台监控

### 3. 紧急联系人管理
- 添加/编辑/删除紧急联系人
- 支持设置联系人姓名和电话号码
- 本地安全存储联系人信息

### 4. SMS 求救通知
- 自动发送求救短信给紧急联系人
- 短信内容包含：
  - 用户姓名
  - 最后签到时间
  - 最后签到位置（经纬度坐标）

### 5. 数据隐私
- 所有数据本地存储，不上传云端
- 支持随时清除所有个人数据
- 完整的隐私政策和用户协议

## 🛠 技术栈

- **开发框架**: HarmonyOS ArkTS
- **开发工具**: DevEco Studio
- **最低 API 版本**: API 10+
- **编程语言**: ArkTS (TypeScript 扩展)

### 核心依赖

- `@kit.TelephonyKit` - SMS 短信发送服务
- `@kit.BackgroundTasksKit` - 后台任务调度（WorkScheduler）
- `@kit.ArkData` - 本地数据持久化（Preferences）
- `@kit.LocationKit` - 地理位置定位服务
- `@kit.AbilityKit` - 应用能力管理

## 📦 项目结构

```
AreYouAlive/
├── entry/
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── entryability/
│   │   │   │   └── EntryAbility.ets          # 应用入口
│   │   │   ├── pages/
│   │   │   │   ├── Index.ets                 # 主页面（签到页）
│   │   │   │   ├── UserAgreement.ets         # 用户协议页面
│   │   │   │   └── PrivacyPolicy.ets         # 隐私政策页面
│   │   │   └── services/
│   │   │       ├── SmsService.ets            # SMS 短信服务
│   │   │       └── WorkSchedulerService.ets  # 后台任务调度服务
│   │   ├── resources/
│   │   │   └── base/
│   │   │       ├── element/
│   │   │       │   └── string.json           # 字符串资源
│   │   │       └── profile/
│   │   │           └── main_pages.json       # 页面路由配置
│   │   └── module.json5                      # 模块配置
│   └── build/
├── AppScope/
│   └── resources/
│       └── base/
│           └── element/
│               └── string.json               # 应用级字符串资源
├── oh-package.json5                          # 项目依赖配置
├── build-profile.json5                       # 构建配置
└── README.md
```

## 🔐 应用权限

应用需要以下权限才能正常运行：

| 权限名称 | 用途 | 申请时机 |
|---------|------|---------|
| `ohos.permission.APPROXIMATELY_LOCATION` | 获取签到时的地理位置信息 | 使用时 |
| `ohos.permission.LOCATION` | 获取精确位置（可选） | 使用时 |
| `ohos.permission.SEND_MESSAGES` | 发送求救短信给紧急联系人 | 使用时 |
| `ohos.permission.KEEP_BACKGROUND_RUNNING` | 后台定时监控签到状态 | 系统级 |
| `ohos.permission.GET_BUNDLE_INFO` | 获取应用信息 | 系统级 |

## 🚀 快速开始

### 环境要求

- DevEco Studio 5.0.0 或更高版本
- HarmonyOS API 10+ SDK
- Node.js 和 ohpm 包管理器

### 安装步骤

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd areYouAlive
   ```

2. **安装依赖**
   ```bash
   ohpm install
   ```

3. **配置应用**

   在 `entry/src/main/module.json5` 中修改 bundleName：
   ```json
   {
     "module": {
       "bundleName": "your.bundle.name"
     }
   }
   ```

4. **构建运行**
   - 连接 HarmonyOS 设备或启动模拟器
   - 点击 DevEco Studio 的运行按钮
   - 或使用命令行：
     ```bash
     hvigorw assembleHap
     ```

## 📱 使用说明

### 首次使用

1. **设置用户信息**
   - 打开应用，输入您的姓名
   - 添加至少一位紧急联系人（姓名 + 电话号码）

2. **授权权限**
   - 位置权限：用于记录签到时的位置
   - 短信权限：用于发送求救通知
   - 后台运行权限：用于 48 小时监控

3. **完成首次签到**
   - 点击签到按钮
   - 应用将记录当前时间和位置

### 日常使用

- **每天签到一次**：建议每天至少签到一次，避免触发误报
- **查看签到记录**：在主页面查看历史签到信息
- **修改联系人**：随时可以添加、修改或删除紧急联系人

### 停止使用

- 卸载应用将自动清除所有数据
- 或在应用内手动清除所有个人数据

## ⚠️ 重要说明

### 责任免除

1. 本应用仅作为辅助安全工具，不能替代专业救援服务
2. 由于以下原因导致的通知延迟或失败，应用不承担责任：
   - 设备关机或断电
   - 网络信号中断
   - 运营商短信服务故障
   - 用户未及时签到
   - 其他不可抗力因素

3. 发送求救短信可能产生 SMS 费用，具体费用由运营商收取

### 使用建议

1. 定期签到（建议每天一次）
2. 确保设备有足够电量和网络信号
3. 定期检查紧急联系人信息是否准确
4. 告知紧急联系人本应用的存在和作用

## 📄 法律文件

- [用户协议](./entry/src/main/ets/pages/UserAgreement.ets)
- [隐私政策](./entry/src/main/ets/pages/PrivacyPolicy.ets)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 🔄 更新日志

### v1.0.0 (2026-01-15)
- ✨ 首次发布
- ✅ 实现基本签到功能
- ✅ 实现 48 小时监控和自动报警
- ✅ 实现 SMS 求救通知
- ✅ 实现紧急联系人管理
- ✅ 添加位置信息记录
- ✅ 完善用户协议和隐私政策

---

**AreYouAlive** - 让关爱的人知道你还活着 ❤️
