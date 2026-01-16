import router from '@ohos.router';

@Entry
@Component
struct PrivacyPolicy {
  @State title: string = "隐私政策"

  build() {
    Column() {
      // 标题栏
      Row() {
        Button() {
          Text("‹")
            .fontSize(30)
            .fontColor(Color.Black)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          router.back();
        })

        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 占位，保持标题居中
        Row()
          .width(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)

      // 内容区域
      Scroll() {
        Column({ space: 20 }) {
          Text("隐私政策")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text("更新日期：2026年1月15日")
            .fontSize(12)
            .fontColor('#999999')
            .width('100%')

          Text("引言")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("欢迎使用「AreYouAlive」应用！我们非常重视用户的隐私保护和个人信息保护。本隐私政策旨在向您说明我们如何收集、存储、使用、共享和保护您的个人信息。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("一、信息收集")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("1.1 个人信息\n我们可能收集以下信息：\n• 用户姓名\n• 紧急联系人信息（姓名和电话号码）\n• 签到记录和时间戳\n• 地理位置信息（签到时的经纬度，需用户授权）\n• 设备信息（用于SMS发送的SIM卡信息）\n• 应用日志信息")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("1.2 信息收集方式\n• 您主动提供的信息\n• 应用自动收集的信息\n• 第三方合作伙伴提供的信息")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("二、信息使用")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("我们使用收集的信息用于：\n• 提供签到记录和保存服务\n• 后台定时监控签到状态（48小时阈值）\n• 发送SMS紧急求救通知给紧急联系人\n• 在求救短信中包含最后签到时间和位置信息\n• 应用功能改进和技术支持\n• 安全保障和防范欺诈")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("三、信息存储")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("3.1 存储位置\n您的个人信息（包括签到记录、紧急联系人信息、位置信息等）将存储在本地设备中，不会上传至云端服务器。\n\n3.2 数据安全\n我们将采取合理的技术措施保护您的信息安全，包括但不限于数据加密、访问控制等，防止信息丢失、泄露或被滥用。\n\n3.3 数据保留\n用户数据将在应用卸载后被删除。用户也可以随时手动删除所有数据。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("四、信息共享")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("4.1 信息共享原则\n我们承诺不会向第三方出售、出租或以其他方式披露您的个人信息。\n\n4.2 紧急联系人通知\n在以下情况下，您的信息将通过SMS短信发送给紧急联系人：\n• 当您超过48小时未签到时，系统将自动发送求救短信\n• 短信内容包括：您的姓名、最后签到时间、最后签到位置（经纬度）\n\n4.3 法律要求\n仅在以下情况下，我们可能披露您的信息：\n• 根据法律法规或政府要求\n• 保护用户或公众的生命财产安全\n• 保护应用的合法权益\n\n4.4 第三方服务\n• SMS短信服务：通过运营商网络发送，可能产生短信费用\n• 位置服务：使用系统定位服务")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("五、紧急联系人通知")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("5.1 功能说明\n当您超过48小时未签到时，系统将在后台自动检测，并通过SMS短信以您的名义通知您设置的紧急联系人。\n\n5.2 短信内容\n发送的求救短信将包含以下信息：\n• 您的姓名\n• 最后签到时间\n• 最后签到位置（经纬度坐标）\n\n5.3 用户权利\n• 您可以随时添加、修改或删除紧急联系人\n• 您可以随时关闭签到提醒功能\n• 您可以随时清除所有签到记录\n\n5.4 费用说明\n发送求救短信可能产生SMS短信费用，具体费用由运营商收取，与本应用无关。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("六、您的权利")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("您对自己的个人信息享有以下权利：\n• 访问和查看：在应用内查看所有个人信息和签到记录\n• 更正和更新：随时修改用户信息、紧急联系人信息\n• 删除：随时删除签到记录或清除所有数据\n• 撤回同意：随时关闭位置权限、SMS权限\n• 停止使用：卸载应用即停止使用所有服务\n• 数据导出：所有数据均存储在本地，您可自由访问")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("七、联系我们")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("如果您对本隐私政策有任何疑问、意见或建议，请通过以下方式联系我们：\n\n邮箱：support@areyoualive.com\n\n我们将在收到您的反馈后尽快回复。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("八、政策更新")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("我们可能会不时更新本隐私政策。更新后的政策将在应用内公布，请您定期查看。继续使用我们的应用即表示您接受更新后的隐私政策。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F5F5F5')
  }
}
