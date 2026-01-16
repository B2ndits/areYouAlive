import { preferences } from '@kit.ArkData';
import { promptAction } from '@kit.ArkUI';
import router from '@ohos.router';
import { DataMasking } from '../utils/DataMasking';
import { LocationService, LocationInfo } from '../services/LocationService';
import { SmsService } from '../services/SmsService';

@Entry
@Component
struct Index {
  @State userName:string =""
  @State Phone:string = ""
  @State isSignIn:boolean = false
  @State Time:string = ""
  @State newTime:string = ""
  @State isEditingName: boolean = false
  @State isEditingPhone: boolean = false
  @State lastSignInLocation: LocationInfo | null = null
  @State lastSignInTimestamp: number = 0

  async aboutToAppear() {
    try {
      const storage = await preferences.getPreferences(getContext(), 'user_data');
      const saveName = await storage.get('userName', '') as string;
      const savePhone = await storage.get('Phone', '') as string;
      const saveSign = await storage.get('isSignIn', false) as boolean;
      const saveTime = await storage.get('Time', '') as string;
      const saveLocation = await storage.get('lastSignInLocation', '') as string;
      const saveTimestamp = await storage.get('lastSignInTimestamp', 0) as number;

      AppStorage.setOrCreate("userName", saveName);
      AppStorage.setOrCreate("Phone", savePhone);
      AppStorage.setOrCreate("isSignIn", saveSign);
      this.userName = saveName;
      this.Phone = savePhone;
      this.isSignIn = saveSign;
      this.Time = saveTime;
      this.lastSignInTimestamp = saveTimestamp;

      // 解析保存的位置信息
      if (saveLocation) {
        try {
          this.lastSignInLocation = JSON.parse(saveLocation) as LocationInfo;
        } catch (e) {
          console.error('解析位置信息失败:', JSON.stringify(e));
        }
      }

      // 检查是否超过48小时未签到
      this.checkAndSendEmergencySms();

      setInterval(() => {
        this.newTime = new Date().toLocaleString();
      }, 1000);
    } catch (err) {
      console.error('偏好设置加载失败:', JSON.stringify(err));
    }
  }

  async saveToLocal() {
    try {
      AppStorage.setOrCreate("userName",this.userName)
      AppStorage.setOrCreate("Phone",this.Phone)
      AppStorage.setOrCreate("isSignIn",this.isSignIn)
      AppStorage.setOrCreate("Time",this.Time)

      const storage = await preferences.getPreferences(getContext(), 'user_data');
      await storage.put('userName', this.userName);
      await storage.put('Phone', this.Phone);
      await storage.put('isSignIn', this.isSignIn);
      await storage.put('Time', this.Time);

      // 保存位置信息
      if (this.lastSignInLocation) {
        await storage.put('lastSignInLocation', JSON.stringify(this.lastSignInLocation));
      }
      await storage.put('lastSignInTimestamp', this.lastSignInTimestamp);

      await storage.flush();
    } catch (err) {
      console.error('偏好设置保存失败:', JSON.stringify(err));
    }
  }

  /**
   * 检查是否超过48小时未签到，如果是则发送求救短信
   */
  async checkAndSendEmergencySms() {
    // 检查是否有必要的签到信息
    if (!this.isSignIn || this.lastSignInTimestamp === 0 || !this.lastSignInLocation) {
      return;
    }

    // 计算距离上次签到的时间（毫秒）
    const currentTime = Date.now();
    const timeSinceLastSignIn = currentTime - this.lastSignInTimestamp;

    // 48小时 = 48 * 60 * 60 * 1000 = 172800000 毫秒
    const fortyEightHours = 48 * 60 * 60 * 1000;

    // 如果超过48小时，发送短信
    if (timeSinceLastSignIn > fortyEightHours) {
      const locationStr = LocationService.formatLocation(this.lastSignInLocation);
      await SmsService.sendEmergencySms(
        this.Phone,
        this.userName,
        this.Time,
        locationStr
      );
      console.info('已发送48小时未签到求救短信');
    }
  }

  build() {
    Column() {
      Column(){
        if (this.isEditingName) {
          TextInput({text: this.userName, placeholder: "姓名"})
            .width("80%")
            .height(40)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Regular)
            .backgroundColor(Color.Transparent)
            .fontSize(16)
            .onChange((value) => {
              this.userName = value
            })
            .onBlur(() => {
              this.isEditingName = false;
              this.saveToLocal()
            })
        } else {
          Text(this.userName ? DataMasking.maskName(this.userName) : "姓名")
            .width("80%")
            .height(40)
            .textAlign(TextAlign.Center)
            .fontColor(this.userName ? Color.Black : "#aaaaaa")
            .fontWeight(FontWeight.Regular)
            .fontSize(16)
            .onClick(() => {
              this.isEditingName = true;
            })
        }

        if (this.isEditingPhone) {
          TextInput({text: this.Phone, placeholder: "紧急联系人"})
            .width("80%")
            .height(40)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Regular)
            .backgroundColor(Color.Transparent)
            .fontSize(16)
            .type(InputType.PhoneNumber)
            .onChange((value) => {
              this.Phone = value
            })
            .onBlur(() => {
              this.isEditingPhone = false;
              this.saveToLocal()
            })
        } else {
          Text(this.Phone ? DataMasking.maskPhone(this.Phone) : "紧急联系人")
            .width("80%")
            .height(40)
            .textAlign(TextAlign.Center)
            .fontColor(this.Phone ? Color.Black : "#aaaaaa")
            .fontWeight(FontWeight.Regular)
            .fontSize(16)
            .onClick(() => {
              this.isEditingPhone = true;
            })
        }
      }
      .width("100%")
      .height("20%")
      .justifyContent(FlexAlign.Center)
      .margin({top:"10%"})

      Button(){
        Column() {
          if (this.isSignIn){
            Text("签到成功")
              .fontSize(20)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
            Text("签到时间:"+this.Time)
              .fontSize(12)
              .fontColor(Color.White)
              .margin({top: 8})
          } else {
            Text("点击签到")
              .fontSize(20)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
            Text("当前时间:"+this.newTime)
              .fontSize(12)
              .fontColor(Color.White)
              .margin({top: 8})
          }
        }
      }
        .borderRadius("100%")
        .backgroundColor(this.isSignIn?"#CCCCCC":"#4CAF50")
        .width("220vp")
        .height("220vp")
        .margin({top:"5%"})
        .onClick(async ()=>{
          if (this.userName == "" || this.Phone == "") {
            try {
              promptAction.showToast({ message: "请先填写姓名和紧急联系人" })
            } catch (error) {
              console.error('签到弹窗错误:', JSON.stringify(error));
            }
            return;
          }
          if (!this.isSignIn) {
            // 请求位置权限
            await LocationService.requestLocationPermission(getContext());

            // 获取当前位置
            const location = await LocationService.getCurrentLocation();
            if (location) {
              this.lastSignInLocation = location;
            } else {
              try {
                promptAction.showToast({ message: "获取位置失败，请检查位置权限" })
              } catch (error) {
                console.error('位置提示错误:', JSON.stringify(error));
              }
            }

            // 更新签到时间和时间戳
            this.Time = new Date().toLocaleString();
            this.lastSignInTimestamp = Date.now();
            this.saveToLocal()
          }
          this.isSignIn = true
        })



      Column({space:10}){
        Text("48小时未签到，系统将会以你的名义通过短信通知你的紧急联系人！")
          .fontSize(12)
          .fontColor("#aaaaaa")
          .width(240)
          .textAlign(TextAlign.Center)

        Row({space: 4}) {
          Text("点击签到即同意")
            .fontSize(12)
            .fontColor("#aaaaaa")

          Text("隐私政策")
            .fontSize(12)
            .fontColor('#4CAF50')
            .decoration({ type: TextDecorationType.Underline })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/PrivacyPolicy'
              }).catch((err: Error) => {
                console.error('跳转隐私政策页面失败:', JSON.stringify(err));
              })
            })

          Text("和")
            .fontSize(12)
            .fontColor("#aaaaaa")

          Text("用户协议")
            .fontSize(12)
            .fontColor('#4CAF50')
            .decoration({ type: TextDecorationType.Underline })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/UserAgreement'
              }).catch((err: Error) => {
                console.error('跳转用户协议页面失败:', JSON.stringify(err));
              })
            })
        }
      }
      .layoutWeight(1)
      .width("100%")
      .justifyContent(FlexAlign.End)
      .margin({bottom:10})
    }
    .height('100%')
    .width('100%')
  }
}