import router from '@ohos.router';

@Entry
@Component
struct UserAgreement {
  @State title: string = "用户协议"

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
          Text("用户协议")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text("更新日期：2026年1月15日")
            .fontSize(12)
            .fontColor('#999999')
            .width('100%')

          Text("欢迎使用「AreYouAlive」")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text('感谢您选择使用「AreYouAlive」应用（以下简称"本应用"）。本用户协议是您与本应用运营者之间就使用本应用所订立的协议。请您仔细阅读本协议，特别是免除或限制责任的条款。')
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("一、服务内容")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("1.1 本应用是一款生命安全签到应用，帮助用户定期签到记录生存状态，并在长时间未签到时自动向紧急联系人发送求救短信。\n\n1.2 本应用提供的服务包括但不限于：\n• 用户信息管理与设置\n• 定期签到功能（支持记录位置信息）\n• 签到历史记录保存\n• 紧急联系人管理\n• 后台定时监控（48小时未签到自动报警）\n• SMS短信紧急通知服务")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("二、用户注册与账户")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("2.1 用户在使用本应用前，需提供真实、准确、完整的个人信息。\n\n2.2 用户应妥善保管账户信息，对使用该账户的所有行为负责。\n\n2.3 用户不得将账户转让、出借或分享给他人使用。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("三、用户行为规范")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("3.1 用户在使用本应用时应遵守以下规定：\n• 遵守相关法律法规\n• 不得利用本应用从事违法活动\n• 不得干扰或破坏本应用的正常运行\n• 不得侵犯他人合法权益\n\n3.2 禁止行为包括但不限于：\n• 提供虚假信息\n• 恶意攻击或破坏系统\n• 传播病毒或恶意代码\n• 侵犯他人隐私或知识产权")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("四、签到与通知服务")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("4.1 用户应定期进行签到操作，建议每天至少签到一次。\n\n4.2 签到时应用可记录用户的地理位置信息（需用户授权），该信息将在发送求救短信时包含在内。\n\n4.3 当用户超过48小时未签到时，本应用将在后台自动检测，并以用户名义通过SMS短信向其设置的紧急联系人发送包含最后签到时间和位置信息的求救通知。\n\n4.4 用户理解并同意，紧急联系人通知功能旨在保障用户生命安全，因用户未及时签到、设备关机、网络故障等原因导致的通知延迟或失败，本应用不承担责任。\n\n4.5 用户可随时更改或删除紧急联系人信息，也可随时停止使用签到功能。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("五、用户隐私")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("5.1 我们重视并保护用户隐私，具体请参阅《隐私政策》。\n\n5.2 用户信息将存储在本地设备中，不会未经授权共享给第三方。\n\n5.3 紧急联系人信息仅用于通知服务，不会用于其他目的。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("六、知识产权")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("6.1 本应用的所有内容，包括但不限于文字、图片、音频、视频、软件、程序、版面设计等均受知识产权法保护。\n\n6.2 未经本应用运营者书面许可，用户不得复制、传播、展示、镜像、上载、下载本应用内容。\n\n6.3 用户在使用本应用时产生的内容，用户享有知识产权，但授予本应用在全球范围内免费、非独家、可转授权的使用权利。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("七、免责声明")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text('7.1 本应用按"现状"提供服务，不保证服务的连续性、及时性、安全性或无错误性。\n\n7.2 因以下情况导致服务中断或终止的，本应用不承担责任：\n• 不可抗力\n• 网络故障\n• 系统维护\n• 第三方原因\n\n7.3 用户因使用本应用而产生的任何直接或间接损失，本应用不承担责任，除非该损失由本应用的故意或重大过失造成。\n\n7.4 关于紧急联系人通知服务，用户理解并同意：短信服务可能因运营商网络问题延迟或失败，本应用不对通知延迟或失败承担责任。')
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("八、协议修改与通知")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("8.1 本应用有权根据需要修改本协议，修改后的协议将在应用内公布。\n\n8.2 用户继续使用本应用即视为同意修改后的协议。\n\n8.3 重大变更将通过应用内通知、推送消息等方式告知用户。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("九、协议终止")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("9.1 用户可以随时停止使用本应用并注销账户。\n\n9.2 在以下情况下，本应用有权终止提供服务：\n• 用户违反本协议规定\n• 用户提供虚假信息\n• 用户滥用服务\n\n9.3 协议终止后，用户的数据将被删除，法律法规另有规定的除外。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("十、法律适用与争议解决")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("10.1 本协议的订立、执行、解释及争议解决均适用中华人民共和国法律。\n\n10.2 如就本协议内容或其执行发生争议，双方应友好协商解决；协商不成的，任何一方均可向本应用运营者所在地人民法院提起诉讼。")
            .fontSize(14)
            .lineHeight(22)
            .width('100%')

          Text("十一、联系我们")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Text("如您对本协议有任何疑问或建议，请通过以下方式联系我们：\n\n邮箱：support@areyoualive.com\n\n感谢您的理解与支持！")
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
